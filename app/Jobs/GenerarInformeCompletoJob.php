<?php

namespace App\Jobs;

use App\Models\User;
use App\Models\Project;
use App\Models\ActivityCalendar;
use App\Models\ActivityNarrative;
use App\Notifications\InformeGeneradoNotification;
use Illuminate\Bus\Batch;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Bus;
use Illuminate\Support\Facades\Log;

class GenerarInformeCompletoJob implements ShouldQueue
{
    use InteractsWithQueue, Queueable, SerializesModels;

    public $timeout = 600; // 10 minutos total

    /**
     * Create a new job instance.
     */
    public function __construct(
        public int $userId,
        public int $projectId,
        public string $fechaInicio,
        public string $fechaFin,
        public array $opciones
    ) {}

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        try {
            Log::info("GenerarInformeCompletoJob: Iniciando", [
                'user_id' => $this->userId,
                'project_id' => $this->projectId,
            ]);

            $proyecto = Project::findOrFail($this->projectId);
            $user = User::findOrFail($this->userId);

            // Obtener eventos del periodo
            $eventosQuery = ActivityCalendar::with([
                'activity.goal',
                'activity.specificObjective',
                'location',
            ])
                ->whereHas('activity.goal', function ($q) use ($proyecto) {
                    $q->where('project_id', $proyecto->id);
                })
                ->whereBetween('start_date', [$this->fechaInicio, $this->fechaFin])
                ->where('cancelled', false);

            // Filtrar por metas si se especificaron
            if (!empty($this->opciones['metas_ids'])) {
                $eventosQuery->whereHas('activity.goal', function ($q) {
                    $q->whereIn('id', $this->opciones['metas_ids']);
                });
            }

            // Filtrar por objetivos si se especificaron
            if (!empty($this->opciones['objetivos_ids'])) {
                $eventosQuery->whereHas('activity.specificObjective', function ($q) {
                    $q->whereIn('id', $this->opciones['objetivos_ids']);
                });
            }

            $eventos = $eventosQuery->orderBy('start_date')->get();

            Log::info("GenerarInformeCompletoJob: Eventos encontrados", [
                'total' => $eventos->count()
            ]);

            // Crear jobs individuales para cada evento sin narrativa
            $jobs = [];
            $usarCache = $this->opciones['usar_cache_narrativas'] ?? true;

            foreach ($eventos as $evento) {
                $narrativa = ActivityNarrative::where('activity_calendar_id', $evento->id)->first();

                // Si no tiene narrativa o no usamos cache, crear job
                if (!$usarCache || !$narrativa || !$narrativa->narrativa_generada) {
                    $jobs[] = new GenerarNarrativaJob($evento, !$usarCache);
                }
            }

            Log::info("GenerarInformeCompletoJob: Jobs a crear", [
                'total_jobs' => count($jobs)
            ]);

            // Si hay jobs para procesar, crear batch
            if (count($jobs) > 0) {
                $batch = Bus::batch($jobs)
                    ->name("Informe: {$proyecto->name}")
                    ->then(function (Batch $batch) use ($user, $proyecto) {
                        // Cuando todos los jobs terminen exitosamente
                        Log::info("GenerarInformeCompletoJob: Batch completado", [
                            'batch_id' => $batch->id
                        ]);

                        // Enviar notificación
                        $user->notify(new InformeGeneradoNotification(
                            proyecto: $proyecto,
                            batchId: $batch->id,
                            totalEventos: $batch->totalJobs,
                            exitosos: $batch->totalJobs - $batch->failedJobs
                        ));
                    })
                    ->catch(function (Batch $batch, \Throwable $e) {
                        // Cuando un job falla
                        Log::error("GenerarInformeCompletoJob: Batch con errores", [
                            'batch_id' => $batch->id,
                            'error' => $e->getMessage()
                        ]);
                    })
                    ->finally(function (Batch $batch) {
                        // Siempre se ejecuta al final
                        Log::info("GenerarInformeCompletoJob: Batch finalizado", [
                            'batch_id' => $batch->id,
                            'processed' => $batch->processedJobs(),
                            'failed' => $batch->failedJobs
                        ]);
                    })
                    ->dispatch();

                Log::info("GenerarInformeCompletoJob: Batch despachado", [
                    'batch_id' => $batch->id
                ]);

            } else {
                // No hay narrativas que generar, notificar directamente
                Log::info("GenerarInformeCompletoJob: No hay narrativas que generar, notificando");

                $user->notify(new InformeGeneradoNotification(
                    proyecto: $proyecto,
                    batchId: null,
                    totalEventos: $eventos->count(),
                    exitosos: $eventos->count()
                ));
            }

        } catch (\Exception $e) {
            Log::error("GenerarInformeCompletoJob: Error", [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            throw $e;
        }
    }
}

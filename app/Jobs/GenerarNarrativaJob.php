<?php

namespace App\Jobs;

use App\Models\ActivityCalendar;
use App\Models\ActivityNarrative;
use App\Services\NarrativaGenerator;
use Illuminate\Bus\Batchable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class GenerarNarrativaJob implements ShouldQueue
{
    use Batchable, InteractsWithQueue, Queueable, SerializesModels;

    public $timeout = 300; // 5 minutos por narrativa
    public $tries = 3;     // 3 intentos si falla
    public $backoff = 60;  // Esperar 60 segundos entre reintentos

    /**
     * Create a new job instance.
     */
    public function __construct(
        public ActivityCalendar $evento,
        public bool $force = false
    ) {}

    /**
     * Execute the job.
     */
    public function handle(NarrativaGenerator $generador): void
    {
        // Verificar si el batch fue cancelado
        if ($this->batch()?->cancelled()) {
            return;
        }

        try {
            Log::info("GenerarNarrativaJob: Iniciando para evento {$this->evento->id}");

            $startTime = microtime(true);

            // Obtener o crear la narrativa
            $narrativa = ActivityNarrative::firstOrCreate(
                ['activity_calendar_id' => $this->evento->id]
            );

            // Solo generar si no existe o si es forzado
            if ($this->force || !$narrativa->narrativa_generada) {
                // Generar la narrativa usando el servicio
                $generador->generarNarrativaEvento($this->evento, $this->force);

                // Refrescar el modelo
                $narrativa->refresh();

                $endTime = microtime(true);
                $tiempoGeneracion = $endTime - $startTime;

                // Crear versión con tiempo de generación
                $narrativa->crearVersion(
                    tipoCambio: $this->force ? 'regeneracion_automatica' : 'generacion_inicial',
                    motivo: $this->force ? 'Regeneración solicitada por usuario' : 'Generación inicial',
                    tiempoGeneracion: $tiempoGeneracion
                );

                Log::info("GenerarNarrativaJob: Completado para evento {$this->evento->id} en {$tiempoGeneracion}s");
            } else {
                Log::info("GenerarNarrativaJob: Narrativa ya existe para evento {$this->evento->id}");
            }

        } catch (\Exception $e) {
            Log::error("GenerarNarrativaJob: Error para evento {$this->evento->id}", [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            // Re-lanzar la excepción para que Laravel maneje los reintentos
            throw $e;
        }
    }

    /**
     * Handle a job failure.
     */
    public function failed(\Throwable $exception): void
    {
        Log::error("GenerarNarrativaJob: Falló definitivamente para evento {$this->evento->id}", [
            'error' => $exception->getMessage()
        ]);

        // Opcional: Crear narrativa de respaldo
        $narrativa = ActivityNarrative::firstOrCreate(
            ['activity_calendar_id' => $this->evento->id]
        );

        if (!$narrativa->narrativa_generada) {
            $narrativa->update([
                'narrativa_generada' => "Se realizó la actividad {$this->evento->activity->name} el {$this->evento->start_date->format('d/m/Y')}. (Generación automática falló)"
            ]);
        }
    }
}

<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Project;
use App\Models\Activity;
use App\Models\PlannedMetric;
use Illuminate\Support\Facades\Log;

class TestProjectDelete extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'test:delete-project {project_id?}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Probar el borrado de un proyecto y verificar que los PlannedMetric se eliminen';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $projectId = $this->argument('project_id');

        if ($projectId) {
            $project = Project::find($projectId);
        } else {
            $project = Project::latest()->first();
        }

        if (!$project) {
            $this->error('No se encontró ningún proyecto');
            return 1;
        }

        $this->info('🔍 Proyecto encontrado: ' . $project->id . ' - ' . $project->name);

        // Verificar datos antes del borrado
        $activities = Activity::whereHas('goal', function($query) use ($project) {
            $query->where('project_id', $project->id);
        })->get();

        $this->info('📊 Datos antes del borrado:');
        $this->info('   - Actividades: ' . $activities->count());

        $totalMetrics = 0;
        foreach ($activities as $activity) {
            $metrics = PlannedMetric::where('activity_id', $activity->id)->get();
            $this->info('   - Actividad ' . $activity->id . ' (' . $activity->name . '): ' . $metrics->count() . ' PlannedMetrics');
            $totalMetrics += $metrics->count();
        }

        $this->info('   - Total PlannedMetrics: ' . $totalMetrics);

        if ($this->confirm('¿Deseas proceder con el borrado del proyecto?')) {
            $this->info('🗑️ Iniciando borrado del proyecto...');

            try {
                // Verificar PlannedMetrics antes del borrado
                $metricsBefore = PlannedMetric::count();
                $this->info('   PlannedMetrics antes del borrado: ' . $metricsBefore);

                // Borrar el proyecto
                $project->delete();
                $this->info('✅ Proyecto eliminado correctamente');

                // Verificar datos después del borrado
                $this->info('📊 Datos después del borrado:');

                $activitiesAfter = Activity::whereHas('goal', function($query) use ($project) {
                    $query->where('project_id', $project->id);
                })->get();
                $this->info('   - Actividades restantes: ' . $activitiesAfter->count());

                $metricsAfter = PlannedMetric::count();
                $this->info('   - PlannedMetrics restantes: ' . $metricsAfter);

                $metricsDeleted = $metricsBefore - $metricsAfter;
                $this->info('   - PlannedMetrics eliminados: ' . $metricsDeleted);

                // Verificar PlannedMetrics huérfanos
                $orphanedMetrics = PlannedMetric::whereDoesntHave('activity')->get();
                $this->info('   - PlannedMetrics huérfanos: ' . $orphanedMetrics->count());

                if ($metricsDeleted > 0) {
                    $this->info('✅ ¡Éxito! Se eliminaron ' . $metricsDeleted . ' PlannedMetrics');
                } else {
                    $this->warn('⚠️ No se eliminaron PlannedMetrics');
                }

                if ($orphanedMetrics->count() > 0) {
                    $this->warn('⚠️ Hay ' . $orphanedMetrics->count() . ' PlannedMetrics huérfanos');
                } else {
                    $this->info('✅ No hay PlannedMetrics huérfanos');
                }

            } catch (\Exception $e) {
                $this->error('❌ Error durante el borrado: ' . $e->getMessage());
                return 1;
            }
        }

        return 0;
    }
}

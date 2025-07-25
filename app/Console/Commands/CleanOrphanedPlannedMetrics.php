<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\PlannedMetric;
use App\Models\Activity;

class CleanOrphanedPlannedMetrics extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'metrics:clean-orphaned';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Eliminar PlannedMetrics que no tienen actividad asociada';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Buscando PlannedMetrics huérfanos...');

        // Buscar PlannedMetrics que no tienen actividad asociada
        $orphanedMetrics = PlannedMetric::whereDoesntHave('activity')->get();

        $this->info('PlannedMetrics huérfanos encontrados: ' . $orphanedMetrics->count());

        if ($orphanedMetrics->count() > 0) {
            $this->warn('Eliminando PlannedMetrics huérfanos...');

            foreach ($orphanedMetrics as $metric) {
                $this->line("Eliminando PlannedMetric ID: {$metric->id}");
                $metric->delete();
            }

            $this->info('PlannedMetrics huérfanos eliminados correctamente.');
        } else {
            $this->info('No se encontraron PlannedMetrics huérfanos.');
        }

        return Command::SUCCESS;
    }
}

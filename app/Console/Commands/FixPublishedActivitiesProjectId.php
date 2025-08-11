<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class FixPublishedActivitiesProjectId extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'fix:published-activities-project-id
                            {--publication-id= : ID específico de publicación a arreglar}
                            {--all : Arreglar todas las publicaciones}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Arregla el campo project_id faltante en la tabla published_activities';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Iniciando corrección de project_id en published_activities...');

        try {
            if ($this->option('publication-id')) {
                // Arreglar una publicación específica
                $publicationId = $this->option('publication-id');
                $this->fixPublicationActivities($publicationId);
            } elseif ($this->option('all')) {
                // Arreglar todas las publicaciones
                $this->fixAllPublications();
            } else {
                // Arreglar solo las que tienen project_id nulo
                $this->fixNullProjectIds();
            }

            $this->info('✅ Corrección completada exitosamente.');

        } catch (\Exception $e) {
            $this->error('❌ Error durante la corrección: ' . $e->getMessage());
            return 1;
        }

        return 0;
    }

    /**
     * Arregla una publicación específica
     */
    private function fixPublicationActivities($publicationId)
    {
        $this->info("Arreglando publicación #{$publicationId}...");

        $result = DB::update("
            UPDATE published_activities pa
            JOIN activities a ON pa.original_activity_id = a.id
            JOIN specific_objectives so ON a.specific_objective_id = so.id
            SET pa.project_id = so.projects_id
            WHERE pa.publication_id = ?
        ", [$publicationId]);

        $this->info("- Actividades actualizadas: {$result}");
    }

    /**
     * Arregla todas las publicaciones
     */
    private function fixAllPublications()
    {
        $this->info("Arreglando todas las publicaciones...");

        $result = DB::update("
            UPDATE published_activities pa
            JOIN activities a ON pa.original_activity_id = a.id
            JOIN specific_objectives so ON a.specific_objective_id = so.id
            SET pa.project_id = so.projects_id
        ");

        $this->info("- Total de actividades actualizadas: {$result}");
    }

    /**
     * Arregla solo las actividades con project_id nulo usando la lógica correcta del procedimiento almacenado
     */
    private function fixNullProjectIds()
    {
        $this->info("Arreglando actividades con project_id nulo usando lógica del procedimiento almacenado...");

        $result = DB::update("
            UPDATE published_activities pa
            JOIN activities a ON pa.original_activity_id = a.id
            JOIN specific_objectives so ON a.specific_objective_id = so.id
            SET pa.project_id = so.projects_id
            WHERE pa.project_id IS NULL
        ");

        $this->info("- Actividades con project_id nulo actualizadas: {$result}");
    }
}

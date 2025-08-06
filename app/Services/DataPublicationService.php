<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class DataPublicationService
{
    /**
     * Ejecuta el procedimiento almacenado PublishDataSnapshot
     *
     * @param int $userId ID del usuario que publica
     * @param string|null $notes Notas de la publicación
     * @param string|null $periodFrom Fecha de inicio del período (YYYY-MM-DD)
     * @param string|null $periodTo Fecha de fin del período (YYYY-MM-DD)
     * @return array Resultado de la publicación
     * @throws \Exception
     */
    public function publishDataSnapshot($userId, $notes = null, $periodFrom = null, $periodTo = null)
    {
        // Validar que el usuario existe
        if (!DB::table('users')->where('id', $userId)->exists()) {
            throw new \Exception('El usuario especificado no existe.');
        }

        // Validar fechas si se proporcionan
        if ($periodFrom && !$this->isValidDate($periodFrom)) {
            throw new \Exception('Formato de fecha de inicio inválido. Use YYYY-MM-DD');
        }

        if ($periodTo && !$this->isValidDate($periodTo)) {
            throw new \Exception('Formato de fecha de fin inválido. Use YYYY-MM-DD');
        }

        // Validar que el rango de fechas sea válido
        if ($periodFrom && $periodTo && $periodFrom > $periodTo) {
            throw new \Exception('La fecha de inicio no puede ser posterior a la fecha de fin.');
        }

        try {
            // Ejecutar el procedimiento almacenado
            $result = DB::select('CALL PublishDataSnapshot(?, ?, ?, ?)', [
                $userId,
                $notes ?? 'Publicación desde aplicación',
                $periodFrom,
                $periodTo
            ]);

            if (empty($result)) {
                throw new \Exception('No se recibió respuesta del procedimiento almacenado.');
            }

            return (array) $result[0];

        } catch (\Exception $e) {
            // Re-lanzar la excepción con un mensaje más descriptivo
            throw new \Exception('Error al ejecutar la publicación: ' . $e->getMessage());
        }
    }

    /**
     * Obtiene el historial de publicaciones
     *
     * @param int|null $limit Límite de registros a retornar
     * @return \Illuminate\Support\Collection
     */
    public function getPublicationHistory($limit = null)
    {
        $query = \App\Models\DataPublication::with('publishedBy')
            ->orderBy('publication_date', 'desc');

        if ($limit) {
            $query->limit($limit);
        }

        return $query->get();
    }

    /**
     * Obtiene estadísticas de publicaciones
     *
     * @return array
     */
    public function getPublicationStats()
    {
        $stats = \App\Models\DataPublication::selectRaw('
                COUNT(*) as total_publications,
                SUM(projects_count) as total_projects_published,
                SUM(activities_count) as total_activities_published,
                SUM(metrics_count) as total_metrics_published,
                MAX(publication_date) as last_publication_date
            ')
            ->first();

        return $stats ? $stats->toArray() : [
            'total_publications' => 0,
            'total_projects_published' => 0,
            'total_activities_published' => 0,
            'total_metrics_published' => 0,
            'last_publication_date' => null,
        ];
    }

    /**
     * Valida si una fecha tiene el formato correcto
     *
     * @param string $date
     * @return bool
     */
    private function isValidDate($date)
    {
        return preg_match('/^\d{4}-\d{2}-\d{2}$/', $date) &&
               Carbon::createFromFormat('Y-m-d', $date) !== false;
    }

    /**
     * Obtiene las publicaciones de un período específico
     *
     * @param string $startDate Fecha de inicio (YYYY-MM-DD)
     * @param string $endDate Fecha de fin (YYYY-MM-DD)
     * @return \Illuminate\Support\Collection
     */
    public function getPublicationsByPeriod($startDate, $endDate)
    {
        return \App\Models\DataPublication::with('publishedBy')
            ->whereBetween('publication_date', [$startDate, $endDate])
            ->orderBy('publication_date', 'desc')
            ->get();
    }

    /**
     * Publica solo los proyectos específicos seleccionados
     *
     * @param int $userId ID del usuario que publica
     * @param array $projectIds Array de IDs de proyectos a publicar
     * @param string|null $notes Notas de la publicación
     * @return array Resultado de la publicación
     * @throws \Exception
     */
    public function publishSelectedProjects($userId, array $projectIds, $notes = null)
    {
        // Validar que el usuario existe
        if (!DB::table('users')->where('id', $userId)->exists()) {
            throw new \Exception('El usuario especificado no existe.');
        }

        // Validar que los proyectos existen
        $existingProjects = DB::table('projects')->whereIn('id', $projectIds)->pluck('id')->toArray();
        $missingProjects = array_diff($projectIds, $existingProjects);

        if (!empty($missingProjects)) {
            throw new \Exception('Los siguientes proyectos no existen: ' . implode(', ', $missingProjects));
        }

        try {
            // Crear una nueva publicación
            $publication = \App\Models\DataPublication::create([
                'published_by' => $userId,
                'publication_notes' => $notes ?? 'Publicación de proyectos seleccionados',
                'publication_date' => now(),
                'projects_count' => 0,
                'activities_count' => 0,
                'metrics_count' => 0
            ]);

            $totalProjects = 0;
            $totalActivities = 0;
            $totalMetrics = 0;

            // Publicar cada proyecto seleccionado
            foreach ($projectIds as $projectId) {
                $project = \App\Models\Project::find($projectId);

                // Publicar el proyecto
                \App\Models\PublishedProject::create([
                    'publication_id' => $publication->id,
                    'original_project_id' => $project->id,
                    'name' => $project->name,
                    'background' => $project->background,
                    'justification' => $project->justification,
                    'general_objective' => $project->general_objective,
                    'start_date' => $project->start_date,
                    'end_date' => $project->end_date,
                    'total_cost' => $project->total_cost,
                    'funded_amount' => $project->funded_amount,
                    'cofunding_amount' => $project->cofunding_amount,
                    'financiers_id' => $project->financiers_id,
                    'co_financier_id' => $project->co_financier_id,
                    'created_by' => $project->created_by,
                    'snapshot_date' => now()
                ]);
                $totalProjects++;

                // Publicar actividades del proyecto
                $activities = \App\Models\Activity::whereHas('goal', function($query) use ($projectId) {
                    $query->where('project_id', $projectId);
                })->get();

                foreach ($activities as $activity) {
                    \App\Models\PublishedActivity::create([
                        'publication_id' => $publication->id,
                        'original_activity_id' => $activity->id,
                        'project_id' => $projectId,
                        'name' => $activity->name,
                        'description' => $activity->description,
                        'specific_objective_id' => $activity->specific_objective_id,
                        'goals_id' => $activity->goals_id,
                        'created_by' => $activity->created_by,
                        'snapshot_date' => now()
                    ]);
                    $totalActivities++;

                    // Publicar métricas de la actividad
                    $metrics = \App\Models\PlannedMetric::where('activity_id', $activity->id)->get();

                    foreach ($metrics as $metric) {
                        \App\Models\PublishedMetric::create([
                            'publication_id' => $publication->id,
                            'original_metric_id' => $metric->id,
                            'activity_id' => $activity->id,
                            'unit' => $metric->unit,
                            'year' => $metric->year,
                            'month' => $metric->month,
                            'population_target_value' => $metric->population_target_value,
                            'population_real_value' => $metric->population_real_value,
                            'product_target_value' => $metric->product_target_value,
                            'product_real_value' => $metric->product_real_value,
                            'snapshot_date' => now()
                        ]);
                        $totalMetrics++;
                    }
                }
            }

            // Actualizar contadores en la publicación
            $publication->update([
                'projects_count' => $totalProjects,
                'activities_count' => $totalActivities,
                'metrics_count' => $totalMetrics
            ]);

            return [
                'publication_id' => $publication->id,
                'projects_count' => $totalProjects,
                'activities_count' => $totalActivities,
                'metrics_count' => $totalMetrics,
                'publication_date' => $publication->publication_date
            ];

        } catch (\Exception $e) {
            throw new \Exception('Error al publicar proyectos seleccionados: ' . $e->getMessage());
        }
    }
}

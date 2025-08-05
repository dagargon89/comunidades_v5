<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use App\Models\Project;
use App\Models\Activity;
use App\Models\PlannedMetric;
use App\Models\DataPublication;
use App\Services\DataPublicationService;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Notifications\Notification;
use Illuminate\Support\Facades\Auth;

class DataPublicationApproval extends Page
{
    use HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.data-publication-approval';

    public $allProjects = [];
    public $selectedProjects = [];
    public $projectsToPublish = [];
    public $projectsToUpdate = [];
    public $publicationNotes = '';

    public function mount()
    {
        $this->selectedProjects = []; // Inicializar como array vacío
        $this->loadProjectAnalysis();

        // Debug: mostrar información de lo que se detectó
        if (count($this->allProjects) > 0) {
            Notification::make()
                ->title('Análisis completado')
                ->body('Proyectos detectados: ' . count($this->allProjects) .
                       ' (Nuevos: ' . count($this->projectsToPublish) .
                       ', Actualizar: ' . count($this->projectsToUpdate) . ')')
                ->info()
                ->send();
        } else {
            Notification::make()
                ->title('No se detectaron cambios')
                ->body('Todos los proyectos están actualizados o no tienen datos para publicar')
                ->warning()
                ->send();
        }
    }

    public function updatedSelectedProjects()
    {
        // Debug: mostrar qué proyectos se seleccionaron
        if (count($this->selectedProjects) > 0) {
            Notification::make()
                ->title('Proyectos seleccionados')
                ->body('Seleccionaste ' . count($this->selectedProjects) . ' proyecto(s)')
                ->info()
                ->send();
        }
    }

    public function toggleProjectSelection($projectId)
    {
        if (in_array($projectId, $this->selectedProjects)) {
            // Remover del array
            $this->selectedProjects = array_values(array_filter($this->selectedProjects, function($id) use ($projectId) {
                return $id != $projectId;
            }));
        } else {
            // Agregar al array
            $this->selectedProjects[] = $projectId;
        }

        // Debug: mostrar el estado actual
        Notification::make()
            ->title('Selección actualizada')
            ->body('Proyectos seleccionados: ' . count($this->selectedProjects))
            ->info()
            ->send();
    }

    public function selectAllProjects()
    {
        $this->selectedProjects = collect($this->allProjects)->pluck('project.id')->toArray();
        Notification::make()
            ->title('Todos los proyectos seleccionados')
            ->body('Se han seleccionado todos los proyectos disponibles')
            ->info()
            ->send();
    }

    public function clearSelection()
    {
        $this->selectedProjects = [];
        Notification::make()
            ->title('Selección limpiada')
            ->body('Se han deseleccionado todos los proyectos')
            ->info()
            ->send();
    }

    public function loadProjectAnalysis()
    {
        $this->allProjects = [];
        $this->projectsToPublish = [];
        $this->projectsToUpdate = [];

        // Obtener todos los proyectos
        $allProjects = Project::with(['financiers', 'goals.activities', 'goals.activities.plannedMetrics'])->get();

        // Obtener la última publicación
        $lastPublication = DataPublication::orderBy('publication_date', 'desc')->first();

        // Debug: mostrar información inicial
        Notification::make()
            ->title('Debug: Análisis iniciado')
            ->body('Proyectos totales: ' . $allProjects->count() .
                   ' | Última publicación: ' . ($lastPublication ? $lastPublication->publication_date->format('d/m/Y H:i') : 'Ninguna'))
            ->info()
            ->send();

        foreach ($allProjects as $project) {
            $projectAnalysis = $this->analyzeProject($project, $lastPublication);

            // Debug: mostrar resultado del análisis de cada proyecto
            $actionType = $projectAnalysis['needs_action'] ? ($projectAnalysis['action_type'] === 'publish' ? 'NUEVO' : 'ACTUALIZAR') : 'SIN ACCIÓN';
            Notification::make()
                ->title('Proyecto: ' . $project->name)
                ->body('Resultado: ' . $actionType . ' | Actividades: ' . $projectAnalysis['current_activities_count'] . ' | Métricas: ' . $projectAnalysis['current_metrics_count'])
                ->info()
                ->send();

            // Solo agregar proyectos que realmente necesitan acción
            if ($projectAnalysis['needs_action']) {
                $this->allProjects[] = $projectAnalysis;

                if ($projectAnalysis['action_type'] === 'publish') {
                    $this->projectsToPublish[] = $projectAnalysis;
                } else {
                    $this->projectsToUpdate[] = $projectAnalysis;
                }
            }
        }

        // Debug: mostrar resultado final
        Notification::make()
            ->title('Debug: Análisis completado')
            ->body('Proyectos con acción: ' . count($this->allProjects) .
                   ' | Nuevos: ' . count($this->projectsToPublish) .
                   ' | Actualizar: ' . count($this->projectsToUpdate))
            ->info()
            ->send();
    }

    public function analyzeProject($project, $lastPublication)
    {
        $analysis = [
            'project' => $project,
            'needs_action' => false,
            'action_type' => null, // 'publish' o 'update'
            'current_activities_count' => 0,
            'current_metrics_count' => 0,
            'published_activities_count' => 0,
            'published_metrics_count' => 0,
            'cost_changed' => false,
            'activities_changed' => false,
            'metrics_changed' => false,
            'last_publication_date' => null,
            'changes_summary' => [],
            'debug_info' => [] // Información de debug
        ];

        // Contar actividades y métricas actuales
        $currentActivities = Activity::whereHas('goal', function($query) use ($project) {
            $query->where('project_id', $project->id);
        })->get();

        $currentMetrics = PlannedMetric::whereHas('activity.goal', function($query) use ($project) {
            $query->where('project_id', $project->id);
        })->get();

        $analysis['current_activities_count'] = $currentActivities->count();
        $analysis['current_metrics_count'] = $currentMetrics->count();

        // Debug: información del proyecto
        $analysis['debug_info'][] = 'Proyecto: ' . $project->name;
        $analysis['debug_info'][] = 'Actividades actuales: ' . $analysis['current_activities_count'];
        $analysis['debug_info'][] = 'Métricas actuales: ' . $analysis['current_metrics_count'];
        $analysis['debug_info'][] = 'Última actualización del proyecto: ' . ($project->updated_at ? $project->updated_at->format('d/m/Y H:i') : 'N/A');

        // Verificar si el proyecto ya fue publicado
        if ($lastPublication) {
            $analysis['debug_info'][] = 'Última publicación: ' . $lastPublication->publication_date->format('d/m/Y H:i');

            $publishedProject = $project->publishedProjects()
                ->where('publication_id', $lastPublication->id)
                ->first();

            if ($publishedProject) {
                // Proyecto ya publicado en la última publicación, verificar si hay cambios
                $analysis['last_publication_date'] = $lastPublication->publication_date;
                $analysis['debug_info'][] = '✅ Proyecto YA publicado en la última publicación';

                // Obtener datos publicados de la última publicación
                $publishedActivities = \App\Models\PublishedActivity::where('publication_id', $lastPublication->id)
                    ->where('project_id', $project->id)
                    ->get();

                $publishedMetrics = \App\Models\PublishedMetric::where('publication_id', $lastPublication->id)
                    ->whereHas('originalMetric.activity.goal', function($query) use ($project) {
                        $query->where('project_id', $project->id);
                    })->get();

                $analysis['published_activities_count'] = $publishedActivities->count();
                $analysis['published_metrics_count'] = $publishedMetrics->count();

                // Debug: información de datos publicados
                $analysis['debug_info'][] = 'Actividades publicadas en última publicación: ' . $analysis['published_activities_count'];
                $analysis['debug_info'][] = 'Métricas publicadas en última publicación: ' . $analysis['published_metrics_count'];

                // Detectar cambios comparando timestamps - SOLO si hay datos para comparar
                $hasChanges = false;

                // Solo verificar timestamps si hay datos publicados para comparar
                if ($analysis['published_activities_count'] > 0 || $analysis['published_metrics_count'] > 0) {
                    // Usar publication_date en lugar de snapshot_date porque snapshot_date no está guardando la fecha correcta
                    $publicationDate = \Carbon\Carbon::parse($lastPublication->publication_date);

                    // Verificar si el proyecto fue actualizado después de la publicación
                    $projectUpdatedAfterPublication = $project->updated_at && $project->updated_at->gt($publicationDate);

                    // Verificar si alguna actividad fue actualizada después de la publicación
                    $activitiesUpdatedAfterPublication = $currentActivities->where('updated_at', '>', $publicationDate)->count() > 0;

                    // Verificar si alguna métrica fue actualizada después de la publicación
                    $metricsUpdatedAfterPublication = $currentMetrics->where('updated_at', '>', $publicationDate)->count() > 0;

                    // Debug: información de timestamps
                    $analysis['debug_info'][] = 'Proyecto actualizado después de la publicación: ' . ($projectUpdatedAfterPublication ? 'SÍ' : 'NO');
                    $analysis['debug_info'][] = 'Actividades actualizadas después de la publicación: ' . ($activitiesUpdatedAfterPublication ? 'SÍ' : 'NO');
                    $analysis['debug_info'][] = 'Métricas actualizadas después de la publicación: ' . ($metricsUpdatedAfterPublication ? 'SÍ' : 'NO');
                    $analysis['debug_info'][] = 'Publication date: ' . $publicationDate->format('d/m/Y H:i');
                    $analysis['debug_info'][] = 'Snapshot date (incorrecto): ' . $publishedProject->snapshot_date;

                    // También verificar cambios en valores
                    $analysis['cost_changed'] = $project->total_cost != $publishedProject->total_cost;
                    $analysis['activities_changed'] = $analysis['current_activities_count'] != $analysis['published_activities_count'];
                    $analysis['metrics_changed'] = $analysis['current_metrics_count'] != $analysis['published_metrics_count'];

                    // Debug: información de cambios en valores
                    $analysis['debug_info'][] = 'Costo cambiado: ' . ($analysis['cost_changed'] ? 'SÍ' : 'NO');
                    $analysis['debug_info'][] = 'Cantidad de actividades cambiada: ' . ($analysis['activities_changed'] ? 'SÍ' : 'NO');
                    $analysis['debug_info'][] = 'Cantidad de métricas cambiada: ' . ($analysis['metrics_changed'] ? 'SÍ' : 'NO');

                    // Detectar si hay cambios basados en timestamps O valores
                    if ($projectUpdatedAfterPublication || $activitiesUpdatedAfterPublication || $metricsUpdatedAfterPublication ||
                        $analysis['cost_changed'] || $analysis['activities_changed'] || $analysis['metrics_changed']) {
                        $hasChanges = true;
                        $analysis['debug_info'][] = '🔴 CAMBIOS DETECTADOS - Marcar como ACTUALIZAR';
                    } else {
                        $analysis['debug_info'][] = '✅ SIN CAMBIOS - No necesita acción';
                    }
                } else {
                    $analysis['debug_info'][] = '⚠️ No hay datos publicados para comparar';
                }

                if ($hasChanges) {
                    $analysis['needs_action'] = true;
                    $analysis['action_type'] = 'update';

                    // Crear resumen de cambios
                    if ($projectUpdatedAfterPublication) {
                        $analysis['changes_summary'][] = 'Proyecto modificado después de la última publicación (' . $project->updated_at->format('d/m/Y H:i') . ')';
                    }
                    if ($activitiesUpdatedAfterPublication) {
                        $analysis['changes_summary'][] = 'Actividades modificadas después de la última publicación';
                    }
                    if ($metricsUpdatedAfterPublication) {
                        $analysis['changes_summary'][] = 'Métricas modificadas después de la última publicación';
                    }
                    if ($analysis['cost_changed']) {
                        $analysis['changes_summary'][] = 'Costo modificado: $' . number_format($publishedProject->total_cost, 2) . ' → $' . number_format($project->total_cost, 2);
                    }
                    if ($analysis['activities_changed']) {
                        $analysis['changes_summary'][] = 'Cantidad de actividades: ' . $analysis['published_activities_count'] . ' → ' . $analysis['current_activities_count'];
                    }
                    if ($analysis['metrics_changed']) {
                        $analysis['changes_summary'][] = 'Cantidad de métricas: ' . $analysis['published_metrics_count'] . ' → ' . $analysis['current_metrics_count'];
                    }
                }
            } else {
                // Proyecto no publicado en la última publicación
                $analysis['debug_info'][] = '❌ Proyecto NO publicado en la última publicación';
                if ($analysis['current_activities_count'] > 0 || $analysis['current_metrics_count'] > 0) {
                    $analysis['needs_action'] = true;
                    $analysis['action_type'] = 'publish';
                    $analysis['changes_summary'][] = 'Nuevo proyecto para publicar';
                    $analysis['debug_info'][] = '🟢 Marcar como NUEVO para publicar';
                } else {
                    $analysis['debug_info'][] = '⚠️ No tiene actividades ni métricas - No necesita acción';
                }
            }
        } else {
            // No hay publicaciones anteriores
            $analysis['debug_info'][] = '⚠️ No hay publicaciones anteriores';
            if ($analysis['current_activities_count'] > 0 || $analysis['current_metrics_count'] > 0) {
                $analysis['needs_action'] = true;
                $analysis['action_type'] = 'publish';
                $analysis['changes_summary'][] = 'Primera publicación del proyecto';
                $analysis['debug_info'][] = '🟢 Primera publicación - Marcar como NUEVO';
            } else {
                $analysis['debug_info'][] = '⚠️ No tiene actividades ni métricas - No necesita acción';
            }
        }

        return $analysis;
    }

    public function approvePublication()
    {
        if (empty($this->selectedProjects)) {
            Notification::make()
                ->title('No hay proyectos seleccionados')
                ->body('Por favor selecciona al menos un proyecto para publicar')
                ->warning()
                ->send();
            return;
        }

        try {
            $service = new DataPublicationService();

            $result = $service->publishDataSnapshot(
                Auth::id(),
                $this->publicationNotes ?: 'Aprobación manual desde panel de administración',
                null,
                null
            );

            Notification::make()
                ->title('Publicación aprobada exitosamente')
                ->body('Se han publicado ' . ($result['projects_count'] ?? 0) . ' proyectos, ' .
                       ($result['activities_count'] ?? 0) . ' actividades y ' .
                       ($result['metrics_count'] ?? 0) . ' métricas.')
                ->success()
                ->send();

            // Recargar los datos
            $this->loadProjectAnalysis();
            $this->selectedProjects = [];
            $this->publicationNotes = '';

        } catch (\Exception $e) {
            Notification::make()
                ->title('Error al aprobar la publicación')
                ->body('Error: ' . $e->getMessage())
                ->danger()
                ->send();
        }
    }
}

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
    }

    public function loadProjectAnalysis()
    {
        $this->allProjects = [];
        $this->projectsToPublish = [];
        $this->projectsToUpdate = [];

        // Obtener todos los proyectos
        $allProjects = Project::with(['financiers', 'goals.activities', 'goals.activities.plannedMetrics'])->get();

        foreach ($allProjects as $project) {
            $projectAnalysis = $this->analyzeProject($project);

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
    }

    public function analyzeProject($project)
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

        // Verificar si el proyecto ya fue publicado
        // Buscar la última publicación específica de este proyecto
        $lastProjectPublication = $project->publishedProjects()
            ->orderBy('publication_id', 'desc')
            ->first();

        if ($lastProjectPublication) {
            // Proyecto ya publicado, obtener la información de esa publicación específica
            $lastPublication = DataPublication::find($lastProjectPublication->publication_id);
            $analysis['last_publication_date'] = $lastPublication->publication_date;

            // Obtener datos publicados de esa publicación específica
            $publishedActivities = \App\Models\PublishedActivity::where('publication_id', $lastProjectPublication->publication_id)
                ->where('project_id', $project->id)
                ->get();

            $publishedMetrics = \App\Models\PublishedMetric::where('publication_id', $lastProjectPublication->publication_id)
                ->whereHas('originalMetric.activity.goal', function($query) use ($project) {
                    $query->where('project_id', $project->id);
                })->get();

            $analysis['published_activities_count'] = $publishedActivities->count();
            $analysis['published_metrics_count'] = $publishedMetrics->count();

            // COMPARACIÓN COMPLETA DE TODOS LOS CAMPOS
            // 1. COMPARACIÓN DE PROYECTO
            $projectChanges = $this->compareProjectFields($project, $lastProjectPublication);

            // 2. COMPARACIÓN DE ACTIVIDADES
            $activityChanges = $this->compareActivities($project, $lastProjectPublication->publication_id);

            // 3. COMPARACIÓN DE MÉTRICAS
            $metricChanges = $this->compareMetrics($project, $lastProjectPublication->publication_id);

            // Detectar si hay cambios en cualquier nivel
            $hasChanges = count($projectChanges) > 0 || count($activityChanges) > 0 || count($metricChanges) > 0;

            if ($hasChanges) {
                $analysis['needs_action'] = true;
                $analysis['action_type'] = 'update';

                // Crear resumen de cambios con información detallada
                $analysis['detailed_changes'] = [
                    'project' => $projectChanges,
                    'activities' => $activityChanges,
                    'metrics' => $metricChanges
                ];

                // Crear resumen simple para compatibilidad
                if (count($projectChanges) > 0) {
                    $analysis['changes_summary'][] = 'Campos del proyecto modificados: ' . count($projectChanges);
                }
                if (count($activityChanges) > 0) {
                    $analysis['changes_summary'][] = 'Cambios en actividades: ' . count($activityChanges);
                }
                if (count($metricChanges) > 0) {
                    $analysis['changes_summary'][] = 'Cambios en métricas: ' . count($metricChanges);
                }
            }
        } else {
            // Proyecto no publicado en ninguna publicación
            if ($analysis['current_activities_count'] > 0 || $analysis['current_metrics_count'] > 0) {
                $analysis['needs_action'] = true;
                $analysis['action_type'] = 'publish';
                $analysis['changes_summary'][] = 'Nuevo proyecto para publicar';
            }
        }

        return $analysis;
    }

    private function compareProjectFields($project, $publishedProject)
    {
        $changes = [];

        // Convertir fechas a formato Y-m-d para comparación correcta
        $currentStartDate = $project->start_date ? $project->start_date->format('Y-m-d') : null;
        $currentEndDate = $project->end_date ? $project->end_date->format('Y-m-d') : null;

        // Comparar todos los campos del proyecto
        $fieldsToCompare = [
            'name' => 'Nombre',
            'background' => 'Antecedentes',
            'justification' => 'Justificación',
            'general_objective' => 'Objetivo general',
            'total_cost' => 'Costo total',
            'funded_amount' => 'Monto financiado',
            'cofunding_amount' => 'Monto cofinanciado',
            'financiers_id' => 'ID del financiador',
            'co_financier_id' => 'ID del cofinanciador',
        ];

        foreach ($fieldsToCompare as $field => $label) {
            if ($project->$field != $publishedProject->$field) {
                $highlighted = $this->highlightDifferences($publishedProject->$field, $project->$field);
                $changes[] = [
                    'field' => $label,
                    'old_value' => $highlighted['old'],
                    'new_value' => $highlighted['new'],
                    'highlighted' => $highlighted['highlighted']
                ];
            }
        }

        // Comparar fechas por separado
        if ($currentStartDate != $publishedProject->start_date) {
            $changes[] = [
                'field' => 'Fecha de inicio',
                'old_value' => $publishedProject->start_date,
                'new_value' => $currentStartDate,
                'highlighted' => false
            ];
        }
        if ($currentEndDate != $publishedProject->end_date) {
            $changes[] = [
                'field' => 'Fecha de fin',
                'old_value' => $publishedProject->end_date,
                'new_value' => $currentEndDate,
                'highlighted' => false
            ];
        }

        return $changes;
    }

    private function compareActivities($project, $publicationId)
    {
        $changes = [];

        // Obtener actividades actuales del proyecto
        $currentActivities = Activity::whereHas('goal', function($query) use ($project) {
            $query->where('project_id', $project->id);
        })->get();

        // Obtener actividades publicadas del proyecto
        $publishedActivities = \App\Models\PublishedActivity::where('publication_id', $publicationId)
            ->where('project_id', $project->id)
            ->get();

        // Comparar cantidad
        if ($currentActivities->count() != $publishedActivities->count()) {
            $changes[] = [
                'field' => 'Cantidad de actividades',
                'old_value' => $publishedActivities->count(),
                'new_value' => $currentActivities->count(),
                'highlighted' => false
            ];
        }

        // Comparar actividades individuales
        $currentActivityIds = $currentActivities->pluck('id')->toArray();
        $publishedActivityIds = $publishedActivities->pluck('original_activity_id')->toArray();

        // Actividades agregadas
        $addedActivities = array_diff($currentActivityIds, $publishedActivityIds);
        if (count($addedActivities) > 0) {
            $changes[] = [
                'field' => 'Actividades agregadas',
                'old_value' => '0',
                'new_value' => count($addedActivities) . ' actividad(es)',
                'highlighted' => false
            ];
        }

        // Actividades eliminadas
        $removedActivities = array_diff($publishedActivityIds, $currentActivityIds);
        if (count($removedActivities) > 0) {
            $changes[] = [
                'field' => 'Actividades eliminadas',
                'old_value' => count($removedActivities) . ' actividad(es)',
                'new_value' => '0',
                'highlighted' => false
            ];
        }

        // Comparar contenido de actividades existentes
        foreach ($currentActivities as $currentActivity) {
            $publishedActivity = $publishedActivities->where('original_activity_id', $currentActivity->id)->first();
            if ($publishedActivity) {
                if ($currentActivity->name != $publishedActivity->name) {
                    $highlighted = $this->highlightDifferences($publishedActivity->name, $currentActivity->name);
                    $changes[] = [
                        'field' => 'Nombre de actividad (ID: ' . $currentActivity->id . ')',
                        'old_value' => $highlighted['old'],
                        'new_value' => $highlighted['new'],
                        'highlighted' => $highlighted['highlighted']
                    ];
                }
                if ($currentActivity->description != $publishedActivity->description) {
                    $highlighted = $this->highlightDifferences($publishedActivity->description, $currentActivity->description);
                    $changes[] = [
                        'field' => 'Descripción de actividad (ID: ' . $currentActivity->id . ')',
                        'old_value' => $highlighted['old'],
                        'new_value' => $highlighted['new'],
                        'highlighted' => $highlighted['highlighted']
                    ];
                }
            }
        }

        return $changes;
    }

    private function compareMetrics($project, $publicationId)
    {
        $changes = [];

        // Obtener métricas actuales del proyecto
        $currentMetrics = PlannedMetric::whereHas('activity.goal', function($query) use ($project) {
            $query->where('project_id', $project->id);
        })->get();

        // Obtener métricas publicadas del proyecto
        $publishedMetrics = \App\Models\PublishedMetric::where('publication_id', $publicationId)
            ->whereHas('originalMetric.activity.goal', function($query) use ($project) {
                $query->where('project_id', $project->id);
            })->get();

        // Comparar cantidad
        if ($currentMetrics->count() != $publishedMetrics->count()) {
            $changes[] = [
                'field' => 'Cantidad de métricas',
                'old_value' => $publishedMetrics->count(),
                'new_value' => $currentMetrics->count(),
                'highlighted' => false
            ];
        }

        // Comparar métricas individuales
        $currentMetricIds = $currentMetrics->pluck('id')->toArray();
        $publishedMetricIds = $publishedMetrics->pluck('original_metric_id')->toArray();

        // Métricas agregadas
        $addedMetrics = array_diff($currentMetricIds, $publishedMetricIds);
        if (count($addedMetrics) > 0) {
            $changes[] = [
                'field' => 'Métricas agregadas',
                'old_value' => '0',
                'new_value' => count($addedMetrics) . ' métrica(s)',
                'highlighted' => false
            ];
        }

        // Métricas eliminadas
        $removedMetrics = array_diff($publishedMetricIds, $currentMetricIds);
        if (count($removedMetrics) > 0) {
            $changes[] = [
                'field' => 'Métricas eliminadas',
                'old_value' => count($removedMetrics) . ' métrica(s)',
                'new_value' => '0',
                'highlighted' => false
            ];
        }

        // Comparar contenido de métricas existentes
        foreach ($currentMetrics as $currentMetric) {
            $publishedMetric = $publishedMetrics->where('original_metric_id', $currentMetric->id)->first();
            if ($publishedMetric) {
                if ($currentMetric->name != $publishedMetric->name) {
                    $highlighted = $this->highlightDifferences($publishedMetric->name, $currentMetric->name);
                    $changes[] = [
                        'field' => 'Nombre de métrica (ID: ' . $currentMetric->id . ')',
                        'old_value' => $highlighted['old'],
                        'new_value' => $highlighted['new'],
                        'highlighted' => $highlighted['highlighted']
                    ];
                }
                if ($currentMetric->description != $publishedMetric->description) {
                    $highlighted = $this->highlightDifferences($publishedMetric->description, $currentMetric->description);
                    $changes[] = [
                        'field' => 'Descripción de métrica (ID: ' . $currentMetric->id . ')',
                        'old_value' => $highlighted['old'],
                        'new_value' => $highlighted['new'],
                        'highlighted' => $highlighted['highlighted']
                    ];
                }
                if ($currentMetric->target_value != $publishedMetric->target_value) {
                    $highlighted = $this->highlightDifferences($publishedMetric->target_value, $currentMetric->target_value);
                    $changes[] = [
                        'field' => 'Valor objetivo de métrica (ID: ' . $currentMetric->id . ')',
                        'old_value' => $highlighted['old'],
                        'new_value' => $highlighted['new'],
                        'highlighted' => $highlighted['highlighted']
                    ];
                }
            }
        }

        return $changes;
    }

    private function highlightDifferences($oldValue, $newValue, $maxLength = 100)
    {
        // Si los valores son muy largos, truncar para mostrar
        $oldDisplay = strlen($oldValue) > $maxLength ? substr($oldValue, 0, $maxLength) . '...' : $oldValue;
        $newDisplay = strlen($newValue) > $maxLength ? substr($newValue, 0, $maxLength) . '...' : $newValue;

        // Si son valores cortos, usar comparación simple
        if (strlen($oldValue) <= 50 && strlen($newValue) <= 50) {
            return [
                'old' => $oldDisplay,
                'new' => $newDisplay,
                'highlighted' => false
            ];
        }

        // Para valores largos, encontrar las diferencias
        $wordsOld = explode(' ', $oldValue);
        $wordsNew = explode(' ', $newValue);

        $highlightedOld = [];
        $highlightedNew = [];

        // Comparar palabras
        $maxWords = max(count($wordsOld), count($wordsNew));
        for ($i = 0; $i < $maxWords; $i++) {
            $oldWord = $wordsOld[$i] ?? '';
            $newWord = $wordsNew[$i] ?? '';

            if ($oldWord !== $newWord) {
                $highlightedOld[] = '<span class="px-1 text-red-800 bg-red-200 rounded">' . htmlspecialchars($oldWord) . '</span>';
                $highlightedNew[] = '<span class="px-1 text-green-800 bg-green-200 rounded">' . htmlspecialchars($newWord) . '</span>';
            } else {
                $highlightedOld[] = htmlspecialchars($oldWord);
                $highlightedNew[] = htmlspecialchars($newWord);
            }
        }

        return [
            'old' => implode(' ', $highlightedOld),
            'new' => implode(' ', $highlightedNew),
            'highlighted' => true
        ];
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

            $result = $service->publishSelectedProjects(
                Auth::id(),
                $this->selectedProjects,
                $this->publicationNotes ?: 'Aprobación manual desde panel de administración'
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

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

    public $pendingProjects = [];
    public $projectsWithData = [];
    public $projectsWithComparison = [];
    public $publicationNotes = '';
    public $showComparison = false;

    public function mount()
    {
        $this->loadPendingData();
    }

    public function loadPendingData()
    {
        // Obtener proyectos pendientes
        $this->pendingProjects = Project::whereDoesntHave('publishedProjects')->get();

        // Agrupar actividades y métricas por proyecto
        $this->projectsWithData = [];

        foreach ($this->pendingProjects as $project) {
            // Obtener actividades del proyecto
            $activities = Activity::whereDoesntHave('publishedActivities')
                ->whereHas('goal', function($query) use ($project) {
                    $query->where('project_id', $project->id);
                })
                ->with(['goal', 'specificObjective'])
                ->get();

            // Obtener métricas del proyecto
            $metrics = PlannedMetric::whereDoesntHave('publishedMetrics')
                ->whereHas('activity.goal', function($query) use ($project) {
                    $query->where('project_id', $project->id);
                })
                ->with(['activity.goal.project'])
                ->get();

            $this->projectsWithData[] = [
                'project' => $project,
                'activities' => $activities,
                'metrics' => $metrics,
                'activities_count' => $activities->count(),
                'metrics_count' => $metrics->count()
            ];
        }

        // Cargar datos de comparación si se solicita
        if ($this->showComparison) {
            $this->loadComparisonData();
        }
    }

    public function loadComparisonData()
    {
        $this->projectsWithComparison = [];

        // Obtener la última publicación
        $lastPublication = DataPublication::orderBy('publication_date', 'desc')->first();

        if ($lastPublication) {
            foreach ($this->pendingProjects as $project) {
                // Obtener datos actuales del proyecto
                $currentProject = $project;

                // Obtener datos publicados del proyecto
                $publishedProject = $project->publishedProjects()
                    ->where('publication_id', $lastPublication->id)
                    ->first();

                // Obtener actividades actuales vs publicadas
                $currentActivities = Activity::whereHas('goal', function($query) use ($project) {
                    $query->where('project_id', $project->id);
                })->with(['goal', 'specificObjective'])->get();

                // Obtener métricas actuales vs publicadas
                $currentMetrics = PlannedMetric::whereHas('activity.goal', function($query) use ($project) {
                    $query->where('project_id', $project->id);
                })->with(['activity.goal.project'])->get();

                // Obtener actividades publicadas (simplificado)
                $publishedActivities = collect();
                if ($publishedProject) {
                    // Buscar actividades publicadas relacionadas con este proyecto
                    $publishedActivities = \App\Models\PublishedActivity::where('publication_id', $lastPublication->id)
                        ->whereHas('originalActivity.goal', function($query) use ($project) {
                            $query->where('project_id', $project->id);
                        })->get();
                }

                // Obtener métricas publicadas (simplificado)
                $publishedMetrics = collect();
                if ($publishedProject) {
                    // Buscar métricas publicadas relacionadas con este proyecto
                    $publishedMetrics = \App\Models\PublishedMetric::where('publication_id', $lastPublication->id)
                        ->whereHas('originalMetric.activity.goal', function($query) use ($project) {
                            $query->where('project_id', $project->id);
                        })->get();
                }

                $this->projectsWithComparison[] = [
                    'project' => $currentProject,
                    'published_project' => $publishedProject,
                    'current_activities' => $currentActivities,
                    'published_activities' => $publishedActivities,
                    'current_metrics' => $currentMetrics,
                    'published_metrics' => $publishedMetrics,
                    'last_publication' => $lastPublication
                ];
            }
        }
    }

    public function toggleComparison()
    {
        $this->showComparison = !$this->showComparison;

        if ($this->showComparison) {
            $this->loadComparisonData();

            // Debug: verificar si hay datos de comparación
            $lastPublication = DataPublication::orderBy('publication_date', 'desc')->first();

            if ($lastPublication) {
                Notification::make()
                    ->title('Comparación activada')
                    ->body('Última publicación: ' . $lastPublication->publication_date->format('d/m/Y H:i') .
                           ' - Proyectos con comparación: ' . count($this->projectsWithComparison))
                    ->info()
                    ->send();
            } else {
                Notification::make()
                    ->title('No hay datos para comparar')
                    ->body('No se encontraron publicaciones anteriores')
                    ->warning()
                    ->send();
            }
        } else {
            Notification::make()
                ->title('Comparación desactivada')
                ->body('Vista de comparación oculta')
                ->info()
                ->send();
        }
    }

    public function approvePublication()
    {
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

            // Recargar los datos pendientes
            $this->loadPendingData();
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

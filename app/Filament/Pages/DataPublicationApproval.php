<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use App\Models\Project;
use App\Models\Activity;
use App\Models\PlannedMetric;
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
    public $publicationNotes = '';

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

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
    public $pendingActivities = [];
    public $pendingMetrics = [];
    public $publicationNotes = '';

    public function mount()
    {
        $this->loadPendingData();
    }

    public function loadPendingData()
    {
        $this->pendingProjects = Project::whereDoesntHave('publishedProjects')->get();
        $this->pendingActivities = Activity::whereDoesntHave('publishedActivities')->get();
        $this->pendingMetrics = PlannedMetric::whereDoesntHave('publishedMetrics')->get();
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

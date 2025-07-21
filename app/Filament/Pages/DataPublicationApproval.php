<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use App\Models\Project;
use App\Models\PublishedProject;
use App\Models\Activity;
use App\Models\PublishedActivity;
use App\Models\PlannedMetric;
use App\Models\PublishedMetric;

class DataPublicationApproval extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.data-publication-approval';

    public ?Project $pendingProject = null;
    public ?PublishedProject $lastPublishedProject = null;

    public ?Activity $pendingActivity = null;
    public ?PublishedActivity $lastPublishedActivity = null;

    public ?PlannedMetric $pendingMetric = null;
    public ?PublishedMetric $lastPublishedMetric = null;

    public function mount()
    {
        // Project
        $this->pendingProject = Project::latest('id')->first();
        $this->lastPublishedProject = $this->pendingProject
            ? PublishedProject::where('original_project_id', $this->pendingProject->id)
                ->orderByDesc('snapshot_date')
                ->first()
            : null;

        // Activity
        $this->pendingActivity = Activity::latest('id')->first();
        $this->lastPublishedActivity = $this->pendingActivity
            ? PublishedActivity::where('original_activity_id', $this->pendingActivity->id)
                ->orderByDesc('snapshot_date')
                ->first()
            : null;

        // PlannedMetric
        $this->pendingMetric = PlannedMetric::latest('id')->first();
        $this->lastPublishedMetric = $this->pendingMetric
            ? PublishedMetric::where('original_metric_id', $this->pendingMetric->id)
                ->orderByDesc('snapshot_date')
                ->first()
            : null;
    }

    public function getPendingSchema(): array
    {
        return [
            Section::make('Datos a aprobar')
                ->schema([
                    TextEntry::make('name')->label('1. Nombre'),
                    TextEntry::make('description')->label('2. Descripción'),
                    TextEntry::make('total_cost')->label('3. Costo total'),
                ])
        ];
    }

    public function getPublishedSchema(): array
    {
        return [
            Section::make('Última publicación')
                ->schema([
                    TextEntry::make('name')->label('1. Nombre'),
                    TextEntry::make('description')->label('2. Descripción'),
                    TextEntry::make('total_cost')->label('3. Costo total'),
                ])
        ];
    }
}

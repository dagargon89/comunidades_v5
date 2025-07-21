<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use App\Models\Project;
use App\Models\Activity;
use App\Models\PlannedMetric;

class DataPublicationApproval extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.data-publication-approval';

    public $pendingProjects = [];
    public $pendingActivities = [];
    public $pendingMetrics = [];

    public function mount()
    {
        $this->pendingProjects = Project::whereDoesntHave('publishedProjects')->get();
        $this->pendingActivities = Activity::whereDoesntHave('publishedActivities')->get();
        $this->pendingMetrics = PlannedMetric::whereDoesntHave('publishedMetrics')->get();
    }
}

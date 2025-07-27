<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use App\Models\Project;
use App\Models\Activity;
use App\Models\PlannedMetric;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;

class DataPublicationApproval extends Page
{
    use HasPageShield;

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

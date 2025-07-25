<?php

namespace App\Observers;

use App\Models\Project;
use App\Models\Activity;
use App\Models\PlannedMetric;
use Illuminate\Support\Facades\Log;

class ProjectObserver
{
    /**
     * Handle the Project "created" event.
     */
    public function created(Project $project): void
    {
        //
    }

    /**
     * Handle the Project "updated" event.
     */
    public function updated(Project $project): void
    {
        //
    }

    /**
     * Handle the Project "deleted" event.
     */
    public function deleted(Project $project): void
    {
        //
    }

    /**
     * Handle the Project "deleting" event.
     */
    public function deleting(Project $project): void
    {
        Log::info('ProjectObserver: Observer ejecutado para proyecto: ' . $project->id);
        // La lógica principal de eliminación de PlannedMetric está en el modelo Project
    }

    /**
     * Handle the Project "restored" event.
     */
    public function restored(Project $project): void
    {
        //
    }

    /**
     * Handle the Project "force deleted" event.
     */
    public function forceDeleted(Project $project): void
    {
        //
    }
}

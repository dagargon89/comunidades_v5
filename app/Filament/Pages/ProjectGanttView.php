<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Actions\Action;
use Filament\Forms;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\TimePicker;
use App\Models\Project;
use App\Models\Goal;
use App\Models\Activity;
use App\Models\User;
use App\Models\Location;
use App\Models\ActivityCalendar;
use Illuminate\Support\Facades\Auth;
use Filament\Notifications\Notification;
use Illuminate\Validation\ValidationException;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use App\Models\Polygon;

class ProjectGanttView extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.project-gantt-view';

    public $ganttTasks = [];

    public function mount()
    {
        $this->ganttTasks = ActivityCalendar::with(['activity' => function($q) { $q->select('id', 'name', 'goals_id'); }])
            ->get()
            ->map(function ($calendar) {
                // Obtener el project_id a través de la relación Goal
                $projectId = null;
                if ($calendar->activity && $calendar->activity->goals_id) {
                    $goal = Goal::find($calendar->activity->goals_id);
                    $projectId = $goal ? $goal->project_id : null;
                }
                return [
                    'id' => $calendar->id,
                    'name' => $calendar->activity ? $calendar->activity->name : 'Sin nombre',
                    'start' => $calendar->start_date ? Carbon::parse($calendar->start_date)->format('Y-m-d') : null,
                    'end' => $calendar->end_date ? Carbon::parse($calendar->end_date)->format('Y-m-d') : null,
                    'progress' => 0,
                    'project_id' => $projectId,
                    'custom_class' => 'gantt-project-' . ($projectId ?? 'default'),
                ];
            })->toArray();
    }

    public function getViewData(): array
    {
        return [
            'projects' => \App\Models\Project::pluck('name', 'id')->toArray(),
            'users' => \App\Models\User::pluck('name', 'id')->toArray(),
            'ganttTasks' => $this->ganttTasks,
        ];
    }

    public function getHeaderActions(): array
    {
        return [
            // Se eliminan los botones de programar y editar actividad
        ];
    }
}

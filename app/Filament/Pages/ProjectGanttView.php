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

class ProjectGanttView extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.project-gantt-view';

    public function getHeaderActions(): array
    {
        return [
            Action::make('programar')
                ->label('Programar actividad')
                ->icon('heroicon-o-plus')
                ->color('primary')
                ->form([
                    Select::make('project_id')
                        ->label('Proyecto')
                        ->options(Project::pluck('name', 'id'))
                        ->searchable()
                        ->required()
                        ->reactive(),
                    Select::make('activity_id')
                        ->label('Actividad')
                        ->options(function (callable $get) {
                            $projectId = $get('project_id');
                            if (!$projectId) return [];
                            $goalIds = Goal::where('project_id', $projectId)->pluck('id');
                            return Activity::whereIn('goals_id', $goalIds)->pluck('name', 'id');
                        })
                        ->searchable()
                        ->required()
                        ->reactive(),
                    DatePicker::make('start_date')
                        ->label('Fecha de inicio')
                        ->required(),
                    DatePicker::make('end_date')
                        ->label('Fecha de finalización')
                        ->required(),
                    TimePicker::make('start_hour')
                        ->label('Hora de inicio')
                        ->required(),
                    TimePicker::make('end_hour')
                        ->label('Hora de finalización')
                        ->required(),
                    Select::make('assigned_person')
                        ->label('Responsable')
                        ->options(User::pluck('name', 'id'))
                        ->searchable()
                        ->required(),
                    Select::make('location_id')
                        ->label('Ubicación')
                        ->options(Location::pluck('name', 'id'))
                        ->searchable()
                        ->required(),
                ])
                ->action(function (array $data) {
                    // Guardar en activity_calendars
                    ActivityCalendar::create([
                        'activity_id' => $data['activity_id'],
                        'start_date' => $data['start_date'],
                        'end_date' => $data['end_date'],
                        'start_hour' => $data['start_hour'],
                        'end_hour' => $data['end_hour'],
                        'assigned_person' => $data['assigned_person'],
                        'location_id' => $data['location_id'],
                        'created_by' => Auth::id(),
                    ]);
                    \Filament\Notifications\Notification::make()
                        ->title('Actividad calendarizada correctamente')
                        ->success()
                        ->send();
                }),
        ];
    }
}

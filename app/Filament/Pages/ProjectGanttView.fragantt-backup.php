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
                    \Filament\Forms\Components\Placeholder::make('project_dates')
                        ->label('Fechas del proyecto')
                        ->content(fn ($get) => Project::find($get('project_id'))
                            ? 'Inicio: ' . (Project::find($get('project_id'))->start_date ? \Carbon\Carbon::parse(Project::find($get('project_id'))->start_date)->format('d/m/Y') : '-') .
                              ' - Fin: ' . (Project::find($get('project_id'))->end_date ? \Carbon\Carbon::parse(Project::find($get('project_id'))->end_date)->format('d/m/Y') : '-')
                            : 'Seleccione un proyecto'),
                    \Filament\Forms\Components\Fieldset::make('Datos de la actividad')
                        ->schema([
                            \Filament\Forms\Components\Grid::make(2)
                                ->schema([
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
                                    Select::make('assigned_person')
                                        ->label('Responsable')
                                        ->options(function () {
                                            return User::pluck('name', 'id')->filter();
                                        })
                                        ->searchable()
                                        ->required(),
                                ]),
                            \Filament\Forms\Components\Grid::make(2)
                                ->schema([
                                    DatePicker::make('start_date')
                                        ->label('Fecha de inicio')
                                        ->required()
                                        ->minDate(fn ($get) => Project::find($get('project_id'))?->start_date)
                                        ->maxDate(fn ($get) => Project::find($get('project_id'))?->end_date),
                                    DatePicker::make('end_date')
                                        ->label('Fecha de finalización')
                                        ->required()
                                        ->minDate(fn ($get) => Project::find($get('project_id'))?->start_date)
                                        ->maxDate(fn ($get) => Project::find($get('project_id'))?->end_date),
                                ]),
                            \Filament\Forms\Components\Grid::make(2)
                                ->schema([
                                    TimePicker::make('start_hour')
                                        ->label('Hora de inicio')
                                        ->required(),
                                    TimePicker::make('end_hour')
                                        ->label('Hora de finalización')
                                        ->required(),
                                ]),
                            \Filament\Forms\Components\Grid::make(1)
                                ->schema([
                                    Select::make('location_id')
                                        ->label('Ubicación')
                                        ->options(Location::pluck('name', 'id'))
                                        ->searchable()
                                        ->required()
                                        ->reactive()
                                        ->createOptionForm([
                                            Forms\Components\TextInput::make('name')->label('Nombre')->required(),
                                            Forms\Components\TextInput::make('category')->label('Categoría'),
                                            Forms\Components\TextInput::make('street')->label('Calle'),
                                            Forms\Components\TextInput::make('neighborhood')->label('Colonia'),
                                            Forms\Components\TextInput::make('ext_number')->label('Número exterior'),
                                            Forms\Components\TextInput::make('int_number')->label('Número interior'),
                                            Forms\Components\TextInput::make('google_place_id')->label('Google Place ID'),
                                            Forms\Components\Select::make('polygons_id')
                                                ->label('Polígono')
                                                ->options(Polygon::pluck('name', 'id'))
                                                ->searchable()
                                                ->required(),
                                        ]),
                                ]),
                        ]),
                ])
                ->action(function (array $data) {
                    try {
                        if (!isset($data['assigned_person']) || !$data['assigned_person']) {
                            throw ValidationException::withMessages([
                                'assigned_person' => 'Debes seleccionar un responsable.',
                            ]);
                        }
                        // Validación extra para asegurar que las fechas estén dentro del rango del proyecto
                        $project = Project::find($data['project_id']);
                        if ($project) {
                            $startDate = Carbon::parse($data['start_date']);
                            $endDate = Carbon::parse($data['end_date']);
                            $projectStart = Carbon::parse($project->start_date);
                            $projectEnd = Carbon::parse($project->end_date);

                            if ($startDate->lt($projectStart) || $endDate->gt($projectEnd)) {
                                throw ValidationException::withMessages([
                                    'start_date' => 'Las fechas de la actividad deben estar dentro del rango del proyecto.',
                                ]);
                            }
                        }
                        // Antes de crear la actividad calendarizada, loguear los datos recibidos
                        Log::info('Datos recibidos para crear actividad:', $data);
                        Log::info('Valor de location_id recibido al crear:', ['location_id' => $data['location_id'], 'data' => $data]);
                        $activityCalendar = ActivityCalendar::create([
                            'activity_id' => $data['activity_id'],
                            'start_date' => $data['start_date'],
                            'end_date' => $data['end_date'],
                            'start_hour' => $data['start_hour'],
                            'end_hour' => $data['end_hour'],
                            'assigned_person' => $data['assigned_person'], // usuario seleccionado en el desplegable
                            'created_by' => Auth::id(), // usuario autenticado
                            'location_id' => $data['location_id'] ? (int) $data['location_id'] : null,
                        ]);
                        if (!$activityCalendar) {
                            throw new \Exception('No se pudo guardar la actividad.');
                        }
                        Notification::make()
                            ->title('Actividad calendarizada correctamente')
                            ->success()
                            ->send();
                        return redirect(request()->header('Referer'));
                    } catch (\Throwable $e) {
                        Log::error('Error al guardar actividad calendarizada: ' . $e->getMessage(), ['exception' => $e]);
                        Notification::make()
                            ->title('Error al guardar la actividad')
                            ->body('Ocurrió un error al intentar guardar la actividad. Por favor, revisa los datos e inténtalo de nuevo.')
                            ->danger()
                            ->send();
                        throw $e;
                    }
                }),
            Action::make('editar')
                ->label('Editar actividades')
                ->icon('heroicon-o-pencil-square')
                ->color('warning')
                ->visible(true)
                ->disabled(false)
                ->form([
                    Select::make('project_id')
                        ->label('Proyecto')
                        ->options(Project::pluck('name', 'id'))
                        ->searchable()
                        ->required()
                        ->reactive(),
                    Select::make('activity_calendar_id')
                        ->label('Actividad calendarizada')
                        ->options(function (callable $get) {
                            $projectId = $get('project_id');
                            if (!$projectId) return [];
                            $goalIds = Goal::where('project_id', $projectId)->pluck('id');
                            $activityIds = Activity::whereIn('goals_id', $goalIds)->pluck('id');
                            return ActivityCalendar::whereIn('activity_id', $activityIds)
                                ->get()
                                ->mapWithKeys(function ($calendar) {
                                    $actividad = $calendar->activity ? $calendar->activity->name : 'Sin nombre';
                                    $fecha = $calendar->start_date;
                                    $hora = $calendar->start_hour;
                                    return [$calendar->id => "$actividad ($fecha $hora)"];
                                })->toArray();
                        })
                        ->searchable()
                        ->required()
                        ->reactive()
                        ->afterStateUpdated(function ($state, $set) {
                            $calendar = ActivityCalendar::find($state);
                            if ($calendar) {
                                $set('start_date', $calendar->start_date ? \Carbon\Carbon::parse($calendar->start_date)->format('Y-m-d') : null);
                                $set('end_date', $calendar->end_date ? \Carbon\Carbon::parse($calendar->end_date)->format('Y-m-d') : null);
                                $set('start_hour', $calendar->start_hour);
                                $set('end_hour', $calendar->end_hour);
                                $set('assigned_person', $calendar->assigned_person);
                                $set('location_id', $calendar->location_id ? (string) $calendar->location_id : null);
                            }
                        }),
                    DatePicker::make('start_date')
                        ->label('Fecha de inicio')
                        ->required()
                        ->reactive(),
                    DatePicker::make('end_date')
                        ->label('Fecha de finalización')
                        ->required()
                        ->reactive(),
                    TimePicker::make('start_hour')
                        ->label('Hora de inicio')
                        ->required()
                        ->reactive(),
                    TimePicker::make('end_hour')
                        ->label('Hora de finalización')
                        ->required()
                        ->reactive(),
                    Select::make('assigned_person')
                        ->label('Responsable')
                        ->options(User::pluck('name', 'id'))
                        ->searchable()
                        ->required()
                        ->reactive(),
                    Select::make('location_id')
                        ->label('Ubicación')
                        ->options(Location::pluck('name', 'id'))
                        ->searchable()
                        ->required()
                        ->reactive()
                        ->createOptionForm([
                            Forms\Components\TextInput::make('name')->label('Nombre')->required(),
                            Forms\Components\TextInput::make('category')->label('Categoría'),
                            Forms\Components\TextInput::make('street')->label('Calle'),
                            Forms\Components\TextInput::make('neighborhood')->label('Colonia'),
                            Forms\Components\TextInput::make('ext_number')->label('Número exterior'),
                            Forms\Components\TextInput::make('int_number')->label('Número interior'),
                            Forms\Components\TextInput::make('google_place_id')->label('Google Place ID'),
                            Forms\Components\Select::make('polygons_id')
                                ->label('Polígono')
                                ->options(Polygon::pluck('name', 'id'))
                                ->searchable()
                                ->required(),
                        ])
                        ->createOptionUsing(function (array $data) {
                            $data['created_by'] = Auth::id();
                            Location::create($data);
                            return null; // No selecciona automáticamente la nueva ubicación
                        }),
                ])
                ->action(function (array $data) {
                    $calendar = ActivityCalendar::find($data['activity_calendar_id']);
                    if (!$calendar) {
                        Notification::make()
                            ->title('No se encontró la actividad calendarizada')
                            ->danger()
                            ->send();
                        return;
                    }
                    Log::info('Valor de location_id recibido al actualizar:', ['location_id' => $data['location_id'], 'data' => $data]);
                    $calendar->update([
                        'start_date' => $data['start_date'],
                        'end_date' => $data['end_date'],
                        'start_hour' => $data['start_hour'],
                        'end_hour' => $data['end_hour'],
                        'assigned_person' => $data['assigned_person'],
                        'location_id' => $data['location_id'] ? (int) $data['location_id'] : null,
                    ]);
                    Notification::make()
                        ->title('Actividad calendarizada actualizada correctamente')
                        ->success()
                        ->send();
                    return redirect(request()->header('Referer'));
                }),
        ];
    }
}

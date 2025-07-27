<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TimePicker;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Section;
use App\Models\Project;
use App\Models\Goal;
use App\Models\Activity;
use App\Models\User;
use App\Models\Location;
use App\Models\Polygon;
use App\Models\ActivityCalendar;
use Illuminate\Support\Facades\Auth;
use Filament\Notifications\Notification;
use Illuminate\Validation\ValidationException;
use Carbon\Carbon;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;

class ActivityCalendarView extends Page implements Forms\Contracts\HasForms
{
    use Forms\Concerns\InteractsWithForms, HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-calendar-days';
    protected static string $view = 'filament.pages.activity-calendar-view';
    protected static ?string $slug = 'activity-calendar-view';
    public static function shouldRegisterNavigation(): bool
    {
        return false;
    }

    public function getTitle(): string
    {
        return 'Gestión de actividades';
    }

    public ?array $data = [];

    public function mount(): void
    {
        $this->form->fill();
    }

    public function form(Forms\Form $form): Forms\Form
    {
        return $form
            ->schema([
                Section::make('Proyecto')
                    ->description('Selecciona el proyecto para programar la actividad')
                    ->schema([
                        Select::make('project_id')
                            ->label('Proyecto')
                            ->options(Project::pluck('name', 'id'))
                            ->searchable()
                            ->required()
                            ->reactive(),
                        Placeholder::make('project_dates')
                            ->label('Fechas del proyecto')
                            ->content(fn ($get) => Project::find($get('project_id'))
                                ? 'Inicio: ' . (Project::find($get('project_id'))->start_date ? \Carbon\Carbon::parse(Project::find($get('project_id'))->start_date)->format('d/m/Y') : '-') .
                                  ' - Fin: ' . (Project::find($get('project_id'))->end_date ? \Carbon\Carbon::parse(Project::find($get('project_id'))->end_date)->format('d/m/Y') : '-')
                                : 'Seleccione un proyecto'),
                    ]),
                Section::make('Actividad')
                    ->description('Datos de la actividad a calendarizar')
                    ->schema([
                        Section::make()
                            ->columns(2)
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
                                    ->options(User::pluck('name', 'id'))
                                    ->searchable()
                                    ->required(),
                            ]),
                        Section::make()
                            ->columns(2)
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
                        Section::make()
                            ->columns(2)
                            ->schema([
                                TimePicker::make('start_hour')
                                    ->label('Hora de inicio')
                                    ->required(),
                                TimePicker::make('end_hour')
                                    ->label('Hora de finalización')
                                    ->required(),
                            ]),
                        Section::make()
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
                                    ])
                                    ->createOptionUsing(function (array $data) {
                                        $data['created_by'] = Auth::id();
                                        $location = Location::create($data);
                                        return $location->id;
                                    }),
                            ]),
                    ]),
            ])
            ->statePath('data');
    }

    public function submit(): void
    {
        $data = $this->form->getState();
        try {
            if (!isset($data['assigned_person']) || !$data['assigned_person']) {
                throw ValidationException::withMessages([
                    'assigned_person' => 'Debes seleccionar un responsable.',
                ]);
            }
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
            $activityCalendar = ActivityCalendar::create([
                'activity_id' => $data['activity_id'],
                'start_date' => $data['start_date'],
                'end_date' => $data['end_date'],
                'start_hour' => $data['start_hour'],
                'end_hour' => $data['end_hour'],
                'assigned_person' => $data['assigned_person'],
                'created_by' => Auth::id(),
                'location_id' => $data['location_id'] ? (int) $data['location_id'] : null,
            ]);
            if (!$activityCalendar) {
                throw new \Exception('No se pudo guardar la actividad.');
            }
            Notification::make()
                ->title('Actividad calendarizada correctamente')
                ->success()
                ->send();
            $this->form->fill([]);
        } catch (\Throwable $e) {
            Notification::make()
                ->title('Error al guardar la actividad')
                ->body('Ocurrió un error al intentar guardar la actividad. Por favor, revisa los datos e inténtalo de nuevo.')
                ->danger()
                ->send();
            throw $e;
        }
    }
}

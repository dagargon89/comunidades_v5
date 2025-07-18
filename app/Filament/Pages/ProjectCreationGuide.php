<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms\Form;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Repeater;
use Filament\Actions\Action;
use Filament\Notifications\Notification;
use Illuminate\Support\Facades\Session;
use App\Models\Financier;
use App\Models\SpecificObjective;
use App\Models\Activity;
use App\Models\Location;

class ProjectCreationGuide extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Guía de Creación de Proyectos';
    protected static ?string $title = 'Guía de Creación de Proyectos';

    protected static string $view = 'filament.pages.project-creation-guide';

    // Propiedades para almacenar datos temporales
    public $projectData = null;
    public $objectivesData = [];
    public $kpisData = [];
    public $cofinanciersData = [];
    public $activitiesData = [];
    public $locationsData = [];
    public $scheduledActivitiesData = [];

    public function mount()
    {
        $this->loadTemporaryData();
    }

    public function loadTemporaryData()
    {
        $this->projectData = Session::get('project_creation_guide.project', null);
        $this->objectivesData = Session::get('project_creation_guide.objectives', []);
        $this->kpisData = Session::get('project_creation_guide.kpis', []);
        $this->cofinanciersData = Session::get('project_creation_guide.cofinanciers', []);
        $this->activitiesData = Session::get('project_creation_guide.activities', []);
        $this->locationsData = Session::get('project_creation_guide.locations', []);
        $this->scheduledActivitiesData = Session::get('project_creation_guide.scheduled_activities', []);
    }

    public function saveTemporaryData()
    {
        Session::put('project_creation_guide.project', $this->projectData);
        Session::put('project_creation_guide.objectives', $this->objectivesData);
        Session::put('project_creation_guide.kpis', $this->kpisData);
        Session::put('project_creation_guide.cofinanciers', $this->cofinanciersData);
        Session::put('project_creation_guide.activities', $this->activitiesData);
        Session::put('project_creation_guide.locations', $this->locationsData);
        Session::put('project_creation_guide.scheduled_activities', $this->scheduledActivitiesData);
    }

    // Método para calcular progreso
    public function getCompletedStepsProperty()
    {
        $steps = 0;
        if ($this->projectData) $steps++;
        if ($this->objectivesData && count($this->objectivesData) > 0) $steps++;
        if ($this->kpisData && count($this->kpisData) > 0) $steps++;
        if ($this->cofinanciersData && count($this->cofinanciersData) > 0) $steps++;
        if ($this->activitiesData && count($this->activitiesData) > 0) $steps++;
        if ($this->locationsData && count($this->locationsData) > 0) $steps++;
        if ($this->scheduledActivitiesData && count($this->scheduledActivitiesData) > 0) $steps++;

        return $steps;
    }

    public function getTotalStepsProperty()
    {
        return 7;
    }

    // Métodos auxiliares para los selectores
    private function getObjectivesOptions()
    {
        $options = [];
        foreach ($this->objectivesData as $index => $objective) {
            $options[$index] = $objective['description'] ?? "Objetivo " . ($index + 1);
        }
        return $options;
    }

    private function getActivitiesOptions()
    {
        $options = [];
        foreach ($this->activitiesData as $index => $activity) {
            $options[$index] = $activity['name'] ?? "Actividad " . ($index + 1);
        }
        return $options;
    }

    private function getLocationsOptions()
    {
        $options = [];
        foreach ($this->locationsData as $index => $location) {
            $options[$index] = $location['name'] ?? $location['street'] ?? "Ubicación " . ($index + 1);
        }
        return $options;
    }

    private function getActivityName($activityId)
    {
        return $this->activitiesData[$activityId]['name'] ?? "Actividad " . ($activityId + 1);
    }

        // Acciones para abrir modales
    protected function getHeaderActions(): array
    {
        $actions = [
            Action::make('projectModal')
                ->label('Crear Proyecto')
                ->icon('heroicon-o-plus')
                ->form([
                    Section::make('Información Básica del Proyecto')
                        ->schema([
                            TextInput::make('name')
                                ->label('Nombre del Proyecto')
                                ->required()
                                ->maxLength(255),

                            Select::make('financiers_id')
                                ->label('Financiadora')
                                ->options(Financier::all()->pluck('name', 'id'))
                                ->required()
                                ->searchable(),

                            Textarea::make('general_objective')
                                ->label('Objetivo General')
                                ->required()
                                ->rows(4),

                            Textarea::make('background')
                                ->label('Antecedentes')
                                ->required()
                                ->rows(4),

                            Textarea::make('justification')
                                ->label('Justificación')
                                ->required()
                                ->rows(4),

                            Grid::make(2)
                                ->schema([
                                    DatePicker::make('start_date')
                                        ->label('Fecha de Inicio')
                                        ->required(),

                                    DatePicker::make('end_date')
                                        ->label('Fecha de Finalización')
                                        ->required()
                                        ->after('start_date'),
                                ]),

                            Grid::make(2)
                                ->schema([
                                    TextInput::make('total_cost')
                                        ->label('Costo Total')
                                        ->numeric()
                                        ->required()
                                        ->prefix('$'),

                                    TextInput::make('funded_amount')
                                        ->label('Cantidad Financiada')
                                        ->numeric()
                                        ->required()
                                        ->prefix('$'),
                                ]),

                            Grid::make(2)
                                ->schema([
                                    Select::make('cofinancier_id')
                                        ->label('Cofinanciador')
                                        ->options(Financier::all()->pluck('name', 'id'))
                                        ->searchable(),

                                    TextInput::make('cofunding_amount')
                                        ->label('Cantidad Cofinanciada')
                                        ->numeric()
                                        ->prefix('$'),
                                ]),

                            Grid::make(2)
                                ->schema([
                                    TextInput::make('monthly_disbursement')
                                        ->label('Ministración Mensual')
                                        ->numeric()
                                        ->prefix('$'),

                                    TextInput::make('followup_officer')
                                        ->label('Encargado de Seguimiento')
                                        ->maxLength(255),
                                ]),

                            Grid::make(2)
                                ->schema([
                                    FileUpload::make('agreement_file')
                                        ->label('Convenio')
                                        ->acceptedFileTypes(['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'])
                                        ->maxSize(10240),

                                    FileUpload::make('project_base_file')
                                        ->label('Proyecto Base')
                                        ->acceptedFileTypes(['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'])
                                        ->maxSize(10240),
                                ]),
                        ])
                ])
                ->action(function (array $data) {
                    $this->projectData = $data;
                    $this->saveTemporaryData();

                    Notification::make()
                        ->title('Proyecto guardado temporalmente')
                        ->success()
                        ->send();
                })
                ->modalHeading('Información Básica del Proyecto')
                ->modalSubmitActionLabel('Guardar Proyecto')
                ->modalCancelActionLabel('Cancelar'),
        ];

        // Solo mostrar las siguientes acciones si ya existe un proyecto
        if ($this->projectData) {
            $actions[] = Action::make('objectivesModal')
                ->label('Crear Objetivos')
                ->icon('heroicon-o-list-bullet')
                ->form([
                    Section::make('Objetivos Específicos')
                        ->schema([
                            Repeater::make('objectives')
                                ->label('Objetivos')
                                ->schema([
                                    TextInput::make('description')
                                        ->label('Descripción del Objetivo')
                                        ->required()
                                        ->maxLength(500),
                                ])
                                ->addActionLabel('Agregar Objetivo')
                                ->reorderable()
                                ->collapsible()
                                ->itemLabel(fn (array $state): ?string => $state['description'] ?? null),
                        ])
                ])
                ->action(function (array $data) {
                    $this->objectivesData = $data['objectives'] ?? [];
                    $this->saveTemporaryData();

                    Notification::make()
                        ->title('Objetivos guardados temporalmente')
                        ->success()
                        ->send();
                })
                ->modalHeading('Objetivos Específicos')
                ->modalSubmitActionLabel('Guardar Objetivos')
                ->modalCancelActionLabel('Cancelar');

            $actions[] = Action::make('kpisModal')
                ->label('Crear KPIs')
                ->icon('heroicon-o-chart-bar')
                ->form([
                    Section::make('Indicadores de Rendimiento (KPIs)')
                        ->schema([
                            Repeater::make('kpis')
                                ->label('KPIs')
                                ->schema([
                                    TextInput::make('name')
                                        ->label('Nombre del KPI')
                                        ->required()
                                        ->maxLength(255),

                                    Textarea::make('description')
                                        ->label('Descripción')
                                        ->required()
                                        ->rows(3),

                                    Grid::make(2)
                                        ->schema([
                                            TextInput::make('initial_value')
                                                ->label('Valor Inicial')
                                                ->numeric()
                                                ->required(),

                                            TextInput::make('final_value')
                                                ->label('Valor Meta')
                                                ->numeric()
                                                ->required(),
                                        ]),

                                    \Filament\Forms\Components\Checkbox::make('is_percentage')
                                        ->label('Es Porcentaje?'),
                                ])
                                ->addActionLabel('Agregar KPI')
                                ->reorderable()
                                ->collapsible()
                                ->itemLabel(fn (array $state): ?string => $state['name'] ?? null),
                        ])
                ])
                ->action(function (array $data) {
                    $this->kpisData = $data['kpis'] ?? [];
                    $this->saveTemporaryData();

                    Notification::make()
                        ->title('KPIs guardados temporalmente')
                        ->success()
                        ->send();
                })
                ->modalHeading('Indicadores de Rendimiento (KPIs)')
                ->modalSubmitActionLabel('Guardar KPIs')
                ->modalCancelActionLabel('Cancelar');

            $actions[] = Action::make('cofinanciersModal')
                ->label('Agregar Cofinanciadores')
                ->icon('heroicon-o-currency-dollar')
                ->form([
                    Section::make('Cofinanciadores')
                        ->schema([
                            Repeater::make('cofinanciers')
                                ->label('Cofinanciadores')
                                ->schema([
                                    Select::make('financier_id')
                                        ->label('Cofinanciador')
                                        ->options(Financier::all()->pluck('name', 'id'))
                                        ->required()
                                        ->searchable(),

                                    TextInput::make('amount')
                                        ->label('Cantidad Cofinanciada')
                                        ->numeric()
                                        ->required()
                                        ->prefix('$'),
                                ])
                                ->addActionLabel('Agregar Cofinanciador')
                                ->reorderable()
                                ->collapsible()
                                ->itemLabel(fn (array $state): ?string =>
                                    $state['financier_id'] ? Financier::find($state['financier_id'])?->name : null
                                ),
                        ])
                ])
                ->action(function (array $data) {
                    $this->cofinanciersData = $data['cofinanciers'] ?? [];
                    $this->saveTemporaryData();

                    Notification::make()
                        ->title('Cofinanciadores guardados temporalmente')
                        ->success()
                        ->send();
                })
                ->modalHeading('Cofinanciadores')
                ->modalSubmitActionLabel('Guardar Cofinanciadores')
                ->modalCancelActionLabel('Cancelar');

            // Solo mostrar actividades si hay objetivos específicos
            if ($this->objectivesData && count($this->objectivesData) > 0) {
                $actions[] = Action::make('activitiesModal')
                    ->label('Crear Actividades')
                    ->icon('heroicon-o-calendar')
                    ->form([
                        Section::make('Actividades del Proyecto')
                            ->schema([
                                Repeater::make('activities')
                                    ->label('Actividades')
                                    ->schema([
                                        TextInput::make('name')
                                            ->label('Nombre de la Actividad')
                                            ->required()
                                            ->maxLength(255),

                                        Textarea::make('description')
                                            ->label('Descripción')
                                            ->required()
                                            ->rows(3),

                                        Select::make('specific_objective_id')
                                            ->label('Objetivo Específico')
                                            ->options($this->getObjectivesOptions())
                                            ->required()
                                            ->searchable(),

                                        Grid::make(2)
                                            ->schema([
                                                TextInput::make('population_target_value')
                                                    ->label('Población Meta')
                                                    ->numeric()
                                                    ->required(),

                                                TextInput::make('product_target_value')
                                                    ->label('Productos Meta')
                                                    ->numeric()
                                                    ->required(),
                                            ]),
                                    ])
                                    ->addActionLabel('Agregar Actividad')
                                    ->reorderable()
                                    ->collapsible()
                                    ->itemLabel(fn (array $state): ?string => $state['name'] ?? null),
                            ])
                    ])
                    ->action(function (array $data) {
                        $this->activitiesData = $data['activities'] ?? [];
                        $this->saveTemporaryData();

                        Notification::make()
                            ->title('Actividades guardadas temporalmente')
                            ->success()
                            ->send();
                    })
                    ->modalHeading('Actividades del Proyecto')
                    ->modalSubmitActionLabel('Guardar Actividades')
                    ->modalCancelActionLabel('Cancelar');
            }

            // Ubicaciones (independiente)
            $actions[] = Action::make('locationsModal')
                ->label('Crear Ubicaciones')
                ->icon('heroicon-o-map-pin')
                ->form([
                    Section::make('Ubicaciones del Proyecto')
                        ->schema([
                            Repeater::make('locations')
                                ->label('Ubicaciones')
                                ->schema([
                                    TextInput::make('street')
                                        ->label('Calle')
                                        ->required()
                                        ->maxLength(255),

                                    Grid::make(2)
                                        ->schema([
                                            TextInput::make('ext_number')
                                                ->label('Número Exterior')
                                                ->maxLength(50),

                                            TextInput::make('int_number')
                                                ->label('Número Interior')
                                                ->maxLength(50),
                                        ]),

                                    TextInput::make('neighborhood')
                                        ->label('Colonia')
                                        ->required()
                                        ->maxLength(255),

                                    Select::make('polygons_id')
                                        ->label('Polígono')
                                        ->options(\App\Models\Polygon::all()->pluck('name', 'id'))
                                        ->required()
                                        ->searchable(),

                                    Select::make('category')
                                        ->label('Categoría')
                                        ->options([
                                            'Centro comunitario' => 'Centro comunitario',
                                            'Escuela' => 'Escuela',
                                            'Hospital' => 'Hospital',
                                            'Parque' => 'Parque',
                                            'Oficina gubernamental' => 'Oficina gubernamental',
                                            'Otro' => 'Otro',
                                        ])
                                        ->required(),

                                    TextInput::make('google_place_id')
                                        ->label('Google Place ID')
                                        ->maxLength(255),

                                    TextInput::make('name')
                                        ->label('Apodo (opcional)')
                                        ->maxLength(255),
                                ])
                                ->addActionLabel('Agregar Ubicación')
                                ->reorderable()
                                ->collapsible()
                                ->itemLabel(fn (array $state): ?string => $state['name'] ?? $state['street'] ?? null),
                        ])
                ])
                ->action(function (array $data) {
                    $this->locationsData = $data['locations'] ?? [];
                    $this->saveTemporaryData();

                    Notification::make()
                        ->title('Ubicaciones guardadas temporalmente')
                        ->success()
                        ->send();
                })
                ->modalHeading('Ubicaciones del Proyecto')
                ->modalSubmitActionLabel('Guardar Ubicaciones')
                ->modalCancelActionLabel('Cancelar');

            // Programación de actividades (depende de actividades y ubicaciones)
            if (($this->activitiesData && count($this->activitiesData) > 0) &&
                ($this->locationsData && count($this->locationsData) > 0)) {
                $actions[] = Action::make('schedulingModal')
                    ->label('Programar Actividades')
                    ->icon('heroicon-o-clock')
                    ->form([
                        Section::make('Programación de Actividades')
                            ->schema([
                                Repeater::make('scheduled_activities')
                                    ->label('Actividades Programadas')
                                    ->schema([
                                        Select::make('activity_id')
                                            ->label('Actividad')
                                            ->options($this->getActivitiesOptions())
                                            ->required()
                                            ->searchable(),

                                        Grid::make(2)
                                            ->schema([
                                                DatePicker::make('start_date')
                                                    ->label('Fecha de Inicio')
                                                    ->required(),

                                                DatePicker::make('end_date')
                                                    ->label('Fecha de Finalización')
                                                    ->required()
                                                    ->after('start_date'),
                                            ]),

                                        Grid::make(2)
                                            ->schema([
                                                \Filament\Forms\Components\TimePicker::make('start_hour')
                                                    ->label('Hora de Inicio')
                                                    ->required(),

                                                \Filament\Forms\Components\TimePicker::make('end_hour')
                                                    ->label('Hora de Finalización')
                                                    ->required(),
                                            ]),

                                        Select::make('location_id')
                                            ->label('Ubicación')
                                            ->options($this->getLocationsOptions())
                                            ->required()
                                            ->searchable(),

                                        TextInput::make('assigned_person')
                                            ->label('Responsable')
                                            ->required()
                                            ->maxLength(255),
                                    ])
                                    ->addActionLabel('Agregar Programación')
                                    ->reorderable()
                                    ->collapsible()
                                    ->itemLabel(fn (array $state): ?string =>
                                        $state['activity_id'] ? $this->getActivityName($state['activity_id']) : null
                                    ),
                            ])
                    ])
                    ->action(function (array $data) {
                        $this->scheduledActivitiesData = $data['scheduled_activities'] ?? [];
                        $this->saveTemporaryData();

                        Notification::make()
                            ->title('Programación guardada temporalmente')
                            ->success()
                            ->send();
                    })
                    ->modalHeading('Programación de Actividades')
                    ->modalSubmitActionLabel('Guardar Programación')
                    ->modalCancelActionLabel('Cancelar');
            }
        }

        return $actions;
    }

    // Método para guardar todo finalmente
    public function saveAllData()
    {
        try {
            // Aquí implementaremos la lógica para guardar todo en las tablas
            // Por ahora solo limpiaremos los datos temporales

            Session::forget('project_creation_guide');

            Notification::make()
                ->title('Proyecto creado exitosamente')
                ->success()
                ->send();

            $this->redirect('/admin/projects');

        } catch (\Exception $e) {
            Notification::make()
                ->title('Error al crear el proyecto')
                ->body($e->getMessage())
                ->danger()
                ->send();
        }
    }
}

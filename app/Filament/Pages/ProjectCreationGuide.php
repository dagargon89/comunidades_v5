<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms\Form;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Components\Actions\Action;
use Filament\Notifications\Notification;
use Filament\Forms\Components\Card;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Actions;
use Filament\Forms\Components\Actions\Action as FormAction;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\DB;
use App\Models\Financier;
use App\Models\SpecificObjective;
use App\Models\Activity;
use App\Models\Location;
use App\Models\Project;
use App\Models\Kpi;
use App\Models\ActivityCalendar;
use App\Models\Polygon;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Forms\Components\FileUpload;

class ProjectCreationGuide extends Page
{
    use HasPageShield;
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Guía de Creación de Proyectos';
    protected static ?string $title = 'Guía de Creación de Proyectos';

    protected static string $view = 'filament.pages.project-creation-guide';

    // Propiedades para almacenar datos temporales
    public $projectData = [];
    public $objectivesData = [];
    public $kpisData = [];
    public $cofinanciersData = [];
    public $activitiesData = [];
    public $locationsData = [];
    public $scheduledActivitiesData = [];
    public $showSummaryModal = false;

    public function mount()
    {
        // Limpiar datos temporales si la petición no es un submit Livewire
        if (!request()->has('_livewire')) {
            Session::forget([
                'project_creation_guide.project',
                'project_creation_guide.objectives',
                'project_creation_guide.kpis',
                'project_creation_guide.cofinanciers',
                'project_creation_guide.activities',
                'project_creation_guide.locations',
                'project_creation_guide.scheduled_activities',
            ]);
            $this->projectData = [];
            $this->objectivesData = [];
            $this->kpisData = [];
            $this->cofinanciersData = [];
            $this->activitiesData = [];
            $this->locationsData = [];
            $this->scheduledActivitiesData = [];
        }
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

    public function getProgressProperty()
    {
        $completed = $this->completedSteps;
        $total = $this->totalSteps;
        return $total > 0 ? round(($completed / $total) * 100) : 0;
    }

    // Formulario principal
    public function form(Form $form): Form
    {
        return $form->schema([
            Section::make('Progreso de Creación')
                ->schema([
                    Placeholder::make('progress')
                        ->content(fn() => "{$this->progress}% Completado")
                        ->extraAttributes(['class' => 'text-center text-lg font-semibold']),
                ])
                ->collapsible(false),

            Section::make('1. Información Básica del Proyecto')
                ->description('Define los datos principales del proyecto')
                ->schema([
                    Section::make('Datos Generales')
                        ->schema([
                            Grid::make(3)
                                ->schema([
                                    TextInput::make('projectData.name')
                                        ->label('Nombre del Proyecto')
                                        ->required(),
                                    Select::make('projectData.financiers_id')
                                        ->label('Financiadora')
                                        ->options(\App\Models\Financier::pluck('name', 'id'))
                                        ->searchable()
                                        ->required(),
                                ]),
                        ]),
                    Section::make('Responsable y Archivos')
                        ->schema([
                            Grid::make(3)
                                ->schema([
                                    Select::make('projectData.followup_officer')
                                        ->label('Encargado de seguimiento')
                                        ->options(\App\Models\User::pluck('name', 'id'))
                                        ->searchable()
                                        ->required()
                                        ->placeholder('Seleccione un usuario'),
                                    // FileUpload::make('projectData.agreement_file')
                                    //     ->label('Convenio')
                                    //     ->directory('project_agreements'),
                                    // FileUpload::make('projectData.project_base_file')
                                    //     ->label('Proyecto Base')
                                    //     ->directory('project_bases'),
                                ]),
                        ]),
                    Section::make('Descripción y Objetivos')
                        ->schema([
                            Grid::make(3)
                                ->schema([
                                    Textarea::make('projectData.general_objective')
                                        ->label('Objetivo General')
                                        ->rows(2),
                                    Textarea::make('projectData.background')
                                        ->label('Antecedentes')
                                        ->rows(2),
                                    Textarea::make('projectData.justification')
                                        ->label('Justificación')
                                        ->rows(2),
                                ]),
                        ]),
                    Section::make('Fechas y Montos')
                        ->schema([
                            Grid::make(3)
                                ->schema([
                                    DatePicker::make('projectData.start_date')
                                        ->label('Fecha de inicio'),
                                    DatePicker::make('projectData.end_date')
                                        ->label('Fecha de finalización'),
                                    TextInput::make('projectData.total_cost')
                                        ->label('Costo total')
                                        ->numeric(),
                                ]),
                            Grid::make(2)
                                ->schema([
                                    TextInput::make('projectData.funded_amount')
                                        ->label('Cantidad financiada')
                                        ->numeric(),
                                    Placeholder::make('cofinanciador_placeholder')
                                        ->content('')
                                        ->extraAttributes(['class' => 'hidden']),
                                ]),
                            Actions::make([
                                Action::make('addCofinancier')
                                    ->label('Agregar Cofinanciador')
                                    ->color('primary')
                                    ->form([
                                        Select::make('financier_id')
                                            ->label('Cofinanciador')
                                            ->options(\App\Models\Financier::pluck('name', 'id'))
                                            ->searchable()
                                            ->required(),
                                        TextInput::make('amount')
                                            ->label('Monto cofinanciado')
                                            ->numeric()
                                            ->required(),
                                    ])
                                    ->action(function (array $data) {
                                        $this->cofinanciersData[] = [
                                            'financier_id' => $data['financier_id'],
                                            'amount' => $data['amount'],
                                        ];
                                        $this->saveTemporaryData();
                                        Notification::make()->title('Cofinanciador agregado')->success()->send();
                                    }),
                            ])->alignRight(),
                        ]),
                ])
                ->collapsible(false),

            Section::make('2. Objetivos Específicos')
                ->description('Define los objetivos específicos del proyecto')
                ->schema([
                    Repeater::make('objectivesData')
                        ->schema([
                            Textarea::make('description')
                                ->label('Descripción del Objetivo')
                                ->required()
                                ->rows(3),
                        ])
                        ->addActionLabel('Agregar Objetivo')
                        ->reorderable()
                        ->collapsible()
                        ->itemLabel(fn(array $state): ?string => $state['description'] ?? null),
                ])
                ->collapsible()
                ->collapsed(false),

            Section::make('3. Indicadores de Rendimiento (KPIs)')
                ->description('Define los indicadores clave del proyecto')
                ->schema([
                    Repeater::make('kpisData')
                        ->schema([
                            TextInput::make('name')
                                ->label('Nombre del KPI')
                                ->required(),
                            Textarea::make('description')
                                ->label('Descripción')
                                ->rows(2),
                            TextInput::make('initial_value')
                                ->label('Valor Inicial')
                                ->numeric()
                                ->required(),
                            TextInput::make('final_value')
                                ->label('Valor Final')
                                ->numeric()
                                ->required(),
                            Toggle::make('is_percentage')
                                ->label('¿Es Porcentaje?')
                                ->default(false),
                            TextInput::make('org_area')
                                ->label('Área Organizacional')
                                ->maxLength(100),
                        ])
                        ->addActionLabel('Agregar KPI')
                        ->reorderable()
                        ->collapsible()
                        ->itemLabel(fn(array $state): ?string => $state['name'] ?? null),
                ])
                ->collapsible()
                ->collapsed(false),

            Section::make('6. Actividades')
                ->description('Define las actividades del proyecto')
                ->schema([
                    Repeater::make('activitiesData')
                        ->schema([
                            TextInput::make('name')
                                ->label('Nombre de la Actividad')
                                ->required(),
                            Select::make('specific_objective_id')
                                ->label('Objetivo Específico')
                                ->options(function () {
                                    // Usar los objetivos temporales y evitar labels null
                                    return collect($this->objectivesData)
                                        ->mapWithKeys(fn($obj, $idx) => [
                                            $idx => isset($obj['description']) && $obj['description'] !== null
                                                ? (string) $obj['description']
                                                : 'Sin descripción'
                                        ])
                                        ->toArray();
                                })
                                ->searchable()
                                ->required(),
                            Textarea::make('description')
                                ->label('Descripción')
                                ->rows(3),
                            Select::make('goals_id')
                                ->label('Meta')
                                ->options(\App\Models\Goal::pluck('description', 'id'))
                                ->searchable()
                                ->required(),
                            Actions::make([
                                Action::make('addPlannedMetric')
                                    ->label('Agregar Métricas Planeadas')
                                    ->color('primary')
                                    ->form([
                                        TextInput::make('population_target_value')
                                            ->label('Meta de Población')
                                            ->numeric()
                                            ->required(),
                                        TextInput::make('product_target_value')
                                            ->label('Meta de Producto')
                                            ->numeric()
                                            ->required(),
                                    ])
                                    ->action(function (array $data, $get, $set, $state, $livewire) {
                                        // Guardar las métricas planeadas en un array temporal dentro de la actividad
                                        $metrics = $get('planned_metrics') ?? [];
                                        $metrics[] = [
                                            'population_target_value' => $data['population_target_value'],
                                            'product_target_value' => $data['product_target_value'],
                                        ];
                                        $set('planned_metrics', $metrics);
                                        \Filament\Notifications\Notification::make()->title('Métrica planeada agregada')->success()->send();
                                    }),
                            ])->alignRight(),
                            // Campo oculto para almacenar las métricas planeadas
                            \Filament\Forms\Components\Hidden::make('planned_metrics'),
                        ])
                        ->addActionLabel('Agregar Actividad')
                        ->reorderable()
                        ->collapsible()
                        ->itemLabel(fn(array $state): ?string => $state['name'] ?? null),
                ])
                ->collapsible()
                ->collapsed(false),
            Actions::make([
                Action::make('showSummary')
                    ->label('Mostrar Resumen y Guardar Proyecto')
                    ->color('success')
                    ->modalHeading('Resumen del Proyecto')
                    ->modalSubmitActionLabel('Confirmar y Guardar')
                    ->modalCancelActionLabel('Cancelar')
                    ->form([
                        Placeholder::make('resumen')
                            ->content(fn() => view('filament.pages.partials.project-summary', [
                                'projectData' => $this->projectData,
                                'objectivesData' => $this->objectivesData,
                                'kpisData' => $this->kpisData,
                                'cofinanciersData' => $this->cofinanciersData,
                                'activitiesData' => $this->activitiesData,
                            ])->render()),
                    ])
                    ->action('saveProject'),
            ])->alignRight(),
        ]);
    }

    // Métodos para manejar datos del proyecto
    public function saveProjectData($data)
    {
        $this->projectData = $data;
        $this->saveTemporaryData();

        Notification::make()
            ->title('Proyecto guardado')
            ->success()
            ->send();
    }

    public function saveObjectivesData($data)
    {
        $this->objectivesData = $data['objectivesData'] ?? [];
        $this->saveTemporaryData();

        Notification::make()
            ->title('Objetivos guardados')
            ->success()
            ->send();
    }

    public function saveKpisData($data)
    {
        $this->kpisData = $data['kpisData'] ?? [];
        $this->saveTemporaryData();

        Notification::make()
            ->title('KPIs guardados')
            ->success()
            ->send();
    }

    public function saveCofinanciersData($data)
    {
        $this->cofinanciersData = $data['cofinanciersData'] ?? [];
        $this->saveTemporaryData();

        Notification::make()
            ->title('Cofinanciadores guardados')
            ->success()
            ->send();
    }

    public function saveLocationsData($data)
    {
        $this->locationsData = $data['locationsData'] ?? [];
        $this->saveTemporaryData();

        Notification::make()
            ->title('Ubicaciones guardadas')
            ->success()
            ->send();
    }

    public function saveActivitiesData($data)
    {
        $this->activitiesData = $data['activitiesData'] ?? [];
        $this->saveTemporaryData();

        Notification::make()
            ->title('Actividades guardadas')
            ->success()
            ->send();
    }

    public function saveScheduledActivitiesData($data)
    {
        $this->scheduledActivitiesData = $data['scheduledActivitiesData'] ?? [];
        $this->saveTemporaryData();

        Notification::make()
            ->title('Programación guardada')
            ->success()
            ->send();
    }

    // Eliminar cofinanciador
    public function removeCofinancier($idx)
    {
        if (isset($this->cofinanciersData[$idx])) {
            unset($this->cofinanciersData[$idx]);
            $this->cofinanciersData = array_values($this->cofinanciersData); // Reindexar
            $this->saveTemporaryData();
            \Filament\Notifications\Notification::make()->title('Cofinanciador eliminado')->success()->send();
        }
    }

    // Eliminar planned metric de una actividad
    public function removePlannedMetric($activityIdx, $metricIdx)
    {
        if (isset($this->activitiesData[$activityIdx]['planned_metrics'][$metricIdx])) {
            unset($this->activitiesData[$activityIdx]['planned_metrics'][$metricIdx]);
            $this->activitiesData[$activityIdx]['planned_metrics'] = array_values($this->activitiesData[$activityIdx]['planned_metrics']);
            $this->saveTemporaryData();
            \Filament\Notifications\Notification::make()->title('Métrica planeada eliminada')->success()->send();
        }
    }

    // Fase 1: Guardar solo el proyecto y retornar el ID
    public function saveProjectOnly()
    {
        try {
            $projectData = $this->projectData ?? [];
            $project = Project::create([
                'name' => $projectData['name'] ?? '',
                'background' => $projectData['background'] ?? '',
                'justification' => $projectData['justification'] ?? '',
                'general_objective' => $projectData['general_objective'] ?? '',
                'financiers_id' => $projectData['financiers_id'] ?? 1,
                'start_date' => !empty($projectData['start_date']) ? $projectData['start_date'] : null,
                'end_date' => !empty($projectData['end_date']) ? $projectData['end_date'] : null,
                'total_cost' => $projectData['total_cost'] ?? 0,
                'funded_amount' => $projectData['funded_amount'] ?? 0,
                'cofunding_amount' => $projectData['cofunding_amount'] ?? 0,
                'monthly_disbursement' => $projectData['monthly_disbursement'] ?? 0,
                'followup_officer' => $projectData['followup_officer'] ?? '',
                'co_financier_id' => $projectData['co_financier_id'] ?? null,
                'created_by' => auth()->id(),
            ]);
            $this->project_id = $project->id;
            Notification::make()->title('Proyecto guardado exitosamente')->success()->send();
            return $project->id;
        } catch (\Exception $e) {
            Notification::make()->title('Error al guardar el proyecto')->body($e->getMessage())->danger()->send();
            return null;
        }
    }

    // Fase 2: Guardar los datos relacionados usando el ID del proyecto
    public function saveProjectRelations($projectId)
    {
        try {
            $objectivesData = $this->objectivesData ?? [];
            $kpisData = $this->kpisData ?? [];
            $locationsData = $this->locationsData ?? [];
            $activitiesData = $this->activitiesData ?? [];
            $scheduledActivitiesData = $this->scheduledActivitiesData ?? [];

            // Guardar objetivos específicos y mapear sus IDs
            $objectiveIdMap = [];
            foreach ($objectivesData as $idx => $objective) {
                $obj = SpecificObjective::create([
                    'name' => $objective['name'] ?? '',
                    'description' => $objective['description'] ?? '',
                    'projects_id' => $projectId,
                    'created_by' => auth()->id(),
                ]);
                $objectiveIdMap[$idx] = $obj->id;
            }
            Notification::make()->title('Objetivos guardados')->success()->send();

            // Guardar KPIs
            foreach ($kpisData as $kpi) {
                Kpi::create([
                    'name' => $kpi['name'] ?? '',
                    'description' => $kpi['description'] ?? '',
                    'initial_value' => $kpi['initial_value'] ?? 0,
                    'final_value' => $kpi['final_value'] ?? 0,
                    'projects_id' => $projectId,
                    'is_percentage' => $kpi['is_percentage'] ?? 0,
                    'org_area' => $kpi['org_area'] ?? null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
            Notification::make()->title('KPIs guardados')->success()->send();

            // Guardar ubicaciones
            foreach ($locationsData as $location) {
                Location::create([
                    'name' => $location['name'] ?? '',
                    'description' => $location['description'] ?? '',
                    'project_id' => $projectId,
                    'created_by' => auth()->id(),
                ]);
            }
            Notification::make()->title('Ubicaciones guardadas')->success()->send();

            // Guardar actividades y planned metrics
            $activityIds = [];
            $plannedMetricsData = [];
            foreach ($activitiesData as $idx => $activity) {
                $realObjectiveId = isset($objectiveIdMap[$activity['specific_objective_id']]) ? $objectiveIdMap[$activity['specific_objective_id']] : null;
                $newActivity = Activity::create([
                    'name' => $activity['name'] ?? '',
                    'description' => $activity['description'] ?? '',
                    'specific_objective_id' => $realObjectiveId,
                    'goals_id' => $activity['goals_id'] ?? 1,
                    'created_by' => auth()->id(),
                ]);
                $activityIds[$idx] = $newActivity->id;
                // Guardar planned metrics asociadas a la actividad
                if (!empty($activity['planned_metrics']) && is_array($activity['planned_metrics'])) {
                    foreach ($activity['planned_metrics'] as $metric) {
                        $plannedMetric = \App\Models\PlannedMetric::create([
                            'activity_id' => $newActivity->id,
                            'population_target_value' => $metric['population_target_value'] ?? 0,
                            'product_target_value' => $metric['product_target_value'] ?? 0,
                        ]);
                        $plannedMetricsData[] = $plannedMetric;
                    }
                }
            }
            Notification::make()->title('Actividades y métricas planeadas guardadas')->success()->send();

            // Guardar programación de actividades
            foreach ($scheduledActivitiesData as $scheduled) {
                ActivityCalendar::create([
                    'activity_id' => isset($scheduled['activity_id']) && isset($activityIds[$scheduled['activity_id']]) ? $activityIds[$scheduled['activity_id']] : 1,
                    'start_date' => $scheduled['start_date'] ?? now(),
                    'end_date' => $scheduled['end_date'] ?? now(),
                    'created_by' => auth()->id(),
                ]);
            }
            Notification::make()->title('Programación guardada')->success()->send();

            // Limpiar datos temporales
            Session::forget([
                'project_creation_guide.project',
                'project_creation_guide.objectives',
                'project_creation_guide.kpis',
                'project_creation_guide.cofinanciers',
                'project_creation_guide.activities',
                'project_creation_guide.locations',
                'project_creation_guide.scheduled_activities',
            ]);

            Notification::make()->title('¡Proyecto completo!')->success()->send();
            return true;
        } catch (\Exception $e) {
            Notification::make()->title('Error al guardar relaciones')->body($e->getMessage())->danger()->send();
            return false;
        }
    }

    // Métodos para el modal de resumen
    public function showSummary()
    {
        $this->loadTemporaryData(); // Refresca los datos antes de mostrar
        $this->showSummaryModal = true;
    }

    public function closeSummary()
    {
        $this->showSummaryModal = false;
    }

    public function saveProject()
    {
        try {
            // Fase 1: Guardar solo el proyecto y obtener el ID
            $projectId = $this->saveProjectOnly();
            if (!$projectId) {
                return;
            }
            // Fase 2: Guardar los datos relacionados usando el ID
            $this->saveProjectRelations($projectId);
        } catch (\Exception $e) {
            Notification::make()
                ->title('Error al guardar el proyecto')
                ->body($e->getMessage())
                ->danger()
                ->send();
        }
    }

    public function editProject()
    {
        // Lógica para editar el proyecto
    }
}

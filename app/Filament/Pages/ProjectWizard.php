<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms\Form;
use Filament\Forms\Components\Wizard;
use Filament\Forms\Components\Wizard\Step;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Notifications\Notification;
use Filament\Actions\Action;
use Filament\Forms\Components\Actions\Action as FormAction;
use App\Models\Financier;
use App\Models\User;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Filament\Forms\Components\Hidden;
use App\Models\Component;
use App\Models\ActionLine;
use App\Models\Program;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Checkbox;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use App\Models\PlannedMetric;

class ProjectWizard extends Page
{
    use HasPageShield;
    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';
    protected static ?string $navigationLabel = 'Asistente de Proyectos';
    protected static ?string $title = 'Asistente de Proyectos';
    protected static ?string $slug = 'asistente-proyectos';
    protected static string $view = 'filament.pages.project-wizard';
    public static function shouldRegisterNavigation(): bool { return false; }

    public $isEditing = false;
    public $editProjectId = null;

    public function getTitle(): string
    {
        return $this->isEditing ? 'Editar Proyecto' : 'Crear Nuevo Proyecto';
    }

    public $formData = [
        'project' => [
            'name' => '',
            'financiers_id' => '',
            'followup_officer' => '',
            'general_objective' => '',
            'background' => '',
            'justification' => '',
            'start_date' => '',
            'end_date' => '',
            'total_cost' => '',
            'funded_amount' => '',
            'cofinancier_id' => '',
            'cofinancier_amount' => '',
        ],
        'objectives' => [],
        'kpis' => [],
        'activities' => [],
        // ...otros pasos
    ];

    public function mount()
    {
        $editId = request()->query('edit');
        if ($editId) {
            $project = \App\Models\Project::find($editId);
            if ($project) {
                $this->isEditing = true;
                $this->editProjectId = $project->id;

                // 1. Objetivos y KPIs
                $objectives = \App\Models\SpecificObjective::where('projects_id', $project->id)->get();
                $kpis = \App\Models\Kpi::where('projects_id', $project->id)->get();

                // 2. Metas (goals) del proyecto - ahora usando project_id
                $goals = \App\Models\Goal::where('project_id', $project->id)->get();

                // 3. Para cada meta, cargar actividades
                $goalsData = $goals->map(function($goal) {
                    $activities = \App\Models\Activity::where('goals_id', $goal->id)->get();
                    return [
                        'id' => $goal->id, // Agregar el ID existente de la meta
                        'description' => $goal->description,
                        'number' => $goal->number,
                        'components_id' => $goal->components_id,
                        'action_lines_id' => $goal->components_action_lines_id,
                        'program_id' => $goal->components_action_lines_program_id,
                        'organizations_id' => $goal->organizations_id, // <-- Asegúrate de incluir esto
                        'activities' => $activities->map(function($a) {
                            // Buscar los valores de meta desde planned_metrics
                            $plannedMetric = PlannedMetric::where('activity_id', $a->id)->first();
                            $populationTarget = $plannedMetric ? $plannedMetric->population_target_value : 0;
                            $productTarget = $plannedMetric ? $plannedMetric->product_target_value : 0;

                            return [
                                'id' => $a->id, // Agregar el ID existente de la actividad
                                'name' => $a->name,
                                'specific_objective_id' => $a->specific_objective_id, // <-- ID real
                                'description' => $a->description,
                                'population_target_value' => $populationTarget,
                                'product_target_value' => $productTarget,
                            ];
                        })->toArray(),
                    ];
                })->toArray();

                $this->formData = [
                    'project' => [
                        'name' => $project->name,
                        'financiers_id' => $project->financiers_id,
                        'followup_officer' => $project->followup_officer,
                        'general_objective' => $project->general_objective,
                        'background' => $project->background,
                        'justification' => $project->justification,
                        'start_date' => $project->start_date,
                        'end_date' => $project->end_date,
                        'total_cost' => $project->total_cost,
                        'funded_amount' => $project->funded_amount,
                        'cofinancier_id' => $project->co_financier_id,
                        'cofinancier_amount' => $project->cofunding_amount,
                    ],
                    'objectives' => $objectives->map(fn($o) => [
                        'uuid' => (string) Str::uuid(),
                        'id' => $o->id, // Agregar el ID existente
                        'description' => $o->description,
                    ])->toArray(),
                    'kpis' => $kpis->map(fn($k) => [
                        'id' => $k->id, // Agregar el ID existente
                        'name' => $k->name,
                        'description' => $k->description,
                        'initial_value' => $k->initial_value,
                        'final_value' => $k->final_value,
                        'is_percentage' => $k->is_percentage,
                        'org_area' => $k->org_area,
                    ])->toArray(),
                    'goals' => $goalsData,
                ];
                return;
            }
        }
        $this->formData = session('project_wizard.formData', [
            'project' => [
                'name' => '',
                'financiers_id' => '',
                'followup_officer' => '',
                'general_objective' => '',
                'background' => '',
                'justification' => '',
                'start_date' => '',
                'end_date' => '',
                'total_cost' => '',
                'funded_amount' => '',
                'cofinancier_id' => '',
                'cofinancier_amount' => '',
            ],
            'objectives' => [],
            'kpis' => [],
            'goals' => [],
            'activities' => [],
        ]);
    }

    public function updated($propertyName)
    {
        $this->saveToSession();
    }

    public function saveToSession()
    {
        session(['project_wizard.formData' => $this->formData]);
    }

    public function clearFormData()
    {
        session()->forget('project_wizard.formData');
        $this->isEditing = false;
        $this->editProjectId = null;
        $this->mount(); // Reinicia los datos
        Notification::make()->title('Campos limpiados')->success()->send();
    }

    public function cleanNumericValue($value)
    {
        if (empty($value)) return 0;
        // Remover comas y convertir a float
        return (float) str_replace(',', '', $value);
    }

    public function form(Form $form): Form
    {
        return $form->schema([
            Wizard::make([
                Step::make(__('Información Básica del Proyecto'))
                    ->schema([
                        // Sección 1: Información General
                        Section::make(__('Información General'))
                            ->description(__('Datos principales del proyecto'))
                            ->schema([
                                Grid::make(2)->schema([
                                    TextInput::make('project.name')
                                        ->label(__('Nombre del Proyecto'))
                                        ->required()
                                        ->maxLength(255)
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                    Select::make('project.financiers_id')
                                        ->label(__('Financiadora Principal'))
                                        ->options(Financier::pluck('name', 'id'))
                                        ->searchable()
                                        ->native(false)
                                        ->required()
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                ]),
                                Grid::make(1)->schema([
                                    TextInput::make('project.followup_officer')
                                        ->label(__('Encargado de Seguimiento'))
                                        ->maxLength(255)
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                ]),
                            ])
                            ->collapsible()
                            ->collapsed(false),

                        // Sección 2: Descripción del Proyecto
                        Section::make(__('Descripción del Proyecto'))
                            ->description(__('Información detallada del proyecto'))
                            ->schema([
                                Grid::make(1)->schema([
                                    Textarea::make('project.general_objective')
                                        ->label(__('Objetivo General'))
                                        ->rows(4)
                                        ->required()
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                ]),
                                Grid::make(2)->schema([
                                    Textarea::make('project.background')
                                        ->label(__('Antecedentes'))
                                        ->rows(6)
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                    Textarea::make('project.justification')
                                        ->label(__('Justificación'))
                                        ->rows(6)
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                ]),
                            ])
                            ->collapsible(true)
                            ->collapsed(false),

                        // Sección 3: Fechas y Duración
                        Section::make(__('Fechas y Duración'))
                            ->description(__('Período de ejecución del proyecto'))
                            ->schema([
                                Grid::make(2)->schema([
                                    DatePicker::make('project.start_date')
                                        ->label(__('Fecha de Inicio'))
                                        ->required()
                                        ->displayFormat('d/m/Y')
                                        ->native(false)
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                    DatePicker::make('project.end_date')
                                        ->label(__('Fecha de Finalización'))
                                        ->required()
                                        ->displayFormat('d/m/Y')
                                        ->native(false)
                                        ->after('project.start_date')
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                ]),
                            ])
                            ->collapsible()
                            ->collapsed(false),

                        // Sección 4: Información Financiera
                        Section::make(__('Información Financiera'))
                            ->description(__('Costos y financiamiento del proyecto'))
                            ->schema([
                                Grid::make(2)->schema([
                                    TextInput::make('project.total_cost')
                                        ->label(__('Costo Total del Proyecto'))
                                        ->numeric()
                                        ->prefix('MXN $')
                                        ->required()
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                    TextInput::make('project.funded_amount')
                                        ->label(__('Cantidad Financiada'))
                                        ->numeric()
                                        ->prefix('MXN $')
                                        ->required()
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                ]),
                                Grid::make(2)->schema([
                                    Select::make('project.cofinancier_id')
                                        ->label(__('Cofinanciador (Opcional)'))
                                        ->options(Financier::pluck('name', 'id'))
                                        ->searchable()
                                        ->native(false)
                                        ->placeholder(__('Seleccionar cofinanciador'))
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                    TextInput::make('project.cofinancier_amount')
                                        ->label(__('Monto Cofinanciado (Opcional)'))
                                        ->numeric()
                                        ->prefix('MXN $')
                                        ->helperText(__('Ingrese el monto si seleccionó un cofinanciador'))
                                        ->afterStateUpdated(fn () => $this->saveToSession()),
                                ]),
                            ])
                            ->collapsible()
                            ->collapsed(false),
                    ]),
                Step::make('Objetivos Específicos')
                    ->schema([
                        Repeater::make('objectives')
                            ->schema([
                                Hidden::make('uuid')
                                    ->default(fn () => (string) Str::uuid()),
                                Textarea::make('description')
                                    ->label('Descripción del Objetivo')
                                    ->required()
                                    ->rows(3),
                            ])
                            ->addActionLabel('Agregar Objetivo')
                            ->reorderable()
                            ->collapsible()
                            ->itemLabel(fn(array $state): ?string => $state['description'] ?? null),
                    ]),
                Step::make('Indicadores de Rendimiento (KPIs)')
                    ->schema([
                        Repeater::make('kpis')
                            ->schema([
                                Grid::make(2)->schema([
                                    TextInput::make('name')
                                        ->label('Nombre del KPI')
                                        ->required()
                                        ->columnSpan(1),
                                    TextInput::make('org_area')
                                        ->label('Área Organizacional')
                                        ->maxLength(100)
                                        ->columnSpan(1),
                                ]),
                                Textarea::make('description')
                                    ->label('Descripción')
                                    ->rows(2)
                                    ->columnSpanFull(),
                                Grid::make(3)->schema([
                                    TextInput::make('initial_value')
                                        ->label('Valor Inicial')
                                        ->numeric()
                                        ->columnSpan(1),
                                    TextInput::make('final_value')
                                        ->label('Valor Final')
                                        ->numeric()
                                        ->columnSpan(1),
                                    Checkbox::make('is_percentage')
                                        ->label('¿Es Porcentaje?')
                                        ->default(false)
                                        ->columnSpan(1),
                                ]),
                            ])
                            ->addActionLabel('Agregar KPI')
                            ->reorderable()
                            ->collapsible()
                            ->itemLabel(fn(array $state): ?string => $state['name'] ?? null),
                    ]),
                Step::make('Metas y Actividades')
                    ->schema([
                        Repeater::make('goals')
                            ->label('Metas del Proyecto')
                            ->schema([
                                Grid::make(3)->schema([
                                    Select::make('components_id')
                                        ->label('Componente')
                                        ->options(Component::pluck('name', 'id'))
                                        ->searchable()
                                        ->native(false)
                                        ->reactive(),
                                    Select::make('action_lines_id')
                                        ->label('Línea de Acción')
                                        ->options(function (callable $get) {
                                            $componentId = $get('components_id');
                                            if (!$componentId) return [];
                                            return ActionLine::where('id', Component::find($componentId)?->action_lines_id)
                                                ->pluck('name', 'id');
                                        })
                                        ->searchable()
                                        ->native(false)
                                        ->reactive(),
                                    Select::make('program_id')
                                        ->label('Programa')
                                        ->options(function (callable $get) {
                                            $actionLineId = $get('action_lines_id');
                                            if (!$actionLineId) return [];
                                            $actionLine = ActionLine::find($actionLineId);
                                            if (!$actionLine) return [];
                                            return Program::where('id', $actionLine->program_id)
                                                ->pluck('name', 'id');
                                        })
                                        ->searchable()
                                        ->native(false),
                                    Select::make('organizations_id')
                                        ->label('Organización')
                                        ->options(\App\Models\Organization::pluck('name', 'id'))
                                        ->searchable()
                                        ->native(false),
                                ]),
                                Textarea::make('description')
                                    ->label('Descripción de la Meta')
                                    ->required()
                                    ->rows(2),
                                Repeater::make('activities')
                                    ->label('Actividades para esta meta')
                                    ->schema([
                                        Grid::make(2)->schema([
                                            TextInput::make('name')
                                                ->label('Nombre de la Actividad')
                                                ->required()
                                                ->columnSpan(1),
                                            Select::make('specific_objective_id')
                                                ->label('Objetivo Específico')
                                                ->options(function () {
                                                    // Si es edición, usa los IDs reales de la base de datos
                                                    $projectId = $this->editProjectId ?? $this->formData['project']['id'] ?? null;
                                                    if ($projectId) {
                                                        return \App\Models\SpecificObjective::where('projects_id', $projectId)
                                                            ->pluck('description', 'id')
                                                            ->toArray();
                                                    }
                                                    // Si es nuevo, usa los objetivos recién creados en el wizard
                                                    return collect($this->formData['objectives'] ?? [])
                                                        ->mapWithKeys(fn($obj) => [$obj['id'] ?? $obj['uuid'] => $obj['description'] ?? 'Sin descripción'])
                                                        ->toArray();
                                                })
                                                ->searchable()
                                                ->native(false)
                                                ->required(),
                                        ]),
                                        Textarea::make('description')
                                            ->label('Descripción')
                                            ->rows(2)
                                            ->columnSpanFull(),
                                        Grid::make(2)->schema([
                                            TextInput::make('population_target_value')
                                                ->label('Meta de Población')
                                                ->numeric()
                                                ->columnSpan(1),
                                            TextInput::make('product_target_value')
                                                ->label('Meta de Producto')
                                                ->numeric()
                                                ->columnSpan(1),
                                        ]),
                                    ])
                                    ->addActionLabel('Agregar Actividad')
                                    ->reorderable()
                                    ->collapsible()
                                    ->itemLabel(fn(array $state): ?string => $state['name'] ?? null),
                            ])
                            ->addActionLabel('Agregar Meta')
                            ->reorderable()
                            ->collapsible()
                            ->itemLabel(fn(array $state): ?string => $state['description'] ?? null),
                    ]),
                Step::make('Resumen')
                    ->schema([
                        Placeholder::make('resumen')
                            ->label('Resumen del Proyecto')
                            ->content(fn () => $this->getFormattedSummary()),
                    ]),
                // Aquí se agregarán los siguientes pasos: ubicaciones, programación, resumen
            ])->statePath('formData')
        ]);
    }

    public function getActions(): array
    {
        $actions = [
            Action::make('regresar')
                ->label('Regresar a Gestión de Proyectos')
                ->icon('heroicon-o-arrow-left')
                ->color('gray')
                ->url(route('filament.admin.pages.gestion-proyectos'))
                ->openUrlInNewTab(false),
            Action::make('limpiar')
                ->label('Limpiar campos de proyecto')
                ->color('danger')
                ->action('clearFormData')
                ->requiresConfirmation(),
        ];

        if ($this->isEditing) {
            $actions[] = Action::make('actualizar')
                ->label('Actualizar Proyecto')
                ->color('success')
                ->action('updateProject')
                ->visible(true);
        } else {
            $actions[] = Action::make('guardar')
                ->label('Guardar Proyecto')
                ->color('success')
                ->action('saveProject')
                ->visible(true);
        }

        return $actions;
    }

    public function saveProject()
    {
        try {
            $data = $this->form->getState()['formData'];
            Log::info('Datos recibidos en ProjectWizard:', $data);
            DB::beginTransaction();

            // 1. Guardar proyecto principal
            $project = \App\Models\Project::create([
                'name' => $data['project']['name'] ?? '',
                'financiers_id' => $data['project']['financiers_id'] ?? null,
                'followup_officer' => $data['project']['followup_officer'] ?? null,
                'general_objective' => $data['project']['general_objective'] ?? '',
                'background' => $data['project']['background'] ?? '',
                'justification' => $data['project']['justification'] ?? '',
                'start_date' => $data['project']['start_date'] ?? null,
                'end_date' => $data['project']['end_date'] ?? null,
                'total_cost' => $this->cleanNumericValue($data['project']['total_cost']),
                'funded_amount' => $this->cleanNumericValue($data['project']['funded_amount']),
                'co_financier_id' => $data['project']['cofinancier_id'] ?? null,
                'cofunding_amount' => $this->cleanNumericValue($data['project']['cofinancier_amount']),
                'created_by' => Auth::id(),
            ]);

            // 2. Guardar objetivos específicos y mapear UUID a ID real
            $objectiveUuidMap = [];
            if (!empty($data['objectives'])) {
                foreach ($data['objectives'] as $objective) {
                    $obj = \App\Models\SpecificObjective::create([
                        'description' => $objective['description'] ?? '',
                        'projects_id' => $project->id,
                        'created_by' => Auth::id(),
                    ]);
                    $objectiveUuidMap[$objective['uuid']] = $obj->id;
                }
            }

            // 3. Guardar metas (goals) y actividades anidadas
            if (!empty($data['goals'])) {
                foreach ($data['goals'] as $goal) {
                    $goalModel = \App\Models\Goal::create([
                        'project_id' => $project->id, // Agregar project_id
                        'description' => $goal['description'] ?? '',
                        'number' => $goal['number'] ?? null,
                        'components_id' => $goal['components_id'] ?? null,
                        'components_action_lines_id' => $goal['action_lines_id'] ?? null,
                        'components_action_lines_program_id' => $goal['program_id'] ?? null,
                        'organizations_id' => $goal['organizations_id'] ?? null,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                    // Guardar actividades asociadas a la meta
                    if (!empty($goal['activities'])) {
                        foreach ($goal['activities'] as $activity) {
                            $uuid = $activity['specific_objective_id'] ?? null;
                            $specificObjectiveId = $uuid && isset($objectiveUuidMap[$uuid]) ? $objectiveUuidMap[$uuid] : $uuid;
                            \App\Models\Activity::create([
                                'name' => $activity['name'] ?? '',
                                'description' => $activity['description'] ?? '',
                                'specific_objective_id' => $specificObjectiveId,
                                'goals_id' => $goalModel->id,
                                'population_target_value' => $activity['population_target_value'] ?? 0,
                                'product_target_value' => $activity['product_target_value'] ?? 0,
                                'created_by' => Auth::id(),
                            ]);
                            // Crear registro en PlannedMetric para esta actividad
                            $activityModel = \App\Models\Activity::where('name', $activity['name'] ?? '')
                                ->where('goals_id', $goalModel->id)
                                ->latest()
                                ->first();
                            if ($activityModel) {
                                PlannedMetric::create([
                                    'activity_id' => $activityModel->id,
                                    'population_target_value' => $activity['population_target_value'] ?? 0,
                                    'product_target_value' => $activity['product_target_value'] ?? 0,
                                ]);
                            }
                        }
                    }
                }
            }

            // 4. Guardar KPIs usando el ID del proyecto
            if (!empty($data['kpis'])) {
                foreach ($data['kpis'] as $kpi) {
                    \App\Models\Kpi::create([
                        'name' => $kpi['name'] ?? '',
                        'description' => $kpi['description'] ?? '',
                        'initial_value' => $kpi['initial_value'] ?? 0,
                        'final_value' => $kpi['final_value'] ?? 0,
                        'is_percentage' => $kpi['is_percentage'] ?? false,
                        'org_area' => $kpi['org_area'] ?? '',
                        'projects_id' => $project->id,
                        'created_by' => Auth::id(),
                    ]);
                }
            }

            DB::commit();
            $this->clearFormData();
            $this->dispatch('wizard::setStep', step: 0); // Regresa al paso 1
            Notification::make()->title('Proyecto guardado exitosamente')->success()->send();

            // Redirigir a la gestión de proyectos
            return redirect()->route('filament.admin.pages.gestion-proyectos');
        } catch (\Illuminate\Validation\ValidationException $e) {
            Notification::make()->title('Error de validación')->body(implode("\n", $e->validator->errors()->all()))->danger()->send();
            throw $e;
        } catch (\Exception $e) {
            DB::rollBack();
            Notification::make()->title('Error al guardar el proyecto')->body($e->getMessage())->danger()->send();
        }
    }

    public function updateProject()
    {
        try {
            $data = $this->form->getState()['formData'];
            Log::info('Datos recibidos en ProjectWizard (actualización):', $data);
            DB::beginTransaction();

            // 1. Actualizar proyecto principal
            $project = \App\Models\Project::find($this->editProjectId);
            if (!$project) {
                throw new \Exception('Proyecto no encontrado');
            }

            $project->update([
                'name' => $data['project']['name'] ?? '',
                'financiers_id' => $data['project']['financiers_id'] ?? null,
                'followup_officer' => $data['project']['followup_officer'] ?? null,
                'general_objective' => $data['project']['general_objective'] ?? '',
                'background' => $data['project']['background'] ?? '',
                'justification' => $data['project']['justification'] ?? '',
                'start_date' => $data['project']['start_date'] ?? null,
                'end_date' => $data['project']['end_date'] ?? null,
                'total_cost' => $this->cleanNumericValue($data['project']['total_cost']),
                'funded_amount' => $this->cleanNumericValue($data['project']['funded_amount']),
                'co_financier_id' => $data['project']['cofinancier_id'] ?? null,
                'cofunding_amount' => $this->cleanNumericValue($data['project']['cofinancier_amount']),
            ]);

            // 2. Actualizar objetivos específicos existentes y crear nuevos si es necesario
            $objectiveUuidMap = [];
            $existingObjectives = \App\Models\SpecificObjective::where('projects_id', $project->id)->get();
            $objectiveIdsToKeep = [];

            if (!empty($data['objectives'])) {
                foreach ($data['objectives'] as $index => $objective) {
                    if (!empty($objective['id']) && $existingObjectives->contains('id', $objective['id'])) {
                        // Actualizar objetivo existente
                        $obj = \App\Models\SpecificObjective::find($objective['id']);
                        if ($obj) {
                            $obj->update([
                                'description' => $objective['description'] ?? '',
                                'projects_id' => $project->id,
                            ]);
                            $objectiveUuidMap[$objective['uuid']] = $obj->id;
                            $objectiveIdsToKeep[] = $obj->id;
                        }
                    } else {
                        // Crear nuevo objetivo
                        $obj = \App\Models\SpecificObjective::create([
                            'description' => $objective['description'] ?? '',
                            'projects_id' => $project->id,
                            'created_by' => Auth::id(),
                        ]);
                        $objectiveUuidMap[$objective['uuid']] = $obj->id;
                        $objectiveIdsToKeep[] = $obj->id;
                    }
                }
            }

            // Eliminar objetivos que ya no están en el formulario
            \App\Models\SpecificObjective::where('projects_id', $project->id)
                ->whereNotIn('id', $objectiveIdsToKeep)
                ->delete();

            // 3. Actualizar KPIs existentes y crear nuevos si es necesario
            $existingKpis = \App\Models\Kpi::where('projects_id', $project->id)->get();
            $kpiIdsToKeep = [];

            if (!empty($data['kpis'])) {
                foreach ($data['kpis'] as $index => $kpi) {
                    if (!empty($kpi['id']) && $existingKpis->contains('id', $kpi['id'])) {
                        // Actualizar KPI existente
                        $kpiModel = \App\Models\Kpi::find($kpi['id']);
                        if ($kpiModel) {
                            $kpiModel->update([
                                'name' => $kpi['name'] ?? '',
                                'description' => $kpi['description'] ?? '',
                                'initial_value' => $kpi['initial_value'] ?? 0,
                                'final_value' => $kpi['final_value'] ?? 0,
                                'is_percentage' => $kpi['is_percentage'] ?? false,
                                'org_area' => $kpi['org_area'] ?? '',
                                'projects_id' => $project->id,
                            ]);
                            $kpiIdsToKeep[] = $kpiModel->id;
                        }
                    } else {
                        // Crear nuevo KPI
                        $kpiModel = \App\Models\Kpi::create([
                            'name' => $kpi['name'] ?? '',
                            'description' => $kpi['description'] ?? '',
                            'initial_value' => $kpi['initial_value'] ?? 0,
                            'final_value' => $kpi['final_value'] ?? 0,
                            'is_percentage' => $kpi['is_percentage'] ?? false,
                            'org_area' => $kpi['org_area'] ?? '',
                            'projects_id' => $project->id,
                            'created_by' => Auth::id(),
                        ]);
                        $kpiIdsToKeep[] = $kpiModel->id;
                    }
                }
            }

            // Eliminar KPIs que ya no están en el formulario
            \App\Models\Kpi::where('projects_id', $project->id)
                ->whereNotIn('id', $kpiIdsToKeep)
                ->delete();

            // 4. Actualizar metas y actividades existentes
            $existingGoals = \App\Models\Goal::where('project_id', $project->id)->get();
            $goalIdsToKeep = [];

            if (!empty($data['goals'])) {
                foreach ($data['goals'] as $index => $goal) {
                    if (!empty($goal['id']) && $existingGoals->contains('id', $goal['id'])) {
                        // Actualizar meta existente
                        $goalModel = \App\Models\Goal::find($goal['id']);
                        if ($goalModel) {
                            $goalModel->update([
                                'description' => $goal['description'] ?? '',
                                'number' => $goal['number'] ?? null,
                                'components_id' => $goal['components_id'] ?? null,
                                'components_action_lines_id' => $goal['action_lines_id'] ?? null,
                                'components_action_lines_program_id' => $goal['program_id'] ?? null,
                                'organizations_id' => $goal['organizations_id'] ?? null,
                            ]);

                            // Actualizar actividades de esta meta
                            $this->updateActivitiesForGoal($goalModel, $goal['activities'] ?? [], $objectiveUuidMap);
                            $goalIdsToKeep[] = $goalModel->id;
                        }
                    } else {
                        // Crear nueva meta
                        $goalModel = \App\Models\Goal::create([
                            'project_id' => $project->id,
                            'description' => $goal['description'] ?? '',
                            'number' => $goal['number'] ?? null,
                            'components_id' => $goal['components_id'] ?? null,
                            'components_action_lines_id' => $goal['action_lines_id'] ?? null,
                            'components_action_lines_program_id' => $goal['program_id'] ?? null,
                            'organizations_id' => $goal['organizations_id'] ?? null,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);

                        // Crear actividades para esta nueva meta
                        $this->createActivitiesForGoal($goalModel, $goal['activities'] ?? [], $objectiveUuidMap);
                        $goalIdsToKeep[] = $goalModel->id;
                    }
                }
            }

            // Eliminar metas que ya no están en el formulario
            \App\Models\Goal::where('project_id', $project->id)
                ->whereNotIn('id', $goalIdsToKeep)
                ->delete();

            DB::commit();
            $this->clearFormData();
            $this->dispatch('wizard::setStep', step: 0);
            Notification::make()->title('Proyecto actualizado exitosamente')->success()->send();

            return redirect()->route('filament.admin.pages.gestion-proyectos');
        } catch (\Illuminate\Validation\ValidationException $e) {
            Notification::make()->title('Error de validación')->body(implode("\n", $e->validator->errors()->all()))->danger()->send();
            throw $e;
        } catch (\Exception $e) {
            DB::rollBack();
            Notification::make()->title('Error al actualizar el proyecto')->body($e->getMessage())->danger()->send();
        }
    }

    private function updateActivitiesForGoal($goalModel, $activities, $objectiveUuidMap)
    {
        $existingActivities = \App\Models\Activity::where('goals_id', $goalModel->id)->get();
        $activityIdsToKeep = [];

        foreach ($activities as $activity) {
            if (!empty($activity['id']) && $existingActivities->contains('id', $activity['id'])) {
                // Actualizar actividad existente
                $activityModel = \App\Models\Activity::find($activity['id']);
                if ($activityModel) {
                    $uuid = $activity['specific_objective_id'] ?? null;
                    $specificObjectiveId = $uuid && isset($objectiveUuidMap[$uuid]) ? $objectiveUuidMap[$uuid] : $uuid;

                    $activityModel->update([
                        'name' => $activity['name'] ?? '',
                        'description' => $activity['description'] ?? '',
                        'specific_objective_id' => $specificObjectiveId,
                        'population_target_value' => $activity['population_target_value'] ?? 0,
                        'product_target_value' => $activity['product_target_value'] ?? 0,
                    ]);

                    // Actualizar PlannedMetric
                    $plannedMetric = PlannedMetric::where('activity_id', $activityModel->id)->first();
                    if ($plannedMetric) {
                        $plannedMetric->update([
                            'population_target_value' => $activity['population_target_value'] ?? 0,
                            'product_target_value' => $activity['product_target_value'] ?? 0,
                        ]);
                    } else {
                        // Crear PlannedMetric si no existe
                        PlannedMetric::create([
                            'activity_id' => $activityModel->id,
                            'population_target_value' => $activity['population_target_value'] ?? 0,
                            'product_target_value' => $activity['product_target_value'] ?? 0,
                        ]);
                    }

                    $activityIdsToKeep[] = $activityModel->id;
                }
            } else {
                // Crear nueva actividad
                $uuid = $activity['specific_objective_id'] ?? null;
                $specificObjectiveId = $uuid && isset($objectiveUuidMap[$uuid]) ? $objectiveUuidMap[$uuid] : $uuid;

                $activityModel = \App\Models\Activity::create([
                    'name' => $activity['name'] ?? '',
                    'description' => $activity['description'] ?? '',
                    'specific_objective_id' => $specificObjectiveId,
                    'goals_id' => $goalModel->id,
                    'population_target_value' => $activity['population_target_value'] ?? 0,
                    'product_target_value' => $activity['product_target_value'] ?? 0,
                    'created_by' => Auth::id(),
                ]);

                // Crear PlannedMetric para la nueva actividad
                PlannedMetric::create([
                    'activity_id' => $activityModel->id,
                    'population_target_value' => $activity['population_target_value'] ?? 0,
                    'product_target_value' => $activity['product_target_value'] ?? 0,
                ]);

                $activityIdsToKeep[] = $activityModel->id;
            }
        }

        // Eliminar actividades que ya no están en el formulario
        $activitiesToDelete = \App\Models\Activity::where('goals_id', $goalModel->id)
            ->whereNotIn('id', $activityIdsToKeep)
            ->get();

        foreach ($activitiesToDelete as $activity) {
            PlannedMetric::where('activity_id', $activity->id)->delete();
            $activity->delete();
        }
    }

    private function createActivitiesForGoal($goalModel, $activities, $objectiveUuidMap)
    {
        foreach ($activities as $activity) {
            $uuid = $activity['specific_objective_id'] ?? null;
            $specificObjectiveId = $uuid && isset($objectiveUuidMap[$uuid]) ? $objectiveUuidMap[$uuid] : $uuid;

            $activityModel = \App\Models\Activity::create([
                'name' => $activity['name'] ?? '',
                'description' => $activity['description'] ?? '',
                'specific_objective_id' => $specificObjectiveId,
                'goals_id' => $goalModel->id,
                'population_target_value' => $activity['population_target_value'] ?? 0,
                'product_target_value' => $activity['product_target_value'] ?? 0,
                'created_by' => Auth::id(),
            ]);

            // Crear PlannedMetric para la nueva actividad
            PlannedMetric::create([
                'activity_id' => $activityModel->id,
                'population_target_value' => $activity['population_target_value'] ?? 0,
                'product_target_value' => $activity['product_target_value'] ?? 0,
            ]);
        }
    }

    protected function getFormattedSummary(): string
    {
        $summary = '<div class="bg-gray-100 p-4 rounded-lg">';
        $summary .= '<h2 class="text-xl font-bold mb-4 flex items-center"><i class="fas fa-info-circle mr-2"></i> Resumen del Proyecto</h2>';

        $summary .= '<div class="grid grid-cols-1 md:grid-cols-2 gap-4">';

        // Proyecto
        $summary .= '<div class="bg-white p-4 rounded-lg shadow-md">';
        $summary .= '<h3 class="text-lg font-semibold mb-2 flex items-center"><i class="fas fa-project-diagram mr-2"></i> Información General</h3>';
        $summary .= '<ul class="list-disc list-inside">';
        $summary .= '<li><strong>Nombre del Proyecto:</strong> ' . ($this->formData['project']['name'] ?? 'N/A') . '</li>';
        $summary .= '<li><strong>Financiadora Principal:</strong> ' . ($this->formData['project']['financiers_id'] ? Financier::find($this->formData['project']['financiers_id'])->name : 'N/A') . '</li>';
        $summary .= '<li><strong>Encargado de Seguimiento:</strong> ' . ($this->formData['project']['followup_officer'] ?? 'N/A') . '</li>';
        $summary .= '<li><strong>Objetivo General:</strong> ' . ($this->formData['project']['general_objective'] ?? 'N/A') . '</li>';
        $summary .= '<li><strong>Fecha de Inicio:</strong> ' . ($this->formData['project']['start_date'] ? \Carbon\Carbon::parse($this->formData['project']['start_date'])->format('d/m/Y') : 'N/A') . '</li>';
        $summary .= '<li><strong>Fecha de Finalización:</strong> ' . ($this->formData['project']['end_date'] ? \Carbon\Carbon::parse($this->formData['project']['end_date'])->format('d/m/Y') : 'N/A') . '</li>';
        $summary .= '<li><strong>Costo Total:</strong> ' . ($this->formData['project']['total_cost'] ? 'MXN $' . number_format($this->formData['project']['total_cost'], 2, '.', ',') : 'N/A') . '</li>';
        $summary .= '<li><strong>Cantidad Financiada:</strong> ' . ($this->formData['project']['funded_amount'] ? 'MXN $' . number_format($this->formData['project']['funded_amount'], 2, '.', ',') : 'N/A') . '</li>';
        $summary .= '<li><strong>Cofinanciador:</strong> ' . ($this->formData['project']['cofinancier_id'] ? Financier::find($this->formData['project']['cofinancier_id'])->name : 'N/A') . '</li>';
        $summary .= '<li><strong>Monto Cofinanciado:</strong> ' . ($this->formData['project']['cofinancier_amount'] ? 'MXN $' . number_format($this->formData['project']['cofinancier_amount'], 2, '.', ',') : 'N/A') . '</li>';
        $summary .= '</ul>';
        $summary .= '</div>';

        // Objetivos Específicos
        $summary .= '<div class="bg-white p-4 rounded-lg shadow-md">';
        $summary .= '<h3 class="text-lg font-semibold mb-2 flex items-center"><i class="fas fa-bullseye mr-2"></i> Objetivos Específicos</h3>';
        $summary .= '<ul class="list-disc list-inside">';
        if (!empty($this->formData['objectives'])) {
            foreach ($this->formData['objectives'] as $objective) {
                $summary .= '<li>' . ($objective['description'] ?? 'Sin descripción') . '</li>';
            }
        } else {
            $summary .= '<li>No hay objetivos específicos definidos.</li>';
        }
        $summary .= '</ul>';
        $summary .= '</div>';

        // KPIs
        $summary .= '<div class="bg-white p-4 rounded-lg shadow-md">';
        $summary .= '<h3 class="text-lg font-semibold mb-2 flex items-center"><i class="fas fa-chart-line mr-2"></i> Indicadores de Rendimiento (KPIs)</h3>';
        $summary .= '<ul class="list-disc list-inside">';
        if (!empty($this->formData['kpis'])) {
            foreach ($this->formData['kpis'] as $kpi) {
                $summary .= '<li>' . ($kpi['name'] ?? 'N/A') . ' - ' . ($kpi['description'] ?? 'N/A') . '</li>';
            }
        } else {
            $summary .= '<li>No hay KPIs definidos.</li>';
        }
        $summary .= '</ul>';
        $summary .= '</div>';

        // Metas y Actividades
        $summary .= '<div class="bg-white p-4 rounded-lg shadow-md">';
        $summary .= '<h3 class="text-lg font-semibold mb-2 flex items-center"><i class="fas fa-tasks mr-2"></i> Metas y Actividades</h3>';
        $summary .= '<ul class="list-disc list-inside">';
        if (!empty($this->formData['goals'])) {
            foreach ($this->formData['goals'] as $goal) {
                $summary .= '<li><strong>' . ($goal['description'] ?? 'Sin descripción') . '</strong>';
                if (!empty($goal['activities'])) {
                    $summary .= ' (Actividades: ' . count($goal['activities']) . ')';
                }
                $summary .= '</li>';
            }
        } else {
            $summary .= '<li>No hay metas definidas.</li>';
        }
        $summary .= '</ul>';
        $summary .= '</div>';

        $summary .= '</div>'; // End of grid
        $summary .= '</div>'; // End of main container

        return $summary;
    }
}

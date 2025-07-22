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

class ProjectWizard extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.project-wizard';

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
            'activities' => [],
        ]);
    }

    public function updated($propertyName)
    {
        session(['project_wizard.formData' => $this->formData]);
    }

    public function clearFormData()
    {
        session()->forget('project_wizard.formData');
        $this->mount(); // Reinicia los datos
        Notification::make()->title('Campos limpiados')->success()->send();
    }

    public function form(Form $form): Form
    {
        return $form->schema([
            Wizard::make([
                Step::make('Información Básica del Proyecto')
                    ->schema([
                        Grid::make(3)->schema([
                            TextInput::make('project.name')
                                ->label('Nombre del Proyecto'),
                            Select::make('project.financiers_id')
                                ->label('Financiadora')
                                ->options(Financier::pluck('name', 'id'))
                                ->searchable(),
                        ]),
                        Grid::make(3)->schema([
                            TextInput::make('project.followup_officer')
                                ->label('Encargado de seguimiento'),
                        ]),
                        Grid::make(3)->schema([
                            Textarea::make('project.general_objective')
                                ->label('Objetivo General')
                                ->rows(2),
                            Textarea::make('project.background')
                                ->label('Antecedentes')
                                ->rows(2),
                            Textarea::make('project.justification')
                                ->label('Justificación')
                                ->rows(2),
                        ]),
                        Grid::make(3)->schema([
                            DatePicker::make('project.start_date')
                                ->label('Fecha de inicio'),
                            DatePicker::make('project.end_date')
                                ->label('Fecha de finalización'),
                            TextInput::make('project.total_cost')
                                ->label('Costo total')
                                ->numeric(),
                        ]),
                        Grid::make(2)->schema([
                            TextInput::make('project.funded_amount')
                                ->label('Cantidad financiada')
                                ->numeric(),
                        ]),
                        // Sección de cofinanciador (opcional, solo uno)
                        Grid::make(2)->schema([
                            Select::make('project.cofinancier_id')
                                ->label('Cofinanciador (opcional)')
                                ->options(Financier::pluck('name', 'id'))
                                ->searchable(),
                            TextInput::make('project.cofinancier_amount')
                                ->label('Monto cofinanciado (opcional)')
                                ->numeric(),
                        ]),
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
                                TextInput::make('name')
                                    ->label('Nombre del KPI'),
                                Textarea::make('description')
                                    ->label('Descripción')
                                    ->rows(2),
                                TextInput::make('initial_value')
                                    ->label('Valor Inicial')
                                    ->numeric(),
                                TextInput::make('final_value')
                                    ->label('Valor Final')
                                    ->numeric(),
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
                                        ->reactive(),
                                    Select::make('action_lines_id')
                                        ->label('Línea de Acción')
                                        ->options(function (callable $get) {
                                            $componentId = $get('components_id');
                                            if (!$componentId) return [];
                                            return ActionLine::where('id', Component::find($componentId)?->action_lines_id)
                                                ->pluck('name', 'id');
                                        })
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
                                        }),
                                ]),
                                Textarea::make('description')
                                    ->label('Descripción de la Meta')
                                    ->required()
                                    ->rows(2),
                                Repeater::make('activities')
                                    ->label('Actividades para esta meta')
                                    ->schema([
                                        TextInput::make('name')->label('Nombre de la Actividad')->required(),
                                        Select::make('specific_objective_id')
                                            ->label('Objetivo Específico')
                                            ->options(fn () => collect($this->formData['objectives'] ?? [])
                                                ->mapWithKeys(fn($obj) => [$obj['uuid'] => $obj['description'] ?? 'Sin descripción'])
                                                ->toArray())
                                            ->searchable()
                                            ->required(),
                                        Textarea::make('description')->label('Descripción')->rows(2),
                                        TextInput::make('population_target_value')->label('Meta de Población')->numeric(),
                                        TextInput::make('product_target_value')->label('Meta de Producto')->numeric(),
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
                            ->label('Resumen de datos')
                            ->content(fn () => '<pre>' . print_r($this->formData, true) . '</pre>'),
                    ]),
                // Aquí se agregarán los siguientes pasos: ubicaciones, programación, resumen
            ])->statePath('formData')
        ]);
    }

    public function getActions(): array
    {
        return [
            Action::make('guardar')
                ->label('Guardar Proyecto')
                ->color('success')
                ->action('saveProject')
                ->visible(true),
            Action::make('limpiar')
                ->label('Limpiar campos de proyecto')
                ->color('danger')
                ->action('clearFormData')
                ->requiresConfirmation(),
        ];
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
                'total_cost' => $data['project']['total_cost'] ?? 0,
                'funded_amount' => $data['project']['funded_amount'] ?? 0,
                'co_financier_id' => $data['project']['cofinancier_id'] ?? null,
                'cofunding_amount' => $data['project']['cofinancier_amount'] ?? 0,
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
                        'description' => $goal['description'] ?? '',
                        'number' => $goal['number'] ?? null,
                        'components_id' => $goal['components_id'] ?? null,
                        'components_action_lines_id' => $goal['action_lines_id'] ?? null,
                        'components_action_lines_program_id' => $goal['program_id'] ?? null,
                        'organizations_id' => $goal['organizations_id'] ?? 1, // Ajusta si tienes organizaciones
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]);
                    // Guardar actividades asociadas a la meta
                    if (!empty($goal['activities'])) {
                        foreach ($goal['activities'] as $activity) {
                            $uuid = $activity['specific_objective_id'] ?? null;
                            $specificObjectiveId = $uuid && isset($objectiveUuidMap[$uuid]) ? $objectiveUuidMap[$uuid] : null;
                            \App\Models\Activity::create([
                                'name' => $activity['name'] ?? '',
                                'description' => $activity['description'] ?? '',
                                'specific_objective_id' => $specificObjectiveId,
                                'goals_id' => $goalModel->id,
                                'created_by' => Auth::id(),
                            ]);
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
            $this->form->fill(['formData' => []]);
            Notification::make()->title('Proyecto guardado exitosamente')->success()->send();
        } catch (\Illuminate\Validation\ValidationException $e) {
            Notification::make()->title('Error de validación')->body(implode("\n", $e->validator->errors()->all()))->danger()->send();
            throw $e;
        } catch (\Exception $e) {
            DB::rollBack();
            Notification::make()->title('Error al guardar el proyecto')->body($e->getMessage())->danger()->send();
        }
    }
}

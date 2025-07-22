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
use App\Models\Financier;
use App\Models\User;

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

    public function form(Form $form): Form
    {
        return $form->schema([
            Wizard::make([
                Step::make('Información Básica del Proyecto')
                    ->schema([
                        Grid::make(3)->schema([
                            TextInput::make('project.name')
                                ->label('Nombre del Proyecto')
                                ->required(),
                            Select::make('project.financiers_id')
                                ->label('Financiadora')
                                ->options(Financier::pluck('name', 'id'))
                                ->searchable()
                                ->required(),
                        ]),
                        Grid::make(3)->schema([
                            Select::make('project.followup_officer')
                                ->label('Encargado de seguimiento')
                                ->options(User::pluck('name', 'id'))
                                ->searchable()
                                ->required(),
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
                    ]),
                Step::make('Actividades')
                    ->schema([
                        Repeater::make('activities')
                            ->schema([
                                TextInput::make('name')
                                    ->label('Nombre de la Actividad')
                                    ->required(),
                                Select::make('specific_objective_id')
                                    ->label('Objetivo Específico')
                                    ->options(fn($get) => collect($this->formData['objectives'] ?? [])
                                        ->mapWithKeys(fn($obj, $idx) => [
                                            $idx => isset($obj['description']) && $obj['description'] !== null
                                                ? (string) $obj['description']
                                                : 'Sin descripción'
                                        ])->toArray())
                                    ->searchable()
                                    ->required(),
                                Textarea::make('description')
                                    ->label('Descripción')
                                    ->rows(3),
                                // Planned metrics como campos simples
                                TextInput::make('population_target_value')
                                    ->label('Meta de Población')
                                    ->numeric(),
                                TextInput::make('product_target_value')
                                    ->label('Meta de Producto')
                                    ->numeric(),
                            ])
                            ->addActionLabel('Agregar Actividad')
                            ->reorderable()
                            ->collapsible()
                            ->itemLabel(fn(array $state): ?string => $state['name'] ?? null),
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
                ->visible(fn ($livewire) => data_get($livewire->formData, 'wizard.step') === 'Resumen'),
        ];
    }

    public function saveProject()
    {
        try {
            \DB::beginTransaction();
            $data = $this->formData;
            // Guardar proyecto principal
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
                'created_by' => auth()->id(),
            ]);

            // Guardar objetivos específicos
            $objectiveIdMap = [];
            foreach ($data['objectives'] as $idx => $objective) {
                $obj = \App\Models\SpecificObjective::create([
                    'description' => $objective['description'] ?? '',
                    'projects_id' => $project->id,
                    'created_by' => auth()->id(),
                ]);
                $objectiveIdMap[$idx] = $obj->id;
            }

            // Guardar KPIs
            foreach ($data['kpis'] as $kpi) {
                \App\Models\Kpi::create([
                    'name' => $kpi['name'] ?? '',
                    'description' => $kpi['description'] ?? '',
                    'initial_value' => $kpi['initial_value'] ?? 0,
                    'final_value' => $kpi['final_value'] ?? 0,
                    'projects_id' => $project->id,
                    'is_percentage' => $kpi['is_percentage'] ?? 0,
                    'org_area' => $kpi['org_area'] ?? null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            // Guardar actividades
            foreach ($data['activities'] as $activity) {
                $realObjectiveId = isset($objectiveIdMap[$activity['specific_objective_id']]) ? $objectiveIdMap[$activity['specific_objective_id']] : null;
                \App\Models\Activity::create([
                    'name' => $activity['name'] ?? '',
                    'description' => $activity['description'] ?? '',
                    'specific_objective_id' => $realObjectiveId,
                    'population_target_value' => $activity['population_target_value'] ?? 0,
                    'product_target_value' => $activity['product_target_value'] ?? 0,
                    'created_by' => auth()->id(),
                ]);
            }

            \DB::commit();
            $this->formData = [
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
            ];
            Notification::make()->title('Proyecto guardado exitosamente')->success()->send();
        } catch (\Exception $e) {
            \DB::rollBack();
            Notification::make()->title('Error al guardar el proyecto')->body($e->getMessage())->danger()->send();
        }
    }
}

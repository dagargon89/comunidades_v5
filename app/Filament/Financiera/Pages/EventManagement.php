<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;
use Illuminate\Support\Facades\DB;

class EventManagement extends BaseDashboard
{
    use HasFiltersForm;

    protected static string $routePath = 'gestion-eventos';

    protected static ?string $navigationIcon = 'heroicon-o-calendar';

    protected static ?string $title = 'Gestión de Eventos';

    protected static ?string $navigationLabel = 'Gestión de Eventos';

    protected static ?int $navigationSort = 4;

    public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Filtros de Gestión de Eventos')
                    ->description('Filtra los eventos por proyecto, actividad y fecha')
                    ->icon('heroicon-o-funnel')
                    ->schema([
                        Grid::make(3)
                            ->schema([
                                Select::make('project_name')
                                    ->label('Proyecto')
                                    ->placeholder('Selecciona un proyecto')
                                    ->options(function () {
                                        return DB::table('padron_beneficiarios')
                                            ->select('nombre_proyecto')
                                            ->whereNotNull('nombre_proyecto')
                                            ->distinct()
                                            ->orderBy('nombre_proyecto')
                                            ->get()
                                            ->pluck('nombre_proyecto', 'nombre_proyecto')
                                            ->filter()
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->native(false)
                                    ->reactive(),

                                Select::make('activity_name')
                                    ->label('Actividad')
                                    ->placeholder('Todas las actividades del proyecto')
                                    ->options(function (callable $get) {
                                        $projectName = $get('project_name');

                                        if (!$projectName) {
                                            return [];
                                        }

                                        return DB::table('padron_beneficiarios')
                                            ->select('nombre_actividad')
                                            ->where('nombre_proyecto', $projectName)
                                            ->whereNotNull('nombre_actividad')
                                            ->distinct()
                                            ->orderBy('nombre_actividad')
                                            ->get()
                                            ->pluck('nombre_actividad', 'nombre_actividad')
                                            ->filter()
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->native(false)
                                    ->disabled(fn (callable $get) => !$get('project_name')),

                                Select::make('event_date')
                                    ->label('Evento')
                                    ->placeholder('Todas las fechas de eventos')
                                    ->options(function (callable $get) {
                                        $projectName = $get('project_name');
                                        $activityName = $get('activity_name');

                                        if (!$projectName || !$activityName) {
                                            return [];
                                        }

                                        return DB::table('padron_beneficiarios')
                                            ->select('Evento_Fecha_Inicio')
                                            ->where('nombre_proyecto', $projectName)
                                            ->where('nombre_actividad', $activityName)
                                            ->whereNotNull('Evento_Fecha_Inicio')
                                            ->distinct()
                                            ->orderBy('Evento_Fecha_Inicio')
                                            ->get()
                                            ->pluck('Evento_Fecha_Inicio', 'Evento_Fecha_Inicio')
                                            ->filter()
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->native(false)
                                    ->disabled(fn (callable $get) => !$get('project_name') || !$get('activity_name')),
                            ])
                            ->columnSpanFull(),
                    ])
                    ->columns(1)
                    ->collapsible()
                    ->collapsed(),
            ]);
    }

    public function getWidgets(): array
    {
        return [
            // Aquí puedes agregar widgets específicos para la gestión de eventos
        ];
    }

    public function getColumns(): int | string | array
    {
        return 2;
    }
}

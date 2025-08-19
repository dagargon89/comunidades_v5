<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;
use Illuminate\Support\Facades\DB;
use App\Filament\Financiera\Widgets\ProjectPerformanceStatsOverview;

class ProjectPerformanceDashboard extends BaseDashboard
{
    use HasFiltersForm;

    protected static string $routePath = 'rendimiento-proyectos';

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';

    protected static ?string $title = 'Dashboard de Rendimiento de Proyectos';

    protected static ?string $navigationLabel = 'Rendimiento de Proyectos';

    protected static ?int $navigationSort = 2;

    public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Filtros de Rendimiento de Proyectos')
                    ->description('Filtra los datos por período, proyecto y estado de eventos')
                    ->icon('heroicon-o-funnel')
                    ->schema([
                        // Fechas - Primera fila
                        Grid::make(2)
                            ->schema([
                                DatePicker::make('startDate')
                                    ->label('Fecha de Inicio')
                                    ->placeholder('Desde esta fecha')
                                    ->columnSpan(1),

                                DatePicker::make('endDate')
                                    ->label('Fecha de Fin')
                                    ->placeholder('Hasta esta fecha')
                                    ->columnSpan(1),
                            ])
                            ->columnSpanFull(),

                        // Filtros específicos - Segunda fila
                        Grid::make(3)
                            ->schema([
                                Select::make('financier_id')
                                    ->label('Financiadora')
                                    ->placeholder('Todas las financiadoras')
                                    ->options(function () {
                                        return DB::table('vista_progreso_proyectos')
                                            ->select('Financiadora_id', DB::raw('MIN(Proyecto) as first_project'))
                                            ->whereNotNull('Financiadora_id')
                                            ->groupBy('Financiadora_id')
                                            ->get()
                                            ->pluck('first_project', 'Financiadora_id')
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->native(false),

                                Select::make('project_id')
                                    ->label('Proyecto')
                                    ->placeholder('Todos los proyectos')
                                    ->options(function () {
                                        return DB::table('vista_progreso_proyectos')
                                            ->select('Proyecto_ID', 'Proyecto')
                                            ->distinct()
                                            ->orderBy('Proyecto')
                                            ->get()
                                            ->pluck('Proyecto', 'Proyecto_ID')
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->native(false),

                                Select::make('event_status')
                                    ->label('Estado del Evento')
                                    ->placeholder('Todos los estados')
                                    ->options([
                                        'Completado' => 'Completado',
                                        'Calendarizado' => 'Calendarizado',
                                        'Sin fecha' => 'Sin fecha',
                                    ])
                                    ->native(false),
                            ])
                            ->columnSpanFull(),

                        // Filtros de tiempo - Tercera fila
                        Grid::make(2)
                            ->schema([
                                Select::make('activity_year')
                                    ->label('Año de Actividad')
                                    ->placeholder('Todos los años')
                                    ->options(function () {
                                        return DB::table('vista_progreso_proyectos')
                                            ->select('year_actividad')
                                            ->whereNotNull('year_actividad')
                                            ->distinct()
                                            ->orderByDesc('year_actividad')
                                            ->get()
                                            ->pluck('year_actividad', 'year_actividad')
                                            ->toArray();
                                    })
                                    ->native(false),

                                Select::make('activity_month')
                                    ->label('Mes de Actividad')
                                    ->placeholder('Todos los meses')
                                    ->options([
                                        1 => 'Enero',
                                        2 => 'Febrero',
                                        3 => 'Marzo',
                                        4 => 'Abril',
                                        5 => 'Mayo',
                                        6 => 'Junio',
                                        7 => 'Julio',
                                        8 => 'Agosto',
                                        9 => 'Septiembre',
                                        10 => 'Octubre',
                                        11 => 'Noviembre',
                                        12 => 'Diciembre',
                                    ])
                                    ->native(false),
                            ])
                            ->columnSpanFull(),
                    ])
                    ->columns(1)
                    ->collapsible()
                    ->persistCollapsed()
                    ->collapsed(false),
            ]);
    }

    public function getWidgets(): array
    {
        return [
            ProjectPerformanceStatsOverview::class,
        ];
    }

    public function getColumns(): int | string | array
    {
        return [
            'md' => 2,
            'xl' => 4,
        ];
    }
}

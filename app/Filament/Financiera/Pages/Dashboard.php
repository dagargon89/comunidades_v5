<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Grid;
use Filament\Forms\Form;
use Filament\Actions\Action;
use Illuminate\Support\Facades\DB;

class Dashboard extends BaseDashboard
{
    use HasFiltersForm;

    protected static ?int $navigationSort = 1;

        public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Filtros del Dashboard')
                    ->description('Utiliza estos filtros para personalizar la visualización de datos en todos los widgets')
                    ->schema([
                        // Fechas - Primera fila
                        Grid::make(2)
                            ->schema([
                                DatePicker::make('startDate')
                                    ->label('Fecha de inicio')
                                    ->placeholder('Desde esta fecha')
                                    ->columnSpan(1),
                                DatePicker::make('endDate')
                                    ->label('Fecha de fin')
                                    ->placeholder('Hasta esta fecha')
                                    ->columnSpan(1),
                            ])
                            ->columnSpanFull(),

                        // Proyectos y Financiadora - Segunda fila
                        Grid::make(2)
                            ->schema([
                                Select::make('financier_id')
                                    ->label('Financiadora')
                                    ->placeholder('Todas las financiadoras')
                                    ->options(function () {
                                        return DB::table('financiers')
                                            ->whereNotNull('name')
                                            ->orderBy('name')
                                            ->pluck('name', 'id')
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->columnSpan(1),
                                Select::make('project_id')
                                    ->label('Proyecto')
                                    ->placeholder('Todos los proyectos')
                                    ->options(function () {
                                        return DB::table('projects')
                                            ->whereNotNull('name')
                                            ->orderBy('name')
                                            ->pluck('name', 'id')
                                            ->toArray();
                                    })
                                    ->searchable()
                                    ->columnSpan(1),
                            ])
                            ->columnSpanFull(),

                        // Actividades - Tercera fila
                        Grid::make(3)
                            ->schema([
                                Select::make('activity_year')
                                    ->label('Año')
                                    ->placeholder('Todos los años')
                                    ->options(function () {
                                        return DB::table('vista_progreso_proyectos')
                                            ->whereNotNull('year_actividad')
                                            ->distinct()
                                            ->orderBy('year_actividad', 'desc')
                                            ->pluck('year_actividad', 'year_actividad')
                                            ->toArray();
                                    })
                                    ->columnSpan(1),
                                Select::make('activity_month')
                                    ->label('Mes')
                                    ->placeholder('Todos los meses')
                                    ->options([
                                        1 => 'Enero', 2 => 'Febrero', 3 => 'Marzo',
                                        4 => 'Abril', 5 => 'Mayo', 6 => 'Junio',
                                        7 => 'Julio', 8 => 'Agosto', 9 => 'Septiembre',
                                        10 => 'Octubre', 11 => 'Noviembre', 12 => 'Diciembre',
                                    ])
                                    ->columnSpan(1),
                                Select::make('event_status')
                                    ->label('Estado del evento')
                                    ->placeholder('Todos los estados')
                                    ->options([
                                        'Completado' => 'Completado',
                                        'Calendarizado' => 'Calendarizado',
                                        'Sin fecha' => 'Sin fecha',
                                    ])
                                    ->columnSpan(1),
                            ])
                            ->columnSpanFull(),
                    ])
                    ->columns(12) // Usar 12 columnas para mayor flexibilidad
                    ->collapsible()
                    ->collapsed(),
            ]);
    }

    protected function getHeaderActions(): array
    {
        return [
            Action::make('resetFilters')
                ->label('Limpiar filtros')
                ->icon('heroicon-o-x-mark')
                ->color('gray')
                ->action(function () {
                    $this->filters = [];
                    $this->dispatch('filtersChanged');
                })
                ->visible(fn () => filled($this->filters)),
        ];
    }

    public function getWidgets(): array
    {
        return [
            \App\Filament\Financiera\Widgets\StatsOverview::class,
            \App\Filament\Financiera\Widgets\CostBeneficiaryProject::class,
            \App\Filament\Financiera\Widgets\CostProductProject::class,
            \App\Filament\Financiera\Widgets\PopulationProgressProject::class,
            \App\Filament\Financiera\Widgets\ProductProgressProject::class,
            \App\Filament\Financiera\Widgets\ProjectDetails::class,
        ];
    }

    public function getColumns(): int | string | array
    {
        return 2;
    }
}

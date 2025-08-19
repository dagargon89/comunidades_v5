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

    public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Filtros por Fechas')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                DatePicker::make('startDate')
                                    ->label('Fecha de inicio')
                                    ->placeholder('Filtrar desde esta fecha'),
                                DatePicker::make('endDate')
                                    ->label('Fecha de fin')
                                    ->placeholder('Filtrar hasta esta fecha'),
                            ]),
                    ])
                    ->description('Filtra proyectos por fecha de inicio/fin y actividades por fecha de eventos')
                    ->collapsible(),

                Section::make('Filtros por Proyecto')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                Select::make('financier_id')
                                    ->label('Financiadora')
                                    ->placeholder('Seleccionar financiadora')
                                    ->options(function () {
                                        return DB::table('financiers')
                                            ->whereNotNull('name')
                                            ->pluck('name', 'id')
                                            ->toArray();
                                    })
                                    ->searchable(),
                                Select::make('project_id')
                                    ->label('Proyecto')
                                    ->placeholder('Seleccionar proyecto')
                                    ->options(function () {
                                        return DB::table('projects')
                                            ->whereNotNull('name')
                                            ->pluck('name', 'id')
                                            ->toArray();
                                    })
                                    ->searchable(),
                            ]),
                    ])
                    ->collapsible(),

                Section::make('Filtros por Actividad')
                    ->schema([
                        Grid::make(3)
                            ->schema([
                                Select::make('activity_year')
                                    ->label('Año de actividad')
                                    ->placeholder('Seleccionar año')
                                    ->options(function () {
                                        return DB::table('vista_progreso_proyectos')
                                            ->whereNotNull('year_actividad')
                                            ->distinct()
                                            ->pluck('year_actividad', 'year_actividad')
                                            ->sort()
                                            ->toArray();
                                    }),
                                Select::make('activity_month')
                                    ->label('Mes de actividad')
                                    ->placeholder('Seleccionar mes')
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
                                    ]),
                                Select::make('event_status')
                                    ->label('Estado del evento')
                                    ->placeholder('Seleccionar estado')
                                    ->options([
                                        'Completado' => 'Completado',
                                        'Calendarizado' => 'Calendarizado',
                                        'Sin fecha' => 'Sin fecha',
                                    ]),
                            ]),
                    ])
                    ->collapsible(),

                Section::make('Filtros por Rangos')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                TextInput::make('min_beneficiaries')
                                    ->label('Mín. beneficiarios')
                                    ->placeholder('Número mínimo')
                                    ->numeric()
                                    ->minValue(0),
                                TextInput::make('max_beneficiaries')
                                    ->label('Máx. beneficiarios')
                                    ->placeholder('Número máximo')
                                    ->numeric()
                                    ->minValue(0),
                                TextInput::make('min_products')
                                    ->label('Mín. productos')
                                    ->placeholder('Número mínimo')
                                    ->numeric()
                                    ->minValue(0),
                                TextInput::make('max_products')
                                    ->label('Máx. productos')
                                    ->placeholder('Número máximo')
                                    ->numeric()
                                    ->minValue(0),
                            ]),
                    ])
                    ->collapsible(),
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
}

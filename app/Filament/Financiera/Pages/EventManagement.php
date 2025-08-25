<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;
use Filament\Actions\Action;
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
                                        return DB::table('vista_progreso_proyectos')
                                            ->select('Proyecto')
                                            ->whereNotNull('Proyecto')
                                            ->distinct()
                                            ->orderBy('Proyecto')
                                            ->get()
                                            ->pluck('Proyecto', 'Proyecto')
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

                                        return DB::table('vista_progreso_proyectos')
                                            ->select('Actividad')
                                            ->where('Proyecto', $projectName)
                                            ->whereNotNull('Actividad')
                                            ->distinct()
                                            ->orderBy('Actividad')
                                            ->get()
                                            ->pluck('Actividad', 'Actividad')
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

                                        return DB::table('vista_progreso_proyectos')
                                            ->select('Evento_fecha_inicio')
                                            ->where('Proyecto', $projectName)
                                            ->where('Actividad', $activityName)
                                            ->whereNotNull('Evento_fecha_inicio')
                                            ->distinct()
                                            ->orderBy('Evento_fecha_inicio')
                                            ->get()
                                            ->pluck('Evento_fecha_inicio', 'Evento_fecha_inicio')
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
            \App\Filament\Financiera\Widgets\EventManagementStatsOverview::class,
            \App\Filament\Financiera\Widgets\BeneficiariesTable::class,
        ];
    }

    public function getColumns(): int | string | array
    {
        return 2;
    }
}

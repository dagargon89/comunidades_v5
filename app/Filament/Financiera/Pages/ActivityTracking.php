<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;
use Illuminate\Support\Facades\DB;

class ActivityTracking extends BaseDashboard
{
    use HasFiltersForm;

    protected static string $routePath = 'seguimiento-actividades';

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';

    protected static ?string $title = 'Seguimiento de Actividades';

    protected static ?string $navigationLabel = 'Seguimiento de Actividades';

    protected static ?int $navigationSort = 3;

    public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Filtros de Seguimiento de Actividades')
                    ->description('Filtra las actividades por proyecto específico')
                    ->icon('heroicon-o-funnel')
                    ->schema([
                        Grid::make(2)
                            ->schema([
                                Select::make('project_id')
                                    ->label('Proyecto')
                                    ->placeholder('Selecciona un proyecto')
                                    ->options(function () {
                                        return DB::table('vista_progreso_proyectos')
                                            ->select('Proyecto_ID', 'Proyecto')
                                            ->whereNotNull('Proyecto_ID')
                                            ->whereNotNull('Proyecto')
                                            ->distinct()
                                            ->orderBy('Proyecto')
                                            ->get()
                                            ->pluck('Proyecto', 'Proyecto_ID')
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
                                        $projectId = $get('project_id');

                                        if (!$projectId) {
                                            return [];
                                        }

                                        return DB::table('vista_progreso_proyectos')
                                            ->select('Actividad')
                                            ->where('Proyecto_ID', $projectId)
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
                                    ->disabled(fn (callable $get) => !$get('project_id')),
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
            \App\Filament\Financiera\Widgets\ActivityTrackStatsOverview::class,
            \App\Filament\Financiera\Widgets\ActivityDetails::class,
        ];
    }

    public function getColumns(): int | string | array
    {
        return 2;
    }
}

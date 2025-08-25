<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\DB;
use Filament\Widgets\Concerns\InteractsWithPageFilters;

class ActivityTrackStatsOverview extends BaseWidget
{
    use InteractsWithPageFilters;

    protected static ?string $pollingInterval = null;

    protected function getStats(): array
    {
        // Obtener los filtros aplicados
        $projectId = $this->filters['project_id'] ?? null;
        $activityName = $this->filters['activity_name'] ?? null;

        return [
            Stat::make(
                'Progreso Promedio de Actividades',
                DB::table('vista_progreso_proyectos')
                    ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                    ->when($activityName, fn ($query) => $query->where('Actividad', $activityName))
                    ->whereNotNull('population_progress_percent')
                    ->avg('population_progress_percent') ?
                    round(DB::table('vista_progreso_proyectos')
                        ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                        ->when($activityName, fn ($query) => $query->where('Actividad', $activityName))
                        ->whereNotNull('population_progress_percent')
                        ->avg('population_progress_percent'), 1) . '%' : 'N/A'
            )
                ->description('Promedio de progreso poblacional por actividad')
                ->descriptionIcon('heroicon-o-chart-bar')
                ->icon('heroicon-o-presentation-chart-line')
                ->color('info')
                ->chart([20, 35, 45, 60, 70, 80, 85])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Total de Beneficiarios',
                number_format(DB::table('vista_progreso_proyectos')
                    ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                    ->when($activityName, fn ($query) => $query->where('Actividad', $activityName))
                    ->whereNotNull('Beneficiarios_evento')
                    ->where('Beneficiarios_evento', '>', 0)
                    ->sum('Beneficiarios_evento'))
            )
                ->description('Suma total de beneficiarios en eventos')
                ->descriptionIcon('heroicon-o-users')
                ->icon('heroicon-o-user-group')
                ->color('primary')
                ->chart([50, 100, 75, 150, 125, 200, 175])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Eventos Completados',
                number_format(DB::table('vista_progreso_proyectos')
                    ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                    ->when($activityName, fn ($query) => $query->where('Actividad', $activityName))
                    ->whereRaw("BINARY Evento_estado = 'Completado'")
                    ->count())
            )
                ->description('Total de eventos finalizados exitosamente')
                ->descriptionIcon('heroicon-o-check-circle')
                ->icon('heroicon-o-check-badge')
                ->color('success')
                ->chart([5, 10, 8, 15, 12, 20, 18])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Eventos Calendarizados',
                number_format(DB::table('vista_progreso_proyectos')
                    ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                    ->when($activityName, fn ($query) => $query->where('Actividad', $activityName))
                    ->whereRaw("BINARY Evento_estado = 'Calendarizado'")
                    ->count())
            )
                ->description('Total de eventos programados para el futuro')
                ->descriptionIcon('heroicon-o-calendar')
                ->icon('heroicon-o-calendar-days')
                ->color('info')
                ->chart([3, 8, 6, 12, 10, 15, 13])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),
        ];
    }
}

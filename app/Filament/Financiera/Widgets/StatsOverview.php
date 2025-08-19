<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\DB;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Database\Eloquent\Builder;

class StatsOverview extends BaseWidget
{
    use InteractsWithPageFilters;

    protected function getStats(): array
    {
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $financierId = $this->filters['financier_id'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;
        $activityYear = $this->filters['activity_year'] ?? null;
        $activityMonth = $this->filters['activity_month'] ?? null;
        $eventStatus = $this->filters['event_status'] ?? null;

        return [
            Stat::make(
                'Total de proyectos',
                DB::table('vista_progreso_proyectos')
                    ->when($startDate, fn ($query) => $query->whereDate('Proyecto_Fecha_Inicio', '>=', $startDate))
                    ->when($endDate, fn ($query) => $query->whereDate('Proyecto_Fecha_Final', '<=', $endDate))
                    ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
                    ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                    ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
                    ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
                    ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus))
                    ->distinct('Proyecto_ID')
                    ->count('Proyecto_ID')
            )
                ->description('Cantidad total de proyectos registrados')
                ->descriptionIcon('heroicon-o-chart-bar')
                ->icon('heroicon-o-briefcase')
                ->color('success')
                ->chart([5, 10, 15, 20, 25, 30, 35])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Total de financiamiento',
                '$' . number_format(
                    DB::table('vista_progreso_proyectos')
                        ->when($startDate, fn ($query) => $query->whereDate('Proyecto_Fecha_Inicio', '>=', $startDate))
                        ->when($endDate, fn ($query) => $query->whereDate('Proyecto_Fecha_Final', '<=', $endDate))
                        ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
                        ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                        ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
                        ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
                        ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus))
                        ->distinct('Proyecto_ID')
                        ->sum('Proyecto_cantidad_financiada'),
                    0, '.', ','
                )
            )
                ->description('Monto total financiado de todos los proyectos')
                ->descriptionIcon('heroicon-o-currency-dollar')
                ->icon('heroicon-o-banknotes')
                ->color('warning')
                ->chart([1000000, 2000000, 1500000, 3000000, 2500000, 4000000, 3500000])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Beneficiarios únicos',
                DB::table('vista_progreso_proyectos')
                    ->when($startDate, fn ($query) => $query->whereDate('Evento_fecha_inicio', '>=', $startDate))
                    ->when($endDate, fn ($query) => $query->whereDate('Evento_fecha_fin', '<=', $endDate))
                    ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
                    ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                    ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
                    ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
                    ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus))
                    ->whereNotNull('Beneficiarios_evento')
                    ->where('Beneficiarios_evento', '>', 0)
                    ->sum('Beneficiarios_evento')
            )
                ->description('Total de beneficiarios registrados en actividades')
                ->descriptionIcon('heroicon-o-users')
                ->icon('heroicon-o-user-group')
                ->color('info')
                ->chart([50, 100, 75, 150, 125, 200, 175])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Productos únicos',
                DB::table('vista_progreso_proyectos')
                    ->when($startDate, fn ($query) => $query->whereDate('Evento_fecha_inicio', '>=', $startDate))
                    ->when($endDate, fn ($query) => $query->whereDate('Evento_fecha_fin', '<=', $endDate))
                    ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
                    ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
                    ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
                    ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
                    ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus))
                    ->whereNotNull('Productos_realizados')
                    ->where('Productos_realizados', '>', 0)
                    ->sum('Productos_realizados') ?: 'N/A'
            )
                ->description('Total de productos realizados en actividades')
                ->descriptionIcon('heroicon-o-cube')
                ->icon('heroicon-o-cube-transparent')
                ->color('success')
                ->chart([10, 20, 15, 30, 25, 40, 35])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),
        ];
    }
}

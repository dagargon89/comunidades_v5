<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\DB;
use Filament\Widgets\Concerns\InteractsWithPageFilters;

class ProjectPerformanceStatsOverview extends BaseWidget
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

        // Query base con filtros aplicados
        $baseQuery = DB::table('vista_progreso_proyectos')
            ->when($startDate, fn ($query) => $query->whereDate('Proyecto_Fecha_Inicio', '>=', $startDate))
            ->when($endDate, fn ($query) => $query->whereDate('Proyecto_Fecha_Final', '<=', $endDate))
            ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
            ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
            ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
            ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus));

        // Project Total Investment - Inversión total única por proyecto
        $totalInvestment = DB::table(DB::raw('(SELECT DISTINCT Proyecto_ID, Proyecto_cantidad_financiada, Financiadora_id, year_actividad, mes_actividad, Evento_estado FROM vista_progreso_proyectos) as unique_projects'))
            ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
            ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
            ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
            ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus))
            ->sum('Proyecto_cantidad_financiada');

        // Total Activities - Actividades únicas
        $totalActivities = (clone $baseQuery)
            ->count(DB::raw('DISTINCT Actividad_id'));

        // Total Beneficiaries - Suma de beneficiarios de eventos
        $totalBeneficiaries = (clone $baseQuery)
            ->whereNotNull('Beneficiarios_evento')
            ->where('Beneficiarios_evento', '>', 0)
            ->sum('Beneficiarios_evento');

        // Progreso promedio de población
        $avgPopulationProgress = (clone $baseQuery)
            ->whereNotNull('population_progress_percent')
            ->avg('population_progress_percent');

        return [
            Stat::make(
                'Inversión Total del Proyecto',
                '$' . number_format($totalInvestment, 0, '.', ',')
            )
                ->description('Monto total de financiamiento único por proyecto')
                ->descriptionIcon('heroicon-o-currency-dollar')
                ->icon('heroicon-o-banknotes')
                ->color('success')
                ->chart([1000000, 1500000, 2000000, 2500000, 3000000, 3500000, 4000000])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Total de Actividades',
                number_format($totalActivities)
            )
                ->description('Número total de actividades únicas registradas')
                ->descriptionIcon('heroicon-o-list-bullet')
                ->icon('heroicon-o-clipboard-document-list')
                ->color('info')
                ->chart([5, 10, 8, 15, 12, 20, 18])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Total de Beneficiarios',
                number_format($totalBeneficiaries)
            )
                ->description('Suma total de beneficiarios en eventos')
                ->descriptionIcon('heroicon-o-users')
                ->icon('heroicon-o-user-group')
                ->color('warning')
                ->chart([50, 100, 75, 150, 125, 200, 175])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Progreso Promedio de Población',
                $avgPopulationProgress ? round($avgPopulationProgress, 1) . '%' : 'N/A'
            )
                ->description('Porcentaje promedio de progreso poblacional')
                ->descriptionIcon('heroicon-o-chart-bar')
                ->icon('heroicon-o-presentation-chart-line')
                ->color($avgPopulationProgress >= 75 ? 'success' : ($avgPopulationProgress >= 50 ? 'warning' : 'danger'))
                ->chart([20, 35, 45, 60, 70, 80, 85])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),
        ];
    }
}

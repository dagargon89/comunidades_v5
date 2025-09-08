<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use App\Models\Project;
use App\Models\Activity;
use App\Models\ActivityCalendar;
use App\Models\BeneficiaryRegistry;
use App\Models\PlannedMetric;
use Illuminate\Support\Facades\DB;

class StatsOverview extends BaseWidget
{
    use InteractsWithPageFilters;

    protected static ?string $pollingInterval = null;

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
                $this->getTotalProjects($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus)
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
                    $this->getTotalFinancing($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus),
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
                $this->getTotalBeneficiaries($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus)
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
                $this->getTotalProducts($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus) ?: 'N/A'
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

    /**
     * Obtener el total de proyectos únicos usando consultas directas a las tablas
     */
    private function getTotalProjects($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus)
    {
        $query = Project::query()
            ->when($startDate, fn ($query) => $query->whereDate('start_date', '>=', $startDate))
            ->when($endDate, fn ($query) => $query->whereDate('end_date', '<=', $endDate))
            ->when($financierId, fn ($query) => $query->where('financiers_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('id', $projectId));

        // Si hay filtros de actividad, filtrar por actividades relacionadas
        if ($activityYear || $activityMonth || $eventStatus) {
            $query->whereHas('specificObjectives.activities', function ($activityQuery) use ($activityYear, $activityMonth, $eventStatus) {
                if ($activityYear) {
                    $activityQuery->whereHas('plannedMetrics', fn ($q) => $q->where('year', $activityYear));
                }
                if ($activityMonth) {
                    $activityQuery->whereHas('plannedMetrics', fn ($q) => $q->where('month', $activityMonth));
                }
                if ($eventStatus) {
                    $activityQuery->whereHas('activityCalendars', function ($calendarQuery) use ($eventStatus) {
                        if ($eventStatus === 'Completado') {
                            $calendarQuery->where('end_date', '<=', now());
                        } elseif ($eventStatus === 'Calendarizado') {
                            $calendarQuery->where('end_date', '>', now());
                        }
                    });
                }
            });
        }

        return $query->count();
    }

    /**
     * Obtener el total de financiamiento usando consultas directas a las tablas
     */
    private function getTotalFinancing($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus)
    {
        $query = Project::query()
            ->when($startDate, fn ($query) => $query->whereDate('start_date', '>=', $startDate))
            ->when($endDate, fn ($query) => $query->whereDate('end_date', '<=', $endDate))
            ->when($financierId, fn ($query) => $query->where('financiers_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('id', $projectId));

        // Si hay filtros de actividad, filtrar por actividades relacionadas
        if ($activityYear || $activityMonth || $eventStatus) {
            $query->whereHas('specificObjectives.activities', function ($activityQuery) use ($activityYear, $activityMonth, $eventStatus) {
                if ($activityYear) {
                    $activityQuery->whereHas('plannedMetrics', fn ($q) => $q->where('year', $activityYear));
                }
                if ($activityMonth) {
                    $activityQuery->whereHas('plannedMetrics', fn ($q) => $q->where('month', $activityMonth));
                }
                if ($eventStatus) {
                    $activityQuery->whereHas('activityCalendars', function ($calendarQuery) use ($eventStatus) {
                        if ($eventStatus === 'Completado') {
                            $calendarQuery->where('end_date', '<=', now());
                        } elseif ($eventStatus === 'Calendarizado') {
                            $calendarQuery->where('end_date', '>', now());
                        }
                    });
                }
            });
        }

        return $query->sum('funded_amount');
    }

    /**
     * Obtener el total de beneficiarios únicos usando consultas directas a las tablas
     */
    private function getTotalBeneficiaries($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus)
    {
        $query = BeneficiaryRegistry::query()
            ->whereHas('activityCalendar.activity.specificObjective.project', function ($projectQuery) use ($startDate, $endDate, $financierId, $projectId) {
                $projectQuery->when($startDate, fn ($query) => $query->whereDate('start_date', '>=', $startDate))
                    ->when($endDate, fn ($query) => $query->whereDate('end_date', '<=', $endDate))
                    ->when($financierId, fn ($query) => $query->where('financiers_id', $financierId))
                    ->when($projectId, fn ($query) => $query->where('id', $projectId));
            })
            ->when($activityYear, function ($query) use ($activityYear) {
                $query->whereHas('activityCalendar.activity.plannedMetrics', fn ($q) => $q->where('year', $activityYear));
            })
            ->when($activityMonth, function ($query) use ($activityMonth) {
                $query->whereHas('activityCalendar.activity.plannedMetrics', fn ($q) => $q->where('month', $activityMonth));
            })
            ->when($eventStatus, function ($query) use ($eventStatus) {
                $query->whereHas('activityCalendar', function ($calendarQuery) use ($eventStatus) {
                    if ($eventStatus === 'Completado') {
                        $calendarQuery->where('end_date', '<=', now());
                    } elseif ($eventStatus === 'Calendarizado') {
                        $calendarQuery->where('end_date', '>', now());
                    }
                });
            });

        return $query->count();
    }

    /**
     * Obtener el total de productos realizados usando consultas directas a las tablas
     */
    private function getTotalProducts($startDate, $endDate, $financierId, $projectId, $activityYear, $activityMonth, $eventStatus)
    {
        $query = PlannedMetric::query()
            ->whereNotNull('product_real_value')
            ->where('product_real_value', '>', 0)
            ->whereHas('activity.specificObjective.project', function ($projectQuery) use ($startDate, $endDate, $financierId, $projectId) {
                $projectQuery->when($startDate, fn ($query) => $query->whereDate('start_date', '>=', $startDate))
                    ->when($endDate, fn ($query) => $query->whereDate('end_date', '<=', $endDate))
                    ->when($financierId, fn ($query) => $query->where('financiers_id', $financierId))
                    ->when($projectId, fn ($query) => $query->where('id', $projectId));
            })
            ->when($activityYear, fn ($query) => $query->where('year', $activityYear))
            ->when($activityMonth, fn ($query) => $query->where('month', $activityMonth))
            ->when($eventStatus, function ($query) use ($eventStatus) {
                $query->whereHas('activity.activityCalendars', function ($calendarQuery) use ($eventStatus) {
                    if ($eventStatus === 'Completado') {
                        $calendarQuery->where('end_date', '<=', now());
                    } elseif ($eventStatus === 'Calendarizado') {
                        $calendarQuery->where('end_date', '>', now());
                    }
                });
            });

        return $query->sum('product_real_value');
    }
}

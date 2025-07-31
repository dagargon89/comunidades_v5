<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\ActivityCalendar;
use Carbon\Carbon;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Auth as AuthFacade;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Database\Eloquent\Builder;

class ActivityCalendarCount extends BaseWidget
{
   // use HasWidgetShield;
    use InteractsWithPageFilters;

    protected static ?string $pollingInterval = null;

    protected static bool $isLazy = false;

    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        try {
            $userId = \Illuminate\Support\Facades\Auth::id();

            // Obtener filtros del dashboard
            $startDate = $this->filters['startDate'] ?? null;
            $endDate = $this->filters['endDate'] ?? null;
            $projectId = $this->filters['project_id'] ?? null;

            // Query base
            $query = ActivityCalendar::where('assigned_person', $userId);

            // Aplicar filtros de fecha
            if ($startDate) {
                $query->where('start_date', '>=', $startDate);
            }
            if ($endDate) {
                $query->where('end_date', '<=', $endDate);
            }

            // Aplicar filtro de proyecto
            if ($projectId) {
                $query->whereHas('activity.goal', function (Builder $q) use ($projectId) {
                    $q->where('project_id', $projectId);
                });
            }

            $totalActivities = $query->count();
            $cancelledActivities = (clone $query)->where('cancelled', 1)->count();
            $activeActivities = (clone $query)->where('cancelled', 0)->count();
            $todayActivities = (clone $query)->whereDate('start_date', Carbon::today())->count();
            $thisWeekActivities = (clone $query)->whereBetween('start_date', [
                Carbon::now()->startOfWeek(),
                Carbon::now()->endOfWeek()
            ])->count();

            return [
                Stat::make('Total de Actividades', $totalActivities)
                    ->description('Todas las actividades calendarizadas')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('primary'),

                Stat::make('Actividades Activas', $activeActivities)
                    ->description('Actividades no canceladas')
                    ->descriptionIcon('heroicon-m-check-circle')
                    ->color('success'),

                Stat::make('Actividades Canceladas', $cancelledActivities)
                    ->description('Actividades canceladas')
                    ->descriptionIcon('heroicon-m-x-circle')
                    ->color('danger'),

                Stat::make('Actividades de Hoy', $todayActivities)
                    ->description('Actividades que empiezan hoy')
                    ->descriptionIcon('heroicon-m-calendar')
                    ->color('info'),

                Stat::make('Actividades de la Semana', $thisWeekActivities)
                    ->description('Actividades de esta semana')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('warning'),
            ];
        } catch (\Exception $e) {
            // En caso de error, devolver estadísticas básicas
            return [
                Stat::make('Total de Actividades', 0)
                    ->description('Error al cargar estadísticas')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        }
    }
}

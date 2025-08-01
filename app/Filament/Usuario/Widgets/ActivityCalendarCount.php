<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\ActivityCalendar;
use Carbon\Carbon;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Auth as AuthFacade;

class ActivityCalendarCount extends BaseWidget
{
   // use HasWidgetShield;

    protected static ?string $pollingInterval = null;

    protected static bool $isLazy = false;

    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        try {
            $userId = \Illuminate\Support\Facades\Auth::id();

            // Query base sin filtros
            $query = ActivityCalendar::where('assigned_person', $userId);

            $totalActivities = $query->count();
            $activeActivities = (clone $query)->where('cancelled', 0)->count();
            $todayActivities = (clone $query)->whereDate('start_date', Carbon::today())->count();
            $thisWeekActivities = (clone $query)->whereBetween('start_date', [
                Carbon::now()->startOfWeek(),
                Carbon::now()->endOfWeek()
            ])->count();

            return [
                Stat::make('Mis Actividades', $totalActivities)
                    ->description('Total de actividades asignadas')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('primary'),

                Stat::make('Activas', $activeActivities)
                    ->description('Actividades pendientes')
                    ->descriptionIcon('heroicon-m-check-circle')
                    ->color('success'),

                Stat::make('Hoy', $todayActivities)
                    ->description('Actividades de hoy')
                    ->descriptionIcon('heroicon-m-calendar')
                    ->color('info'),

                Stat::make('Esta Semana', $thisWeekActivities)
                    ->description('Actividades de la semana')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('warning'),
            ];
        } catch (\Exception $e) {
            // En caso de error, devolver estadísticas básicas
            return [
                Stat::make('Mis Actividades', 0)
                    ->description('Error al cargar estadísticas')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        }
    }
}

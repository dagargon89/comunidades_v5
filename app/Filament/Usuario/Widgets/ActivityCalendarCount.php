<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\ActivityCalendar;
use Carbon\Carbon;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;

class ActivityCalendarCount extends BaseWidget
{
    use HasWidgetShield;

    protected function getStats(): array
    {
        $totalActivities = ActivityCalendar::count();
        $cancelledActivities = ActivityCalendar::where('cancelled', 1)->count();
        $activeActivities = ActivityCalendar::where('cancelled', 0)->count();
        $todayActivities = ActivityCalendar::whereDate('start_date', Carbon::today())->count();
        $thisWeekActivities = ActivityCalendar::whereBetween('start_date', [
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
    }
}

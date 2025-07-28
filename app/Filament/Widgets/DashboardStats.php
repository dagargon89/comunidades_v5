<?php

namespace App\Filament\Widgets;

use App\Models\User;
use App\Models\ActivityCalendar;
use App\Models\Beneficiary;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Carbon\Carbon;

class DashboardStats extends BaseWidget
{
    protected function getStats(): array
    {
        $today = Carbon::today();
        $thisWeek = Carbon::now()->startOfWeek();
        $thisMonth = Carbon::now()->startOfMonth();

        return [
            Stat::make('Usuarios del Sistema', User::count())
                ->description('Total de usuarios registrados')
                ->descriptionIcon('heroicon-m-users')
                ->color('primary')
                ->chart([7, 2, 10, 3, 15, 4, 17]),

            Stat::make('Usuarios Activos', User::where('email_verified_at', '!=', null)->count())
                ->description('Usuarios con email verificado')
                ->descriptionIcon('heroicon-m-check-circle')
                ->color('success')
                ->chart([17, 16, 14, 15, 14, 13, 12]),

            Stat::make('Actividades de Hoy', ActivityCalendar::whereDate('start_date', $today)->count())
                ->description('Actividades programadas para hoy')
                ->descriptionIcon('heroicon-m-calendar')
                ->color('warning'),

            Stat::make('Actividades de la Semana', ActivityCalendar::whereBetween('start_date', [$thisWeek, $thisWeek->copy()->endOfWeek()])->count())
                ->description('Actividades de esta semana')
                ->descriptionIcon('heroicon-m-calendar-days')
                ->color('info'),

            Stat::make('Beneficiarios Registrados', Beneficiary::count())
                ->description('Total de beneficiarios en el sistema')
                ->descriptionIcon('heroicon-m-user-group')
                ->color('success'),

            Stat::make('Sistema Operativo', 'Laravel ' . app()->version())
                ->description('Versión del framework')
                ->descriptionIcon('heroicon-m-cog-6-tooth')
                ->color('gray'),
        ];
    }
}

<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\BeneficiaryRegistry;
use App\Models\ActivityCalendar;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;

class BeneficiaryStats extends BaseWidget
{
    // use HasWidgetShield;

    protected static ?string $pollingInterval = null;

    protected static bool $isLazy = false;

    protected static ?int $sort = 3;

    protected function getStats(): array
    {
        try {
            $userId = Auth::id();

            // Obtener las actividades calendarizadas del usuario
            $userActivityIds = ActivityCalendar::where('assigned_person', $userId)
                ->pluck('id')
                ->toArray();

            // Si no hay actividades, mostrar estadísticas vacías
            if (empty($userActivityIds)) {
                return [
                    Stat::make('Beneficiarios', 0)
                        ->description('No hay actividades asignadas')
                        ->descriptionIcon('heroicon-m-users')
                        ->color('gray'),

                    Stat::make('Esta Semana', 0)
                        ->description('Sin registros esta semana')
                        ->descriptionIcon('heroicon-m-calendar-days')
                        ->color('gray'),

                    Stat::make('Hoy', 0)
                        ->description('Sin registros hoy')
                        ->descriptionIcon('heroicon-m-clock')
                        ->color('gray'),

                    Stat::make('Pendientes', 0)
                        ->description('Sin actividades pendientes')
                        ->descriptionIcon('heroicon-m-exclamation-triangle')
                        ->color('gray'),
                ];
            }

            // Estadísticas de beneficiarios
            $totalBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)->count();
            $thisWeekBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->whereBetween('created_at', [
                    Carbon::now()->startOfWeek(),
                    Carbon::now()->endOfWeek()
                ])
                ->count();
            $todayBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->whereDate('created_at', Carbon::today())
                ->count();

            // Actividades con y sin registros
            $activitiesWithRegistries = ActivityCalendar::where('assigned_person', $userId)
                ->whereHas('beneficiaryRegistries')
                ->count();
            $activitiesWithoutRegistries = ActivityCalendar::where('assigned_person', $userId)
                ->whereDoesntHave('beneficiaryRegistries')
                ->count();

            return [
                Stat::make('Beneficiarios', $totalBeneficiaries)
                    ->description('Total de registros')
                    ->descriptionIcon('heroicon-m-users')
                    ->color('primary'),

                Stat::make('Esta Semana', $thisWeekBeneficiaries)
                    ->description('Registros de esta semana')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('warning'),

                Stat::make('Hoy', $todayBeneficiaries)
                    ->description('Registros de hoy')
                    ->descriptionIcon('heroicon-m-clock')
                    ->color('success'),

                Stat::make('Pendientes', $activitiesWithoutRegistries)
                    ->description('Actividades sin registros')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        } catch (\Exception $e) {
            return [
                Stat::make('Beneficiarios', 0)
                    ->description('Error al cargar estadísticas')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        }
    }
}

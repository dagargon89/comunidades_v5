<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\BeneficiaryRegistry;
use App\Models\ActivityCalendar;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Database\Eloquent\Builder;

class BeneficiaryStats extends BaseWidget
{
    // use HasWidgetShield;
    use InteractsWithPageFilters;

    protected static ?string $pollingInterval = null;

    protected static bool $isLazy = false;

    protected static ?int $sort = 4;

    protected function getStats(): array
    {
        try {
            $userId = Auth::id();

            // Obtener filtros del dashboard
            $startDate = $this->filters['startDate'] ?? null;
            $endDate = $this->filters['endDate'] ?? null;
            $projectId = $this->filters['project_id'] ?? null;

            // Obtener las actividades calendarizadas del usuario con filtros
            $activityQuery = ActivityCalendar::where('assigned_person', $userId);

            // Aplicar filtros de fecha
            if ($startDate) {
                $activityQuery->where('start_date', '>=', $startDate);
            }
            if ($endDate) {
                $activityQuery->where('end_date', '<=', $endDate);
            }

            // Aplicar filtro de proyecto
            if ($projectId) {
                $activityQuery->whereHas('activity.goal', function (Builder $q) use ($projectId) {
                    $q->where('project_id', $projectId);
                });
            }

            $userActivityIds = $activityQuery->pluck('id')->toArray();

            // Estadísticas de beneficiarios
            $totalBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)->count();
            $thisMonthBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->whereMonth('created_at', Carbon::now()->month)
                ->count();
            $thisWeekBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->whereBetween('created_at', [
                    Carbon::now()->startOfWeek(),
                    Carbon::now()->endOfWeek()
                ])
                ->count();
            $todayBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->whereDate('created_at', Carbon::today())
                ->count();

            // Estadísticas por género
            $maleBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->whereHas('beneficiaries', function ($query) {
                    $query->where('gender', 'M');
                })
                ->count();
            $femaleBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->whereHas('beneficiaries', function ($query) {
                    $query->where('gender', 'F');
                })
                ->count();

            // Beneficiarios únicos (sin duplicados)
            $uniqueBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
                ->distinct('beneficiaries_id')
                ->count();

            return [
                Stat::make('Total de Registros', $totalBeneficiaries)
                    ->description('Todos los registros de beneficiarios')
                    ->descriptionIcon('heroicon-m-users')
                    ->color('primary'),

                Stat::make('Beneficiarios Únicos', $uniqueBeneficiaries)
                    ->description('Beneficiarios sin duplicados')
                    ->descriptionIcon('heroicon-m-user-group')
                    ->color('success'),

                Stat::make('Registros del Mes', $thisMonthBeneficiaries)
                    ->description('Registros este mes')
                    ->descriptionIcon('heroicon-m-calendar')
                    ->color('info'),

                Stat::make('Registros de la Semana', $thisWeekBeneficiaries)
                    ->description('Registros esta semana')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('warning'),

                Stat::make('Registros de Hoy', $todayBeneficiaries)
                    ->description('Registros hoy')
                    ->descriptionIcon('heroicon-m-clock')
                    ->color('success'),

                Stat::make('Hombres', $maleBeneficiaries)
                    ->description('Beneficiarios masculinos')
                    ->descriptionIcon('heroicon-m-user')
                    ->color('blue'),

                Stat::make('Mujeres', $femaleBeneficiaries)
                    ->description('Beneficiarias femeninas')
                    ->descriptionIcon('heroicon-m-user')
                    ->color('pink'),
            ];
        } catch (\Exception $e) {
            return [
                Stat::make('Total de Registros', 0)
                    ->description('Error al cargar estadísticas')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        }
    }
}

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

            // Actividades de hoy con detalles
            $todayActivities = (clone $query)->whereDate('start_date', Carbon::today())->get();
            $todayCount = $todayActivities->count();

            // Actividades de esta semana con detalles
            $thisWeekActivities = (clone $query)->whereBetween('start_date', [
                Carbon::now()->startOfWeek(),
                Carbon::now()->endOfWeek()
            ])->get();
            $thisWeekCount = $thisWeekActivities->count();

            // Preparar descripciones con detalles
            $todayDescription = $this->getActivitiesDescription($todayActivities, 'hoy');
            $thisWeekDescription = $this->getActivitiesDescription($thisWeekActivities, 'esta semana');

            return [
                Stat::make('Mis Actividades', $totalActivities)
                    ->description('Total de actividades asignadas')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('primary'),

                Stat::make('Activas', $activeActivities)
                    ->description('Actividades pendientes')
                    ->descriptionIcon('heroicon-m-check-circle')
                    ->color('success'),

                Stat::make('Hoy (' . $todayCount . ')', $todayCount)
                    ->description($todayDescription)
                    ->descriptionIcon('heroicon-m-calendar')
                    ->color('info'),

                Stat::make('Esta Semana (' . $thisWeekCount . ')', $thisWeekCount)
                    ->description($thisWeekDescription)
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

    private function getActivitiesDescription($activities, $period): string
    {
        if ($activities->isEmpty()) {
            return "No hay actividades para " . $period;
        }

        $descriptions = [];
        foreach ($activities->take(3) as $activity) {
            $date = Carbon::parse($activity->start_date)->format('d/m');
            $time = $activity->start_hour ? Carbon::parse($activity->start_hour)->format('H:i') : '';
            $name = $activity->activity->name ?? 'Sin nombre';

            $description = $date;
            if ($time) {
                $description .= " " . $time;
            }
            $description .= " - " . substr($name, 0, 30);
            if (strlen($name) > 30) {
                $description .= "...";
            }

            $descriptions[] = $description;
        }

        $result = implode(", ", $descriptions);

        if ($activities->count() > 3) {
            $remaining = $activities->count() - 3;
            $result .= " y " . $remaining . " más";
        }

        return $result;
    }
}

<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Widgets\Widget;
use App\Models\ActivityCalendar;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;

class UpcomingActivitiesWidget extends Widget
{
    protected static ?string $heading = 'Próximas Actividades';
    protected static ?int $sort = 8;
    protected static bool $isLazy = false;
    protected static string $view = 'filament.usuario.widgets.upcoming-activities-widget';

    public function getUpcomingActivities()
    {
        return ActivityCalendar::query()
            ->with(['activity', 'activity.goal', 'location'])
            ->where('assigned_person', Auth::id())
            ->where('cancelled', false)
            ->where('start_date', '>=', Carbon::today())
            ->orderBy('start_date')
            ->orderBy('start_hour')
            ->limit(8)
            ->get()
            ->map(function ($activity) {
                $startDate = Carbon::parse($activity->start_date);
                $time = $activity->start_hour ? Carbon::parse($activity->start_hour)->format('H:i') : '';

                // Determinar el estado
                if ($startDate->isToday()) {
                    $status = 'Hoy';
                    $statusColor = 'success';
                } elseif ($startDate->isTomorrow()) {
                    $status = 'Mañana';
                    $statusColor = 'warning';
                } elseif ($startDate->isThisWeek()) {
                    $status = 'Esta Semana';
                    $statusColor = 'info';
                } else {
                    $status = 'Próximamente';
                    $statusColor = 'gray';
                }

                return [
                    'id' => $activity->id,
                    'name' => $activity->activity->name ?? 'Sin nombre',
                    'date' => $startDate->format('d/m/Y'),
                    'time' => $time,
                    'location' => $activity->location->name ?? 'Sin ubicación',
                    'status' => $status,
                    'status_color' => $statusColor,
                    'full_date' => $startDate->format('l, d \d\e F Y'),
                ];
            });
    }
}

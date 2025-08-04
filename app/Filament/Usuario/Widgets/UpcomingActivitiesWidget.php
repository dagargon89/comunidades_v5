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
    protected static bool $isLazy = false;
    protected static string $view = 'filament.usuario.widgets.upcoming-activities-widget';

    // Hacer que el widget ocupe todo el ancho disponible
    protected int|string|array $columnSpan = 'full';

    // Propiedad para el modal
    public ?int $selectedActivityId = null;

    public function openActivityModal(int $activityId): void
    {
        $this->selectedActivityId = $activityId;
        $this->dispatch('open-modal', id: 'activity-details-modal');
    }

    public function getSelectedActivity()
    {
        if (!$this->selectedActivityId) {
            return null;
        }

        return ActivityCalendar::query()
            ->with(['activity', 'activity.goal', 'location'])
            ->find($this->selectedActivityId);
    }

    public function getUpcomingActivities()
    {
        return ActivityCalendar::query()
            ->with(['activity', 'activity.goal', 'location'])
            ->where('assigned_person', Auth::id())
            ->where('cancelled', false)
            ->where(function ($query) {
                $query->where('start_date', '>=', Carbon::today())
                      ->orWhere(function ($subQuery) {
                          $subQuery->where('start_date', '<=', Carbon::today())
                                   ->where('end_date', '>=', Carbon::today());
                      });
            })
            ->orderBy('start_date')
            ->orderBy('start_hour')
            ->limit(8)
            ->get()
            ->map(function ($activity) {
                $startDate = Carbon::parse($activity->start_date);
                $endDate = $activity->end_date ? Carbon::parse($activity->end_date) : null;
                $time = $activity->start_hour ? Carbon::parse($activity->start_hour)->format('H:i') : '';

                // Determinar el estado considerando rangos de fechas
                $today = Carbon::today();

                if ($startDate->isToday() || ($startDate->lte($today) && $endDate && $endDate->gte($today))) {
                    $status = 'En Curso';
                    $statusColor = 'success';
                } elseif ($startDate->isTomorrow()) {
                    $status = 'Mañana';
                    $statusColor = 'warning';
                } elseif ($startDate->isThisWeek()) {
                    $status = 'Esta Semana';
                    $statusColor = 'info';
                } elseif ($startDate->isNextWeek()) {
                    $status = 'Próxima Semana';
                    $statusColor = 'gray';
                } else {
                    $status = 'Próximamente';
                    $statusColor = 'gray';
                }

                // Formatear la fecha mostrando rango si es necesario
                $dateDisplay = $startDate->format('d/m/Y');
                if ($endDate && $endDate->ne($startDate)) {
                    $dateDisplay .= ' - ' . $endDate->format('d/m/Y');
                }

                return [
                    'id' => $activity->id,
                    'name' => $activity->activity->name ?? 'Sin nombre',
                    'date' => $dateDisplay,
                    'time' => $time,
                    'location' => $activity->location->name ?? 'Sin ubicación',
                    'status' => $status,
                    'status_color' => $statusColor,
                    'full_date' => $startDate->format('l, d \d\e F Y'),
                    'has_range' => $endDate && $endDate->ne($startDate),
                    'end_date' => $endDate ? $endDate->format('d/m/Y') : null,
                ];
            });
    }
}

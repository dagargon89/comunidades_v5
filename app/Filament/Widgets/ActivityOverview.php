<?php

namespace App\Filament\Widgets;

use App\Models\User;
use App\Models\ActivityCalendar;
use Filament\Widgets\ChartWidget;
use Carbon\Carbon;

class ActivityOverview extends ChartWidget
{
    protected static ?string $heading = 'Registros por Mes';
    protected static ?int $sort = 3;

    protected function getData(): array
    {
        $users = User::query()
            ->selectRaw('MONTH(created_at) as month, COUNT(*) as count')
            ->groupBy('month')
            ->orderBy('month')
            ->get();

        $activities = ActivityCalendar::query()
            ->selectRaw('MONTH(created_at) as month, COUNT(*) as count')
            ->groupBy('month')
            ->orderBy('month')
            ->get();

        $months = [];
        $userCounts = [];
        $activityCounts = [];

        for ($i = 1; $i <= 12; $i++) {
            $monthName = Carbon::create()->month($i)->format('M');
            $months[] = $monthName;

            $user = $users->where('month', $i)->first();
            $userCounts[] = $user ? $user->count : 0;

            $activity = $activities->where('month', $i)->first();
            $activityCounts[] = $activity ? $activity->count : 0;
        }

        return [
            'datasets' => [
                [
                    'label' => 'Usuarios Registrados',
                    'data' => $userCounts,
                    'backgroundColor' => '#36A2EB',
                    'borderColor' => '#36A2EB',
                ],
                [
                    'label' => 'Actividades Creadas',
                    'data' => $activityCounts,
                    'backgroundColor' => '#FF6384',
                    'borderColor' => '#FF6384',
                ],
            ],
            'labels' => $months,
        ];
    }

    protected function getType(): string
    {
        return 'bar';
    }
}

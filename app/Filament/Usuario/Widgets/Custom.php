<?php

namespace App\Filament\Usuario\Widgets;

use App\Models\Activity;
use App\Models\ActivityLog;
use App\Models\Goal;
use App\Models\Project;
use Filament\Widgets\Widget;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;

class Custom extends Widget
{
    use HasWidgetShield;

    protected static ?string $heading = 'Dashboard de Actividades';
    protected static ?int $sort = 1;
    protected static bool $isLazy = false;
    protected static string $view = 'filament.usuario.widgets.custom';

    public function getData()
    {
        $user = Auth::user();

        // Obtener actividades creadas por el usuario
        $userActivities = Activity::where('created_by', $user->id)
            ->with(['goal.project', 'specificObjective.project', 'createdBy'])
            ->get();

        // Estadísticas generales
        $totalActivities = $userActivities->count();
        $activitiesThisMonth = $userActivities->where('created_at', '>=', now()->startOfMonth())->count();
        $activitiesThisWeek = $userActivities->where('created_at', '>=', now()->startOfWeek())->count();

        // Actividades por proyecto
        $activitiesByProject = $userActivities->groupBy(function($activity) {
            return $activity->goal->project->name ?? 'Sin proyecto';
        })->map(function($group) {
            return $group->count();
        });

        // Actividades por mes (últimos 6 meses)
        $activitiesByMonth = collect();
        for ($i = 5; $i >= 0; $i--) {
            $month = now()->subMonths($i);
            $count = $userActivities->where('created_at', '>=', $month->startOfMonth())
                                  ->where('created_at', '<', $month->endOfMonth())
                                  ->count();
            $activitiesByMonth->put($month->format('M Y'), $count);
        }

        // Proyectos más activos
        $topProjects = $userActivities->groupBy(function($activity) {
            return $activity->goal->project->name ?? 'Sin proyecto';
        })->map(function($group) {
            return $group->count();
        })->sortDesc()->take(5);

        // Actividades recientes
        $recentActivities = $userActivities->sortByDesc('created_at')->take(10);

        // Logs de actividades (si existen)
        $activityLogs = ActivityLog::where('created_by', $user->id)
            ->with(['plannedMetrics.activity', 'createdBy'])
            ->get();

        return [
            'totalActivities' => $totalActivities,
            'activitiesThisMonth' => $activitiesThisMonth,
            'activitiesThisWeek' => $activitiesThisWeek,
            'activitiesByProject' => $activitiesByProject,
            'activitiesByMonth' => $activitiesByMonth,
            'topProjects' => $topProjects,
            'recentActivities' => $recentActivities,
            'activityLogs' => $activityLogs,
            'user' => $user,
        ];
    }
}

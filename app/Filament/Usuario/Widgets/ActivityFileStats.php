<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use App\Models\ActivityFile;
use App\Models\ActivityCalendar;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;

class ActivityFileStats extends BaseWidget
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
                    Stat::make('Documentación', 0)
                        ->description('No hay actividades asignadas')
                        ->descriptionIcon('heroicon-m-document-text')
                        ->color('gray'),

                    Stat::make('Esta Semana', 0)
                        ->description('Sin archivos esta semana')
                        ->descriptionIcon('heroicon-m-calendar-days')
                        ->color('gray'),

                    Stat::make('Hoy', 0)
                        ->description('Sin archivos hoy')
                        ->descriptionIcon('heroicon-m-clock')
                        ->color('gray'),

                    Stat::make('Pendientes', 0)
                        ->description('Sin actividades pendientes')
                        ->descriptionIcon('heroicon-m-exclamation-triangle')
                        ->color('gray'),
                ];
            }

            // Estadísticas de archivos
            $totalFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)->count();
            $thisWeekFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->whereBetween('upload_date', [
                    Carbon::now()->startOfWeek(),
                    Carbon::now()->endOfWeek()
                ])
                ->count();
            $todayFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->whereDate('upload_date', Carbon::today())
                ->count();

            // Actividades con y sin documentación
            $activitiesWithFiles = ActivityCalendar::where('assigned_person', $userId)
                ->whereHas('activityFiles')
                ->count();
            $activitiesWithoutFiles = ActivityCalendar::where('assigned_person', $userId)
                ->whereDoesntHave('activityFiles')
                ->count();

            return [
                Stat::make('Documentación', $totalFiles)
                    ->description('Total de archivos subidos')
                    ->descriptionIcon('heroicon-m-document-text')
                    ->color('primary'),

                Stat::make('Esta Semana', $thisWeekFiles)
                    ->description('Archivos de esta semana')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('warning'),

                Stat::make('Hoy', $todayFiles)
                    ->description('Archivos de hoy')
                    ->descriptionIcon('heroicon-m-clock')
                    ->color('success'),

                Stat::make('Pendientes', $activitiesWithoutFiles)
                    ->description('Actividades sin documentación')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        } catch (\Exception $e) {
            return [
                Stat::make('Documentación', 0)
                    ->description('Error al cargar estadísticas')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        }
    }
}

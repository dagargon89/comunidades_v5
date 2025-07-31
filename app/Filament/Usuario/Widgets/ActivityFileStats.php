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

            // Obtener las actividades calendarizadas del usuario sin filtros
            $activityQuery = ActivityCalendar::where('assigned_person', $userId);

            $userActivityIds = $activityQuery->pluck('id')->toArray();

            // Estadísticas de archivos
            $totalFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)->count();
            $thisMonthFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->whereMonth('upload_date', Carbon::now()->month)
                ->count();
            $thisWeekFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->whereBetween('upload_date', [
                    Carbon::now()->startOfWeek(),
                    Carbon::now()->endOfWeek()
                ])
                ->count();
            $todayFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->whereDate('upload_date', Carbon::today())
                ->count();

            // Estadísticas por tipo de archivo
            $pdfFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->where('type', 'like', '%pdf%')
                ->count();
            $imageFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->where(function ($query) {
                    $query->where('type', 'like', '%imagen%')
                          ->orWhere('type', 'like', '%image%')
                          ->orWhere('type', 'like', '%jpg%')
                          ->orWhere('type', 'like', '%jpeg%')
                          ->orWhere('type', 'like', '%png%');
                })
                ->count();

            return [
                Stat::make('Total de Archivos', $totalFiles)
                    ->description('Todos los archivos subidos')
                    ->descriptionIcon('heroicon-m-document-text')
                    ->color('primary'),

                Stat::make('Archivos del Mes', $thisMonthFiles)
                    ->description('Archivos subidos este mes')
                    ->descriptionIcon('heroicon-m-calendar')
                    ->color('info'),

                Stat::make('Archivos de la Semana', $thisWeekFiles)
                    ->description('Archivos subidos esta semana')
                    ->descriptionIcon('heroicon-m-calendar-days')
                    ->color('warning'),

                Stat::make('Archivos de Hoy', $todayFiles)
                    ->description('Archivos subidos hoy')
                    ->descriptionIcon('heroicon-m-clock')
                    ->color('success'),

                Stat::make('Archivos PDF', $pdfFiles)
                    ->description('Documentos PDF')
                    ->descriptionIcon('heroicon-m-document')
                    ->color('danger'),

                Stat::make('Archivos de Imagen', $imageFiles)
                    ->description('Imágenes subidas')
                    ->descriptionIcon('heroicon-m-photo')
                    ->color('info'),
            ];
        } catch (\Exception $e) {
            return [
                Stat::make('Total de Archivos', 0)
                    ->description('Error al cargar estadísticas')
                    ->descriptionIcon('heroicon-m-exclamation-triangle')
                    ->color('danger'),
            ];
        }
    }
}

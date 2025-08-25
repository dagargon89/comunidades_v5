<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\DB;
use Filament\Widgets\Concerns\InteractsWithPageFilters;

class EventManagementStatsOverview extends BaseWidget
{
    use InteractsWithPageFilters;

    protected static ?string $pollingInterval = null;

    protected function getStats(): array
    {
        // Obtener los filtros aplicados
        $projectName = $this->filters['project_name'] ?? null;
        $activityName = $this->filters['activity_name'] ?? null;
        $eventDate = $this->filters['event_date'] ?? null;

        return [
            Stat::make(
                'Total de Beneficiarios',
                number_format(DB::table('vista_progreso_proyectos')
                    ->when($projectName, fn ($query) => $query->where('Proyecto', $projectName))
                    ->when($activityName, fn ($query) => $query->where('Actividad', $activityName))
                    ->when($eventDate, fn ($query) => $query->where('Evento_fecha_inicio', $eventDate))
                    ->whereNotNull('Beneficiarios_evento')
                    ->where('Beneficiarios_evento', '>', 0)
                    ->sum('Beneficiarios_evento'))
            )
                ->description('Total de beneficiarios registrados según los filtros aplicados')
                ->descriptionIcon('heroicon-o-users')
                ->icon('heroicon-o-user-group')
                ->color('primary')
                ->chart([50, 100, 75, 150, 125, 200, 175])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),
        ];
    }
}

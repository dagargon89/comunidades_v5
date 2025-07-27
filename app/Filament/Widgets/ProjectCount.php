<?php

namespace App\Filament\Widgets;

use App\Models\Project;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class ProjectCount extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Total de Proyectos', Project::count())
                ->description('Todos los proyectos registrados')
                ->descriptionIcon('heroicon-m-folder-open')
                ->color('primary'),

            Stat::make('Proyectos Activos', Project::where('end_date', '>=', now())->count())
                ->description('Proyectos en curso o futuros')
                ->descriptionIcon('heroicon-m-play-circle')
                ->color('success'),

            Stat::make('Proyectos Finalizados', Project::where('end_date', '<', now())->count())
                ->description('Proyectos completados')
                ->descriptionIcon('heroicon-m-check-circle')
                ->color('gray'),

            Stat::make('Proyectos este Mes', Project::whereMonth('created_at', now()->month)->count())
                ->description('Proyectos creados en el mes actual')
                ->descriptionIcon('heroicon-m-calendar')
                ->color('info'),
        ];
    }
}

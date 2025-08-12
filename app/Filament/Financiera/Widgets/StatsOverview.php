<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make(
                'Total de proyectos',
                \DB::table('vista_progreso_proyectos')->distinct('Proyecto_ID')->count('Proyecto_ID')
            )
                ->description('Cantidad total de proyectos registrados')
                ->descriptionIcon('heroicon-o-chart-bar')
                ->icon('heroicon-o-briefcase')
                ->color('success')
                ->chart([5, 10, 15, 20, 25, 30, 35])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),
        ];
    }
}

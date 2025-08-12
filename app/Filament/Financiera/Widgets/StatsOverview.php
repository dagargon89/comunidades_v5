<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\DB;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make(
                'Total de proyectos',
                DB::table('projects')->count()
            )
                ->description('Cantidad total de proyectos registrados')
                ->descriptionIcon('heroicon-o-chart-bar')
                ->icon('heroicon-o-briefcase')
                ->color('success')
                ->chart([5, 10, 15, 20, 25, 30, 35])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Total de financiamiento',
                '$' . number_format(DB::table('projects')->sum('funded_amount'), 0, '.', ',')
            )
                ->description('Monto total financiado de todos los proyectos')
                ->descriptionIcon('heroicon-o-currency-dollar')
                ->icon('heroicon-o-banknotes')
                ->color('warning')
                ->chart([1000000, 2000000, 1500000, 3000000, 2500000, 4000000, 3500000])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Beneficiarios únicos',
                DB::table('beneficiary_registries')
                    ->distinct('beneficiaries_id')
                    ->count('beneficiaries_id')
            )
                ->description('Total de beneficiarios registrados en actividades')
                ->descriptionIcon('heroicon-o-users')
                ->icon('heroicon-o-user-group')
                ->color('info')
                ->chart([50, 100, 75, 150, 125, 200, 175])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),

            Stat::make(
                'Productos únicos',
                DB::table('planned_metrics')
                    ->whereNotNull('product_real_value')
                    ->where('product_real_value', '>', 0)
                    ->sum('product_real_value') ?: 'N/A'
            )
                ->description('Total de productos realizados en actividades')
                ->descriptionIcon('heroicon-o-cube')
                ->icon('heroicon-o-cube-transparent')
                ->color('success')
                ->chart([10, 20, 15, 30, 25, 40, 35])
                ->extraAttributes([
                    'class' => 'cursor-pointer hover:shadow-lg transition-shadow duration-200',
                ]),
        ];
    }
}

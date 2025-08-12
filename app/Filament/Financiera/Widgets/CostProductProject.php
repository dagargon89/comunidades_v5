<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;

class CostProductProject extends ChartWidget
{
    protected static ?string $heading = 'Costo por Producto por Proyecto';

    // protected static ?string $maxHeight = '400px';

    protected function getData(): array
    {
        // Consultar directamente las tablas para obtener datos de proyectos con costo por producto
        $data = DB::table('projects as p')
            ->select([
                'p.name as project_name',
                'p.funded_amount',
                DB::raw('COALESCE(SUM(pm.product_real_value), 0) as products_completed')
            ])
            ->leftJoin('specific_objectives as so', 'p.id', '=', 'so.projects_id')
            ->leftJoin('activities as a', 'so.id', '=', 'a.specific_objective_id')
            ->leftJoin('planned_metrics as pm', 'a.id', '=', 'pm.activity_id')
            ->whereNotNull('p.funded_amount')
            ->where('p.funded_amount', '>', 0)
            ->groupBy('p.id', 'p.name', 'p.funded_amount')
            ->having('products_completed', '>', 0)
            ->get()
            ->map(function ($item) {
                // Calcular costo por producto
                $costPerProduct = $item->products_completed > 0
                    ? $item->funded_amount / $item->products_completed
                    : 0;

                return [
                    'project' => $item->project_name,
                    'cost_per_product' => round($costPerProduct, 2)
                ];
            })
            ->sortByDesc('cost_per_product')
            ->take(10); // Limitar a 10 proyectos para mejor visualización

        return [
            'datasets' => [
                [
                    'label' => 'Costo por Producto ($)',
                    'data' => $data->pluck('cost_per_product')->toArray(),
                    'backgroundColor' => 'rgba(59, 130, 246, 0.8)', // Azul para diferenciar del otro widget
                    'borderColor' => 'rgb(59, 130, 246)',
                    'borderWidth' => 2,
                ],
            ],
            'labels' => $data->pluck('project')->toArray(),
        ];
    }

    protected function getType(): string
    {
        return 'bar';
    }

    protected function getOptions(): array
    {
        return [
            'indexAxis' => 'x',
            'plugins' => [
                'legend' => [
                    'display' => true,
                ],
                'tooltip' => [
                    'enabled' => true,
                    'mode' => 'index',
                    'intersect' => false,
                ],
            ],
            'scales' => [
                'x' => [
                    'title' => [
                        'display' => true,
                        'text' => 'Proyecto'
                    ],
                    'ticks' => [
                        'display' => true,
                        'maxRotation' => 45,
                        'minRotation' => 0
                    ],
                    'grid' => [
                        'display' => true
                    ]
                ],
                'y' => [
                    'title' => [
                        'display' => true,
                        'text' => 'Costo por Producto ($)'
                    ],
                    'ticks' => [
                        'display' => true,
                        'callback' => 'function(value) { return "$" + value.toLocaleString(); }',
                        'stepSize' => 1000
                    ],
                    'grid' => [
                        'display' => true
                    ],
                    'beginAtZero' => true
                ]
            ],
            'responsive' => true,
            'maintainAspectRatio' => true,
        ];
    }

    public function getDescription(): ?string
    {
        return 'Muestra el costo promedio por producto para cada proyecto, calculado dividiendo el monto financiado entre el número de productos realizados.';
    }
}

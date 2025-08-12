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
        // Consultar la vista para obtener datos de proyectos con costo por producto
        $data = DB::table('vista_progreso_proyectos')
            ->select([
                'Proyecto',
                'Proyecto_cantidad_financiada',
                'Productos_realizados'
            ])
            ->whereNotNull('Proyecto_cantidad_financiada')
            ->where('Productos_realizados', '>', 0)
            ->get()
            ->map(function ($item) {
                // Calcular costo por producto
                $costPerProduct = $item->Productos_realizados > 0
                    ? $item->Proyecto_cantidad_financiada / $item->Productos_realizados
                    : 0;

                return [
                    'project' => $item->Proyecto,
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
                    ]
                ],
                'y' => [
                    'title' => [
                        'display' => true,
                        'text' => 'Costo por Producto ($)'
                    ],
                    'ticks' => [
                        'callback' => 'function(value) { return "$" + value.toLocaleString(); }'
                    ]
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

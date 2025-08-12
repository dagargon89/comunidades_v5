<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;

class CostBeneficiaryProject extends ChartWidget
{
    protected static ?string $heading = 'Costo por Beneficiario por Proyecto';

   // protected static ?string $maxHeight = '400px';

    protected function getData(): array
    {
        // Consultar la vista para obtener datos de proyectos con costo por beneficiario
        $data = DB::table('vista_progreso_proyectos')
            ->select([
                'Proyecto',
                'Proyecto_cantidad_financiada',
                'Beneficiarios_registrados'
            ])
            ->whereNotNull('Proyecto_cantidad_financiada')
            ->where('Beneficiarios_registrados', '>', 0)
            ->get()
            ->map(function ($item) {
                // Calcular costo por beneficiario
                $costPerBeneficiary = $item->Beneficiarios_registrados > 0
                    ? $item->Proyecto_cantidad_financiada / $item->Beneficiarios_registrados
                    : 0;

                return [
                    'project' => $item->Proyecto,
                    'cost_per_beneficiary' => round($costPerBeneficiary, 2)
                ];
            })
            ->sortByDesc('cost_per_beneficiary')
            ->take(10); // Limitar a 10 proyectos para mejor visualización

        return [
            'datasets' => [
                [
                    'label' => 'Costo por Beneficiario ($)',
                    'data' => $data->pluck('cost_per_beneficiary')->toArray(),
                    'backgroundColor' => 'rgba(92, 168, 133, 0.8)',
                    'borderColor' => 'rgb(92, 168, 133)',
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
            'indexAxis' => 'x', // Hacer la gráfica vertical
            'plugins' => [
                'legend' => [
                    'display' => true, // Ocultar leyenda
                ],
                'tooltip' => [
                    'callbacks' => [
                        'label' => 'function(context) { return "$" + context.parsed.x.toLocaleString(); }'
                    ]
                ],
            ],
            'scales' => [
                'x' => [
                    'title' => [
                        'display' => true,
                        'text' => 'Costo por Beneficiario ($)'
                    ],
                    'ticks' => [
                        'callback' => 'function(value) { return "$" + value.toLocaleString(); }'
                    ]
                ],
                'y' => [
                    'title' => [
                        'display' => true,
                        'text' => 'Proyecto'
                    ]
                ]
            ],
            'responsive' => true,
            'maintainAspectRatio' => true,
        ];
    }

    public function getDescription(): ?string
    {
        return 'Muestra el costo promedio por beneficiario para cada proyecto, calculado dividiendo el monto financiado entre el número de beneficiarios registrados.';
    }
}

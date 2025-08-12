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
        // Consultar directamente las tablas para obtener datos de proyectos con costo por beneficiario
        $data = DB::table('projects as p')
            ->select([
                'p.name as project_name',
                'p.funded_amount',
                DB::raw('COUNT(DISTINCT br.beneficiaries_id) as beneficiaries_count')
            ])
            ->leftJoin('specific_objectives as so', 'p.id', '=', 'so.projects_id')
            ->leftJoin('activities as a', 'so.id', '=', 'a.specific_objective_id')
            ->leftJoin('activity_calendars as ac', 'a.id', '=', 'ac.activity_id')
            ->leftJoin('beneficiary_registries as br', 'ac.id', '=', 'br.activity_calendar_id')
            ->whereNotNull('p.funded_amount')
            ->where('p.funded_amount', '>', 0)
            ->groupBy('p.id', 'p.name', 'p.funded_amount')
            ->having('beneficiaries_count', '>', 0)
            ->get()
            ->map(function ($item) {
                // Calcular costo por beneficiario
                $costPerBeneficiary = $item->beneficiaries_count > 0
                    ? $item->funded_amount / $item->beneficiaries_count
                    : 0;

                return [
                    'project' => $item->project_name,
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
                        'text' => 'Costo por Beneficiario ($)'
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
        return 'Muestra el costo promedio por beneficiario para cada proyecto, calculado dividiendo el monto financiado entre el número de beneficiarios registrados.';
    }
}

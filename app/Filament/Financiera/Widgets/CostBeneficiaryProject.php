<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;
use Filament\Widgets\Concerns\InteractsWithPageFilters;

class CostBeneficiaryProject extends ChartWidget
{
    use InteractsWithPageFilters;

    protected static ?string $pollingInterval = null;

    protected static ?string $heading = 'Costo por Beneficiario por Proyecto';

   // protected static ?string $maxHeight = '400px';

        protected function getData(): array
    {
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $financierId = $this->filters['financier_id'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;
        $activityYear = $this->filters['activity_year'] ?? null;
        $activityMonth = $this->filters['activity_month'] ?? null;
        $eventStatus = $this->filters['event_status'] ?? null;

        // Utilizar la vista vista_progreso_proyectos para obtener datos consolidados
        $data = DB::table('vista_progreso_proyectos as vpp')
            ->select([
                'vpp.Proyecto as project_name',
                'vpp.Proyecto_cantidad_financiada as funded_amount',
                DB::raw('SUM(vpp.Beneficiarios_evento) as total_beneficiaries')
            ])
            ->when($startDate, fn ($query) => $query->whereDate('vpp.Evento_fecha_inicio', '>=', $startDate))
            ->when($endDate, fn ($query) => $query->whereDate('vpp.Evento_fecha_fin', '<=', $endDate))
            ->when($financierId, fn ($query) => $query->where('vpp.Financiadora_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('vpp.Proyecto_ID', $projectId))
            ->when($activityYear, fn ($query) => $query->where('vpp.year_actividad', $activityYear))
            ->when($activityMonth, fn ($query) => $query->where('vpp.mes_actividad', $activityMonth))
            ->when($eventStatus, fn ($query) => $query->where('vpp.Evento_estado', $eventStatus))
            ->whereNotNull('vpp.Proyecto_cantidad_financiada')
            ->where('vpp.Proyecto_cantidad_financiada', '>', 0)
            ->groupBy('vpp.Proyecto_ID', 'vpp.Proyecto', 'vpp.Proyecto_cantidad_financiada')
            ->having('total_beneficiaries', '>', 0)
            ->get()
            ->map(function ($item) {
                // Calcular costo por beneficiario
                $costPerBeneficiary = $item->total_beneficiaries > 0
                    ? $item->funded_amount / $item->total_beneficiaries
                    : 0;

                return [
                    'project' => strlen($item->project_name) > 30
                        ? substr($item->project_name, 0, 27) . '...'
                        : $item->project_name,
                    'cost_per_beneficiary' => round($costPerBeneficiary, 2)
                ];
            })
            ->sortByDesc('cost_per_beneficiary')
            ->take($projectId ? 10 : 8); // Menos proyectos si no hay filtro específico

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
                        'minRotation' => 45,
                        'font' => [
                            'size' => 10
                        ]
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

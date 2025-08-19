<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;
use Filament\Widgets\Concerns\InteractsWithPageFilters;

class PopulationProgressProject extends ChartWidget
{
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Progreso de Población por Proyecto';

    protected function getData(): array
    {
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $financierId = $this->filters['financier_id'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;
        $activityYear = $this->filters['activity_year'] ?? null;
        $activityMonth = $this->filters['activity_month'] ?? null;
        $eventStatus = $this->filters['event_status'] ?? null;

        // Utilizar la vista vista_progreso_proyectos según la documentación
        $data = DB::table('vista_progreso_proyectos as vpp')
            ->select([
                'vpp.Proyecto as project_name',
                DB::raw('AVG(vpp.population_progress_percent) as avg_population_progress')
            ])
            ->when($startDate, fn ($query) => $query->whereDate('vpp.Evento_fecha_inicio', '>=', $startDate))
            ->when($endDate, fn ($query) => $query->whereDate('vpp.Evento_fecha_fin', '<=', $endDate))
            ->when($financierId, fn ($query) => $query->where('vpp.Financiadora_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('vpp.Proyecto_ID', $projectId))
            ->when($activityYear, fn ($query) => $query->where('vpp.year_actividad', $activityYear))
            ->when($activityMonth, fn ($query) => $query->where('vpp.mes_actividad', $activityMonth))
            ->when($eventStatus, fn ($query) => $query->where('vpp.Evento_estado', $eventStatus))
            ->whereNotNull('vpp.population_progress_percent')
            ->groupBy('vpp.Proyecto_ID', 'vpp.Proyecto')
            ->having('avg_population_progress', '>', 0)
            ->get()
            ->map(function ($item) {
                return [
                    'project' => strlen($item->project_name) > 30
                        ? substr($item->project_name, 0, 27) . '...'
                        : $item->project_name,
                    'progress' => round($item->avg_population_progress, 2)
                ];
            })
            ->sortByDesc('progress')
            ->take($projectId ? 10 : 8); // Menos proyectos si no hay filtro específico

        return [
            'datasets' => [
                [
                    'label' => 'Progreso de Población (%)',
                    'data' => $data->pluck('progress')->toArray(),
                    'backgroundColor' => 'rgba(34, 197, 94, 0.8)', // Verde para progreso
                    'borderColor' => 'rgb(34, 197, 94)',
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
                        'text' => 'Progreso de Población (%)'
                    ],
                    'ticks' => [
                        'display' => true,
                        'min' => 0,
                        'max' => 100,
                        'stepSize' => 10
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
        return 'Muestra el progreso promedio de población para cada proyecto, calculado como porcentaje de población alcanzada versus meta.';
    }
}

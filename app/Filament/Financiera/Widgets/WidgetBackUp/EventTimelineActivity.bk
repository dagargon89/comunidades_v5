<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\ChartWidget;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EventTimelineActivity extends ChartWidget
{
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Event Timeline by Activity';
    protected static ?string $maxHeight = '500px';
    protected static ?int $sort = 4;
    protected int | string | array $columnSpan = 'full';
    protected static ?string $pollingInterval = null;

    protected function getData(): array
    {
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $financierId = $this->filters['financier_id'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;
        $activityYear = $this->filters['activity_year'] ?? null;
        $activityMonth = $this->filters['activity_month'] ?? null;
        $eventStatus = $this->filters['event_status'] ?? null;

        // Consulta basada en la documentación: Event Timeline by Activity usando vista_progreso_proyectos
        // Columnas utilizadas: Evento_Fecha_Inicio, Actividad, Proyecto
        $events = DB::table('vista_progreso_proyectos')
            ->select([
                'Evento_Fecha_Inicio',
                'Actividad',
                'Proyecto'
            ])
            ->when($startDate, fn ($query) => $query->whereDate('Evento_fecha_inicio', '>=', $startDate))
            ->when($endDate, fn ($query) => $query->whereDate('Evento_fecha_fin', '<=', $endDate))
            ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
            ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
            ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
            ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus))
            ->whereNotNull('Evento_Fecha_Inicio')
            ->whereNotNull('Actividad')
            ->orderBy('Evento_Fecha_Inicio')
            ->get();

        if ($events->isEmpty()) {
            return [
                'datasets' => [],
                'labels' => []
            ];
        }

        // Agrupar eventos por actividad y truncar nombres a 15 caracteres
        $activitiesByName = $events->groupBy(function($event) {
            return mb_substr($event->Actividad, 0, 15) . (mb_strlen($event->Actividad) > 15 ? '...' : '');
        });
        $datasets = [];
        $colors = [
            'rgb(34, 197, 94)',   // green-500
            'rgb(59, 130, 246)',  // blue-500
            'rgb(239, 68, 68)',   // red-500
            'rgb(245, 158, 11)',  // amber-500
            'rgb(168, 85, 247)',  // purple-500
            'rgb(236, 72, 153)',  // pink-500
            'rgb(20, 184, 166)',  // teal-500
            'rgb(251, 146, 60)',  // orange-500
        ];

        $activityIndex = 0;
        foreach ($activitiesByName as $activityName => $activityEvents) {
            $dataPoints = [];

            foreach ($activityEvents as $event) {
                $date = Carbon::parse($event->Evento_Fecha_Inicio);
                $dataPoints[] = [
                    'x' => $date->format('Y-m-d'),
                    'y' => $activityIndex
                ];
            }

            $color = $colors[$activityIndex % count($colors)];

            $datasets[] = [
                'label' => $activityName,
                'data' => $dataPoints,
                'backgroundColor' => $color,
                'borderColor' => $color,
                'pointRadius' => 6,
                'pointHoverRadius' => 8,
                'showLine' => false,
            ];

            $activityIndex++;
        }

        return [
            'datasets' => $datasets,
                            'options' => [
                'scales' => [
                    'x' => [
                        'type' => 'time',
                        'time' => [
                            'unit' => 'month',
                            'displayFormats' => [
                                'month' => 'MMM YYYY'
                            ]
                        ],
                        'title' => [
                            'display' => true,
                            'text' => 'Fecha de Inicio del Evento'
                        ],
                        'ticks' => [
                            'maxRotation' => 45,
                            'minRotation' => 45,
                            'maxTicksLimit' => 12,
                            'autoSkip' => true,
                            'autoSkipPadding' => 10,
                            'font' => [
                                'size' => 11
                            ]
                        ],
                        'grid' => [
                            'display' => true,
                            'color' => 'rgba(0,0,0,0.1)'
                        ]
                    ],
                    'y' => [
                        'type' => 'linear',
                        'position' => 'left',
                        'title' => [
                            'display' => true,
                            'text' => 'Activity'
                        ],
                        'min' => -0.5,
                        'max' => count($activitiesByName) - 0.5,
                        'ticks' => [
                            'stepSize' => 1,
                            'callback' => new \Filament\Support\RawJs('function(value) {
                                const activities = ' . json_encode(array_values($activitiesByName->keys()->toArray())) . ';
                                return activities[Math.round(value)] || "";
                            }')
                        ]
                    ]
                ],
                'plugins' => [
                    'legend' => [
                        'display' => true,
                        'position' => 'right'
                    ],
                    'tooltip' => [
                        'callbacks' => [
                            'title' => 'function(context) {
                                return context[0].dataset.label;
                            }',
                            'label' => 'function(context) {
                                return "Fecha del evento: " + context.parsed.x;
                            }'
                        ]
                    ]
                ],
                'responsive' => true,
                'maintainAspectRatio' => false,
                'layout' => [
                    'padding' => [
                        'left' => 10,
                        'right' => 10,
                        'top' => 10,
                        'bottom' => 50
                    ]
                ],
                'elements' => [
                    'point' => [
                        'radius' => 6,
                        'hoverRadius' => 8,
                        'borderWidth' => 2
                    ]
                ]
            ]
        ];
    }

    protected function getType(): string
    {
        return 'scatter';
    }

    protected function getOptions(): array
    {
        return [
            'scales' => [
                'x' => [
                    'type' => 'time',
                    'time' => [
                        'unit' => 'month'
                    ]
                ]
            ]
        ];
    }
}

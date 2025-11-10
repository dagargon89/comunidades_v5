<?php

namespace App\Filament\Widgets;

use App\Models\ActivityNarrative;
use Filament\Widgets\ChartWidget;
use Illuminate\Support\Facades\DB;

class NarrativasPorMesChart extends ChartWidget
{
    protected static ?string $heading = 'Narrativas Generadas por Mes';

    protected static ?string $pollingInterval = '1m';

    protected static ?int $sort = 2;

    protected function getData(): array
    {
        // Obtener últimos 12 meses de datos
        $datos = ActivityNarrative::selectRaw('
                YEAR(created_at) as year,
                MONTH(created_at) as month,
                COUNT(*) as total,
                SUM(CASE WHEN narrativa_generada IS NOT NULL THEN 1 ELSE 0 END) as generadas,
                SUM(CASE WHEN narrativa_aprobada = 1 THEN 1 ELSE 0 END) as aprobadas
            ')
            ->where('created_at', '>=', now()->subMonths(12))
            ->groupBy(DB::raw('YEAR(created_at), MONTH(created_at)'))
            ->orderBy(DB::raw('YEAR(created_at)'))
            ->orderBy(DB::raw('MONTH(created_at)'))
            ->get();

        // Preparar labels (nombres de meses)
        $labels = [];
        $totales = [];
        $generadas = [];
        $aprobadas = [];

        foreach ($datos as $dato) {
            $fecha = \Carbon\Carbon::create($dato->year, $dato->month, 1);
            $labels[] = $fecha->locale('es')->format('M Y');
            $totales[] = $dato->total;
            $generadas[] = $dato->generadas;
            $aprobadas[] = $dato->aprobadas;
        }

        return [
            'datasets' => [
                [
                    'label' => 'Total de Narrativas',
                    'data' => $totales,
                    'backgroundColor' => 'rgba(59, 130, 246, 0.1)',
                    'borderColor' => 'rgb(59, 130, 246)',
                    'borderWidth' => 2,
                    'tension' => 0.3,
                    'fill' => true,
                ],
                [
                    'label' => 'Narrativas Generadas',
                    'data' => $generadas,
                    'backgroundColor' => 'rgba(34, 197, 94, 0.1)',
                    'borderColor' => 'rgb(34, 197, 94)',
                    'borderWidth' => 2,
                    'tension' => 0.3,
                    'fill' => true,
                ],
                [
                    'label' => 'Narrativas Aprobadas',
                    'data' => $aprobadas,
                    'backgroundColor' => 'rgba(234, 179, 8, 0.1)',
                    'borderColor' => 'rgb(234, 179, 8)',
                    'borderWidth' => 2,
                    'tension' => 0.3,
                    'fill' => true,
                ],
            ],
            'labels' => $labels,
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }

    protected function getOptions(): array
    {
        return [
            'plugins' => [
                'legend' => [
                    'display' => true,
                    'position' => 'bottom',
                ],
            ],
            'scales' => [
                'y' => [
                    'beginAtZero' => true,
                    'ticks' => [
                        'precision' => 0,
                    ],
                ],
            ],
        ];
    }
}

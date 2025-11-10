<?php

namespace App\Filament\Widgets;

use App\Models\ActivityNarrative;
use App\Models\ActivityCalendar;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\DB;

class NarrativasStatsWidget extends BaseWidget
{
    protected static ?string $pollingInterval = '30s';

    protected function getStats(): array
    {
        $totalNarrativas = ActivityNarrative::count();
        $totalGeneradas = ActivityNarrative::whereNotNull('narrativa_generada')->count();
        $totalAprobadas = ActivityNarrative::where('narrativa_aprobada', true)->count();
        $totalEventos = ActivityCalendar::count();

        // Calcular porcentaje de cobertura
        $porcentajeCobertura = $totalEventos > 0
            ? round(($totalNarrativas / $totalEventos) * 100, 1)
            : 0;

        // Calcular tasa de aprobación
        $tasaAprobacion = $totalGeneradas > 0
            ? round(($totalAprobadas / $totalGeneradas) * 100, 1)
            : 0;

        // Narrativas del mes actual vs mes anterior
        $narrativasEsteMes = ActivityNarrative::whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)
            ->count();

        $narrativasMesAnterior = ActivityNarrative::whereMonth('created_at', now()->subMonth()->month)
            ->whereYear('created_at', now()->subMonth()->year)
            ->count();

        $crecimientoMensual = $narrativasMesAnterior > 0
            ? round((($narrativasEsteMes - $narrativasMesAnterior) / $narrativasMesAnterior) * 100, 1)
            : 0;

        // Promedio de participantes
        $promedioParticipantes = ActivityNarrative::whereNotNull('participantes_count')
            ->avg('participantes_count');
        $promedioParticipantes = $promedioParticipantes ? round($promedioParticipantes, 0) : 0;

        // Datos para el mini chart (últimos 7 meses)
        $chartData = ActivityNarrative::selectRaw('COUNT(*) as count')
            ->whereNotNull('narrativa_generada')
            ->where('created_at', '>=', now()->subMonths(7))
            ->groupBy(DB::raw('YEAR(created_at), MONTH(created_at)'))
            ->orderBy(DB::raw('YEAR(created_at)'))
            ->orderBy(DB::raw('MONTH(created_at)'))
            ->pluck('count')
            ->toArray();

        return [
            Stat::make('Total de Narrativas', $totalNarrativas)
                ->description("{$porcentajeCobertura}% de eventos con narrativa")
                ->descriptionIcon('heroicon-m-document-text')
                ->color('primary')
                ->chart($chartData),

            Stat::make('Narrativas Generadas', $totalGeneradas)
                ->description('Con texto generado por IA')
                ->descriptionIcon('heroicon-m-sparkles')
                ->color('success')
                ->chart(array_slice($chartData, -5)),

            Stat::make('Narrativas Aprobadas', $totalAprobadas)
                ->description("{$tasaAprobacion}% de tasa de aprobación")
                ->descriptionIcon('heroicon-m-check-badge')
                ->color('info'),

            Stat::make('Narrativas este Mes', $narrativasEsteMes)
                ->description($crecimientoMensual >= 0 ? "+{$crecimientoMensual}% vs mes anterior" : "{$crecimientoMensual}% vs mes anterior")
                ->descriptionIcon($crecimientoMensual >= 0 ? 'heroicon-m-arrow-trending-up' : 'heroicon-m-arrow-trending-down')
                ->color($crecimientoMensual >= 0 ? 'success' : 'warning'),

            Stat::make('Promedio de Participantes', number_format($promedioParticipantes, 0))
                ->description('Por evento narrativo')
                ->descriptionIcon('heroicon-m-user-group')
                ->color('warning'),

            Stat::make('Pendientes de Generar', $totalEventos - $totalNarrativas)
                ->description('Eventos sin narrativa')
                ->descriptionIcon('heroicon-m-exclamation-triangle')
                ->color($totalEventos - $totalNarrativas > 0 ? 'danger' : 'success'),
        ];
    }
}

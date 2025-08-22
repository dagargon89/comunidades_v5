<?php

namespace App\Filament\Usuario\Pages;

use Filament\Pages\Dashboard as BaseDashboard;

class Dashboard extends BaseDashboard
{
    protected static ?string $title = 'Dashboard de Seguimiento';
    protected static ?string $navigationLabel = 'Dashboard';

    protected function getHeaderWidgets(): array
    {
        return [
            // ========================================
            // WIDGETS DE RESUMEN GENERAL (HEADER)
            // ========================================

        ];
    }

    protected function getContentWidgets(): array
    {
        return [
            // ========================================
            // WIDGETS DE CONTENIDO PRINCIPAL
            // ========================================

            // SECCIÓN 1: SEGUIMIENTO DE ACTIVIDADES
           // \App\Filament\Usuario\Widgets\UpcomingActivitiesWidget::class,      // Próximas actividades (hoy, mañana, semana)


        ];
    }

    protected function getFooterWidgets(): array
    {
        return [
            // ========================================
            // WIDGETS DE PIE DE PÁGINA
            // ========================================

            // SECCIÓN 5: ALERTAS Y NOTIFICACIONES
            // \App\Filament\Usuario\Widgets\AlertsWidget::class,                 // Alertas de actividades vencidas, documentación pendiente
            // \App\Filament\Usuario\Widgets\NotificationsWidget::class,          // Notificaciones importantes

            // SECCIÓN 6: MÉTRICAS DE RENDIMIENTO
            // \App\Filament\Usuario\Widgets\PerformanceMetricsWidget::class,     // Métricas de rendimiento y estadísticas
            // \App\Filament\Usuario\Widgets\ActivityTrendsWidget::class,         // Tendencias de actividades completadas
        ];
    }

    public function getTitle(): string
    {
        return 'Dashboard de Seguimiento';
    }

    public function getSubheading(): string
    {
        return 'Panel de control para seguimiento de actividades, documentación y beneficiarios';
    }
}

<?php

namespace App\Filament\Usuario\Pages;

use Filament\Pages\Dashboard as BaseDashboard;

class Dashboard extends BaseDashboard
{
    protected function getHeaderWidgets(): array
    {
        return [
            // ========================================
            // WIDGETS DE RESUMEN GENERAL (HEADER)
            // ========================================
            // Solo los widgets más importantes para el resumen general
            \App\Filament\Usuario\Widgets\ActivityCalendarCount::class,        // Resumen de actividades (total, activas, canceladas, etc.)
            \App\Filament\Usuario\Widgets\ActivityFileStats::class,            // Estado de documentación y archivos
            \App\Filament\Usuario\Widgets\BeneficiaryStats::class,             // Resumen de beneficiarios registrados
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
            // \App\Filament\Usuario\Widgets\ProjectProgressWidget::class,         // Progreso por proyecto con barras de avance

            // SECCIÓN 2: GESTIÓN DE DOCUMENTACIÓN
            // \App\Filament\Usuario\Widgets\RecentFilesWidget::class,            // Archivos subidos recientemente
            // \App\Filament\Usuario\Widgets\PendingDocumentationWidget::class,   // Actividades pendientes de documentación

            // SECCIÓN 3: REGISTROS DE BENEFICIARIOS
            // \App\Filament\Usuario\Widgets\RecentRegistriesWidget::class,       // Últimos beneficiarios registrados
            // \App\Filament\Usuario\Widgets\PendingRegistriesWidget::class,      // Actividades pendientes de registro

            // SECCIÓN 4: ACCIONES RÁPIDAS
            // \App\Filament\Usuario\Widgets\QuickActionsWidget::class,           // Botones de acceso rápido a funciones principales
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

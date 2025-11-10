<?php

namespace App\Filament\Pages;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;
use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Pages\Dashboard\Actions\FilterAction;
use Filament\Pages\Dashboard\Concerns\HasFiltersAction;

class Dashboard extends BaseDashboard
{
    use HasFiltersAction;

    protected static ?string $title = 'Dashboard de Administración';
    protected static ?string $navigationLabel = 'Dashboard';

    protected function getHeaderActions(): array
    {
        return [
            FilterAction::make()
                ->form([
                    Section::make('Filtros de Fecha')
                        ->description('Filtrar datos por rango de fechas')
                        ->schema([
                            DatePicker::make('startDate')
                                ->label('Fecha de Inicio')
                                ->placeholder('Seleccionar fecha de inicio'),
                            DatePicker::make('endDate')
                                ->label('Fecha de Fin')
                                ->placeholder('Seleccionar fecha de fin'),
                        ])
                        ->columns(2),
                ])
                ->label('Filtrar Datos')
                ->icon('heroicon-m-funnel'),
        ];
    }

    public function getWidgets(): array
    {
        return [
            \App\Filament\Widgets\DashboardStats::class,
            \App\Filament\Widgets\RecentProjects::class,
            \App\Filament\Widgets\ActivityOverview::class,
            // Widgets de Narrativas
            \App\Filament\Widgets\NarrativasStatsWidget::class,
            \App\Filament\Widgets\NarrativasPorMesChart::class,
            \App\Filament\Widgets\NarrativasRecientesWidget::class,
        ];
    }

    public function getColumns(): int | string | array
    {
        return [
            'md' => 4,
            'xl' => 6,
        ];
    }

    public function persistsFiltersInSession(): bool
    {
        return true;
    }
}

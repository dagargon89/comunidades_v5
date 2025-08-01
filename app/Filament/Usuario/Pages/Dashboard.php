<?php

namespace App\Filament\Usuario\Pages;

use Filament\Pages\Dashboard as BaseDashboard;

class Dashboard extends BaseDashboard
{
    protected function getHeaderWidgets(): array
    {
        return [
            // \App\Filament\Usuario\Widgets\ActivityCalendarCount::class,
            // \App\Filament\Usuario\Widgets\ActivityFileStats::class,
            // \App\Filament\Usuario\Widgets\BeneficiaryStats::class,
        ];
    }

    protected function getFooterWidgets(): array
    {
        return [
            // \App\Filament\Usuario\Widgets\ProjectActivitySummary::class,
            // \App\Filament\Usuario\Widgets\ActivityCalendarTable::class,
            // \App\Filament\Usuario\Widgets\ActivityFileTable::class,
            // \App\Filament\Usuario\Widgets\BeneficiaryRegistryTable::class,
        ];
    }

    public function getTitle(): string
    {
        return 'Dashboard de Seguimiento';
    }
}

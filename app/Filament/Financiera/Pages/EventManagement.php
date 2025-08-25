<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;

class EventManagement extends BaseDashboard
{
    protected static string $routePath = 'gestion-eventos';

    protected static ?string $navigationIcon = 'heroicon-o-calendar';

    protected static ?string $title = 'Gestión de Eventos';

    protected static ?string $navigationLabel = 'Gestión de Eventos';

    protected static ?int $navigationSort = 4;

    public function getWidgets(): array
    {
        return [

        ];
    }

    public function getColumns(): int | string | array
    {
        return 2;
    }
}

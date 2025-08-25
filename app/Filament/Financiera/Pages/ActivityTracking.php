<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;

class ActivityTracking extends BaseDashboard
{
    protected static string $routePath = 'seguimiento-actividades';

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';

    protected static ?string $title = 'Seguimiento de Actividades';

    protected static ?string $navigationLabel = 'Seguimiento de Actividades';

    protected static ?int $navigationSort = 3;

}

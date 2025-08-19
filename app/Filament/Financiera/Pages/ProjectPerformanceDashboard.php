<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;

class ProjectPerformanceDashboard extends Dashboard
{

    protected static string $routePath = 'rendimiento-proyectos';

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';

    protected static ?string $title = 'Dashboard de Rendimiento de Proyectos';

    protected static ?string $navigationLabel = 'Rendimiento de Proyectos';

    protected static ?int $navigationSort = 2;

}

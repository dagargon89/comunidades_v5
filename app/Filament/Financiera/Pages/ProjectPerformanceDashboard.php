<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Page;
use Illuminate\Support\Facades\DB;

class ProjectPerformanceDashboard extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';

    protected static string $view = 'filament.financiera.pages.project-performance-dashboard';

    protected static ?string $title = 'Dashboard de Rendimiento de Proyectos';

    protected static ?string $navigationLabel = 'Rendimiento de Proyectos';

    protected static ?int $navigationSort = 2;

}

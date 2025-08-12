<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\ChartWidget;

class CostProductProject extends ChartWidget
{
    protected static ?string $heading = 'Chart';

    protected function getData(): array
    {
        return [
            //
        ];
    }

    protected function getType(): string
    {
        return 'bar';
    }
}

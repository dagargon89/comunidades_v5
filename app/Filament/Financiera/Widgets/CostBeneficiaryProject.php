<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\ChartWidget;

class CostBeneficiaryProject extends ChartWidget
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

<?php

namespace App\Filament\Financiera\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;

class Dashboard extends BaseDashboard
{
    use HasFiltersForm;

    public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Section::make()
                    ->schema([
                        DatePicker::make('startDate')
                            ->label('Fecha de inicio')
                            ->placeholder('Filtrar desde esta fecha'),
                        DatePicker::make('endDate')
                            ->label('Fecha de fin')
                            ->placeholder('Filtrar hasta esta fecha'),
                    ])
                    ->columns(2)
                    ->description('Filtra proyectos por fecha de inicio/fin y actividades por fecha de eventos'),
            ]);
    }
}

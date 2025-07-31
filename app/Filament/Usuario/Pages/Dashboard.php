<?php

namespace App\Filament\Usuario\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Forms\Form;
use App\Models\Project;

class Dashboard extends BaseDashboard
{
    use HasFiltersForm;

    protected function getHeaderWidgets(): array
    {
        return [
            \App\Filament\Usuario\Widgets\ActivityCalendarCount::class,
            \App\Filament\Usuario\Widgets\ActivityFileStats::class,
            \App\Filament\Usuario\Widgets\BeneficiaryStats::class,
        ];
    }

    protected function getFooterWidgets(): array
    {
        return [
            \App\Filament\Usuario\Widgets\ProjectActivitySummary::class,
            \App\Filament\Usuario\Widgets\ActivityCalendarTable::class,
            \App\Filament\Usuario\Widgets\ActivityFileTable::class,
            \App\Filament\Usuario\Widgets\BeneficiaryRegistryTable::class,
        ];
    }

    public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Select::make('project_id')
                    ->label('Proyecto')
                    ->placeholder('Seleccionar proyecto')
                    ->options(Project::pluck('name', 'id')->toArray())
                    ->searchable()
                    ->allowHtml(),
                DatePicker::make('startDate')
                    ->label('Fecha de inicio')
                    ->placeholder('Seleccionar fecha de inicio'),
                DatePicker::make('endDate')
                    ->label('Fecha de fin')
                    ->placeholder('Seleccionar fecha de fin'),
            ])
            ->columns(3);
    }

    public function getTitle(): string
    {
        return 'Dashboard de Seguimiento';
    }
}

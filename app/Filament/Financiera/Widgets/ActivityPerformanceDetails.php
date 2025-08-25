<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use App\Models\Activity;
use Illuminate\Support\Facades\DB;

class ActivityPerformanceDetails extends BaseWidget
{
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Detalles de Rendimiento de Actividades';

    protected static ?string $pollingInterval = null;

    protected int | string | array $columnSpan = 'full';

    protected static ?int $sort = 5;

    public function table(Table $table): Table
    {
        // Query usando el modelo Activity con sus relaciones
        $query = Activity::query()
            ->with([
                'goal.project',
                'specificObjective.project',
                'activityCalendars',
                'beneficiaryRegistries'
            ])
            ->withCount(['activityCalendars', 'beneficiaryRegistries']);

        return $table
            ->query($query)
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('ACTIVIDAD')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->grow()
                    ->tooltip(fn ($record) => $record->name)
                    ->limit(50),

                Tables\Columns\TextColumn::make('goal.project.name')
                    ->label('PROYECTO (VÍA GOAL)')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->width('200px')
                    ->tooltip(fn ($record) => $record->goal?->project?->name ?? 'N/A')
                    ->limit(30)
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('specificObjective.project.name')
                    ->label('PROYECTO (VÍA OBJ)')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->width('200px')
                    ->tooltip(fn ($record) => $record->specificObjective?->project?->name ?? 'N/A')
                    ->limit(30)
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('activity_calendars_count')
                    ->label('EVENTOS CALENDARIZADOS')
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->color('info')
                    ->formatStateUsing(fn ($state) => number_format($state)),

                Tables\Columns\TextColumn::make('beneficiary_registries_count')
                    ->label('BENEFICIARIOS')
                    ->sortable()
                    ->alignCenter()
                    ->width('120px')
                    ->color('primary')
                    ->formatStateUsing(fn ($state) => number_format($state)),

                Tables\Columns\TextColumn::make('description')
                    ->label('DESCRIPCIÓN')
                    ->searchable()
                    ->wrap()
                    ->limit(100)
                    ->placeholder('Sin descripción'),
            ])
            ->defaultSort('name', 'asc')
            ->striped()
            ->paginated([10, 25, 50])
            ->emptyStateHeading('No hay datos de actividades')
            ->emptyStateDescription('No se encontraron actividades con los filtros aplicados.')
            ->emptyStateIcon('heroicon-o-chart-bar');
    }
}

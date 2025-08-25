<?php

namespace App\Filament\Financiera\Widgets;

use App\Models\PadronBeneficiario;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Widgets\Concerns\InteractsWithPageFilters;

class BeneficiariesTable extends BaseWidget
{
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Tabla de Beneficiarios';

    protected static ?string $pollingInterval = null;

    protected int | string | array $columnSpan = 'full';

    public function table(Table $table): Table
    {
        // Obtener los filtros aplicados
        $projectName = $this->filters['project_name'] ?? null;
        $activityName = $this->filters['activity_name'] ?? null;
        $eventDate = $this->filters['event_date'] ?? null;

        // Query usando el modelo Eloquent con filtros aplicados
        $query = PadronBeneficiario::query()
            ->when($projectName, fn ($query) => $query->where('nombre_proyecto', $projectName))
            ->when($activityName, fn ($query) => $query->where('nombre_actividad', $activityName))
            ->when($eventDate, fn ($query) => $query->where('Evento_Fecha_Inicio', $eventDate))
            ->orderBy('nombre_proyecto')
            ->orderBy('nombre_actividad')
            ->orderBy('Evento_Fecha_Inicio');

        return $table
            ->query($query)
            ->columns([
                Tables\Columns\TextColumn::make('nombre_proyecto')
                    ->label('PROYECTO')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->width('200px')
                    ->tooltip(fn ($record) => $record->nombre_proyecto ?? 'N/A')
                    ->limit(30)
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('nombre_actividad')
                    ->label('ACTIVIDAD')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->width('200px')
                    ->tooltip(fn ($record) => $record->nombre_actividad ?? 'N/A')
                    ->limit(30)
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('Evento_Fecha_Inicio')
                    ->label('FECHA DEL EVENTO')
                    ->searchable()
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->dateTime('d/m/Y H:i')
                    ->placeholder('Sin fecha'),

                Tables\Columns\TextColumn::make('nombre_beneficiario')
                    ->label('NOMBRE DEL BENEFICIARIO')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->grow()
                    ->tooltip(fn ($record) => $record->nombre_beneficiario ?? 'N/A')
                    ->limit(50)
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('identificacion')
                    ->label('IDENTIFICACIÓN')
                    ->searchable()
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->tooltip(fn ($record) => $record->identificacion ?? 'N/A')
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('edad')
                    ->label('EDAD')
                    ->sortable()
                    ->alignCenter()
                    ->width('100px')
                    ->color(fn ($state) =>
                        $state >= 65 ? 'warning' :
                        ($state >= 18 ? 'success' : 'info')
                    )
                    ->formatStateUsing(fn ($state) => $state ? $state . ' años' : 'N/A')
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('genero')
                    ->label('GÉNERO')
                    ->sortable()
                    ->alignCenter()
                    ->width('120px')
                    ->badge()
                    ->color(fn ($state) =>
                        $state === 'Femenino' ? 'pink' :
                        ($state === 'Masculino' ? 'blue' : 'gray')
                    )
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('estado_civil')
                    ->label('ESTADO CIVIL')
                    ->sortable()
                    ->alignCenter()
                    ->width('130px')
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('telefono')
                    ->label('TELÉFONO')
                    ->searchable()
                    ->sortable()
                    ->alignCenter()
                    ->width('140px')
                    ->placeholder('Sin teléfono'),

                Tables\Columns\TextColumn::make('email')
                    ->label('EMAIL')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->width('200px')
                    ->placeholder('Sin email'),
            ])
            ->defaultSort('nombre_proyecto', 'asc')
            ->striped()
            ->paginated([10, 25, 50, 100])
            ->emptyStateHeading('No hay beneficiarios registrados')
            ->emptyStateDescription('No se encontraron beneficiarios con los filtros aplicados.')
            ->emptyStateIcon('heroicon-o-user-group');
    }
}

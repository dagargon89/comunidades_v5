<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use App\Models\VistaProgresoProyecto;
use Illuminate\Support\Facades\DB;
use pxlrbt\FilamentExcel\Actions\Tables\ExportAction;
use pxlrbt\FilamentExcel\Exports\ExcelExport;

class ActivityPerformanceDetails extends BaseWidget
{
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Detalles de Rendimiento de Actividades';

    protected static ?string $pollingInterval = null;

    protected int | string | array $columnSpan = 'full';

    public function table(Table $table): Table
    {
        // Query usando el modelo VistaProgresoProyecto
        $query = VistaProgresoProyecto::query()
            ->select([
                'Actividad',
                'Proyecto',
                'population_progress_percent',
                'product_progress_percent',
                'Evento_estado',
                'Beneficiarios_evento'
            ])
            ->distinct()
            ->orderBy('Actividad');

        return $table
            ->query($query)
            ->columns([
                Tables\Columns\TextColumn::make('Actividad')
                    ->label('ACTIVIDAD')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->grow()
                    ->tooltip(fn ($record) => $record->Actividad)
                    ->limit(50),

                Tables\Columns\TextColumn::make('Proyecto')
                    ->label('PROYECTO')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->width('200px')
                    ->tooltip(fn ($record) => $record->Proyecto ?? 'N/A')
                    ->limit(30)
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('population_progress_percent')
                    ->label('PROGRESO POBLACIONAL')
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->color(fn ($state) =>
                        $state >= 75 ? 'success' :
                        ($state >= 50 ? 'warning' : 'danger')
                    )
                    ->formatStateUsing(fn ($state) => $state ? number_format($state, 1) . '%' : 'N/A')
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('product_progress_percent')
                    ->label('PROGRESO DE PRODUCTOS')
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->color(fn ($state) =>
                        $state >= 75 ? 'success' :
                        ($state >= 50 ? 'warning' : 'danger')
                    )
                    ->formatStateUsing(fn ($state) => $state ? number_format($state, 1) . '%' : 'N/A')
                    ->placeholder('N/A'),

                Tables\Columns\TextColumn::make('Evento_estado')
                    ->label('ESTADO DEL EVENTO')
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->color(fn ($state) =>
                        $state === 'Completado' ? 'success' :
                        ($state === 'Calendarizado' ? 'info' : 'warning')
                    )
                    ->formatStateUsing(fn ($state) => $state ?? 'Sin estado'),

                Tables\Columns\TextColumn::make('Beneficiarios_evento')
                    ->label('BENEFICIARIOS')
                    ->sortable()
                    ->alignCenter()
                    ->width('120px')
                    ->color('primary')
                    ->formatStateUsing(fn ($state) => number_format($state ?? 0)),
            ])
            ->headerActions([
                ExportAction::make()->exports([
                    ExcelExport::make('excel')->label('Excel')->withFilename('detalles_rendimiento_actividades.xlsx'),
                    ExcelExport::make('csv')->label('CSV')->withFilename('detalles_rendimiento_actividades.csv'),
                    ExcelExport::make('pdf')->label('PDF')->withFilename('detalles_rendimiento_actividades.pdf'),
                ])
            ])
            ->defaultSort('Actividad', 'asc')
            ->striped()
            ->paginated([10, 25, 50])
            ->emptyStateHeading('No hay datos de actividades')
            ->emptyStateDescription('No se encontraron actividades con los filtros aplicados.')
            ->emptyStateIcon('heroicon-o-chart-bar');
    }
}

<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Columns\BadgeColumn;
use Filament\Widgets\TableWidget as BaseWidget;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;

class ProjectDetails extends BaseWidget
{
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Detalles de Proyectos';

    protected int | string | array $columnSpan = 'full';

    public function getTableRecordKey($record): string
    {
        return (string) $record->Proyecto_ID;
    }

    public function table(Table $table): Table
    {
        return $table
            ->query(
                $this->getTableQuery()
            )
            ->columns([
                TextColumn::make('Proyecto')
                    ->label('PROJECT')
                    ->searchable()
                    ->sortable()
                    ->wrap()
                    ->grow()
                    ->tooltip(fn ($record) => $record->Proyecto),

                TextColumn::make('Proyecto_ID')
                    ->label('PROJECT ID')
                    ->sortable()
                    ->alignCenter()
                    ->width('120px'),

                TextColumn::make('Proyecto_Fecha_Inicio')
                    ->label('START DATE')
                    ->date('Y-m-d')
                    ->sortable()
                    ->alignCenter()
                    ->width('120px'),

                TextColumn::make('Proyecto_Fecha_Final')
                    ->label('END DATE')
                    ->date('Y-m-d')
                    ->sortable()
                    ->alignCenter()
                    ->width('120px'),

                TextColumn::make('Proyecto_cantidad_financiada')
                    ->label('FUNDED AMOUNT')
                    ->money('USD')
                    ->sortable()
                    ->alignEnd()
                    ->width('150px'),

                TextColumn::make('population_progress_percent')
                    ->label('POPULATION PROGRESS %')
                    ->suffix('%')
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->color(fn ($state) => $state >= 80 ? 'success' : ($state >= 50 ? 'warning' : 'danger'))
                    ->formatStateUsing(fn ($state) => $state ? number_format($state, 1) : '0.0'),

                TextColumn::make('product_progress_percent')
                    ->label('PRODUCT PROGRESS %')
                    ->suffix('%')
                    ->sortable()
                    ->alignCenter()
                    ->width('150px')
                    ->color(fn ($state) => $state >= 80 ? 'success' : ($state >= 50 ? 'warning' : 'danger'))
                    ->formatStateUsing(fn ($state) => $state ? number_format($state, 1) : '0.0'),
            ])
            ->defaultSort('Proyecto_cantidad_financiada', 'desc')
            ->striped()
            ->paginated([10, 25, 50])
            ->poll('30s')
            ->extremePaginationLinks()
            ->persistSearchInSession()
            ->persistSortInSession();
    }

    protected function getTableQuery(): Builder
    {
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $financierId = $this->filters['financier_id'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;
        $activityYear = $this->filters['activity_year'] ?? null;
        $activityMonth = $this->filters['activity_month'] ?? null;
        $eventStatus = $this->filters['event_status'] ?? null;

        // Modelo simple que apunta directamente a la vista
        $model = new class extends Model {
            protected $table = 'vista_progreso_proyectos';
            protected $primaryKey = 'Proyecto_ID';
            public $timestamps = false;
        };

        // Query simple basado en la documentación: usar la vista directamente
        return $model->newQuery()
            ->when($startDate, fn ($query) => $query->whereDate('Evento_fecha_inicio', '>=', $startDate))
            ->when($endDate, fn ($query) => $query->whereDate('Evento_fecha_fin', '<=', $endDate))
            ->when($financierId, fn ($query) => $query->where('Financiadora_id', $financierId))
            ->when($projectId, fn ($query) => $query->where('Proyecto_ID', $projectId))
            ->when($activityYear, fn ($query) => $query->where('year_actividad', $activityYear))
            ->when($activityMonth, fn ($query) => $query->where('mes_actividad', $activityMonth))
            ->when($eventStatus, fn ($query) => $query->where('Evento_estado', $eventStatus))
            ->whereNotNull('Proyecto');
    }
}

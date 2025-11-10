<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Contracts\HasTable;
use Filament\Tables\Concerns\InteractsWithTable;
use Illuminate\Support\Facades\Bus;
use Illuminate\Support\Facades\DB;

class SeguimientoNarrativas extends Page implements HasTable
{
    use InteractsWithTable;

    protected static ?string $navigationIcon = 'heroicon-o-queue-list';

    protected static string $view = 'filament.pages.seguimiento-narrativas';

    protected static ?string $navigationLabel = 'Seguimiento de Generación';

    protected static ?string $title = 'Seguimiento de Generación de Narrativas';

    protected static ?string $navigationGroup = 'Informes y Reportes';

    protected static ?int $navigationSort = 3;

    // Polling cada 5 segundos para actualizar en tiempo real
    protected $pollInterval = '5s';

    public function table(Table $table): Table
    {
        return $table
            ->query(
                DB::table('job_batches')
                    ->orderBy('created_at', 'desc')
            )
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Nombre del proceso')
                    ->searchable()
                    ->default('Sin nombre')
                    ->description(fn ($record) => "Batch ID: {$record->id}"),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Iniciado')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),

                Tables\Columns\TextColumn::make('progreso')
                    ->label('Progreso')
                    ->badge()
                    ->getStateUsing(function ($record) {
                        $total = $record->total_jobs;
                        $completed = $record->total_jobs - $record->pending_jobs;
                        $percentage = $total > 0 ? round(($completed / $total) * 100) : 0;
                        return "{$completed}/{$total} ({$percentage}%)";
                    })
                    ->color(fn ($record) => match(true) {
                        $record->finished_at !== null => 'success',
                        $record->cancelled_at !== null => 'danger',
                        ($record->total_jobs - $record->pending_jobs) > 0 => 'warning',
                        default => 'gray',
                    }),

                Tables\Columns\TextColumn::make('status')
                    ->label('Estado')
                    ->badge()
                    ->getStateUsing(function ($record) {
                        if ($record->cancelled_at) {
                            return 'Cancelado';
                        }
                        if ($record->finished_at) {
                            return 'Completado';
                        }
                        if ($record->pending_jobs < $record->total_jobs) {
                            return 'Procesando';
                        }
                        return 'Pendiente';
                    })
                    ->color(fn ($record) => match(true) {
                        $record->cancelled_at !== null => 'danger',
                        $record->finished_at !== null => 'success',
                        $record->pending_jobs < $record->total_jobs => 'warning',
                        default => 'gray',
                    }),

                Tables\Columns\TextColumn::make('failed_jobs')
                    ->label('Fallidos')
                    ->badge()
                    ->color('danger')
                    ->default(0)
                    ->visible(fn ($record) => $record->failed_jobs > 0),

                Tables\Columns\TextColumn::make('finished_at')
                    ->label('Finalizado')
                    ->dateTime('d/m/Y H:i')
                    ->placeholder('En proceso')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('duracion')
                    ->label('Duración')
                    ->getStateUsing(function ($record) {
                        if (!$record->finished_at) {
                            $seconds = now()->diffInSeconds($record->created_at);
                            return $this->formatDuration($seconds) . ' (en curso)';
                        }
                        $seconds = \Carbon\Carbon::parse($record->finished_at)->diffInSeconds($record->created_at);
                        return $this->formatDuration($seconds);
                    })
                    ->toggleable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('Estado')
                    ->options([
                        'pendiente' => 'Pendiente',
                        'procesando' => 'Procesando',
                        'completado' => 'Completado',
                        'cancelado' => 'Cancelado',
                    ])
                    ->query(function ($query, $state) {
                        if (!$state['value']) return $query;

                        return match($state['value']) {
                            'pendiente' => $query->whereNull('finished_at')
                                ->whereNull('cancelled_at')
                                ->whereRaw('pending_jobs = total_jobs'),
                            'procesando' => $query->whereNull('finished_at')
                                ->whereNull('cancelled_at')
                                ->whereRaw('pending_jobs < total_jobs'),
                            'completado' => $query->whereNotNull('finished_at'),
                            'cancelado' => $query->whereNotNull('cancelled_at'),
                            default => $query,
                        };
                    }),
            ])
            ->actions([
                Tables\Actions\Action::make('ver_detalles')
                    ->label('Ver Detalles')
                    ->icon('heroicon-o-eye')
                    ->color('info')
                    ->modalHeading(fn ($record) => "Detalles del Batch: {$record->name}")
                    ->modalContent(fn ($record) => view('filament.modals.batch-details', [
                        'batch' => $record
                    ]))
                    ->modalSubmitAction(false)
                    ->modalCancelActionLabel('Cerrar')
                    ->modalWidth('2xl'),

                Tables\Actions\Action::make('cancelar')
                    ->label('Cancelar')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->requiresConfirmation()
                    ->visible(fn ($record) => !$record->finished_at && !$record->cancelled_at)
                    ->action(function ($record) {
                        $batch = Bus::findBatch($record->id);
                        if ($batch) {
                            $batch->cancel();
                        }
                    }),
            ])
            ->poll($this->pollInterval)
            ->defaultSort('created_at', 'desc')
            ->emptyStateHeading('No hay procesos de generación')
            ->emptyStateDescription('Cuando generes informes narrativos con muchos eventos, aparecerán aquí.')
            ->emptyStateIcon('heroicon-o-queue-list');
    }

    protected function formatDuration(int $seconds): string
    {
        if ($seconds < 60) {
            return "{$seconds}s";
        }

        $minutes = floor($seconds / 60);
        $remainingSeconds = $seconds % 60;

        if ($minutes < 60) {
            return "{$minutes}m {$remainingSeconds}s";
        }

        $hours = floor($minutes / 60);
        $remainingMinutes = $minutes % 60;

        return "{$hours}h {$remainingMinutes}m";
    }
}

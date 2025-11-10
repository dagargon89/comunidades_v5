<?php

namespace App\Filament\Widgets;

use App\Models\ActivityNarrative;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use Illuminate\Database\Eloquent\Builder;

class NarrativasRecientesWidget extends BaseWidget
{
    protected static ?int $sort = 3;

    protected int | string | array $columnSpan = 'full';

    public function table(Table $table): Table
    {
        return $table
            ->query(
                ActivityNarrative::query()
                    ->with(['activityCalendar.activity', 'activityCalendar.location'])
                    ->whereNotNull('narrativa_generada')
                    ->latest()
                    ->limit(10)
            )
            ->columns([
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Fecha Generación')
                    ->dateTime('d/m/Y H:i')
                    ->sortable()
                    ->size('sm'),

                Tables\Columns\TextColumn::make('activityCalendar.fecha')
                    ->label('Fecha Evento')
                    ->date('d/m/Y')
                    ->sortable()
                    ->size('sm'),

                Tables\Columns\TextColumn::make('activityCalendar.activity.name')
                    ->label('Actividad')
                    ->searchable()
                    ->limit(40)
                    ->tooltip(fn (ActivityNarrative $record) => $record->activityCalendar?->activity?->name)
                    ->size('sm'),

                Tables\Columns\TextColumn::make('activityCalendar.location.name')
                    ->label('Ubicación')
                    ->limit(30)
                    ->size('sm')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('participantes_count')
                    ->label('Participantes')
                    ->alignCenter()
                    ->badge()
                    ->color('info')
                    ->size('sm'),

                Tables\Columns\IconColumn::make('narrativa_generada')
                    ->label('Generada')
                    ->boolean()
                    ->trueIcon('heroicon-o-check-circle')
                    ->falseIcon('heroicon-o-x-circle')
                    ->trueColor('success')
                    ->falseColor('danger')
                    ->alignCenter()
                    ->size('sm'),

                Tables\Columns\IconColumn::make('narrativa_aprobada')
                    ->label('Aprobada')
                    ->boolean()
                    ->trueIcon('heroicon-o-check-badge')
                    ->falseIcon('heroicon-o-clock')
                    ->trueColor('success')
                    ->falseColor('warning')
                    ->alignCenter()
                    ->size('sm'),

                Tables\Columns\TextColumn::make('narrativa_regenerada_at')
                    ->label('Última Regeneración')
                    ->dateTime('d/m/Y H:i')
                    ->placeholder('—')
                    ->size('sm')
                    ->toggleable()
                    ->toggledHiddenByDefault(),
            ])
            ->actions([
                Tables\Actions\Action::make('ver')
                    ->label('Ver')
                    ->icon('heroicon-o-eye')
                    ->url(fn (ActivityNarrative $record): string =>
                        route('filament.admin.resources.activity-narratives.edit', ['record' => $record->id])
                    )
                    ->openUrlInNewTab(),
            ])
            ->heading('Narrativas Recientes')
            ->description('Últimas 10 narrativas generadas en el sistema')
            ->defaultSort('created_at', 'desc');
    }
}

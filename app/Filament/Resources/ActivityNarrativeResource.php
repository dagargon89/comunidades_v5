<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ActivityNarrativeResource\Pages;
use App\Models\ActivityNarrative;
use App\Models\ActivityCalendar;
use App\Services\NarrativaGenerator;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Notifications\Notification;
use Illuminate\Database\Eloquent\Builder;

class ActivityNarrativeResource extends Resource
{
    protected static ?string $model = ActivityNarrative::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    protected static ?string $navigationLabel = 'Narrativas de Eventos';

    protected static ?string $modelLabel = 'Narrativa';

    protected static ?string $pluralModelLabel = 'Narrativas';

    protected static ?string $navigationGroup = 'Informes y Reportes';

    protected static ?int $navigationSort = 1;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Evento')
                    ->description('Selecciona el evento para el cual se generará la narrativa')
                    ->schema([
                        Forms\Components\Select::make('activity_calendar_id')
                            ->label('Evento (Activity Calendar)')
                            ->relationship(
                                'activityCalendar',
                                'id',
                                fn (Builder $query) => $query
                                    ->with(['activity', 'location'])
                                    ->orderBy('start_date', 'desc')
                            )
                            ->getOptionLabelFromRecordUsing(fn (ActivityCalendar $record) =>
                                "{$record->start_date->format('d/m/Y')} - {$record->activity->name} " .
                                ($record->location ? "({$record->location->name})" : "")
                            )
                            ->searchable()
                            ->preload()
                            ->required()
                            ->disabled(fn ($context) => $context === 'edit')
                            ->helperText('El evento no puede cambiarse después de crear la narrativa'),
                    ])
                    ->columns(1),

                Forms\Components\Section::make('Información para generar la narrativa')
                    ->description('Completa estos campos con la información del evento. Serán utilizados por la IA para generar la narrativa formal.')
                    ->schema([
                        Forms\Components\Textarea::make('narrativa_contexto')
                            ->label('Contexto del evento')
                            ->helperText('¿Qué se hizo? ¿Quiénes participaron? ¿Dónde se realizó?')
                            ->rows(4)
                            ->columnSpanFull(),

                        Forms\Components\Textarea::make('narrativa_desarrollo')
                            ->label('Desarrollo de la actividad')
                            ->helperText('¿Cómo se llevó a cabo? ¿Qué temas se abordaron? ¿Qué metodología se empleó?')
                            ->rows(4)
                            ->columnSpanFull(),

                        Forms\Components\Textarea::make('narrativa_resultados')
                            ->label('Resultados y acuerdos')
                            ->helperText('¿Qué acuerdos se alcanzaron? ¿Qué compromisos se establecieron? ¿Próximos pasos?')
                            ->rows(4)
                            ->columnSpanFull(),

                        Forms\Components\TextInput::make('participantes_count')
                            ->label('Número de participantes')
                            ->numeric()
                            ->minValue(0)
                            ->helperText('Cantidad exacta de personas que participaron'),

                        Forms\Components\Textarea::make('organizaciones_participantes')
                            ->label('Organizaciones participantes')
                            ->helperText('Nombres de organizaciones separados por coma (ej: Org1, Org2, Org3)')
                            ->rows(2),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Narrativa generada por IA')
                    ->description('Esta sección muestra la narrativa generada automáticamente')
                    ->schema([
                        Forms\Components\Textarea::make('narrativa_generada')
                            ->label('Narrativa generada')
                            ->disabled()
                            ->rows(8)
                            ->columnSpanFull()
                            ->placeholder('La narrativa se generará automáticamente usando IA'),

                        Forms\Components\Toggle::make('narrativa_aprobada')
                            ->label('Narrativa aprobada')
                            ->helperText('Marca como aprobada después de revisar la narrativa generada')
                            ->default(false)
                            ->disabled(fn ($record) => !$record || !$record->narrativa_generada),

                        Forms\Components\Placeholder::make('narrativa_regenerada_at')
                            ->label('Última generación')
                            ->content(fn ($record) => $record?->narrativa_regenerada_at?->format('d/m/Y H:i') ?? 'No generada aún'),
                    ])
                    ->columns(2)
                    ->collapsed(fn ($record) => !$record || !$record->narrativa_generada),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('activityCalendar.start_date')
                    ->label('Fecha del evento')
                    ->date('d/m/Y')
                    ->sortable()
                    ->searchable(),

                Tables\Columns\TextColumn::make('activityCalendar.activity.name')
                    ->label('Actividad')
                    ->limit(40)
                    ->searchable()
                    ->tooltip(fn ($record) => $record->activityCalendar->activity->name),

                Tables\Columns\TextColumn::make('activityCalendar.location.name')
                    ->label('Ubicación')
                    ->limit(30)
                    ->searchable()
                    ->placeholder('Sin ubicación'),

                Tables\Columns\TextColumn::make('participantes_count')
                    ->label('Participantes')
                    ->alignCenter()
                    ->default('-'),

                Tables\Columns\IconColumn::make('narrativa_generada')
                    ->label('Generada')
                    ->boolean()
                    ->trueIcon('heroicon-o-check-circle')
                    ->falseIcon('heroicon-o-x-circle')
                    ->trueColor('success')
                    ->falseColor('danger')
                    ->alignCenter(),

                Tables\Columns\IconColumn::make('narrativa_aprobada')
                    ->label('Aprobada')
                    ->boolean()
                    ->trueIcon('heroicon-o-check-badge')
                    ->falseIcon('heroicon-o-clock')
                    ->trueColor('success')
                    ->falseColor('warning')
                    ->alignCenter(),

                Tables\Columns\TextColumn::make('total_versiones')
                    ->label('Versiones')
                    ->badge()
                    ->color('gray')
                    ->icon('heroicon-o-clock')
                    ->alignCenter()
                    ->default(0)
                    ->tooltip('Número de versiones guardadas')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('narrativa_regenerada_at')
                    ->label('Última generación')
                    ->dateTime('d/m/Y H:i')
                    ->sortable()
                    ->placeholder('No generada')
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Creado')
                    ->dateTime('d/m/Y')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('narrativa_aprobada')
                    ->label('Estado de aprobación')
                    ->options([
                        '1' => 'Aprobadas',
                        '0' => 'Pendientes',
                    ]),

                Tables\Filters\Filter::make('con_narrativa')
                    ->label('Con narrativa generada')
                    ->query(fn (Builder $query): Builder => $query->whereNotNull('narrativa_generada')),

                Tables\Filters\Filter::make('sin_narrativa')
                    ->label('Sin narrativa generada')
                    ->query(fn (Builder $query): Builder => $query->whereNull('narrativa_generada')),

                Tables\Filters\Filter::make('fecha')
                    ->form([
                        Forms\Components\DatePicker::make('desde')
                            ->label('Desde'),
                        Forms\Components\DatePicker::make('hasta')
                            ->label('Hasta'),
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        return $query
                            ->when(
                                $data['desde'],
                                fn (Builder $query, $date): Builder => $query->whereHas('activityCalendar', function ($q) use ($date) {
                                    $q->whereDate('start_date', '>=', $date);
                                }),
                            )
                            ->when(
                                $data['hasta'],
                                fn (Builder $query, $date): Builder => $query->whereHas('activityCalendar', function ($q) use ($date) {
                                    $q->whereDate('start_date', '<=', $date);
                                }),
                            );
                    }),
            ])
            ->actions([
                // Acción: Ver historial de versiones
                Tables\Actions\Action::make('ver_historial')
                    ->label('Historial')
                    ->icon('heroicon-o-clock')
                    ->color('gray')
                    ->visible(fn ($record) => $record->versions()->count() > 0)
                    ->modalHeading(fn ($record) => "Historial de Versiones ({$record->versions()->count()})")
                    ->modalContent(fn ($record) => view('filament.modals.narrativa-historial', [
                        'versiones' => $record->versions
                    ]))
                    ->modalSubmitAction(false)
                    ->modalCancelActionLabel('Cerrar')
                    ->modalWidth('4xl'),

                // Acción: Ver narrativa
                Tables\Actions\Action::make('ver_narrativa')
                    ->label('Ver')
                    ->icon('heroicon-o-eye')
                    ->color('info')
                    ->visible(fn ($record) => $record->narrativa_generada)
                    ->modalContent(fn ($record) => view('filament.modals.narrativa-preview', [
                        'narrativa' => $record
                    ]))
                    ->modalSubmitAction(false)
                    ->modalCancelActionLabel('Cerrar')
                    ->modalWidth('3xl'),

                // Acción: Generar narrativa
                Tables\Actions\Action::make('generar_narrativa')
                    ->label('Generar')
                    ->icon('heroicon-o-sparkles')
                    ->color('success')
                    ->visible(fn ($record) => !$record->narrativa_generada)
                    ->requiresConfirmation()
                    ->modalHeading('Generar narrativa con IA')
                    ->modalDescription('Se generará una narrativa en estilo formal institucional usando los datos proporcionados.')
                    ->action(function ($record) {
                        try {
                            $generator = app(NarrativaGenerator::class);
                            $generator->generarNarrativaEvento($record->activityCalendar);

                            Notification::make()
                                ->title('Narrativa generada exitosamente')
                                ->success()
                                ->send();

                        } catch (\Exception $e) {
                            Notification::make()
                                ->title('Error al generar narrativa')
                                ->body($e->getMessage())
                                ->danger()
                                ->send();
                        }
                    }),

                // Acción: Regenerar narrativa
                Tables\Actions\Action::make('regenerar_narrativa')
                    ->label('Regenerar')
                    ->icon('heroicon-o-arrow-path')
                    ->color('warning')
                    ->visible(fn ($record) => $record->narrativa_generada)
                    ->requiresConfirmation()
                    ->modalHeading('¿Regenerar narrativa?')
                    ->modalDescription('Se eliminará la narrativa actual y se generará una nueva. Si ya fue aprobada, deberás aprobarla nuevamente.')
                    ->action(function ($record) {
                        try {
                            $generator = app(NarrativaGenerator::class);
                            $generator->generarNarrativaEvento($record->activityCalendar, true);

                            Notification::make()
                                ->title('Narrativa regenerada exitosamente')
                                ->success()
                                ->send();

                        } catch (\Exception $e) {
                            Notification::make()
                                ->title('Error al regenerar narrativa')
                                ->body($e->getMessage())
                                ->danger()
                                ->send();
                        }
                    }),

                // Acción: Aprobar narrativa
                Tables\Actions\Action::make('aprobar_narrativa')
                    ->label('Aprobar')
                    ->icon('heroicon-o-check-circle')
                    ->color('success')
                    ->visible(fn ($record) => $record->narrativa_generada && !$record->narrativa_aprobada)
                    ->requiresConfirmation()
                    ->modalHeading('Aprobar narrativa')
                    ->modalDescription('Una vez aprobada, esta narrativa se incluirá en los informes generados.')
                    ->action(function ($record) {
                        $record->marcarAprobada();

                        Notification::make()
                            ->title('Narrativa aprobada')
                            ->success()
                            ->send();
                    }),

                // Acción: Rechazar aprobación
                Tables\Actions\Action::make('rechazar_narrativa')
                    ->label('Rechazar aprobación')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->visible(fn ($record) => $record->narrativa_aprobada)
                    ->requiresConfirmation()
                    ->modalHeading('Rechazar aprobación')
                    ->modalDescription('La narrativa quedará pendiente de revisión.')
                    ->action(function ($record) {
                        $record->marcarNoAprobada();

                        Notification::make()
                            ->title('Aprobación rechazada')
                            ->warning()
                            ->send();
                    }),

                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    // Acción masiva: Generar narrativas
                    Tables\Actions\BulkAction::make('generar_narrativas')
                        ->label('Generar narrativas')
                        ->icon('heroicon-o-sparkles')
                        ->color('success')
                        ->requiresConfirmation()
                        ->modalHeading('Generar narrativas con IA')
                        ->modalDescription('Se generarán narrativas para todos los registros seleccionados que no tengan una. Este proceso puede tardar varios minutos.')
                        ->action(function ($records) {
                            $generator = app(NarrativaGenerator::class);
                            $count = 0;
                            $errors = 0;

                            foreach ($records as $record) {
                                if (!$record->narrativa_generada) {
                                    try {
                                        $generator->generarNarrativaEvento($record->activityCalendar);
                                        $count++;
                                    } catch (\Exception $e) {
                                        $errors++;
                                    }
                                }
                            }

                            Notification::make()
                                ->title("{$count} narrativas generadas exitosamente")
                                ->body($errors > 0 ? "{$errors} errores encontrados" : '')
                                ->success()
                                ->send();
                        }),

                    // Acción masiva: Aprobar narrativas
                    Tables\Actions\BulkAction::make('aprobar_narrativas')
                        ->label('Aprobar narrativas')
                        ->icon('heroicon-o-check-badge')
                        ->color('success')
                        ->requiresConfirmation()
                        ->action(function ($records) {
                            $count = 0;
                            foreach ($records as $record) {
                                if ($record->narrativa_generada && !$record->narrativa_aprobada) {
                                    $record->marcarAprobada();
                                    $count++;
                                }
                            }

                            Notification::make()
                                ->title("{$count} narrativas aprobadas")
                                ->success()
                                ->send();
                        }),

                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('activityCalendar.start_date', 'desc');
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListActivityNarratives::route('/'),
            'create' => Pages\CreateActivityNarrative::route('/create'),
            'edit' => Pages\EditActivityNarrative::route('/{record}/edit'),
        ];
    }

    public static function getNavigationBadge(): ?string
    {
        return static::getModel()::sinNarrativaGenerada()->count() ?: null;
    }

    public static function getNavigationBadgeColor(): ?string
    {
        $count = static::getModel()::sinNarrativaGenerada()->count();
        return $count > 10 ? 'danger' : ($count > 0 ? 'warning' : 'success');
    }
}

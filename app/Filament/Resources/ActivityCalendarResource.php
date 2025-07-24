<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ActivityCalendarResource\Pages;
use App\Filament\Resources\ActivityCalendarResource\RelationManagers;
use App\Models\ActivityCalendar;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ActivityCalendarResource extends Resource
{
    protected static ?string $model = ActivityCalendar::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $navigationGroup = 'Sección de Calendarización';

    protected static ?string $navigationLabel = 'Calendario de Actividades';

    protected static ?string $modelLabel = 'Calendario de Actividad';

    protected static ?string $pluralModelLabel = 'Calendarios de Actividades';

    protected static ?string $slug = 'calendario-actividades';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la Actividad')
                    ->description('Datos básicos de la actividad programada')
                    ->icon('heroicon-o-calendar')
                    ->schema([
                        Forms\Components\Select::make('activity_id')
                            ->relationship('activity', 'name')
                            ->label('Actividad')
                            ->required()
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->placeholder('Seleccione una actividad'),
                        Forms\Components\Toggle::make('cancelled')
                            ->label('Cancelado')
                            ->required(),
                        Forms\Components\Textarea::make('change_reason')
                            ->label('Motivo del cambio')
                            ->placeholder('Especifique el motivo del cambio o cancelación')
                            ->columnSpanFull(),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Programación Temporal')
                    ->description('Fechas y horarios de la actividad')
                    ->icon('heroicon-o-clock')
                    ->schema([
                        Forms\Components\DatePicker::make('start_date')
                            ->label('Fecha de inicio')
                            ->placeholder('Seleccione fecha de inicio'),
                        Forms\Components\DatePicker::make('end_date')
                            ->label('Fecha de fin')
                            ->placeholder('Seleccione fecha de fin'),
                        Forms\Components\TimePicker::make('start_hour')
                            ->label('Hora de inicio')
                            ->placeholder('Seleccione hora de inicio'),
                        Forms\Components\TimePicker::make('end_hour')
                            ->label('Hora de fin')
                            ->placeholder('Seleccione hora de fin'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Información de Ubicación')
                    ->description('Datos de ubicación y dirección')
                    ->icon('heroicon-o-map-pin')
                    ->schema([
                        Forms\Components\Textarea::make('address_backup')
                            ->label('Dirección de respaldo')
                            ->placeholder('Ingrese la dirección completa')
                            ->columnSpanFull(),
                    ]),

                Forms\Components\Section::make('Asignación y Control')
                    ->description('Responsables y seguimiento')
                    ->icon('heroicon-o-users')
                    ->schema([
                        Forms\Components\Select::make('created_by')
                            ->label('Creado por')
                            ->options(fn() => \App\Models\User::pluck('name', 'id'))
                            ->required()
                            ->placeholder('Seleccione el usuario creador'),
                        Forms\Components\Select::make('asigned_person')
                            ->label('Persona asignada')
                            ->options(fn() => \App\Models\User::pluck('name', 'id'))
                            ->required()
                            ->placeholder('Seleccione la persona asignada'),
                        Forms\Components\DateTimePicker::make('last_modified')
                            ->label('Última modificación')
                            ->placeholder('Fecha y hora de última modificación'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('activity.description')
                    ->label('Actividad')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_date')
                    ->label('Fecha inicio')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->label('Fecha fin')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_hour')
                    ->label('Hora inicio'),
                Tables\Columns\TextColumn::make('end_hour')
                    ->label('Hora fin'),
                Tables\Columns\TextColumn::make('last_modified')
                    ->label('Última modificación')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\IconColumn::make('cancelled')
                    ->label('Cancelado')
                    ->boolean(),
                Tables\Columns\TextColumn::make('createdBy.name')
                    ->label('Creado por')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('asignedPerson.name')
                    ->label('Persona asignada')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
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
            'index' => Pages\ListActivityCalendars::route('/'),
            'create' => Pages\CreateActivityCalendar::route('/create'),
            'edit' => Pages\EditActivityCalendar::route('/{record}/edit'),
        ];
    }
}

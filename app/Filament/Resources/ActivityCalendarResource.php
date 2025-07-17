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

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('activity_id')
                    ->relationship('activity', 'description')
                    ->required(),
                Forms\Components\DatePicker::make('start_date'),
                Forms\Components\DatePicker::make('end_date'),
                Forms\Components\TimePicker::make('start_hour'),
                Forms\Components\TimePicker::make('end_hour'),
                Forms\Components\Textarea::make('address_backup')
                    ->columnSpanFull(),
                Forms\Components\DateTimePicker::make('last_modified'),
                Forms\Components\Toggle::make('cancelled')
                    ->required(),
                Forms\Components\Textarea::make('change_reason')
                    ->columnSpanFull(),
                Forms\Components\Select::make('created_by')
                    ->options(fn () => \App\Models\User::pluck('name', 'id'))
                    ->required(),
                Forms\Components\Select::make('asigned_person')
                    ->options(fn () => \App\Models\User::pluck('name', 'id'))
                    ->required(),
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

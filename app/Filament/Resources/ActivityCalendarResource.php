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
                    ->relationship('activity', 'id')
                    ->required(),
                Forms\Components\DatePicker::make('start_date'),
                Forms\Components\DatePicker::make('end_date'),
                Forms\Components\TextInput::make('start_hour'),
                Forms\Components\TextInput::make('end_hour'),
                Forms\Components\Textarea::make('address_backup')
                    ->columnSpanFull(),
                Forms\Components\DateTimePicker::make('last_modified'),
                Forms\Components\Toggle::make('cancelled')
                    ->required(),
                Forms\Components\Textarea::make('change_reason')
                    ->columnSpanFull(),
                Forms\Components\TextInput::make('created_by')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('asigned_person')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('belongsTo')
                    ->required()
                    ->maxLength(255),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('activity.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_date')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_hour'),
                Tables\Columns\TextColumn::make('end_hour'),
                Tables\Columns\TextColumn::make('last_modified')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\IconColumn::make('cancelled')
                    ->boolean(),
                Tables\Columns\TextColumn::make('created_by')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('asigned_person')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('belongsTo')
                    ->searchable(),
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

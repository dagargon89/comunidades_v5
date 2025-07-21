<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PublishedActivityResource\Pages;
use App\Filament\Resources\PublishedActivityResource\RelationManagers;
use App\Models\PublishedActivity;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class PublishedActivityResource extends Resource
{
    protected static ?string $model = PublishedActivity::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('publication_id')
                    ->relationship('publication', 'id')
                    ->required(),
                Forms\Components\Select::make('original_activity_id')
                    ->relationship('originalActivity', 'name')
                    ->required(),
                Forms\Components\TextInput::make('name')
                    ->maxLength(255),
                Forms\Components\Textarea::make('description')
                    ->columnSpanFull(),
                Forms\Components\Select::make('specific_objective_id')
                    ->relationship('specificObjective', 'id')
                    ->required(),
                Forms\Components\TextInput::make('goals_id')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('created_by')
                    ->required()
                    ->numeric(),
                Forms\Components\DateTimePicker::make('snapshot_date')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('publication.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('originalActivity.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('specificObjective.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('goals_id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_by')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('snapshot_date')
                    ->dateTime()
                    ->sortable(),
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
            'index' => Pages\ListPublishedActivities::route('/'),
            'create' => Pages\CreatePublishedActivity::route('/create'),
            'edit' => Pages\EditPublishedActivity::route('/{record}/edit'),
        ];
    }
}

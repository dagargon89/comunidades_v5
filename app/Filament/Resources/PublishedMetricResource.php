<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PublishedMetricResource\Pages;
use App\Filament\Resources\PublishedMetricResource\RelationManagers;
use App\Models\PublishedMetric;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class PublishedMetricResource extends Resource
{
    protected static ?string $model = PublishedMetric::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('publication_id')
                    ->relationship('publication', 'id')
                    ->required(),
                Forms\Components\Select::make('original_metric_id')
                    ->relationship('originalMetric', 'id')
                    ->required(),
                Forms\Components\Select::make('activity_id')
                    ->relationship('activity', 'name')
                    ->required(),
                Forms\Components\TextInput::make('unit')
                    ->maxLength(100),
                Forms\Components\TextInput::make('year')
                    ->numeric(),
                Forms\Components\TextInput::make('month')
                    ->numeric(),
                Forms\Components\TextInput::make('population_target_value')
                    ->numeric(),
                Forms\Components\TextInput::make('population_real_value')
                    ->numeric(),
                Forms\Components\TextInput::make('product_target_value')
                    ->numeric(),
                Forms\Components\TextInput::make('product_real_value')
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
                Tables\Columns\TextColumn::make('originalMetric.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('activity.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('unit')
                    ->searchable(),
                Tables\Columns\TextColumn::make('year')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('month')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('population_target_value')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('population_real_value')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('product_target_value')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('product_real_value')
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
            'index' => Pages\ListPublishedMetrics::route('/'),
            'create' => Pages\CreatePublishedMetric::route('/create'),
            'edit' => Pages\EditPublishedMetric::route('/{record}/edit'),
        ];
    }
}

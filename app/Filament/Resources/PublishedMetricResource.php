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
    protected static ?string $navigationIcon = 'heroicon-o-archive-box';
    protected static ?string $navigationGroup = 'Datos publicados';
    protected static ?string $navigationLabel = 'Métricas publicadas';
    protected static ?string $modelLabel = 'Métrica publicada';
    protected static ?string $pluralModelLabel = 'Métricas publicadas';
    protected static ?string $slug = 'metricas-publicadas';

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la métrica publicada')
                    ->schema([
                        Forms\Components\TextInput::make('unit')->label('Unidad'),
                        Forms\Components\TextInput::make('year')->label('Año')->numeric(),
                        Forms\Components\TextInput::make('month')->label('Mes')->numeric(),
                        Forms\Components\TextInput::make('population_target_value')->label('Meta población')->numeric(),
                        Forms\Components\TextInput::make('population_real_value')->label('Valor real población')->numeric(),
                        Forms\Components\TextInput::make('product_target_value')->label('Meta producto')->numeric(),
                        Forms\Components\TextInput::make('product_real_value')->label('Valor real producto')->numeric(),
                    ])
            ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')->label('ID')->sortable(),
                Tables\Columns\TextColumn::make('unit')->label('Unidad'),
                Tables\Columns\TextColumn::make('year')->label('Año'),
                Tables\Columns\TextColumn::make('month')->label('Mes'),
                Tables\Columns\TextColumn::make('population_target_value')->label('Meta población'),
                Tables\Columns\TextColumn::make('population_real_value')->label('Valor real población'),
                Tables\Columns\TextColumn::make('product_target_value')->label('Meta producto'),
                Tables\Columns\TextColumn::make('product_real_value')->label('Valor real producto'),
            ])
            ->filters([
                // Puedes agregar filtros aquí
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

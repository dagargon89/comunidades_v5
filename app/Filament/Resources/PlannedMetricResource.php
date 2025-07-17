<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PlannedMetricResource\Pages;
use App\Filament\Resources\PlannedMetricResource\RelationManagers;
use App\Models\PlannedMetric;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class PlannedMetricResource extends Resource
{
    protected static ?string $model = PlannedMetric::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-chart-bar';
    protected static ?string $navigationGroup = 'Sección de Captura de Proyectos';
    protected static ?string $navigationLabel = 'Métricas Planificadas';
    protected static ?string $modelLabel = 'Métrica Planificada';
    protected static ?string $pluralModelLabel = 'Métricas Planificadas';
    protected static ?string $slug = 'metricas-planificadas';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la Métrica Planificada')
                    ->description('Datos básicos de la métrica planificada')
                    ->icon('heroicon-o-document-chart-bar')
                    ->schema([
                        Forms\Components\Select::make('activity_id')
                            ->label('Actividad')
                            ->relationship('activity', 'id')
                            ->required(),
                        Forms\Components\TextInput::make('unit')
                            ->label('Unidad')
                            ->required()
                            ->maxLength(50),
                        Forms\Components\TextInput::make('year')
                            ->label('Año')
                            ->numeric()
                            ->required(),
                        Forms\Components\TextInput::make('month')
                            ->label('Mes')
                            ->numeric()
                            ->required(),
                        Forms\Components\TextInput::make('population_target_value')
                            ->label('Valor Objetivo de Población')
                            ->numeric(),
                        Forms\Components\TextInput::make('population_real_value')
                            ->label('Valor Real de Población')
                            ->numeric(),
                        Forms\Components\TextInput::make('product_target_value')
                            ->label('Valor Objetivo de Producto')
                            ->numeric(),
                        Forms\Components\TextInput::make('product_real_value')
                            ->label('Valor Real de Producto')
                            ->numeric(),
                        Forms\Components\Select::make('activity_progress_log_id')
                            ->label('Registro de Progreso')
                            ->relationship('activityProgressLog', 'id')
                            ->required(),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('activity.id')
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
                Tables\Columns\TextColumn::make('activityProgressLog.id')
                    ->numeric()
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
            'index' => Pages\ListPlannedMetrics::route('/'),
            'create' => Pages\CreatePlannedMetric::route('/create'),
            'edit' => Pages\EditPlannedMetric::route('/{record}/edit'),
        ];
    }
}

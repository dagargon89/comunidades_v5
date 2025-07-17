<?php

namespace App\Filament\Resources;

use App\Filament\Resources\KpiResource\Pages;
use App\Filament\Resources\KpiResource\RelationManagers;
use App\Models\Kpi;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class KpiResource extends Resource
{
    protected static ?string $model = Kpi::class;

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar-square';
    protected static ?string $navigationGroup = 'Sección de Captura de Proyectos';
    protected static ?string $navigationLabel = 'KPIs';
    protected static ?string $modelLabel = 'KPI';
    protected static ?string $pluralModelLabel = 'KPIs';
    protected static ?string $slug = 'kpis';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del KPI')
                    ->description('Datos básicos del indicador de rendimiento')
                    ->icon('heroicon-o-chart-bar-square')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre del KPI')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Textarea::make('description')
                            ->label('Descripción')
                            ->maxLength(500),
                        Forms\Components\TextInput::make('initial_value')
                            ->label('Valor Inicial')
                            ->numeric(),
                        Forms\Components\TextInput::make('final_value')
                            ->label('Valor Final')
                            ->numeric(),
                        Forms\Components\Select::make('projects_id')
                            ->label('Proyecto')
                            ->relationship('projects', 'name')
                            ->required(),
                        Forms\Components\Toggle::make('is_percentage')
                            ->label('Es Porcentaje')
                            ->default(false),
                        Forms\Components\TextInput::make('org_area')
                            ->label('Área Organizacional')
                            ->maxLength(100),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('initial_value')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('final_value')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('projects.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\IconColumn::make('is_percentage')
                    ->boolean(),
                Tables\Columns\TextColumn::make('org_area')
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
            'index' => Pages\ListKpis::route('/'),
            'create' => Pages\CreateKpi::route('/create'),
            'edit' => Pages\EditKpi::route('/{record}/edit'),
        ];
    }
}

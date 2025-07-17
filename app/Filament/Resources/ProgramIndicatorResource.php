<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProgramIndicatorResource\Pages;
use App\Filament\Resources\ProgramIndicatorResource\RelationManagers;
use App\Models\ProgramIndicator;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ProgramIndicatorResource extends Resource
{
    protected static ?string $model = ProgramIndicator::class;

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';
    protected static ?string $navigationGroup = 'Sección de Planeación Estratégica';
    protected static ?string $navigationLabel = 'Indicadores de Programa';
    protected static ?string $modelLabel = 'Indicador de Programa';
    protected static ?string $pluralModelLabel = 'Indicadores de Programa';
    protected static ?string $slug = 'indicadores-programa';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del Indicador de Programa')
                    ->description('Datos básicos del indicador')
                    ->icon('heroicon-o-chart-bar')
                    ->schema([
                        Forms\Components\Select::make('program_id')
                            ->label('Programa')
                            ->relationship('program', 'name')
                            ->required(),
                        Forms\Components\Select::make('program_axes_id')
                            ->label('Eje')
                            ->relationship('programAxes', 'name')
                            ->required(),
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre del Indicador')
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
                Tables\Columns\TextColumn::make('program.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('programAxes.name')
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
            'index' => Pages\ListProgramIndicators::route('/'),
            'create' => Pages\CreateProgramIndicator::route('/create'),
            'edit' => Pages\EditProgramIndicator::route('/{record}/edit'),
        ];
    }
}

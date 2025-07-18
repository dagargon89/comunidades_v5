<?php

namespace App\Filament\Resources;

use App\Filament\Resources\SpecificObjectiveResource\Pages;
use App\Filament\Resources\SpecificObjectiveResource\RelationManagers;
use App\Models\SpecificObjective;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class SpecificObjectiveResource extends Resource
{
    protected static ?string $model = SpecificObjective::class;

    protected static ?string $navigationIcon = 'heroicon-o-flag';
    protected static ?string $navigationGroup = 'Sección de Captura de Proyectos';
    protected static ?string $navigationLabel = 'Objetivos Específicos';
    protected static ?string $modelLabel = 'Objetivo Específico';
    protected static ?string $pluralModelLabel = 'Objetivos Específicos';
    protected static ?string $slug = 'objetivos-especificos';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del Objetivo Específico')
                    ->description('Datos básicos del objetivo específico')
                    ->icon('heroicon-o-flag')
                    ->schema([
                        Forms\Components\Textarea::make('description')
                            ->label('Descripción del Objetivo')
                            ->required()
                            ->maxLength(500),
                        Forms\Components\Select::make('projects_id')
                            ->label('Proyecto')
                            ->relationship('projects', 'name')
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->required(),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('description')->label('Descripción'),
                Tables\Columns\TextColumn::make('projects_id')->label('Proyecto'),
                Tables\Columns\TextColumn::make('created_at')->label('Creado'),
                Tables\Columns\TextColumn::make('updated_at')->label('Actualizado'),
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
            'index' => Pages\ListSpecificObjectives::route('/'),
            'create' => Pages\CreateSpecificObjective::route('/create'),
            'edit' => Pages\EditSpecificObjective::route('/{record}/edit'),
        ];
    }
}

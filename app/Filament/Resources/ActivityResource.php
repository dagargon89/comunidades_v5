<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ActivityResource\Pages;
use App\Filament\Resources\ActivityResource\RelationManagers;
use App\Models\Activity;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ActivityResource extends Resource
{
    protected static ?string $model = Activity::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';
    protected static ?string $navigationGroup = 'Sección de Captura de Proyectos';
    protected static ?string $navigationLabel = 'Actividades';
    protected static ?string $modelLabel = 'Actividad';
    protected static ?string $pluralModelLabel = 'Actividades';
    protected static ?string $slug = 'actividades';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la Actividad')
                    ->description('Datos básicos de la actividad')
                    ->icon('heroicon-o-clipboard-document-list')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre de la Actividad')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('Ingrese el nombre de la actividad'),
                        Forms\Components\Select::make('specific_objective_id')
                            ->label('Objetivo Específico')
                            ->relationship('specificObjective', 'description')
                            ->required(),
                        Forms\Components\Textarea::make('description')
                            ->label('Descripción de la Actividad')
                            ->required()
                            ->maxLength(500),
                        Forms\Components\Select::make('goals_id')
                            ->label('Meta')
                            ->relationship('goals', 'description')
                            ->required(),
                        Forms\Components\Select::make('created_by')
                            ->label('Creado por')
                            ->relationship('createdBy', 'name')
                            ->required(),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Nombre')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('description')->label('Descripción'),
                Tables\Columns\TextColumn::make('specific_objective_id')->label('Objetivo Específico'),
                Tables\Columns\TextColumn::make('goals_id')->label('Meta'),
                Tables\Columns\TextColumn::make('created_by')->label('Creado por'),
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
            'index' => Pages\ListActivities::route('/'),
            'create' => Pages\CreateActivity::route('/create'),
            'edit' => Pages\EditActivity::route('/{record}/edit'),
        ];
    }
}

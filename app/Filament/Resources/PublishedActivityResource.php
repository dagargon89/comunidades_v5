<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PublishedActivityResource\Pages;
use App\Models\PublishedActivity;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;

class PublishedActivityResource extends Resource
{
    protected static ?string $model = PublishedActivity::class;
    protected static ?string $navigationIcon = 'heroicon-o-archive-box';
    protected static ?string $navigationGroup = 'Datos publicados';
    protected static ?string $navigationLabel = 'Actividades publicadas';
    protected static ?string $modelLabel = 'Actividad publicada';
    protected static ?string $pluralModelLabel = 'Actividades publicadas';
    protected static ?string $slug = 'actividades-publicadas';

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la actividad publicada')
                    ->schema([
                        Forms\Components\TextInput::make('name')->label('Nombre')->maxLength(255),
                        Forms\Components\TextInput::make('description')->label('Descripción'),
                    ])
            ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')->label('ID')->sortable(),
                Tables\Columns\TextColumn::make('name')->label('Nombre'),
                Tables\Columns\TextColumn::make('specificObjective.description')->label('Objetivo específico'),
                Tables\Columns\TextColumn::make('goal.description')->label('Meta'),
            ])
            ->filters([
                // Puedes agregar filtros aquí
            ]);
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

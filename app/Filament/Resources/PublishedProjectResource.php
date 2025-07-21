<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PublishedProjectResource\Pages;
use App\Filament\Resources\PublishedProjectResource\RelationManagers;
use App\Models\PublishedProject;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class PublishedProjectResource extends Resource
{
    protected static ?string $model = PublishedProject::class;
    protected static ?string $navigationIcon = 'heroicon-o-archive-box';
    protected static ?string $navigationGroup = 'Datos publicados';
    protected static ?string $navigationLabel = 'Proyectos publicados';
    protected static ?string $modelLabel = 'Proyecto publicado';
    protected static ?string $pluralModelLabel = 'Proyectos publicados';
    protected static ?string $slug = 'proyectos-publicados';

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del proyecto publicado')
                    ->schema([
                        Forms\Components\TextInput::make('name')->label('Nombre')->maxLength(500),
                        Forms\Components\TextInput::make('background')->label('Antecedentes'),
                        Forms\Components\TextInput::make('justification')->label('Justificación'),
                        Forms\Components\TextInput::make('general_objective')->label('Objetivo general'),
                        Forms\Components\DatePicker::make('start_date')->label('Fecha inicio'),
                        Forms\Components\DatePicker::make('end_date')->label('Fecha fin'),
                        Forms\Components\TextInput::make('total_cost')->label('Costo total')->numeric(),
                        Forms\Components\TextInput::make('funded_amount')->label('Monto financiado')->numeric(),
                        Forms\Components\TextInput::make('cofunding_amount')->label('Monto cofinanciado')->numeric(),
                    ])
            ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')->label('ID')->sortable(),
                Tables\Columns\TextColumn::make('name')->label('Nombre'),
                Tables\Columns\TextColumn::make('start_date')->label('Fecha inicio')->date(),
                Tables\Columns\TextColumn::make('end_date')->label('Fecha fin')->date(),
                Tables\Columns\TextColumn::make('financier.name')->label('Financiador'),
                Tables\Columns\TextColumn::make('total_cost')->label('Costo total'),
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
            'index' => Pages\ListPublishedProjects::route('/'),
            'create' => Pages\CreatePublishedProject::route('/create'),
            'edit' => Pages\EditPublishedProject::route('/{record}/edit'),
        ];
    }
}

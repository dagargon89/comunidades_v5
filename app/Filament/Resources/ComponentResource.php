<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ComponentResource\Pages;
use App\Filament\Resources\ComponentResource\RelationManagers;
use App\Models\Component;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ComponentResource extends Resource
{
    protected static ?string $model = Component::class;

    protected static ?string $navigationIcon = 'heroicon-o-cube';
    protected static ?string $navigationGroup = 'Sección de Planeación Estratégica';
    protected static ?string $navigationLabel = 'Componentes';
    protected static ?string $modelLabel = 'Componente';
    protected static ?string $pluralModelLabel = 'Componentes';
    protected static ?string $slug = 'componentes';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del Componente')
                    ->description('Datos básicos del componente')
                    ->icon('heroicon-o-cube')
                    ->schema([
                        Forms\Components\Select::make('action_lines_id')
                            ->label('Línea de Acción')
                            ->relationship('actionLines', 'name')
                            ->required(),
                        Forms\Components\Select::make('action_lines_program_id')
                            ->label('Programa')
                            ->relationship('actionLinesProgram', 'name')
                            ->required(),
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre del Componente')
                            ->required()
                            ->maxLength(255),
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
                Tables\Columns\TextColumn::make('actionLines.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('actionLinesProgram.name')
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
            'index' => Pages\ListComponents::route('/'),
            'create' => Pages\CreateComponent::route('/create'),
            'edit' => Pages\EditComponent::route('/{record}/edit'),
        ];
    }
}

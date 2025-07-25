<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ActionLineResource\Pages;
use App\Filament\Resources\ActionLineResource\RelationManagers;
use App\Models\ActionLine;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ActionLineResource extends Resource
{
    protected static ?string $model = ActionLine::class;

    protected static ?string $navigationIcon = 'heroicon-o-bars-3-bottom-left';
    protected static ?string $navigationGroup = 'Sección de Planeación Estratégica';
    protected static ?string $navigationLabel = 'Líneas de Acción';
    protected static ?string $modelLabel = 'Línea de Acción';
    protected static ?string $pluralModelLabel = 'Líneas de Acción';
    protected static ?string $slug = 'lineas-accion';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la Línea de Acción')
                    ->description('Datos básicos de la línea de acción')
                    ->icon('heroicon-o-bars-3-bottom-left')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre de la Línea de Acción')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Select::make('program_id')
                            ->label('Programa')
                            ->relationship('program', 'name')
                            ->native(false)
                            ->required()
                            ->searchable()
                            ->preload(),
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
                Tables\Columns\TextColumn::make('program.name')
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
            'index' => Pages\ListActionLines::route('/'),
            'create' => Pages\CreateActionLine::route('/create'),
            'edit' => Pages\EditActionLine::route('/{record}/edit'),
        ];
    }
}

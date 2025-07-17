<?php

namespace App\Filament\Resources;

use App\Filament\Resources\AxeResource\Pages;
use App\Filament\Resources\AxeResource\RelationManagers;
use App\Models\Axe;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class AxeResource extends Resource
{
    protected static ?string $model = Axe::class;

    protected static ?string $navigationIcon = 'heroicon-o-adjustments-horizontal';
    protected static ?string $navigationGroup = 'Sección de Planeación Estratégica';
    protected static ?string $navigationLabel = 'Ejes';
    protected static ?string $modelLabel = 'Eje';
    protected static ?string $pluralModelLabel = 'Ejes';
    protected static ?string $slug = 'ejes';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del Eje')
                    ->description('Datos básicos del eje')
                    ->icon('heroicon-o-adjustments-horizontal')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre del Eje')
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
            'index' => Pages\ListAxes::route('/'),
            'create' => Pages\CreateAxe::route('/create'),
            'edit' => Pages\EditAxe::route('/{record}/edit'),
        ];
    }
}

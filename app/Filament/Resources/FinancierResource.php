<?php

namespace App\Filament\Resources;

use App\Filament\Resources\FinancierResource\Pages;
use App\Filament\Resources\FinancierResource\RelationManagers;
use App\Models\Financier;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class FinancierResource extends Resource
{
    protected static ?string $model = Financier::class;

    protected static ?string $navigationIcon = 'heroicon-o-banknotes';

    protected static ?string $navigationGroup = 'Sección Técnica';

    protected static ?string $navigationLabel = 'Financiadores';

    protected static ?string $modelLabel = 'Financiador';

    protected static ?string $pluralModelLabel = 'Financiadores';

    protected static ?string $slug = 'financiadores';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del Financiador')
                    ->description('Datos básicos del financiador o entidad financiera')
                    ->icon('heroicon-o-building-office')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre del Financiador')
                            ->required()
                            ->maxLength(500)
                            ->placeholder('Ej: Banco Mundial, BID, Gobierno Nacional'),
                    ])
                    ->columns(1),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Financiador')
                    ->searchable()
                    ->sortable()
                    ->weight('bold'),
                Tables\Columns\TextColumn::make('projects_count')
                    ->label('Proyectos')
                    ->counts('projects')
                    ->sortable()
                    ->toggleable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Creado')
                    ->dateTime('d/m/Y H:i')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make()
                    ->icon('heroicon-o-pencil'),
                Tables\Actions\DeleteAction::make()
                    ->icon('heroicon-o-trash'),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
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
            'index' => Pages\ListFinanciers::route('/'),
            'create' => Pages\CreateFinancier::route('/create'),
            'edit' => Pages\EditFinancier::route('/{record}/edit'),
        ];
    }
}

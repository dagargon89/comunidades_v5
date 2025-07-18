<?php

namespace App\Filament\Resources;

use App\Filament\Resources\GoalResource\Pages;
use App\Filament\Resources\GoalResource\RelationManagers;
use App\Models\Goal;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class GoalResource extends Resource
{
    protected static ?string $model = Goal::class;

    protected static ?string $navigationIcon = 'heroicon-o-flag';
    protected static ?string $navigationGroup = 'Sección de Planeación Estratégica';
    protected static ?string $navigationLabel = 'Metas';
    protected static ?string $modelLabel = 'Meta';
    protected static ?string $pluralModelLabel = 'Metas';
    protected static ?string $slug = 'metas';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la Meta')
                    ->description('Datos básicos de la meta')
                    ->icon('heroicon-o-flag')
                    ->schema([
                        Forms\Components\Select::make('components_id')
                            ->label('Componente')
                            ->relationship('components', 'name')
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->required(),
                        Forms\Components\Select::make('components_action_lines_id')
                            ->label('Línea de Acción')
                            ->relationship('componentsActionLines', 'name')
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->required(),
                        Forms\Components\Select::make('components_action_lines_program_id')
                            ->label('Programa')
                            ->relationship('componentsActionLinesProgram', 'name')
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->required(),
                        Forms\Components\Select::make('organizations_id')
                            ->label('Organización')
                            ->relationship('organizations', 'name')
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->required(),
                        Forms\Components\TextInput::make('description')
                            ->label('Descripción de la Meta')
                            ->required()
                            ->maxLength(500),
                        Forms\Components\TextInput::make('number')
                            ->label('Número de Meta')
                            ->numeric()
                            ->required(),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('number')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('components.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('componentsActionLines.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('componentsActionLinesProgram.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('organizations.name')
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
            'index' => Pages\ListGoals::route('/'),
            'create' => Pages\CreateGoal::route('/create'),
            'edit' => Pages\EditGoal::route('/{record}/edit'),
        ];
    }
}

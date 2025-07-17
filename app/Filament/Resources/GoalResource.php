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
                Forms\Components\Textarea::make('description')
                    ->columnSpanFull(),
                Forms\Components\TextInput::make('number')
                    ->numeric(),
                Forms\Components\Select::make('components_id')
                    ->relationship('components', 'name')
                    ->required(),
                Forms\Components\Select::make('components_action_lines_id')
                    ->relationship('componentsActionLines', 'name')
                    ->required(),
                Forms\Components\Select::make('components_action_lines_program_id')
                    ->relationship('componentsActionLinesProgram', 'name')
                    ->required(),
                Forms\Components\Select::make('organizations_id')
                    ->relationship('organizations', 'name')
                    ->required(),
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

<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProjectResource\Pages;
use App\Filament\Resources\ProjectResource\RelationManagers;
use App\Models\Project;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ProjectResource extends Resource
{
    protected static ?string $model = Project::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->required()
                    ->maxLength(500),
                Forms\Components\Textarea::make('background')
                    ->columnSpanFull(),
                Forms\Components\Textarea::make('justification')
                    ->columnSpanFull(),
                Forms\Components\Textarea::make('general_objective')
                    ->columnSpanFull(),
                Forms\Components\Select::make('financiers_id')
                    ->relationship('financiers', 'name')
                    ->required(),
                Forms\Components\DatePicker::make('start_date'),
                Forms\Components\DatePicker::make('end_date'),
                Forms\Components\TextInput::make('total_cost')
                    ->numeric(),
                Forms\Components\TextInput::make('funded_amount')
                    ->numeric(),
                Forms\Components\TextInput::make('cofunding_amount')
                    ->numeric(),
                Forms\Components\TextInput::make('monthly_disbursement')
                    ->numeric(),
                Forms\Components\Textarea::make('followup_officer')
                    ->columnSpanFull(),
                Forms\Components\Textarea::make('agreement_file')
                    ->columnSpanFull(),
                Forms\Components\Textarea::make('project_base_file')
                    ->columnSpanFull(),
                Forms\Components\Select::make('co_financier_id')
                    ->relationship('coFinancier', 'name'),
                Forms\Components\TextInput::make('created_by')
                    ->required()
                    ->numeric(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('financiers.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_date')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('total_cost')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('funded_amount')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('cofunding_amount')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('monthly_disbursement')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('coFinancier.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_by')
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
            'index' => Pages\ListProjects::route('/'),
            'create' => Pages\CreateProject::route('/create'),
            'edit' => Pages\EditProject::route('/{record}/edit'),
        ];
    }
}

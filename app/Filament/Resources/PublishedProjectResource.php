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

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('publication_id')
                    ->relationship('publication', 'id')
                    ->required(),
                Forms\Components\Select::make('original_project_id')
                    ->relationship('originalProject', 'name')
                    ->required(),
                Forms\Components\TextInput::make('name')
                    ->required()
                    ->maxLength(500),
                Forms\Components\Textarea::make('background')
                    ->columnSpanFull(),
                Forms\Components\Textarea::make('justification')
                    ->columnSpanFull(),
                Forms\Components\Textarea::make('general_objective')
                    ->columnSpanFull(),
                Forms\Components\DatePicker::make('start_date'),
                Forms\Components\DatePicker::make('end_date'),
                Forms\Components\TextInput::make('total_cost')
                    ->numeric(),
                Forms\Components\TextInput::make('funded_amount')
                    ->numeric(),
                Forms\Components\TextInput::make('cofunding_amount')
                    ->numeric(),
                Forms\Components\TextInput::make('financiers_id')
                    ->required()
                    ->numeric(),
                Forms\Components\Select::make('co_financier_id')
                    ->relationship('coFinancier', 'name'),
                Forms\Components\TextInput::make('created_by')
                    ->required()
                    ->numeric(),
                Forms\Components\DateTimePicker::make('snapshot_date')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('publication.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('originalProject.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
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
                Tables\Columns\TextColumn::make('financiers_id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('coFinancier.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_by')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('snapshot_date')
                    ->dateTime()
                    ->sortable(),
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
            'index' => Pages\ListPublishedProjects::route('/'),
            'create' => Pages\CreatePublishedProject::route('/create'),
            'edit' => Pages\EditPublishedProject::route('/{record}/edit'),
        ];
    }
}

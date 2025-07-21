<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DataPublicationResource\Pages;
use App\Filament\Resources\DataPublicationResource\RelationManagers;
use App\Models\DataPublication;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class DataPublicationResource extends Resource
{
    protected static ?string $model = DataPublication::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\DateTimePicker::make('publication_date')
                    ->required(),
                Forms\Components\TextInput::make('published_by')
                    ->required()
                    ->numeric(),
                Forms\Components\Textarea::make('publication_notes')
                    ->columnSpanFull(),
                Forms\Components\TextInput::make('metrics_count')
                    ->required()
                    ->numeric()
                    ->default(0),
                Forms\Components\TextInput::make('projects_count')
                    ->required()
                    ->numeric()
                    ->default(0),
                Forms\Components\TextInput::make('activities_count')
                    ->required()
                    ->numeric()
                    ->default(0),
                Forms\Components\DatePicker::make('period_from'),
                Forms\Components\DatePicker::make('period_to'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('publication_date')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('published_by')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('metrics_count')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('projects_count')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('activities_count')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('period_from')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('period_to')
                    ->date()
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
            'index' => Pages\ListDataPublications::route('/'),
            'create' => Pages\CreateDataPublication::route('/create'),
            'edit' => Pages\EditDataPublication::route('/{record}/edit'),
        ];
    }
}

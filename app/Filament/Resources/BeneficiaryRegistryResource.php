<?php

namespace App\Filament\Resources;

use App\Filament\Resources\BeneficiaryRegistryResource\Pages;
use App\Filament\Resources\BeneficiaryRegistryResource\RelationManagers;
use App\Models\BeneficiaryRegistry;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class BeneficiaryRegistryResource extends Resource
{
    protected static ?string $model = BeneficiaryRegistry::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('activity_calendar_id')
                    ->relationship('activityCalendar', 'id')
                    ->required(),
                Forms\Components\Select::make('beneficiaries_id')
                    ->relationship('beneficiaries', 'id')
                    ->required(),
                Forms\Components\Select::make('data_collectors_id')
                    ->relationship('dataCollectors', 'name')
                    ->required(),
                Forms\Components\TextInput::make('created_by')
                    ->required()
                    ->numeric(),
                Forms\Components\TextInput::make('belongsTo')
                    ->required()
                    ->maxLength(255),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('activityCalendar.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('beneficiaries.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('dataCollectors.name')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_by')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('belongsTo')
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
            'index' => Pages\ListBeneficiaryRegistries::route('/'),
            'create' => Pages\CreateBeneficiaryRegistry::route('/create'),
            'edit' => Pages\EditBeneficiaryRegistry::route('/{record}/edit'),
        ];
    }
}

<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ActivityFileResource\Pages;
use App\Filament\Resources\ActivityFileResource\RelationManagers;
use App\Models\ActivityFile;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ActivityFileResource extends Resource
{
    protected static ?string $model = ActivityFile::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('month')
                    ->maxLength(20),
                Forms\Components\TextInput::make('type')
                    ->maxLength(100),
                Forms\Components\Textarea::make('file_path')
                    ->columnSpanFull(),
                Forms\Components\DateTimePicker::make('upload_date'),
                Forms\Components\Select::make('activity_progress_log_id')
                    ->relationship('activityProgressLog', 'id')
                    ->required(),
                Forms\Components\Select::make('activity_log_id')
                    ->relationship('activityLog', 'id')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('month')
                    ->searchable(),
                Tables\Columns\TextColumn::make('type')
                    ->searchable(),
                Tables\Columns\TextColumn::make('upload_date')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('activityProgressLog.id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('activityLog.id')
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
            'index' => Pages\ListActivityFiles::route('/'),
            'create' => Pages\CreateActivityFile::route('/create'),
            'edit' => Pages\EditActivityFile::route('/{record}/edit'),
        ];
    }
}

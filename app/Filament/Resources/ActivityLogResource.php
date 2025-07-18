<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ActivityLogResource\Pages;
use App\Filament\Resources\ActivityLogResource\RelationManagers;
use App\Models\ActivityLog;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ActivityLogResource extends Resource
{
    protected static ?string $model = ActivityLog::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Sección de captura de avances';
    protected static ?string $navigationLabel = 'Bitácoras de Actividad';
    protected static ?string $modelLabel = 'Bitácora de Actividad';
    protected static ?string $pluralModelLabel = 'Bitácoras de Actividad';
    protected static ?string $slug = 'bitacoras-actividad';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información general')
                    ->description('Datos principales de la bitácora')
                    ->icon('heroicon-o-document-text')
                    ->schema([
                        Forms\Components\Select::make('planned_metrics_id')
                            ->relationship('plannedMetrics', 'id')
                            ->label('Métrica planificada')
                            ->required()
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->placeholder('Seleccione la métrica planificada'),
                        Forms\Components\Select::make('created_by')
                            ->label('Usuario creador')
                            ->options(\App\Models\User::pluck('name', 'id'))
                            ->searchable()
                            ->native(false)
                            ->preload()
                            ->required()
                            ->placeholder('Seleccione el usuario creador'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('plannedMetrics.id')
                    ->label('Métrica planificada')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_by')
                    ->label('Usuario creador')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Creado')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->label('Actualizado')
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
            'index' => Pages\ListActivityLogs::route('/'),
            'create' => Pages\CreateActivityLog::route('/create'),
            'edit' => Pages\EditActivityLog::route('/{record}/edit'),
        ];
    }
}

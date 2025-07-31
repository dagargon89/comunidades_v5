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
    protected static ?string $navigationGroup = 'Sección de captura de avances';
    protected static ?string $navigationLabel = 'Archivos de Actividad';
    protected static ?string $modelLabel = 'Archivo de Actividad';
    protected static ?string $pluralModelLabel = 'Archivos de Actividad';
    protected static ?string $slug = 'archivos-actividad';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información general')
                    ->description('Datos principales del archivo')
                    ->icon('heroicon-o-document')
                    ->schema([
                        Forms\Components\TextInput::make('month')
                            ->label('Mes')
                            ->maxLength(20)
                            ->placeholder('Ej: Enero, Febrero'),
                        Forms\Components\TextInput::make('type')
                            ->label('Tipo de archivo')
                            ->maxLength(100)
                            ->placeholder('Ej: PDF, Imagen'),
                        Forms\Components\Textarea::make('file_path')
                            ->label('Ruta del archivo')
                            ->placeholder('Ruta o URL del archivo')
                            ->columnSpanFull(),
                        Forms\Components\DateTimePicker::make('upload_date')
                            ->label('Fecha de carga')
                            ->placeholder('Seleccione la fecha y hora de carga'),
                    ])
                    ->columns(2),
                Forms\Components\Section::make('Relaciones y control')
                    ->description('Relaciones con otras entidades y control')
                    ->icon('heroicon-o-link')
                    ->schema([

                        Forms\Components\Select::make('activity_log_id')
                            ->relationship('activityLog', 'id')
                            ->label('Bitácora de actividad')
                            ->required()
                            ->placeholder('Seleccione la bitácora de actividad'),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('month')
                    ->label('Mes')
                    ->searchable(),
                Tables\Columns\TextColumn::make('type')
                    ->label('Tipo de archivo')
                    ->searchable(),
                Tables\Columns\TextColumn::make('upload_date')
                    ->label('Fecha de carga')
                    ->dateTime()
                    ->sortable(),

                Tables\Columns\TextColumn::make('activityLog.id')
                    ->label('Bitácora de actividad')
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
            'index' => Pages\ListActivityFiles::route('/'),
            'create' => Pages\CreateActivityFile::route('/create'),
            'edit' => Pages\EditActivityFile::route('/{record}/edit'),
        ];
    }
}

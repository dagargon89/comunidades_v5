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
    protected static ?string $navigationIcon = 'heroicon-o-archive-box';
    protected static ?string $navigationGroup = 'Datos publicados';
    protected static ?string $navigationLabel = 'Publicaciones de datos';
    protected static ?string $modelLabel = 'Publicación de datos';
    protected static ?string $pluralModelLabel = 'Publicaciones de datos';
    protected static ?string $slug = 'publicaciones-datos';

    public static function form(Forms\Form $form): Forms\Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información de la publicación')
                    ->schema([
                        Forms\Components\TextInput::make('publication_notes')->label('Notas')->maxLength(255),
                        Forms\Components\DatePicker::make('publication_date')->label('Fecha de publicación'),
                        Forms\Components\TextInput::make('metrics_count')->label('Métricas')->numeric(),
                        Forms\Components\TextInput::make('projects_count')->label('Proyectos')->numeric(),
                        Forms\Components\TextInput::make('activities_count')->label('Actividades')->numeric(),
                    ])
            ]);
    }

    public static function table(Tables\Table $table): Tables\Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')->label('ID')->sortable(),
                Tables\Columns\TextColumn::make('publication_date')->label('Fecha de publicación')->dateTime(),
                Tables\Columns\TextColumn::make('publisher.name')->label('Publicado por'),
                Tables\Columns\TextColumn::make('metrics_count')->label('Métricas'),
                Tables\Columns\TextColumn::make('projects_count')->label('Proyectos'),
                Tables\Columns\TextColumn::make('activities_count')->label('Actividades'),
            ])
            ->filters([
                // Puedes agregar filtros aquí
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

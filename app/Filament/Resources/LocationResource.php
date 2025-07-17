<?php

namespace App\Filament\Resources;

use App\Filament\Resources\LocationResource\Pages;
use App\Filament\Resources\LocationResource\RelationManagers;
use App\Models\Location;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class LocationResource extends Resource
{
    protected static ?string $model = Location::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $navigationGroup = 'Sección de Calendarización';

    protected static ?string $navigationLabel = 'Ubicaciones';

    protected static ?string $modelLabel = 'Ubicación';

    protected static ?string $pluralModelLabel = 'Ubicaciones';

    protected static ?string $slug = 'ubicaciones';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información Básica')
                    ->description('Datos principales de la ubicación')
                    ->icon('heroicon-o-map-pin')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre de la ubicación')
                            ->required()
                            ->maxLength(150)
                            ->placeholder('Ingrese el nombre de la ubicación'),
                        Forms\Components\TextInput::make('category')
                            ->label('Categoría')
                            ->maxLength(50)
                            ->placeholder('Ej: Oficina, Taller, Almacén'),
                        Forms\Components\Select::make('polygons_id')
                            ->relationship('polygons', 'name')
                            ->label('Polígono')
                            ->required()
                            ->placeholder('Seleccione un polígono'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Dirección Detallada')
                    ->description('Información completa de la dirección')
                    ->icon('heroicon-o-home')
                    ->schema([
                        Forms\Components\Textarea::make('street')
                            ->label('Calle y dirección')
                            ->placeholder('Ingrese la dirección completa')
                            ->columnSpanFull(),
                        Forms\Components\TextInput::make('neighborhood')
                            ->label('Colonia')
                            ->maxLength(100)
                            ->placeholder('Nombre de la colonia'),
                        Forms\Components\TextInput::make('ext_number')
                            ->label('Número exterior')
                            ->numeric()
                            ->placeholder('Número exterior'),
                        Forms\Components\TextInput::make('int_number')
                            ->label('Número interior')
                            ->numeric()
                            ->placeholder('Número interior (opcional)'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Información Adicional')
                    ->description('Datos complementarios y control')
                    ->icon('heroicon-o-information-circle')
                    ->schema([
                        Forms\Components\TextInput::make('google_place_id')
                            ->label('ID de Google Places')
                            ->maxLength(500)
                            ->placeholder('ID de Google Places (opcional)'),
                        Forms\Components\Select::make('created_by')
                            ->label('Usuario creador')
                            ->options(\App\Models\User::pluck('name', 'id'))
                            ->searchable()
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
                Tables\Columns\TextColumn::make('name')
                    ->label('Nombre')
                    ->searchable(),
                Tables\Columns\TextColumn::make('category')
                    ->label('Categoría')
                    ->searchable(),
                Tables\Columns\TextColumn::make('neighborhood')
                    ->label('Colonia')
                    ->searchable(),
                Tables\Columns\TextColumn::make('ext_number')
                    ->label('Número exterior')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('int_number')
                    ->label('Número interior')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('google_place_id')
                    ->label('ID Google Places')
                    ->searchable(),
                Tables\Columns\TextColumn::make('polygons.name')
                    ->label('Polígono')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_by')
                    ->label('Creado por')
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
            'index' => Pages\ListLocations::route('/'),
            'create' => Pages\CreateLocation::route('/create'),
            'edit' => Pages\EditLocation::route('/{record}/edit'),
        ];
    }
}

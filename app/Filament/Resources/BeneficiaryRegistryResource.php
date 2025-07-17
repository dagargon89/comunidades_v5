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

    protected static ?string $navigationGroup = 'Sección de campo';
    protected static ?string $navigationLabel = 'Registros de Beneficiarios';
    protected static ?string $modelLabel = 'Registro de Beneficiario';
    protected static ?string $pluralModelLabel = 'Registros de Beneficiarios';
    protected static ?string $slug = 'registros-beneficiarios';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Datos de registro')
                    ->description('Información de registro de beneficiario en actividad')
                    ->icon('heroicon-o-clipboard-document')
                    ->schema([
                        Forms\Components\Select::make('activity_calendar_id')
                            ->relationship('activityCalendar', 'id')
                            ->label('Calendario de actividad')
                            ->required()
                            ->placeholder('Seleccione el calendario de actividad'),
                        Forms\Components\Select::make('beneficiaries_id')
                            ->relationship('beneficiaries', 'id')
                            ->label('Beneficiario')
                            ->required()
                            ->placeholder('Seleccione el beneficiario'),
                        Forms\Components\Select::make('data_collectors_id')
                            ->relationship('dataCollectors', 'name')
                            ->label('Colector de datos')
                            ->required()
                            ->placeholder('Seleccione el colector de datos'),
                    ])
                    ->columns(2),
                Forms\Components\Section::make('Control y auditoría')
                    ->description('Datos de control y usuario creador')
                    ->icon('heroicon-o-user')
                    ->schema([
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
                Tables\Columns\TextColumn::make('activityCalendar.id')
                    ->label('Calendario de actividad')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('beneficiaries.id')
                    ->label('Beneficiario')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('dataCollectors.name')
                    ->label('Colector de datos')
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
            'index' => Pages\ListBeneficiaryRegistries::route('/'),
            'create' => Pages\CreateBeneficiaryRegistry::route('/create'),
            'edit' => Pages\EditBeneficiaryRegistry::route('/{record}/edit'),
        ];
    }
}

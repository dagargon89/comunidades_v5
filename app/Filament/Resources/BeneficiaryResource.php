<?php

namespace App\Filament\Resources;

use App\Filament\Resources\BeneficiaryResource\Pages;
use App\Filament\Resources\BeneficiaryResource\RelationManagers;
use App\Models\Beneficiary;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class BeneficiaryResource extends Resource
{
    protected static ?string $model = Beneficiary::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $navigationGroup = 'Sección de campo';
    protected static ?string $navigationLabel = 'Beneficiarios';
    protected static ?string $modelLabel = 'Beneficiario';
    protected static ?string $pluralModelLabel = 'Beneficiarios';
    protected static ?string $slug = 'beneficiarios';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Datos personales')
                    ->description('Información básica del beneficiario')
                    ->icon('heroicon-o-user')
                    ->schema([
                        Forms\Components\TextInput::make('last_name')
                            ->label('Apellido paterno')
                            ->maxLength(100)
                            ->placeholder('Ingrese el apellido paterno'),
                        Forms\Components\TextInput::make('mother_last_name')
                            ->label('Apellido materno')
                            ->maxLength(100)
                            ->placeholder('Ingrese el apellido materno'),
                        Forms\Components\TextInput::make('first_names')
                            ->label('Nombres')
                            ->maxLength(100)
                            ->placeholder('Ingrese los nombres'),
                        Forms\Components\TextInput::make('birth_year')
                            ->label('Año de nacimiento')
                            ->maxLength(4)
                            ->placeholder('Ej: 1990'),
                        Forms\Components\TextInput::make('gender')
                            ->label('Género')
                            ->placeholder('Masculino/Femenino'),
                        Forms\Components\TextInput::make('phone')
                            ->label('Teléfono')
                            ->tel()
                            ->maxLength(20)
                            ->placeholder('Ingrese el teléfono'),
                    ])
                    ->columns(2),
                Forms\Components\Section::make('Información de registro')
                    ->description('Datos de registro y control')
                    ->icon('heroicon-o-clipboard-document')
                    ->schema([
                        Forms\Components\Textarea::make('signature')
                            ->label('Firma')
                            ->placeholder('Firma digital o imagen')
                            ->columnSpanFull(),
                        Forms\Components\Textarea::make('address_backup')
                            ->label('Dirección de respaldo')
                            ->placeholder('Dirección completa')
                            ->columnSpanFull(),
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
                Tables\Columns\TextColumn::make('last_name')
                    ->label('Apellido paterno')
                    ->searchable(),
                Tables\Columns\TextColumn::make('mother_last_name')
                    ->label('Apellido materno')
                    ->searchable(),
                Tables\Columns\TextColumn::make('first_names')
                    ->label('Nombres')
                    ->searchable(),
                Tables\Columns\TextColumn::make('birth_year')
                    ->label('Año de nacimiento')
                    ->searchable(),
                Tables\Columns\TextColumn::make('gender')
                    ->label('Género'),
                Tables\Columns\TextColumn::make('phone')
                    ->label('Teléfono')
                    ->searchable(),
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
            'index' => Pages\ListBeneficiaries::route('/'),
            'create' => Pages\CreateBeneficiary::route('/create'),
            'edit' => Pages\EditBeneficiary::route('/{record}/edit'),
        ];
    }
}

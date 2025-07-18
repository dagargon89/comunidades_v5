<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Filament\Resources\UserResource\RelationManagers;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class UserResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    protected static ?string $navigationGroup = 'Sección Técnica';

    protected static ?string $navigationLabel = 'Usuarios';

    protected static ?string $modelLabel = 'Usuario';

    protected static ?string $pluralModelLabel = 'Usuarios';

    protected static ?string $slug = 'usuarios';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información Personal')
                    ->description('Datos básicos del usuario')
                    ->icon('heroicon-o-user')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('Ingrese el nombre completo'),
                        Forms\Components\TextInput::make('email')
                            ->label('Correo Electrónico')
                            ->email()
                            ->required()
                            ->maxLength(255)
                            ->unique(ignoreRecord: true)
                            ->placeholder('usuario@ejemplo.com'),
                        Forms\Components\TextInput::make('password')
                            ->label('Contraseña')
                            ->password()
                            ->required(fn(string $context): bool => $context === 'create')
                            ->minLength(8)
                            ->maxLength(255)
                            ->placeholder('Mínimo 8 caracteres'),
                        Forms\Components\DateTimePicker::make('email_verified_at')
                            ->label('Email Verificado')
                            ->nullable(),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Información de Contacto')
                    ->description('Datos de contacto y comunicación')
                    ->icon('heroicon-o-phone')
                    ->schema([
                        Forms\Components\TextInput::make('phone')
                            ->label('Teléfono')
                            ->tel()
                            ->maxLength(45)
                            ->placeholder('+1234567890'),
                        Forms\Components\Select::make('point_of_contact_id')
                            ->label('Punto de Contacto')
                            ->relationship('pointOfContact', 'name')
                            ->searchable()
                            ->preload()
                            ->placeholder('Seleccione un supervisor')
                            ->helperText('Usuario responsable de este empleado'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Información Organizacional')
                    ->description('Datos relacionados con la organización')
                    ->icon('heroicon-o-building-office')
                    ->schema([
                        Forms\Components\Select::make('organizations_id')
                            ->label('Organización')
                            ->relationship('organization', 'name')
                            ->required()
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->placeholder('Seleccione una organización'),
                        Forms\Components\TextInput::make('org_role')
                            ->label('Rol en la Organización')
                            ->maxLength(45)
                            ->placeholder('Ej: Gerente, Supervisor, Empleado'),
                        Forms\Components\TextInput::make('org_area')
                            ->label('Área Organizacional')
                            ->maxLength(100)
                            ->placeholder('Ej: Recursos Humanos, IT, Ventas'),
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
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('email')
                    ->label('Email')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('phone')
                    ->label('Teléfono')
                    ->searchable()
                    ->toggleable(),
                Tables\Columns\TextColumn::make('pointOfContact.name')
                    ->label('Supervisor')
                    ->sortable()
                    ->toggleable(),
                Tables\Columns\TextColumn::make('organization.name')
                    ->label('Organización')
                    ->sortable()
                    ->toggleable(),
                Tables\Columns\TextColumn::make('org_role')
                    ->label('Rol')
                    ->searchable()
                    ->toggleable(),
                Tables\Columns\TextColumn::make('system_role')
                    ->label('Rol Sistema')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'admin' => 'danger',
                        'manager' => 'warning',
                        'user' => 'success',
                        'viewer' => 'info',
                        default => 'gray',
                    })
                    ->toggleable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Creado')
                    ->dateTime('d/m/Y H:i')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('system_role')
                    ->label('Rol del Sistema')
                    ->options([
                        'admin' => 'Administrador',
                        'manager' => 'Gerente',
                        'user' => 'Usuario',
                        'viewer' => 'Solo Lectura',
                    ]),
                Tables\Filters\SelectFilter::make('organizations_id')
                    ->label('Organización')
                    ->relationship('organization', 'name'),
            ])
            ->actions([
                Tables\Actions\EditAction::make()
                    ->icon('heroicon-o-pencil'),
                Tables\Actions\DeleteAction::make()
                    ->icon('heroicon-o-trash'),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
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
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}

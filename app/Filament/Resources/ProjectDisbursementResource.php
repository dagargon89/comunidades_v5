<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProjectDisbursementResource\Pages;
use App\Filament\Resources\ProjectDisbursementResource\RelationManagers;
use App\Models\ProjectDisbursement;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ProjectDisbursementResource extends Resource
{
    protected static ?string $model = ProjectDisbursement::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Eventos posteriores';
    protected static ?string $navigationLabel = 'Desembolsos de Proyectos';
    protected static ?string $modelLabel = 'Desembolso de Proyecto';
    protected static ?string $pluralModelLabel = 'Desembolsos de Proyectos';
    protected static ?string $slug = 'desembolsos-proyectos';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del desembolso')
                    ->description('Datos principales del desembolso')
                    ->icon('heroicon-o-currency-dollar')
                    ->schema([
                        Forms\Components\Select::make('projects_id')
                            ->relationship('projects', 'name')
                            ->label('Proyecto')
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->required()
                            ->placeholder('Seleccione el proyecto'),
                        Forms\Components\TextInput::make('amount')
                            ->label('Monto')
                            ->numeric()
                            ->placeholder('Ingrese el monto del desembolso'),
                        Forms\Components\DatePicker::make('disbursement_date')
                            ->label('Fecha de desembolso')
                            ->placeholder('Seleccione la fecha de desembolso'),
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
                Tables\Columns\TextColumn::make('projects.name')
                    ->label('Proyecto')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('amount')
                    ->label('Monto')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('disbursement_date')
                    ->label('Fecha de desembolso')
                    ->date()
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
            'index' => Pages\ListProjectDisbursements::route('/'),
            'create' => Pages\CreateProjectDisbursement::route('/create'),
            'edit' => Pages\EditProjectDisbursement::route('/{record}/edit'),
        ];
    }
}

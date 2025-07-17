<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProjectResource\Pages;
use App\Filament\Resources\ProjectResource\RelationManagers;
use App\Models\Project;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ProjectResource extends Resource
{
    protected static ?string $model = Project::class;

    protected static ?string $navigationIcon = 'heroicon-o-folder';
    protected static ?string $navigationGroup = 'Sección de Captura de Proyectos';
    protected static ?string $navigationLabel = 'Proyectos';
    protected static ?string $modelLabel = 'Proyecto';
    protected static ?string $pluralModelLabel = 'Proyectos';
    protected static ?string $slug = 'proyectos';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del Proyecto')
                    ->description('Datos básicos del proyecto')
                    ->icon('heroicon-o-folder')
                    ->schema([
                        Forms\Components\TextInput::make('name')
                            ->label('Nombre del Proyecto')
                            ->required()
                            ->maxLength(500),
                        Forms\Components\Select::make('financiers_id')
                            ->label('Financiador')
                            ->relationship('financiers', 'name')
                            ->required(),
                        Forms\Components\DatePicker::make('start_date')
                            ->label('Fecha de Inicio'),
                        Forms\Components\DatePicker::make('end_date')
                            ->label('Fecha de Fin'),
                        Forms\Components\TextInput::make('total_cost')
                            ->label('Costo Total')
                            ->numeric(),
                        Forms\Components\TextInput::make('funded_amount')
                            ->label('Monto Financiado')
                            ->numeric(),
                        Forms\Components\TextInput::make('cofunding_amount')
                            ->label('Monto de Cofinanciación')
                            ->numeric(),
                        Forms\Components\TextInput::make('monthly_disbursement')
                            ->label('Desembolso Mensual')
                            ->numeric(),
                        Forms\Components\Select::make('co_financier_id')
                            ->label('Cofinanciador')
                            ->relationship('coFinancier', 'name'),
                        Forms\Components\Select::make('created_by')
                            ->label('Creado por')
                            ->relationship('createdBy', 'name', fn ($query) => $query->select('id', 'name'))
                            ->required(),
                    ])
                    ->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')->label('Nombre del Proyecto'),
                Tables\Columns\TextColumn::make('financiers_id')->label('Financiador'),
                Tables\Columns\TextColumn::make('start_date')->label('Fecha de Inicio'),
                Tables\Columns\TextColumn::make('end_date')->label('Fecha de Fin'),
                Tables\Columns\TextColumn::make('created_at')->label('Creado'),
                Tables\Columns\TextColumn::make('updated_at')->label('Actualizado'),
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
            'index' => Pages\ListProjects::route('/'),
            'create' => Pages\CreateProject::route('/create'),
            'edit' => Pages\EditProject::route('/{record}/edit'),
        ];
    }
}

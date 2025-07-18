<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ProjectReportResource\Pages;
use App\Filament\Resources\ProjectReportResource\RelationManagers;
use App\Models\ProjectReport;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class ProjectReportResource extends Resource
{
    protected static ?string $model = ProjectReport::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Eventos posteriores';
    protected static ?string $navigationLabel = 'Reportes de Proyectos';
    protected static ?string $modelLabel = 'Reporte de Proyecto';
    protected static ?string $pluralModelLabel = 'Reportes de Proyectos';
    protected static ?string $slug = 'reportes-proyectos';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Información del reporte')
                    ->description('Datos principales del reporte')
                    ->icon('heroicon-o-document-text')
                    ->schema([
                        Forms\Components\Select::make('projects_id')
                            ->relationship('projects', 'name')
                            ->label('Proyecto')
                            ->required()
                            ->searchable()
                            ->preload()
                            ->native(false)
                            ->placeholder('Seleccione el proyecto'),
                        Forms\Components\DatePicker::make('report_date')
                            ->label('Fecha del reporte')
                            ->placeholder('Seleccione la fecha del reporte'),
                        Forms\Components\Textarea::make('report_file')
                            ->label('Archivo del reporte')
                            ->placeholder('Ruta o contenido del archivo del reporte')
                            ->columnSpanFull(),
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
                Tables\Columns\TextColumn::make('report_date')
                    ->label('Fecha del reporte')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('projects.name')
                    ->label('Proyecto')
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
            'index' => Pages\ListProjectReports::route('/'),
            'create' => Pages\CreateProjectReport::route('/create'),
            'edit' => Pages\EditProjectReport::route('/{record}/edit'),
        ];
    }
}

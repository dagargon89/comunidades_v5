<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Actions\EditAction;
use Filament\Tables\Actions\DeleteAction;
use App\Models\Project;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;

class ProjectManagement extends Page implements Tables\Contracts\HasTable
{
    protected static ?string $navigationIcon = 'heroicon-o-folder-open';
    protected static ?string $navigationLabel = 'Gestión de Proyectos';
    protected static ?string $title = 'Gestión de Proyectos';
    protected static ?string $slug = 'gestion-proyectos';
    protected static string $view = 'filament.pages.project-management';

    use Tables\Concerns\InteractsWithTable;

    public function table(Table $table): Table
    {
        return $table
            ->query(Project::query())
            ->columns([
                Tables\Columns\TextColumn::make('name')->label('Nombre')->searchable(),
                Tables\Columns\TextColumn::make('financiers.name')->label('Financiadora')->searchable(),
                Tables\Columns\TextColumn::make('start_date')->label('Inicio')->date('d/m/Y'),
                Tables\Columns\TextColumn::make('end_date')->label('Fin')->date('d/m/Y'),
                Tables\Columns\TextColumn::make('created_at')->label('Creado')->dateTime('d/m/Y H:i'),
            ])
            ->actions([
                EditAction::make()
                    ->label('Editar')
                    ->form([
                        TextInput::make('name')->label('Nombre')->required(),
                        Select::make('financiers_id')
                            ->label('Financiadora')
                            ->options(\App\Models\Financier::pluck('name', 'id'))
                            ->searchable()
                            ->required(),
                        DatePicker::make('start_date')->label('Inicio')->required(),
                        DatePicker::make('end_date')->label('Fin')->required(),
                    ]),
                DeleteAction::make()
                    ->label('Eliminar')
                    ->requiresConfirmation()
                    ->modalHeading('¿Eliminar proyecto?')
                    ->modalDescription('Esta acción eliminará el proyecto y toda su información relacionada. ¿Estás seguro?')
                    ->modalSubmitActionLabel('Sí, eliminar')
                    ->modalCancelActionLabel('Cancelar')
                    ->action(function (Project $record) {
                        // Eliminar en cascada la información relacionada
                        $record->specificObjectives()->delete();
                        $record->kpis()->delete();
                        $record->goals()->each(function($goal) {
                            $goal->activities()->delete();
                            $goal->delete();
                        });
                        $record->delete();
                    }),
            ])
            ->defaultSort('created_at', 'desc');
    }
}

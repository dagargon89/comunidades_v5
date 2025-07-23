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
use BezhanSalleh\FilamentShield\Traits\HasPageShield;

class ProjectManagement extends Page implements Tables\Contracts\HasTable
{
    protected static ?string $navigationIcon = 'heroicon-o-folder-open';
    protected static ?string $navigationLabel = 'Gestión de Proyectos';
    protected static ?string $title = 'Gestión de Proyectos';
    protected static ?string $slug = 'gestion-proyectos';
    protected static string $view = 'filament.pages.project-management';

    use Tables\Concerns\InteractsWithTable;
    use HasPageShield;

    public function table(Table $table): Table
    {
        return $table
            ->headerActions([
                Tables\Actions\Action::make('create')
                    ->label('Crear proyecto')
                    ->icon('heroicon-o-plus')
                    ->url(fn() => route('filament.admin.pages.asistente-proyectos')),
            ])
            ->query(Project::query())
            ->columns([
                Tables\Columns\TextColumn::make('name')->label('Nombre')->searchable(),
                Tables\Columns\TextColumn::make('financiers.name')->label('Financiadora')->searchable(),
                Tables\Columns\TextColumn::make('start_date')->label('Inicio')->date('d/m/Y'),
                Tables\Columns\TextColumn::make('end_date')->label('Fin')->date('d/m/Y'),
                Tables\Columns\TextColumn::make('created_at')->label('Creado')->dateTime('d/m/Y H:i'),
            ])
            ->actions([
                Tables\Actions\Action::make('edit')
                    ->label('Editar')
                    ->icon('heroicon-o-pencil-square')
                    ->url(fn(Project $record) => url('/admin/asistente-proyectos?edit=' . $record->id)),
                DeleteAction::make()
                    ->label('Eliminar')
                    ->requiresConfirmation()
                    ->modalHeading('¿Eliminar proyecto?')
                    ->modalDescription('Esta acción eliminará el proyecto y toda su información relacionada. ¿Estás seguro?')
                    ->modalSubmitActionLabel('Sí, eliminar')
                    ->modalCancelActionLabel('Cancelar')
                    ->action(function (Project $record) {
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

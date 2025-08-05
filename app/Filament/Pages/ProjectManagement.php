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
use App\Filament\Widgets\ProjectCount;

class ProjectManagement extends Page implements Tables\Contracts\HasTable
{
    protected static ?string $navigationIcon = 'heroicon-o-folder-open';
    protected static ?string $navigationLabel = 'Gestión de Proyectos';
    protected static ?string $title = 'Gestión de Proyectos';
    protected static ?string $slug = 'gestion-proyectos';
    protected static string $view = 'filament.pages.project-management';

    use Tables\Concerns\InteractsWithTable;
    use HasPageShield;

    protected function getHeaderWidgets(): array
    {
        return [
            ProjectCount::class,
        ];
    }

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
            ->recordUrl(fn(Project $record) => url('/admin/asistente-proyectos?edit=' . $record->id))
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Nombre')
                    ->searchable()
                    ->sortable()
                    ->limit(50)
                    ->tooltip(fn (Project $record) => $record->name),
                Tables\Columns\TextColumn::make('financiers.name')
                    ->label('Financiadora')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_date')
                    ->label('Inicio')
                    ->date('d/m/Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->label('Fin')
                    ->date('d/m/Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Creado')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('financier')
                    ->label('Financiadora')
                    ->relationship('financiers', 'name')
                    ->searchable()
                    ->preload(),
                Tables\Filters\Filter::make('name')
                    ->label('Nombre del proyecto')
                    ->form([
                        TextInput::make('name')
                            ->label('Buscar por nombre')
                            ->placeholder('Escriba el nombre del proyecto...')
                    ])
                    ->query(function ($query, array $data) {
                        return $query
                            ->when(
                                $data['name'],
                                fn ($query, $name) => $query->where('name', 'like', "%{$name}%")
                            );
                    })
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
                        // Eliminar en orden correcto respetando las restricciones de clave foránea
                        $record->goals()->each(function($goal) {
                            $goal->activities()->each(function($activity) {
                                // 1. Eliminar activity_logs relacionados con planned_metrics
                                \App\Models\ActivityLog::whereIn('planned_metrics_id', $activity->plannedMetrics()->pluck('id'))->delete();

                                // 2. Eliminar published_metrics relacionados con planned_metrics
                                \App\Models\PublishedMetric::whereIn('original_metric_id', $activity->plannedMetrics()->pluck('id'))->delete();

                                // 3. Eliminar planned_metrics de la actividad
                                $activity->plannedMetrics()->delete();

                                // 4. Eliminar activity_files relacionados con activity_calendars
                                \App\Models\ActivityFile::whereIn('activity_calendar_id', $activity->activityCalendars()->pluck('id'))->delete();

                                // 5. Eliminar beneficiary_registries relacionados con activity_calendars
                                \App\Models\BeneficiaryRegistry::whereIn('activity_calendar_id', $activity->activityCalendars()->pluck('id'))->delete();

                                // 6. Eliminar activity_calendars
                                $activity->activityCalendars()->delete();

                                // 7. Eliminar la actividad
                                $activity->delete();
                            });
                            $goal->delete();
                        });

                        // 8. Eliminar specific_objectives
                        $record->specificObjectives()->delete();

                        // 9. Eliminar kpis
                        $record->kpis()->delete();

                        // 10. Eliminar el proyecto
                        $record->delete();
                    }),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make()
                        ->label('Eliminar seleccionados')
                        ->requiresConfirmation()
                        ->modalHeading('¿Eliminar proyectos seleccionados?')
                        ->modalDescription('Esta acción eliminará todos los proyectos seleccionados y toda su información relacionada. Esta acción no se puede deshacer.')
                        ->modalSubmitActionLabel('Sí, eliminar todos')
                        ->modalCancelActionLabel('Cancelar')
                        ->action(function ($records) {
                            foreach ($records as $record) {
                                // Eliminar en orden correcto respetando las restricciones de clave foránea
                                $record->goals()->each(function($goal) {
                                    $goal->activities()->each(function($activity) {
                                        // 1. Eliminar activity_logs relacionados con planned_metrics
                                        \App\Models\ActivityLog::whereIn('planned_metrics_id', $activity->plannedMetrics()->pluck('id'))->delete();

                                        // 2. Eliminar published_metrics relacionados con planned_metrics
                                        \App\Models\PublishedMetric::whereIn('original_metric_id', $activity->plannedMetrics()->pluck('id'))->delete();

                                        // 3. Eliminar planned_metrics de la actividad
                                        $activity->plannedMetrics()->delete();

                                        // 4. Eliminar activity_files relacionados con activity_calendars
                                        \App\Models\ActivityFile::whereIn('activity_calendar_id', $activity->activityCalendars()->pluck('id'))->delete();

                                        // 5. Eliminar beneficiary_registries relacionados con activity_calendars
                                        \App\Models\BeneficiaryRegistry::whereIn('activity_calendar_id', $activity->activityCalendars()->pluck('id'))->delete();

                                        // 6. Eliminar activity_calendars
                                        $activity->activityCalendars()->delete();

                                        // 7. Eliminar la actividad
                                        $activity->delete();
                                    });
                                    $goal->delete();
                                });

                                // 8. Eliminar specific_objectives
                                $record->specificObjectives()->delete();

                                // 9. Eliminar kpis
                                $record->kpis()->delete();

                                // 10. Eliminar el proyecto
                                $record->delete();
                            }
                        })
                        ->deselectRecordsAfterCompletion(),
                ]),
            ])
            ->defaultSort('created_at', 'desc');
    }
}

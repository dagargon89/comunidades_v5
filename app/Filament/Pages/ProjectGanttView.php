<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Actions\Action as TableAction;
use App\Models\ActivityCalendar;
use App\Models\Project;
use App\Models\Activity;
use App\Models\User;
use Filament\Tables\Filters\SelectFilter;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker as FormDatePicker;
use Filament\Forms\Components\TextInput;

class ProjectGanttView extends Page implements Tables\Contracts\HasTable
{
    use Tables\Concerns\InteractsWithTable;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.project-gantt-view';

    public function table(Table $table): Table
    {
        return $table
            ->query(ActivityCalendar::query()->with(['activity.goal']))
            ->columns([
                Tables\Columns\TextColumn::make('activity.name')->label('Actividad')->searchable(),
                Tables\Columns\TextColumn::make('assigned_person')
                    ->label('Encargado')
                    ->formatStateUsing(fn($state) => User::find($state)?->name ?? '-')
                    ->searchable(),
                Tables\Columns\TextColumn::make('start_date')->label('Fecha de inicio')->date('d/m/Y'),
                Tables\Columns\TextColumn::make('end_date')->label('Fecha de fin')->date('d/m/Y'),
            ])
            ->filters([
                SelectFilter::make('project_id')
                    ->label('Proyecto')
                    ->options(Project::pluck('name', 'id')->toArray())
                    ->query(function ($query, array $data) {
                        if (!empty($data['project_id'])) {
                            $query->whereHas('activity.goal', function ($q) use ($data) {
                                $q->where('project_id', $data['project_id']);
                            });
                        }
                    }),
            ])
            ->headerActions([
                TableAction::make('programar')
                    ->label('Programar actividad')
                    ->icon('heroicon-o-plus')
                    ->color('primary')
                    ->url(fn() => url('/admin/activity-calendar-view')),
                TableAction::make('editar-avanzado')
                    ->label('Editar actividad calendarizada')
                    ->icon('heroicon-o-pencil-square')
                    ->color('warning')
                    ->form([
                        Select::make('project_id')
                            ->label('Proyecto')
                            ->options(Project::pluck('name', 'id')->toArray())
                            ->reactive(),
                        Select::make('activity_calendar_id')
                            ->label('Actividad calendarizada')
                            ->options(function (callable $get) {
                                $projectId = $get('project_id');
                                if (!$projectId) return [];
                                $activityIds = Activity::whereIn('goals_id', \App\Models\Goal::where('project_id', $projectId)->pluck('id'))->pluck('id');
                                return ActivityCalendar::whereIn('activity_id', $activityIds)
                                    ->get()
                                    ->mapWithKeys(function ($calendar) {
                                        $actividad = $calendar->activity ? $calendar->activity->name : 'Sin nombre';
                                        $fecha = $calendar->start_date;
                                        $hora = $calendar->start_hour;
                                        return [$calendar->id => "$actividad ($fecha $hora)"];
                                    })->toArray();
                            })
                            ->reactive()
                            ->afterStateUpdated(function ($state, $set) {
                                $calendar = ActivityCalendar::find($state);
                                if ($calendar) {
                                    $set('start_date', $calendar->start_date ? \Carbon\Carbon::parse($calendar->start_date)->format('Y-m-d') : null);
                                    $set('end_date', $calendar->end_date ? \Carbon\Carbon::parse($calendar->end_date)->format('Y-m-d') : null);
                                    $set('start_hour', $calendar->start_hour);
                                    $set('end_hour', $calendar->end_hour);
                                    $set('assigned_person', $calendar->assigned_person);
                                    $set('location_id', $calendar->location_id ? (string) $calendar->location_id : null);
                                }
                            }),
                        FormDatePicker::make('start_date')
                            ->label('Fecha de inicio'),
                        FormDatePicker::make('end_date')
                            ->label('Fecha de finalización'),
                        TextInput::make('start_hour')
                            ->label('Hora de inicio'),
                        TextInput::make('end_hour')
                            ->label('Hora de finalización'),
                        Select::make('assigned_person')
                            ->label('Responsable')
                            ->options(User::pluck('name', 'id')->toArray()),
                        Select::make('location_id')
                            ->label('Ubicación')
                            ->options(\App\Models\Location::pluck('name', 'id')->toArray()),
                    ])
                    ->action(function (array $data) {
                        $calendar = ActivityCalendar::find($data['activity_calendar_id']);
                        if (!$calendar) {
                            \Filament\Notifications\Notification::make()
                                ->title('No se encontró la actividad calendarizada')
                                ->danger()
                                ->send();
                            return;
                        }
                        $calendar->update([
                            'start_date' => $data['start_date'],
                            'end_date' => $data['end_date'],
                            'start_hour' => $data['start_hour'],
                            'end_hour' => $data['end_hour'],
                            'assigned_person' => $data['assigned_person'],
                            'location_id' => $data['location_id'] ? (int) $data['location_id'] : null,
                        ]);
                        \Filament\Notifications\Notification::make()
                            ->title('Actividad calendarizada actualizada correctamente')
                            ->success()
                            ->send();
                    }),
            ])
            ->actions([
                TableAction::make('editar')
                    ->label('Editar')
                    ->icon('heroicon-o-pencil-square')
                    ->color('warning')
                    ->form([
                        FormDatePicker::make('start_date')
                            ->label('Fecha de inicio'),
                        FormDatePicker::make('end_date')
                            ->label('Fecha de finalización'),
                        TextInput::make('start_hour')
                            ->label('Hora de inicio'),
                        TextInput::make('end_hour')
                            ->label('Hora de finalización'),
                        Select::make('assigned_person')
                            ->label('Responsable')
                            ->options(User::pluck('name', 'id')->toArray()),
                        Select::make('location_id')
                            ->label('Ubicación')
                            ->options(\App\Models\Location::pluck('name', 'id')->toArray()),
                    ])
                    ->mountUsing(function ($form, $record) {
                        $form->fill([
                            'start_date' => $record->start_date,
                            'end_date' => $record->end_date,
                            'start_hour' => $record->start_hour,
                            'end_hour' => $record->end_hour,
                            'assigned_person' => $record->assigned_person,
                            'location_id' => $record->location_id,
                        ]);
                    })
                    ->action(function (array $data, $record) {
                        $record->update([
                            'start_date' => $data['start_date'],
                            'end_date' => $data['end_date'],
                            'start_hour' => $data['start_hour'],
                            'end_hour' => $data['end_hour'],
                            'assigned_person' => $data['assigned_person'],
                            'location_id' => $data['location_id'] ? (int) $data['location_id'] : null,
                        ]);
                        \Filament\Notifications\Notification::make()
                            ->title('Actividad calendarizada actualizada correctamente')
                            ->success()
                            ->send();
                    }),
            ]);
    }
}

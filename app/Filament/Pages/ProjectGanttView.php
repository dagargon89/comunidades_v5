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
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Section;
use App\Filament\Widgets\ActivityCalendarCount;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;

class ProjectGanttView extends Page implements Tables\Contracts\HasTable
{
    use Tables\Concerns\InteractsWithTable, HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-group';
    protected static string $view = 'filament.pages.project-gantt-view';
    protected static ?string $slug = 'gestor-actividades';
    protected static ?string $navigationLabel = 'Gestor de actividades';


    public function getTitle(): string
    {
        return 'Gestor de actividades';
    }

    protected function getHeaderWidgets(): array
    {
        return [
            ActivityCalendarCount::class,
        ];
    }

    public function table(Table $table): Table
    {
        return $table
            ->query(ActivityCalendar::query()->with(['activity', 'activity.goal']))
            ->columns([
                Tables\Columns\TextColumn::make('activity.name')
                    ->label('Actividad')
                    ->searchable()
                    ->sortable()
                    ->limit(50)
                    ->tooltip(function ($record) {
                        return $record->activity?->name;
                    }),
                Tables\Columns\TextColumn::make('assigned_person')
                    ->label('Encargado')
                    ->formatStateUsing(fn($state) => User::find($state)?->name ?? '-')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_date')->label('Fecha de inicio')->date('d/m/Y')->sortable(),
                Tables\Columns\TextColumn::make('end_date')->label('Fecha de fin')->date('d/m/Y')->sortable(),
                Tables\Columns\TextColumn::make('cancelled')
                    ->label('Cancelado')
                    ->formatStateUsing(fn($state) => $state ? 'Sí' : 'No')
                    ->sortable(),
                Tables\Columns\TextColumn::make('change_reason')
                    ->label('Motivo de cancelación')
                    ->limit(40)
                    ->sortable(),
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
                Tables\Filters\MultiSelectFilter::make('assigned_person')
                    ->label('Encargado')
                    ->options(User::pluck('name', 'id')->toArray()),
                Tables\Filters\SelectFilter::make('cancelled')
                    ->label('Cancelado')
                    ->options([
                        1 => 'Sí',
                        0 => 'No',
                    ]),
                Tables\Filters\Filter::make('date_filter')
                    ->label('Filtro por fechas')
                    ->form([
                        FormDatePicker::make('start_date')
                            ->label('Fecha de inicio'),
                        FormDatePicker::make('end_date')
                            ->label('Fecha de fin'),
                    ])
                    ->query(function ($query, array $data) {
                        return $query
                            ->when(
                                $data['start_date'],
                                fn ($query, $date) => $query->where('start_date', '>=', $date)
                            )
                            ->when(
                                $data['end_date'],
                                fn ($query, $date) => $query->where('end_date', '<=', $date)
                            );
                    }),
            ])
            ->headerActions([
                TableAction::make('programar')
                    ->label('Programar actividad (Gestor)')
                    ->icon('heroicon-o-plus')
                    ->color('primary')
                    ->url(fn() => url('/admin/activity-calendar-view')),
                TableAction::make('editar-avanzado')
                    ->label('Edición avanzada (Gestor)')
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
                        Select::make('activity_id')
                            ->label('Actividad')
                            ->options(Activity::pluck('name', 'id')->toArray())
                            ->required(),
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
                            'activity_id' => $record->activity_id,
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
                            'activity_id' => $data['activity_id'],
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
                TableAction::make('eliminar')
                    ->label('Eliminar')
                    ->icon('heroicon-o-trash')
                    ->color('danger')
                    ->requiresConfirmation()
                    ->action(function ($record) {
                        $record->delete();
                        \Filament\Notifications\Notification::make()
                            ->title('Actividad calendarizada eliminada correctamente')
                            ->success()
                            ->send();
                    }),
                TableAction::make('cancelar')
                    ->label('Cancelar')
                    ->icon('heroicon-o-x-circle')
                    ->color('danger')
                    ->form([
                        Textarea::make('change_reason')
                            ->label('Motivo de cancelación')
                            ->required(),
                    ])
                    ->requiresConfirmation()
                    ->action(function (array $data, $record) {
                        $record->update([
                            'cancelled' => 1,
                            'change_reason' => $data['change_reason'],
                        ]);
                        \Filament\Notifications\Notification::make()
                            ->title('Actividad calendarizada cancelada')
                            ->danger()
                            ->send();
                    }),
                TableAction::make('vista')
                    ->label('Ver detalle (Gestor)')
                    ->icon('heroicon-o-eye')
                    ->color('info')
                    ->modalHeading('Detalle de la actividad calendarizada')
                    ->form([
                        Section::make('Información general')
                            ->columns(2)
                            ->schema([
                                TextInput::make('activity_name')
                                    ->label('Actividad')
                                    ->disabled(),
                                TextInput::make('assigned_person')
                                    ->label('Encargado')
                                    ->disabled(),
                            ]),
                        Section::make('Fechas y horas')
                            ->columns(2)
                            ->schema([
                                TextInput::make('start_date')
                                    ->label('Fecha de inicio')
                                    ->disabled(),
                                TextInput::make('end_date')
                                    ->label('Fecha de fin')
                                    ->disabled(),
                                TextInput::make('start_hour')
                                    ->label('Hora de inicio')
                                    ->disabled(),
                                TextInput::make('end_hour')
                                    ->label('Hora de fin')
                                    ->disabled(),
                            ]),
                        Section::make('Ubicación')
                            ->schema([
                                TextInput::make('location')
                                    ->label('Ubicación')
                                    ->disabled(),
                            ]),
                        Section::make('Cancelación')
                            ->columns(2)
                            ->schema([
                                TextInput::make('cancelled')
                                    ->label('Cancelado')
                                    ->disabled(),
                                TextInput::make('change_reason')
                                    ->label('Motivo de cancelación')
                                    ->disabled(),
                            ]),
                    ])
                    ->mountUsing(function ($form, $record) {
                        $form->fill([
                            'activity_name' => $record->activity?->name,
                            'assigned_person' => \App\Models\User::find($record->assigned_person)?->name,
                            'start_date' => $record->start_date,
                            'end_date' => $record->end_date,
                            'start_hour' => $record->start_hour,
                            'end_hour' => $record->end_hour,
                            'location' => \App\Models\Location::find($record->location_id)?->name,
                            'cancelled' => $record->cancelled ? 'Sí' : 'No',
                            'change_reason' => $record->change_reason,
                        ]);
                    })
                    ->action(fn () => null),
            ])
            ->recordClasses(function ($record) {
                return $record->cancelled ? 'bg-red-100' : '';
            });
    }
}

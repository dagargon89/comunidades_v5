<?php

namespace App\Filament\Usuario\Pages;

use App\Models\Activity;
use App\Models\ActivityFile;
use App\Models\ActivityCalendar;
use App\Models\ActivityLog;
use App\Models\PlannedMetric;
use App\Models\User;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Forms;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Hidden;
use Filament\Forms\Form;
use Filament\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Actions\Action as TableAction;
use Filament\Tables\Actions\DeleteAction;
use Filament\Tables\Actions\HeaderActionsPosition;
use Filament\Notifications\Notification;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Auth;
use Livewire\Features\SupportFileUploads\TemporaryUploadedFile;

class ActivityFileManager extends Page implements Tables\Contracts\HasTable
{
    use Tables\Concerns\InteractsWithTable, HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Gestión de Archivos';
    protected static ?string $title = 'Gestión de Archivos de Actividades';
    protected static ?string $slug = 'activity-file-manager';
    protected static string $view = 'filament.pages.activity-file-manager';

    public ?int $activity_id = null;
    public ?int $activity_calendar_id = null;

    public function mount(): void
    {
        $userId = Auth::id();
        $firstActivityId = ActivityCalendar::where('assigned_person', $userId)
            ->pluck('activity_id')
            ->unique()
            ->first();
        $this->activity_id = $firstActivityId ?? null;

        $firstCalendar = null;
        if ($this->activity_id) {
            $firstCalendar = ActivityCalendar::where('activity_id', $this->activity_id)
                ->where('assigned_person', $userId) // Filtrar por responsable
                ->orderBy('start_date')
                ->orderBy('start_hour')
                ->first();
        }
        $this->activity_calendar_id = $firstCalendar ? $firstCalendar->id : null;
    }

    public function form(Form $form): Form
    {
        return $form->schema([
            Forms\Components\Section::make('Información de actividad')
                ->description('Selecciona la actividad y la fecha para gestionar archivos')
                ->schema([
                    Forms\Components\Select::make('activity_id')
                        ->label('Actividad')
                        ->options(function () {
                            // Obtener el usuario logueado
                            $userId = Auth::id();

                            // Obtener las actividades donde el usuario es responsable
                            $activityIds = ActivityCalendar::where('assigned_person', $userId)
                                ->pluck('activity_id')
                                ->unique()
                                ->toArray();

                            // Obtener las actividades correspondientes
                            $activities = Activity::whereIn('id', $activityIds)
                                ->pluck('name', 'id')
                                ->toArray();

                            return $activities;
                        })
                        ->searchable()
                        ->required()
                        ->live()
                        ->default(function () {
                            $userId = Auth::id();
                            $firstActivityId = ActivityCalendar::where('assigned_person', $userId)
                                ->pluck('activity_id')
                                ->unique()
                                ->first();
                            return $firstActivityId;
                        }),
                    Forms\Components\Select::make('activity_calendar_id')
                        ->label('Fecha y hora de la actividad')
                        ->options(function () {
                            $activityId = $this->activity_id;
                            $userId = Auth::id();

                            if (!$activityId) {
                                return [];
                            }

                            $calendars = ActivityCalendar::where('activity_id', $activityId)
                                ->where('assigned_person', $userId) // Filtrar por responsable
                                ->orderBy('start_date')
                                ->orderBy('start_hour')
                                ->get();

                            if ($calendars->isEmpty()) {
                                return [];
                            }

                            return $calendars->mapWithKeys(function ($calendar) {
                                $fecha = \Carbon\Carbon::parse($calendar->start_date)->translatedFormat('d \d\e F \d\e Y');
                                $horaInicio = $calendar->start_hour ? substr($calendar->start_hour, 0, 5) : '--:--';
                                $horaFin = $calendar->end_hour ? substr($calendar->end_hour, 0, 5) : '--:--';
                                $label = "$fecha ($horaInicio - $horaFin)";
                                return [$calendar->id => $label];
                            })
                            ->toArray();
                        })
                        ->required()
                        ->live()
                        ->default(function () {
                            $activityId = $this->activity_id;
                            $userId = Auth::id();

                            if (!$activityId) {
                                return null;
                            }

                            $firstCalendar = ActivityCalendar::where('activity_id', $activityId)
                                ->where('assigned_person', $userId) // Filtrar por responsable
                                ->orderBy('start_date')
                                ->orderBy('start_hour')
                                ->first();
                            return $firstCalendar ? $firstCalendar->id : null;
                        })
                        ->native(false)
                        ->searchable()
                        ->preload()
                        ->afterStateUpdated(function ($state, $set) {
                            $set('activity_calendar_id', $state);
                        })
                        ->helperText(function () {
                            $activityId = $this->activity_id;
                            $userId = Auth::id();

                            if (!$activityId) {
                                return 'Selecciona una actividad primero';
                            }

                            $count = ActivityCalendar::where('activity_id', $activityId)
                                ->where('assigned_person', $userId) // Filtrar por responsable
                                ->count();

                            if ($count === 0) {
                                return 'Esta actividad no tiene fechas y horarios programados donde seas responsable';
                            }
                            return "Esta actividad tiene {$count} fecha(s) programada(s) donde eres responsable";
                        }),
                ]),
        ]);
    }

    public function updatedActivityId($value): void
    {
        $this->activity_id = $value ? (int) $value : null;
        $userId = Auth::id();
        $firstCalendar = null;
        if ($this->activity_id) {
            $firstCalendar = ActivityCalendar::where('activity_id', $this->activity_id)
                ->where('assigned_person', $userId) // Filtrar por responsable
                ->orderBy('start_date')
                ->orderBy('start_hour')
                ->first();
        }
        $this->activity_calendar_id = $firstCalendar ? $firstCalendar->id : null;
        $this->resetTable();
    }

    public function updatedActivityCalendarId($value): void
    {
        $this->activity_calendar_id = $value;
        $this->resetTable();
    }

    public function getActivityInfo(): ?array
    {
        if (!$this->activity_id || !$this->activity_calendar_id) {
            return null;
        }
        $activity = Activity::find($this->activity_id);
        $calendar = ActivityCalendar::find($this->activity_calendar_id);
        if (!$activity || !$calendar) {
            return null;
        }
        $responsable = User::find($calendar->asigned_person);
        return [
            'actividad' => $activity->name,
            'fecha' => $calendar->start_date,
            'hora_inicio' => $calendar->start_hour,
            'hora_fin' => $calendar->end_hour,
            'responsable' => $responsable?->name ?? 'No asignado',
        ];
    }

    public function table(Table $table): Table
    {
        return $table
            ->query(function () {
                if (!$this->activity_id || !$this->activity_calendar_id) {
                    return ActivityFile::query()->whereRaw('1=0');
                }

                // Buscar el planned_metrics_id correspondiente a la actividad
                $plannedMetric = \App\Models\PlannedMetric::where('activity_id', $this->activity_id)->first();

                if (!$plannedMetric) {
                    return ActivityFile::query()->whereRaw('1=0');
                }

                // Buscar el activity_log_id correspondiente
                $activityLog = \App\Models\ActivityLog::where('planned_metrics_id', $plannedMetric->id)->first();

                if (!$activityLog) {
                    return ActivityFile::query()->whereRaw('1=0');
                }

                // Filtrar por activity_calendar_id específico
                return ActivityFile::query()
                    ->where('activity_calendar_id', $this->activity_calendar_id);
            })
            ->columns([
                Tables\Columns\TextColumn::make('file_path')->label('Archivo')->searchable(),
                Tables\Columns\TextColumn::make('month')->label('Mes'),
                Tables\Columns\TextColumn::make('type')->label('Tipo'),
                Tables\Columns\TextColumn::make('upload_date')->label('Fecha de subida')->dateTime('d/m/Y H:i')->sortable(),
                Tables\Columns\TextColumn::make('created_at')->label('Creado')->dateTime('d/m/Y H:i')->sortable(),
            ])
            ->actions([
                TableAction::make('download')
                    ->label('Descargar')
                    ->icon('heroicon-o-arrow-down-tray')
                    ->url(fn(ActivityFile $record) => Storage::url($record->file_path))
                    ->openUrlInNewTab(),
                DeleteAction::make()
                    ->label('Eliminar')
                    ->requiresConfirmation()
                    ->modalHeading('¿Eliminar archivo?')
                    ->modalDescription('Esta acción eliminará el archivo de la actividad. ¿Estás seguro?')
                    ->modalSubmitActionLabel('Sí, eliminar')
                    ->modalCancelActionLabel('Cancelar'),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\BulkAction::make('download_zip')
                        ->label('Descargar seleccionados en ZIP')
                        ->icon('heroicon-o-archive-box-arrow-down')
                        ->action(function ($records) {
                            $zipFileName = 'archivos_seleccionados_' . now()->timestamp . '.zip';
                            $zipPath = storage_path('app/public/' . $zipFileName);
                            $zip = new \ZipArchive;
                            if ($zip->open($zipPath, \ZipArchive::CREATE) === TRUE) {
                                foreach ($records as $file) {
                                    $filePath = storage_path('app/public/' . $file->file_path);
                                    if (file_exists($filePath)) {
                                        $zip->addFile($filePath, basename($file->file_path));
                                    }
                                }
                                $zip->close();
                            }
                            return response()->download($zipPath)->deleteFileAfterSend(true);
                        })
                        ->deselectRecordsAfterCompletion(),
                ]),
            ])
            ->headerActions([
                TableAction::make('add_files')
                    ->label('Agregar archivos')
                    ->icon('heroicon-o-plus')
                    ->form([
                        Forms\Components\Section::make('Gestión de Archivos de Actividad')
                            ->description('Sube múltiples archivos relacionados con la actividad seleccionada')
                            ->icon('heroicon-o-document-plus')
                            ->schema([
                                Repeater::make('files')
                                    ->label('Lista de Archivos')
                                    ->schema([
                                        // Sección de información del archivo
                                        Forms\Components\Section::make('Información del Archivo')
                                            ->description('Datos básicos del archivo a subir')
                                            ->icon('heroicon-m-document-text')
                                            ->schema([
                                                FileUpload::make('file_upload')
                                                    ->label('Archivo')
                                                    ->required()
                                                    ->directory('activity-files')
                                                    ->preserveFilenames()
                                                                                        ->maxSize(100 * 1024 * 1024) // 100MB máximo
                                    ->acceptedFileTypes([
                                        'application/pdf',
                                        'image/*',
                                        'application/msword',
                                        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                        'application/vnd.ms-excel',
                                        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                        'application/zip',
                                        'application/x-zip-compressed',
                                        'application/octet-stream'
                                    ])
                                    ->helperText('Formatos permitidos: PDF, imágenes, Word, Excel, ZIP. Tamaño máximo: 100MB')
                                                    ->columnSpanFull(),
                                            ])
                                            ->collapsible()
                                            ->collapsed(),

                                        // Sección de metadatos
                                        Forms\Components\Section::make('Metadatos del Archivo')
                                            ->description('Información adicional sobre el archivo')
                                            ->icon('heroicon-m-tag')
                                            ->schema([
                                                TextInput::make('month')
                                                    ->label('Mes')
                                                    ->placeholder('Ej: Enero, Febrero, Marzo')
                                                    ->helperText('Especifica el mes al que corresponde este archivo')
                                                    ->columnSpan(1),
                                                TextInput::make('type')
                                                    ->label('Tipo de archivo')
                                                    ->placeholder('Ej: PDF, Imagen, Documento, Reporte')
                                                    ->helperText('Describe el tipo o categoría del archivo')
                                                    ->columnSpan(1),
                                            ])
                                            ->columns(2)
                                            ->collapsible()
                                            ->collapsed(),
                                    ])
                                    ->addActionLabel('Agregar Otro Archivo')
                                    ->reorderable()
                                    ->collapsible()
                                    ->itemLabel(fn (array $state): ?string =>
                                        $state['type'] ?? $state['month'] ?? 'Nuevo Archivo'
                                    )
                                    ->minItems(1)
                                    ->maxItems(20)
                                    ->columnSpanFull(),
                            ])
                            ->collapsible()
                            ->collapsed(),
                    ])
                    ->action(function (array $data) {
                        $activityId = $this->activity_id;
                        $calendarId = $this->activity_calendar_id;

                        if (!$activityId || !$calendarId) {
                            Notification::make()->title('Selecciona una actividad y fecha')->danger()->send();
                            return;
                        }

                        // Buscar el planned_metrics_id correspondiente a la actividad
                        $plannedMetric = \App\Models\PlannedMetric::where('activity_id', $activityId)->first();

                        if (!$plannedMetric) {
                            Notification::make()->title('No se encontró la métrica planificada para esta actividad')->danger()->send();
                            return;
                        }

                        // Buscar el activity_log_id correspondiente
                        $activityLog = \App\Models\ActivityLog::where('planned_metrics_id', $plannedMetric->id)->first();

                        if (!$activityLog) {
                            // Si no existe el activity_log, lo creamos
                            $activityLog = \App\Models\ActivityLog::create([
                                'planned_metrics_id' => $plannedMetric->id,
                                'created_by' => 1, // Usuario por defecto
                            ]);
                        }

                        foreach ($data['files'] as $fileData) {
                            if (!empty($fileData['file_upload'])) {
                                $uploaded = $fileData['file_upload'];
                                if ($uploaded instanceof \Illuminate\Http\UploadedFile || $uploaded instanceof \Livewire\Features\SupportFileUploads\TemporaryUploadedFile) {
                                    $path = $uploaded->store('activity-files', 'public');
                                } else {
                                    $path = $uploaded; // Ya es la ruta
                                }

                                ActivityFile::create([
                                    'file_path' => $path,
                                    'month' => $fileData['month'] ?? null,
                                    'type' => $fileData['type'] ?? null,
                                    'upload_date' => now(),
                                    'activity_log_id' => $activityLog->id,
                                    'activity_progress_log_id' => $plannedMetric->activity_progress_log_id ?? 1, // Valor por defecto
                                    'activity_calendar_id' => $calendarId,
                                ]);
                            }
                        }
                        Notification::make()->title('Archivos subidos correctamente')->success()->send();
                        $this->resetTable();
                    })
                    ->color('success'),
            ])
            ->defaultSort('created_at', 'desc');
    }
}


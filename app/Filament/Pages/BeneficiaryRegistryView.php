<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use App\Models\Activity;
use App\Models\ActivityCalendar;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Carbon\Carbon;
use Filament\Tables;
use Filament\Tables\Contracts\HasTable;
use Filament\Tables\Concerns\InteractsWithTable;
use Saade\FilamentAutograph\Forms\Components\SignaturePad;
use Filament\Tables\Actions;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Tables\Columns\ImageColumn;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;
use Awcodes\TableRepeater\Components\TableRepeater;
use Awcodes\TableRepeater\Header;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Forms\Components\Repeater;

class BeneficiaryRegistryView extends Page implements HasTable
{
    use InteractsWithTable, HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    protected static string $view = 'filament.pages.beneficiary-registry-view';

    protected static ?string $title = 'Registro de Beneficiarios';
    protected static ?string $navigationLabel = 'Registro de Beneficiarios';
    protected static ?string $modelLabel = 'Registro de Beneficiario';
    protected static ?string $pluralModelLabel = 'Registros de Beneficiarios';
    protected static ?string $slug = 'registro-beneficiarios';

    public ?int $activity_id = null;
    public ?int $activity_calendar_id = null;

    public function mount(): void
    {
        // Obtener la primera actividad que tenga fechas no canceladas
        $firstActivityId = ActivityCalendar::where('cancelled', false)
            ->pluck('activity_id')
            ->unique()
            ->first();
        $this->activity_id = $firstActivityId ?? null;

        $firstCalendar = null;
        if ($this->activity_id) {
            $firstCalendar = ActivityCalendar::where('activity_id', $this->activity_id)
                ->where('cancelled', false) // Filtrar fechas canceladas
                ->orderBy('start_date')
                ->orderBy('start_hour')
                ->first();
        }
        $this->activity_calendar_id = $firstCalendar ? $firstCalendar->id : null;
    }

    public function updatedActivityId($value): void
    {
        $this->activity_id = $value ? (int) $value : null;
        // Buscar la primera fecha disponible para la nueva actividad
        $firstCalendar = null;
        if ($this->activity_id) {
            $firstCalendar = ActivityCalendar::where('activity_id', $this->activity_id)
                ->where('cancelled', false) // Filtrar fechas canceladas
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

    public function form(\Filament\Forms\Form $form): \Filament\Forms\Form
    {
        return $form->schema([
            Section::make('Información de actividad')
                ->description('Datos de la actividad asociada')
                ->schema([
                    Select::make('activity_id')
                        ->label('Actividad')
                        ->options(function () {
                            // Obtener solo las actividades que tienen al menos una fecha no cancelada
                            $activityIds = ActivityCalendar::where('cancelled', false)
                                ->pluck('activity_id')
                                ->unique()
                                ->toArray();

                            return Activity::whereIn('id', $activityIds)
                                ->pluck('name', 'id')
                                ->toArray();
                        })
                        ->searchable()
                        ->live()
                        ->default(function () {
                            // Obtener la primera actividad que tenga fechas no canceladas
                            $firstActivityId = ActivityCalendar::where('cancelled', false)
                                ->pluck('activity_id')
                                ->unique()
                                ->first();
                            return $firstActivityId;
                        })
                        ->afterStateUpdated(function ($state, $set) {
                            $set('activity_id', $state);
                        }),
                    Select::make('activity_calendar_id')
                        ->label('Fecha y hora de la actividad')
                        ->options(function () {
                            $activityId = $this->activity_id;
                            if (!$activityId) {
                                return [];
                            }
                            $calendars = ActivityCalendar::where('activity_id', $activityId)
                                ->where('cancelled', false) // Filtrar fechas canceladas
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
                        ->live()
                        ->default(function () {
                            $activityId = $this->activity_id;
                            if (!$activityId) {
                                return null;
                            }
                            $firstCalendar = ActivityCalendar::where('activity_id', $activityId)
                                ->where('cancelled', false) // Filtrar fechas canceladas
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
                            if (!$activityId) {
                                return 'Selecciona una actividad primero';
                            }
                            $count = ActivityCalendar::where('activity_id', $activityId)
                                ->where('cancelled', false) // Filtrar fechas canceladas
                                ->count();
                            if ($count === 0) {
                                return 'Esta actividad no tiene fechas y horarios programados disponibles';
                            }
                            return "Esta actividad tiene {$count} fecha(s) programada(s) disponible(s)";
                        }),
                ]),
        ]);
    }

    public function getActivityInfo(): ?array
    {
        if (!$this->activity_id || !$this->activity_calendar_id) {
            return null;
        }
        $calendar = ActivityCalendar::where('id', $this->activity_calendar_id)
            ->with(['assignedPerson', 'activity'])
            ->first();
        if (!$calendar) {
            return null;
        }
        $activity = $calendar->activity;
        $responsible = $calendar->assignedPerson?->name ?? '-';
        return [
            'actividad' => $activity?->name ?? '-',
            'descripcion' => $activity?->description ?? '-',
            'fecha' => $calendar->start_date ?? '-',
            'hora_inicio' => $calendar->start_hour ?? '-',
            'hora_fin' => $calendar->end_hour ?? '-',
            'responsable' => $responsible,
        ];
    }

    protected function getTableQuery()
    {
        $query = \App\Models\BeneficiaryRegistry::query()
            ->with(['beneficiaries', 'activityCalendar']);

        // Solo filtrar si hay un activity_calendar_id válido
        if ($this->activity_calendar_id && $this->activity_calendar_id > 0) {
            $query->where('activity_calendar_id', $this->activity_calendar_id);
        } else {
            // Si no hay activity_calendar_id válido, no mostrar ningún registro
            $query->whereRaw('1 = 0'); // Esto asegura que no se muestren registros
        }

        return $query;
    }

    protected function shouldRenderTable(): bool
    {
        // Solo mostrar la tabla si hay un activity_calendar_id válido
        if (!$this->activity_calendar_id || $this->activity_calendar_id <= 0) {
            return false;
        }

        // Verificar que el activity_calendar_id existe en la base de datos
        $calendarExists = ActivityCalendar::where('id', $this->activity_calendar_id)->exists();
        if (!$calendarExists) {
            return false;
        }

        return true;
    }

    protected function getTableColumns(): array
    {
        return [
            Tables\Columns\TextColumn::make('beneficiaries.last_name')
                ->label('Apellido Paterno')
                ->sortable()
                ->searchable(),
            Tables\Columns\TextColumn::make('beneficiaries.mother_last_name')
                ->label('Apellido Materno')
                ->sortable()
                ->searchable(),
            Tables\Columns\TextColumn::make('beneficiaries.first_names')
                ->label('Nombres')
                ->sortable()
                ->searchable(),
            Tables\Columns\TextColumn::make('beneficiaries.birth_year')
                ->label('Año Nacimiento')
                ->sortable()
                ->searchable(),
            Tables\Columns\TextColumn::make('beneficiaries.gender')
                ->label('Género')
                ->sortable()
                ->formatStateUsing(fn ($state) => match ($state) {
                    'M' => 'Masculino',
                    'F' => 'Femenino',
                    'Male' => 'Masculino',
                    'Female' => 'Femenino',
                    default => $state,
                }),
            Tables\Columns\TextColumn::make('beneficiaries.phone')
                ->label('Teléfono')
                ->sortable()
                ->searchable(),
            ImageColumn::make('signature')
                ->label('Firma')
                ->height(60)
                ->width(180),
            Tables\Columns\TextColumn::make('created_at')
                ->label('Registrado el')
                ->dateTime('d/m/Y H:i')
                ->sortable(),
        ];
    }

    protected function getTableHeaderActions(): array
    {
        // Solo mostrar los botones si hay un activity_calendar_id válido
        if (!$this->activity_calendar_id || $this->activity_calendar_id <= 0) {
            return [];
        }

        // Verificar que el activity_calendar_id existe
        $calendarExists = ActivityCalendar::where('id', $this->activity_calendar_id)->exists();
        if (!$calendarExists) {
            return [];
        }

        return [
            Actions\Action::make('addSingle')
                ->label('Registrar beneficiario único')
                ->icon('heroicon-o-user-plus')
                ->form([
                    Forms\Components\Section::make('Registro de Beneficiario Único')
                        ->description('Registra un beneficiario individual con todos sus datos')
                        ->icon('heroicon-o-user-plus')
                        ->schema([
                            // Sección de búsqueda
                            Forms\Components\Section::make('Búsqueda de Beneficiario')
                                ->description('Busca un beneficiario existente')
                                ->icon('heroicon-m-magnifying-glass')
                                ->schema([
                                    // Campo de búsqueda con dropdown de opciones
                                    Select::make('search_beneficiary_dropdown')
                                        ->label('Búsqueda con opciones')
                                        ->placeholder('Escribe para buscar beneficiarios...')
                                        ->helperText('Escribe nombre, apellido o identificador para ver opciones disponibles')
                                        ->searchable()
                                        ->getSearchResultsUsing(function (string $search) {
                                            if (strlen($search) < 2) {
                                                return [];
                                            }

                                            return \App\Models\Beneficiary::where('identifier', 'like', "%{$search}%")
                                                ->orWhere('first_names', 'like', "%{$search}%")
                                                ->orWhere('last_name', 'like', "%{$search}%")
                                                ->orWhere('mother_last_name', 'like', "%{$search}%")
                                                ->limit(10)
                                                ->get()
                                                ->mapWithKeys(function ($beneficiary) {
                                                    $label = "{$beneficiary->first_names} {$beneficiary->last_name} ({$beneficiary->identifier})";
                                                    return [$beneficiary->id => $label];
                                                });
                                        })
                                        ->getOptionLabelUsing(fn ($value): ?string =>
                                            \App\Models\Beneficiary::find($value)?->first_names . ' ' .
                                            \App\Models\Beneficiary::find($value)?->last_name . ' (' .
                                            \App\Models\Beneficiary::find($value)?->identifier . ')'
                                        )
                                        ->live()
                                        ->afterStateUpdated(function ($state, $set) {
                                            if ($state) {
                                                $beneficiary = \App\Models\Beneficiary::find($state);
                                                if ($beneficiary) {
                                                    $set('last_name', $beneficiary->last_name);
                                                    $set('mother_last_name', $beneficiary->mother_last_name);
                                                    $set('first_names', $beneficiary->first_names);
                                                    $set('birth_year', $beneficiary->birth_year);
                                                    $set('gender', $beneficiary->gender);
                                                    $set('phone', $beneficiary->phone);
                                                    $set('street', $beneficiary->street);
                                                    $set('ext_number', $beneficiary->ext_number);
                                                    $set('neighborhood', $beneficiary->neighborhood);
                                                    $set('address_backup', $beneficiary->address_backup);

                                                    \Filament\Notifications\Notification::make()
                                                        ->title('Beneficiario seleccionado')
                                                        ->body("Se prellenaron los datos de: {$beneficiary->first_names} {$beneficiary->last_name}")
                                                        ->success()
                                                        ->send();
                                                }
                                            }
                                        })
                                        ->columnSpanFull(),
                                ])
                                ->collapsible()
                                ->collapsed(),

                            // Sección de datos personales
                            Forms\Components\Section::make('Datos Personales')
                                ->description('Información básica del beneficiario')
                                ->icon('heroicon-m-user')
                                ->schema([
                                    TextInput::make('last_name')
                                        ->label('Apellido paterno')
                                        ->maxLength(100)
                                        ->columnSpan(1),
                                    TextInput::make('mother_last_name')
                                        ->label('Apellido materno')
                                        ->maxLength(100)
                                        ->columnSpan(1),
                                    TextInput::make('first_names')
                                        ->label('Nombres')
                                        ->required()
                                        ->maxLength(100)
                                        ->columnSpan(2),
                                    TextInput::make('birth_year')
                                        ->label('Año de nacimiento')
                                        ->maxLength(4)
                                        ->columnSpan(1),
                                    Select::make('gender')
                                        ->label('Género')
                                        ->required()
                                        ->options([
                                            'M' => 'Masculino',
                                            'F' => 'Femenino',
                                        ])
                                        ->columnSpan(1),
                                ])
                                ->columns(2),

                            // Sección de información de contacto
                            Forms\Components\Section::make('Información de Contacto')
                                ->description('Datos de contacto del beneficiario')
                                ->icon('heroicon-m-phone')
                                ->schema([
                                    TextInput::make('phone')
                                        ->label('Teléfono')
                                        ->maxLength(20)
                                        ->columnSpan(1),
                                    TextInput::make('street')
                                        ->label('Calle')
                                        ->maxLength(255)
                                        ->columnSpan(1),
                                    TextInput::make('ext_number')
                                        ->label('Número')
                                        ->maxLength(50)
                                        ->columnSpan(1),
                                    TextInput::make('neighborhood')
                                        ->label('Colonia')
                                        ->maxLength(255)
                                        ->columnSpan(1),
                                    Textarea::make('address_backup')
                                        ->label('Dirección de respaldo')
                                        ->rows(3)
                                        ->columnSpan(2),
                                ])
                                ->columns(2)
                                ->collapsible()
                                ->collapsed(),

                            // Sección de firma
                            SignaturePad::make('signature')->label('Firma del beneficiario'),
                        ])
                        ->collapsible()
                        ->collapsed(),
                ])
                ->action(function (array $data) {
                    // Log temporal para depurar
                    Log::info('Datos recibidos en acción:', $data);

                    // Buscar beneficiario existente o crear uno nuevo
                    $beneficiary = \App\Models\Beneficiary::firstOrCreate(
                        [
                            'first_names' => $data['first_names'],
                            'last_name' => $data['last_name'],
                            'mother_last_name' => $data['mother_last_name'],
                            'birth_year' => $data['birth_year'],
                            'gender' => $data['gender'],
                        ],
                        [
                            'last_name' => $data['last_name'],
                            'mother_last_name' => $data['mother_last_name'],
                            'first_names' => $data['first_names'],
                            'birth_year' => $data['birth_year'],
                            'gender' => $data['gender'],
                            'phone' => $data['phone'] ?? null,
                            'street' => $data['street'] ?? null,
                            'ext_number' => $data['ext_number'] ?? null,
                            'neighborhood' => $data['neighborhood'] ?? null,
                            'address_backup' => $data['address_backup'] ?? null,
                            'created_by' => Auth::id(),
                        ]
                    );

                    // Verificar si ya existe una participación para esta actividad y calendario
                    $existingParticipation = \App\Models\BeneficiaryRegistry::where([
                        'beneficiaries_id' => $beneficiary->id,
                        'activity_calendar_id' => $this->activity_calendar_id,
                    ])->first();

                    if ($existingParticipation) {
                        \Filament\Notifications\Notification::make()
                            ->title('Participación ya registrada')
                            ->body('Este beneficiario ya está registrado para esta actividad en la fecha seleccionada.')
                            ->warning()
                            ->send();
                        return;
                    }

                    // Registrar en BeneficiaryRegistry (con signature)
                    \App\Models\BeneficiaryRegistry::create([
                        'activity_calendar_id' => $this->activity_calendar_id,
                        'beneficiaries_id' => $beneficiary->id,
                        'data_collectors_id' => Auth::id(),
                        'created_by' => Auth::id(),
                        'signature' => $data['signature'] ?? null,
                    ]);

                    \Filament\Notifications\Notification::make()
                        ->title('Beneficiario registrado')
                        ->success()
                        ->send();
                }),
            Actions\Action::make('addMassive')
                ->label('Registrar beneficiarios masivos')
                ->icon('heroicon-o-users')
                ->form([
                    Forms\Components\Section::make('Registro Masivo de Beneficiarios')
                        ->description('Agrega múltiples beneficiarios de forma eficiente')
                        ->icon('heroicon-o-users')
                        ->schema([
                            Repeater::make('beneficiarios')
                                ->label('Lista de Beneficiarios')
                                ->schema([
                                    // Sección de búsqueda
                                    Forms\Components\Section::make('Búsqueda Rápida')
                                        ->description('Busca un beneficiario existente')
                                        ->icon('heroicon-m-magnifying-glass')
                                        ->schema([
                                            // Campo de búsqueda con dropdown de opciones
                                            Select::make('search_beneficiary_dropdown')
                                                ->label('Búsqueda con opciones')
                                                ->placeholder('Escribe para buscar beneficiarios...')
                                                ->helperText('Escribe nombre, apellido o identificador para ver opciones disponibles')
                                                ->searchable()
                                                ->getSearchResultsUsing(function (string $search) {
                                                    if (strlen($search) < 2) {
                                                        return [];
                                                    }

                                                    return \App\Models\Beneficiary::where('identifier', 'like', "%{$search}%")
                                                        ->orWhere('first_names', 'like', "%{$search}%")
                                                        ->orWhere('last_name', 'like', "%{$search}%")
                                                        ->orWhere('mother_last_name', 'like', "%{$search}%")
                                                        ->limit(10)
                                                        ->get()
                                                        ->mapWithKeys(function ($beneficiary) {
                                                            $label = "{$beneficiary->first_names} {$beneficiary->last_name} ({$beneficiary->identifier})";
                                                            return [$beneficiary->id => $label];
                                                        });
                                                })
                                                ->getOptionLabelUsing(fn ($value): ?string =>
                                                    \App\Models\Beneficiary::find($value)?->first_names . ' ' .
                                                    \App\Models\Beneficiary::find($value)?->last_name . ' (' .
                                                    \App\Models\Beneficiary::find($value)?->identifier . ')'
                                                )
                                                ->live()
                                                ->afterStateUpdated(function ($state, $set) {
                                                    if ($state) {
                                                        $beneficiary = \App\Models\Beneficiary::find($state);
                                                        if ($beneficiary) {
                                                            $set('last_name', $beneficiary->last_name);
                                                            $set('mother_last_name', $beneficiary->mother_last_name);
                                                            $set('first_names', $beneficiary->first_names);
                                                            $set('birth_year', $beneficiary->birth_year);
                                                            $set('gender', $beneficiary->gender);
                                                            $set('phone', $beneficiary->phone);
                                                            $set('street', $beneficiary->street);
                                                            $set('ext_number', $beneficiary->ext_number);
                                                            $set('neighborhood', $beneficiary->neighborhood);
                                                            $set('address_backup', $beneficiary->address_backup);

                                                            \Filament\Notifications\Notification::make()
                                                                ->title('Beneficiario seleccionado')
                                                                ->body("Se prellenaron los datos de: {$beneficiary->first_names} {$beneficiary->last_name}")
                                                                ->success()
                                                                ->send();
                                                        }
                                                    }
                                                })
                                                ->columnSpanFull(),
                                        ])
                                        ->collapsible()
                                        ->collapsed(),

                                    // Sección de datos personales
                                    Forms\Components\Section::make('Datos Personales')
                                        ->description('Información básica del beneficiario')
                                        ->icon('heroicon-m-user')
                                        ->schema([
                                            TextInput::make('last_name')
                                                ->label('Apellido Paterno')
                                                ->maxLength(100)
                                                ->columnSpan(1),
                                            TextInput::make('mother_last_name')
                                                ->label('Apellido Materno')
                                                ->maxLength(100)
                                                ->columnSpan(1),
                                            TextInput::make('first_names')
                                                ->label('Nombres')
                                                ->required()
                                                ->maxLength(100)
                                                ->columnSpan(2),
                                            TextInput::make('birth_year')
                                                ->label('Año de Nacimiento')
                                                ->maxLength(4)
                                                ->columnSpan(1),
                                            Select::make('gender')
                                                ->label('Género')
                                                ->required()
                                                ->options([
                                                    'M' => 'Masculino',
                                                    'F' => 'Femenino',
                                                ])
                                                ->columnSpan(1),
                                        ])
                                        ->columns(2),

                                    // Sección de información de contacto
                                    Forms\Components\Section::make('Información de Contacto')
                                        ->description('Datos de contacto del beneficiario')
                                        ->icon('heroicon-m-phone')
                                        ->schema([
                                            TextInput::make('phone')
                                                ->label('Teléfono')
                                                ->maxLength(20)
                                                ->columnSpan(1),
                                            TextInput::make('street')
                                                ->label('Calle')
                                                ->maxLength(255)
                                                ->columnSpan(1),
                                            TextInput::make('ext_number')
                                                ->label('Número')
                                                ->maxLength(50)
                                                ->columnSpan(1),
                                            TextInput::make('neighborhood')
                                                ->label('Colonia')
                                                ->maxLength(255)
                                                ->columnSpan(1),
                                            Textarea::make('address_backup')
                                                ->label('Dirección de Respaldo')
                                                ->rows(3)
                                                ->columnSpan(2),
                                        ])
                                        ->columns(2)
                                        ->collapsible()
                                        ->collapsed(),

                                    // Sección de firma
                                    SignaturePad::make('signature')->label('Firma del beneficiario'),
                                ])
                                ->addActionLabel('Agregar Beneficiario')
                                ->reorderable()
                                ->collapsible()
                                ->itemLabel(fn (array $state): ?string =>
                                    $state['first_names'] ?? $state['last_name'] ?? 'Nuevo Beneficiario'
                                )
                                ->minItems(1)
                                ->maxItems(50)
                                ->columnSpanFull(),
                        ])
                        ->collapsible()
                        ->collapsed(),
                ])
                ->action(function (array $data) {
                    $registered = 0;
                    $skipped = 0;
                    foreach ($data['beneficiarios'] as $beneficiary) {
                        $beneficiaryModel = \App\Models\Beneficiary::firstOrCreate(
                            [
                                'first_names' => $beneficiary['first_names'],
                                'last_name' => $beneficiary['last_name'],
                                'mother_last_name' => $beneficiary['mother_last_name'],
                                'birth_year' => $beneficiary['birth_year'],
                                'gender' => $beneficiary['gender'],
                            ],
                            [
                                'last_name' => $beneficiary['last_name'],
                                'mother_last_name' => $beneficiary['mother_last_name'],
                                'first_names' => $beneficiary['first_names'],
                                'birth_year' => $beneficiary['birth_year'],
                                'gender' => $beneficiary['gender'],
                                'phone' => $beneficiary['phone'] ?? null,
                                'street' => $beneficiary['street'] ?? null,
                                'ext_number' => $beneficiary['ext_number'] ?? null,
                                'neighborhood' => $beneficiary['neighborhood'] ?? null,
                                'address_backup' => $beneficiary['address_backup'] ?? null,
                                'created_by' => Auth::id(),
                            ]
                        );
                        $exists = \App\Models\BeneficiaryRegistry::where([
                            'beneficiaries_id' => $beneficiaryModel->id,
                            'activity_calendar_id' => $this->activity_calendar_id,
                        ])->first();
                        if ($exists) {
                            $skipped++;
                            continue;
                        }
                        \App\Models\BeneficiaryRegistry::create([
                            'activity_calendar_id' => $this->activity_calendar_id,
                            'beneficiaries_id' => $beneficiaryModel->id,
                            'data_collectors_id' => Auth::id(),
                            'created_by' => Auth::id(),
                            'signature' => $beneficiary['signature'] ?? null,
                        ]);
                        $registered++;
                    }
                    $msg = "Se registraron $registered beneficiarios correctamente.";
                    if ($skipped > 0) {
                        $msg .= " Se omitieron $skipped ya existentes.";
                    }
                    \Filament\Notifications\Notification::make()
                        ->title('Registro masivo completado')
                        ->body($msg)
                        ->success()
                        ->send();
                }),
        ];
    }

    protected function getTableActions(): array
    {
        return [
            Actions\Action::make('editBeneficiary')
                ->label('Editar Datos')
                ->icon('heroicon-o-user')
                ->form([
                    Forms\Components\Section::make('Editar Datos del Beneficiario')
                        ->description('Modifica la información personal del beneficiario')
                        ->icon('heroicon-o-user')
                        ->schema([
                            // Sección de datos personales
                            Forms\Components\Section::make('Datos Personales')
                                ->description('Información básica del beneficiario')
                                ->icon('heroicon-m-user')
                                ->schema([
                                    TextInput::make('last_name')
                                        ->label('Apellido paterno')
                                        ->maxLength(100)
                                        ->columnSpan(1),
                                    TextInput::make('mother_last_name')
                                        ->label('Apellido materno')
                                        ->maxLength(100)
                                        ->columnSpan(1),
                                    TextInput::make('first_names')
                                        ->label('Nombres')
                                        ->required()
                                        ->maxLength(100)
                                        ->columnSpan(2),
                                    TextInput::make('birth_year')
                                        ->label('Año de nacimiento')
                                        ->maxLength(4)
                                        ->columnSpan(1),
                                    Select::make('gender')
                                        ->label('Género')
                                        ->required()
                                        ->options([
                                            'M' => 'Masculino',
                                            'F' => 'Femenino',
                                        ])
                                        ->columnSpan(1),
                                ])
                                ->columns(2),

                            // Sección de información de contacto
                            Forms\Components\Section::make('Información de Contacto')
                                ->description('Datos de contacto del beneficiario')
                                ->icon('heroicon-m-phone')
                                ->schema([
                                    TextInput::make('phone')
                                        ->label('Teléfono')
                                        ->maxLength(20)
                                        ->columnSpan(1),
                                    TextInput::make('street')
                                        ->label('Calle')
                                        ->maxLength(255)
                                        ->columnSpan(1),
                                    TextInput::make('ext_number')
                                        ->label('Número')
                                        ->maxLength(50)
                                        ->columnSpan(1),
                                    TextInput::make('neighborhood')
                                        ->label('Colonia')
                                        ->maxLength(255)
                                        ->columnSpan(1),
                                    Textarea::make('address_backup')
                                        ->label('Dirección de respaldo')
                                        ->rows(3)
                                        ->columnSpan(2),
                                ])
                                ->columns(2)
                                ->collapsible()
                                ->collapsed(),

                            // Sección de acciones peligrosas
                            Forms\Components\Section::make('Acciones Peligrosas')
                                ->description('Acciones que no se pueden deshacer')
                                ->icon('heroicon-m-exclamation-triangle')
                                ->schema([
                                    Forms\Components\Actions::make([
                                        Forms\Components\Actions\Action::make('deleteBeneficiary')
                                            ->label('Eliminar Beneficiario')
                                            ->icon('heroicon-o-trash')
                                            ->color('danger')
                                            ->requiresConfirmation()
                                            ->modalHeading('¿Eliminar beneficiario?')
                                            ->modalDescription('Esta acción eliminará permanentemente el beneficiario y todos sus registros asociados. Esta acción no se puede deshacer.')
                                            ->modalSubmitActionLabel('Sí, eliminar permanentemente')
                                            ->modalCancelActionLabel('Cancelar')
                                            ->action(function ($record) {
                                                // Obtener el beneficiario asociado al registro
                                                $beneficiary = $record->beneficiaries;

                                                if (!$beneficiary) {
                                                    \Filament\Notifications\Notification::make()
                                                        ->title('Error')
                                                        ->body('No se encontró el beneficiario asociado.')
                                                        ->danger()
                                                        ->send();
                                                    return;
                                                }

                                                // Eliminar todos los registros asociados al beneficiario
                                                \App\Models\BeneficiaryRegistry::where('beneficiaries_id', $beneficiary->id)->delete();

                                                // Eliminar el beneficiario
                                                $beneficiary->delete();

                                                \Filament\Notifications\Notification::make()
                                                    ->title('Beneficiario eliminado')
                                                    ->body('El beneficiario y todos sus registros han sido eliminados permanentemente.')
                                                    ->success()
                                                    ->send();
                                            }),
                                    ])
                                    ->columnSpanFull(),
                                ])
                                ->collapsible()
                                ->collapsed(),
                        ])
                        ->collapsible()
                        ->collapsed(),
                ])
                ->action(function (array $data, $record) {
                    // Obtener el beneficiario asociado al registro
                    $beneficiary = $record->beneficiaries;

                    if (!$beneficiary) {
                        \Filament\Notifications\Notification::make()
                            ->title('Error')
                            ->body('No se encontró el beneficiario asociado.')
                            ->danger()
                            ->send();
                        return;
                    }

                    // Actualizar los datos del beneficiario
                    $beneficiary->update([
                        'last_name' => $data['last_name'],
                        'mother_last_name' => $data['mother_last_name'],
                        'first_names' => $data['first_names'],
                        'birth_year' => $data['birth_year'],
                        'gender' => $data['gender'],
                        'phone' => $data['phone'] ?? null,
                        'street' => $data['street'] ?? null,
                        'ext_number' => $data['ext_number'] ?? null,
                        'neighborhood' => $data['neighborhood'] ?? null,
                        'address_backup' => $data['address_backup'] ?? null,
                    ]);

                    \Filament\Notifications\Notification::make()
                        ->title('Datos actualizados')
                        ->body('Los datos del beneficiario han sido actualizados correctamente.')
                        ->success()
                        ->send();
                })
                ->fillForm(function ($record) {
                    // Prellenar el formulario con los datos actuales del beneficiario
                    $beneficiary = $record->beneficiaries;
                    return [
                        'last_name' => $beneficiary->last_name,
                        'mother_last_name' => $beneficiary->mother_last_name,
                        'first_names' => $beneficiary->first_names,
                        'birth_year' => $beneficiary->birth_year,
                        'gender' => $beneficiary->gender,
                        'phone' => $beneficiary->phone,
                        'street' => $beneficiary->street,
                        'ext_number' => $beneficiary->ext_number,
                        'neighborhood' => $beneficiary->neighborhood,
                        'address_backup' => $beneficiary->address_backup,
                    ];
                }),
            Actions\EditAction::make()
                ->label('Editar Firma')
                ->icon('heroicon-o-pencil-square')
                ->form([
                    SignaturePad::make('signature')->label('Firma del beneficiario'),
                ]),
            Actions\DeleteAction::make()
                ->label('Eliminar')
                ->icon('heroicon-o-trash')
                ->requiresConfirmation()
                ->modalHeading('¿Eliminar registro?')
                ->modalDescription('Esta acción eliminará el registro del beneficiario de esta actividad. ¿Estás seguro?')
                ->modalSubmitActionLabel('Sí, eliminar')
                ->modalCancelActionLabel('Cancelar'),
        ];
    }
}

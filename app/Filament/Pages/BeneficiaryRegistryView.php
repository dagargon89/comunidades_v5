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

class BeneficiaryRegistryView extends Page implements HasTable
{
    use InteractsWithTable;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';

    protected static string $view = 'filament.pages.beneficiary-registry-view';

    public ?int $activity_id = null;
    public ?int $activity_calendar_id = null;

    public function mount(): void
    {
        $this->activity_id = Activity::query()->min('id') ?? null;
        $firstCalendar = null;
        if ($this->activity_id) {
            $firstCalendar = ActivityCalendar::where('activity_id', $this->activity_id)
                ->orderBy('start_date')
                ->orderBy('start_hour')
                ->first();
        }
        $this->activity_calendar_id = $firstCalendar ? $firstCalendar->id : null;
    }

    public function form(\Filament\Forms\Form $form): \Filament\Forms\Form
    {
        return $form->schema([
            Section::make('Información de actividad')
                ->description('Datos de la actividad asociada')
                ->schema([
                    Select::make('activity_id')
                        ->label('Actividad')
                        ->options(Activity::pluck('name', 'id')->toArray())
                        ->searchable()
                        ->required()
                        ->live()
                        ->default(Activity::query()->min('id')),
                    Select::make('activity_calendar_id')
                        ->label('Fecha y hora de la actividad')
                        ->options(function () {
                            $activityId = $this->activity_id;
                            if (!$activityId) {
                                return [];
                            }
                            return ActivityCalendar::where('activity_id', $activityId)
                                ->orderBy('start_date')
                                ->orderBy('start_hour')
                                ->get()
                                ->mapWithKeys(function ($calendar) {
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
                            if (!$activityId) {
                                return null;
                            }
                            $firstCalendar = ActivityCalendar::where('activity_id', $activityId)
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
            ->first();
        if (!$calendar) {
            return null;
        }
        $activity = $calendar->activity;
        $responsible = $activity?->createdBy?->name ?? '-';
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
        if ($this->activity_calendar_id) {
            $query->where('activity_calendar_id', $this->activity_calendar_id);
        }
        return $query;
    }

    protected function shouldRenderTable(): bool
    {
        return $this->activity_calendar_id && $this->activity_calendar_id > 0;
    }

    protected function getTableColumns(): array
    {
        return [
            Tables\Columns\TextColumn::make('beneficiaries.last_name')->label('Apellido Paterno'),
            Tables\Columns\TextColumn::make('beneficiaries.mother_last_name')->label('Apellido Materno'),
            Tables\Columns\TextColumn::make('beneficiaries.first_names')->label('Nombres'),
            Tables\Columns\TextColumn::make('beneficiaries.birth_year')->label('Año Nacimiento'),
            Tables\Columns\TextColumn::make('beneficiaries.gender')->label('Género')
                ->formatStateUsing(fn ($state) => match ($state) {
                    'M' => 'Masculino',
                    'F' => 'Femenino',
                    'Male' => 'Male',
                    'Female' => 'Female',
                    default => $state,
                }),
            Tables\Columns\TextColumn::make('beneficiaries.phone')->label('Teléfono'),
            ImageColumn::make('signature')->label('Firma')->height(60)->width(180),
            Tables\Columns\TextColumn::make('created_at')->label('Registrado el')->dateTime('d/m/Y H:i'),
        ];
    }

    protected function getTableHeaderActions(): array
    {
        if (!$this->activity_calendar_id) {
            return [];
        }
        return [
            Actions\Action::make('addSingle')
                ->label('Registrar beneficiario único')
                ->icon('heroicon-o-user-plus')
                ->form([
                    TextInput::make('last_name')->label('Apellido paterno')->required()->maxLength(100),
                    TextInput::make('mother_last_name')->label('Apellido materno')->required()->maxLength(100),
                    TextInput::make('first_names')->label('Nombres')->required()->maxLength(100),
                    TextInput::make('birth_year')->label('Año de nacimiento')->required()->maxLength(4),
                    Select::make('gender')->label('Género')->required()
                        ->options([
                            'Male' => 'Masculino',
                            'Female' => 'Femenino',
                        ]),
                    TextInput::make('phone')->label('Teléfono')->maxLength(20),
                    Textarea::make('address_backup')->label('Dirección de respaldo'),
                    SignaturePad::make('signature')->label('Firma del beneficiario')->required()->columnSpanFull(),
                ])
                ->action(function (array $data) {
                    // Log temporal para depurar
                    \Log::info('Datos recibidos en acción:', $data);

                    // Generar identificador automáticamente
                    $identifier = \App\Models\BeneficiaryRegistry::generarIdentificador(
                        $data['first_names'],
                        $data['last_name'],
                        $data['mother_last_name'],
                        $data['birth_year'],
                        $data['gender']
                    );

                    // Crear beneficiario (sin signature, pero con identifier)
                    $beneficiary = \App\Models\Beneficiary::create([
                        'last_name' => $data['last_name'],
                        'mother_last_name' => $data['mother_last_name'],
                        'first_names' => $data['first_names'],
                        'birth_year' => $data['birth_year'],
                        'gender' => $data['gender'],
                        'phone' => $data['phone'] ?? null,
                        'address_backup' => $data['address_backup'] ?? null,
                        'identifier' => $identifier,
                        'created_by' => auth()->id(),
                    ]);
                    // Registrar en BeneficiaryRegistry (con signature)
                    \App\Models\BeneficiaryRegistry::create([
                        'activity_calendar_id' => $this->activity_calendar_id,
                        'beneficiaries_id' => $beneficiary->id,
                        'data_collectors_id' => auth()->id(),
                        'created_by' => auth()->id(),
                        'signature' => $data['signature'] ?? null,
                    ]);
                    \Filament\Notifications\Notification::make()
                        ->title('Beneficiario registrado')
                        ->success()
                        ->send();
                }),
        ];
    }

    protected function getTableActions(): array
    {
        return [
            Actions\EditAction::make()
                ->label('Editar')
                ->form([
                    SignaturePad::make('signature')->label('Firma del beneficiario')->required(),
                ]),
            Actions\DeleteAction::make()
                ->label('Eliminar')
                ->requiresConfirmation()
                ->modalHeading('¿Eliminar registro?')
                ->modalDescription('Esta acción eliminará el registro del beneficiario de esta actividad. ¿Estás seguro?')
                ->modalSubmitActionLabel('Sí, eliminar')
                ->modalCancelActionLabel('Cancelar'),
        ];
    }
}

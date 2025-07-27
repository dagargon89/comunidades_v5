<?php

namespace App\Livewire\Capturista;

use Livewire\Component;
use App\Models\Activity;
use App\Models\ActivityCalendar;
use App\Models\Beneficiary;
use App\Models\BeneficiaryRegistry as BeneficiaryRegistryModel;
use App\Models\User;
use Livewire\WithFileUploads;
use Livewire\WithPagination;
use Illuminate\Support\Facades\Log;

class BeneficiaryCapture extends Component
{
    use WithFileUploads, WithPagination;

    public ?int $activity_id = null;
    public ?int $activity_calendar_id = null;

    // Propiedades para el formulario de registro único
    public $showSingleForm = false;
    public $search_identifier = '';
    public $last_name = '';
    public $mother_last_name = '';
    public $first_names = '';
    public $birth_year = '';
    public $gender = '';
    public $phone = '';
    public $address_backup = '';
    public $signature = '';

    // Propiedades para el formulario masivo
    public $showMassiveForm = false;
    public $beneficiarios = [];

    // Propiedades para ordenamiento y filtros
    public $sortField = 'created_at';
    public $sortDirection = 'desc';
    public $search = '';
    public $filterGender = '';
    public $filterYear = '';

    protected $rules = [
        'last_name' => 'required|max:100',
        'mother_last_name' => 'required|max:100',
        'first_names' => 'required|max:100',
        'birth_year' => 'required|max:4',
        'gender' => 'required|in:M,F,Male,Female',
        'phone' => 'nullable|max:20',
        'address_backup' => 'nullable|max:500',
        'signature' => 'required',
    ];

    protected $messages = [
        'last_name.required' => 'El apellido paterno es obligatorio.',
        'mother_last_name.required' => 'El apellido materno es obligatorio.',
        'first_names.required' => 'Los nombres son obligatorios.',
        'birth_year.required' => 'El año de nacimiento es obligatorio.',
        'gender.required' => 'El género es obligatorio.',
        'signature.required' => 'La firma es obligatoria.',
    ];

    public function mount()
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

    public function updatedActivityId($value)
    {
        $this->activity_id = $value ? (int) $value : null;
        $firstCalendar = null;
        if ($this->activity_id) {
            $firstCalendar = ActivityCalendar::where('activity_id', $this->activity_id)
                ->orderBy('start_date')
                ->orderBy('start_hour')
                ->first();
        }
        $this->activity_calendar_id = $firstCalendar ? $firstCalendar->id : null;
        $this->resetPage();
    }

    public function updatedActivityCalendarId($value)
    {
        $this->activity_calendar_id = $value;
        $this->resetPage();
    }

    public function updatedSearchIdentifier()
    {
        if (!empty($this->search_identifier)) {
            $beneficiary = Beneficiary::where('identifier', $this->search_identifier)->first();
            if ($beneficiary) {
                $this->last_name = $beneficiary->last_name;
                $this->mother_last_name = $beneficiary->mother_last_name;
                $this->first_names = $beneficiary->first_names;
                $this->birth_year = $beneficiary->birth_year;
                $this->gender = $beneficiary->gender;
                $this->phone = $beneficiary->phone;
                $this->address_backup = $beneficiary->address_backup;

                session()->flash('message', 'Beneficiario encontrado. Los datos han sido pre-llenados. Solo necesitas capturar la nueva firma.');
                session()->flash('messageType', 'success');
            } else {
                $this->last_name = '';
                $this->mother_last_name = '';
                $this->first_names = '';
                $this->birth_year = '';
                $this->gender = '';
                $this->phone = '';
                $this->address_backup = '';

                session()->flash('message', 'No se encontró un beneficiario con ese identificador. Puedes proceder con el registro normal.');
                session()->flash('messageType', 'warning');
            }
        }
    }

    public function getActivityInfo()
    {
        if (!$this->activity_id || !$this->activity_calendar_id) {
            return null;
        }

        $calendar = ActivityCalendar::where('id', $this->activity_calendar_id)->first();
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

    public function getActivities()
    {
        return Activity::pluck('name', 'id')->toArray();
    }

    public function getActivityCalendars()
    {
        if (!$this->activity_id) {
            return [];
        }

        $calendars = ActivityCalendar::where('activity_id', $this->activity_id)
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
        })->toArray();
    }

    public function getCalendarCount()
    {
        if (!$this->activity_id) {
            return 0;
        }
        return ActivityCalendar::where('activity_id', $this->activity_id)->count();
    }

    public function getBeneficiaries()
    {
        if (!$this->activity_calendar_id || $this->activity_calendar_id <= 0) {
            return collect();
        }

        $query = BeneficiaryRegistryModel::with(['beneficiaries', 'activityCalendar'])
            ->where('activity_calendar_id', $this->activity_calendar_id);

        // Aplicar filtros
        if (!empty($this->search)) {
            $query->whereHas('beneficiaries', function ($q) {
                $q->where('identifier', 'like', '%' . $this->search . '%')
                  ->orWhere('last_name', 'like', '%' . $this->search . '%')
                  ->orWhere('mother_last_name', 'like', '%' . $this->search . '%')
                  ->orWhere('first_names', 'like', '%' . $this->search . '%');
            });
        }

        if (!empty($this->filterGender)) {
            $query->whereHas('beneficiaries', function ($q) {
                $q->where('gender', $this->filterGender);
            });
        }

        if (!empty($this->filterYear)) {
            $query->whereHas('beneficiaries', function ($q) {
                $q->where('birth_year', $this->filterYear);
            });
        }

        // Aplicar ordenamiento
        if ($this->sortField === 'identifier') {
            $query->join('beneficiaries', 'beneficiary_registries.beneficiaries_id', '=', 'beneficiaries.id')
                  ->orderBy('beneficiaries.identifier', $this->sortDirection);
        } elseif ($this->sortField === 'last_name') {
            $query->join('beneficiaries', 'beneficiary_registries.beneficiaries_id', '=', 'beneficiaries.id')
                  ->orderBy('beneficiaries.last_name', $this->sortDirection);
        } elseif ($this->sortField === 'first_names') {
            $query->join('beneficiaries', 'beneficiary_registries.beneficiaries_id', '=', 'beneficiaries.id')
                  ->orderBy('beneficiaries.first_names', $this->sortDirection);
        } elseif ($this->sortField === 'gender') {
            $query->join('beneficiaries', 'beneficiary_registries.beneficiaries_id', '=', 'beneficiaries.id')
                  ->orderBy('beneficiaries.gender', $this->sortDirection);
        } elseif ($this->sortField === 'birth_year') {
            $query->join('beneficiaries', 'beneficiary_registries.beneficiaries_id', '=', 'beneficiaries.id')
                  ->orderBy('beneficiaries.birth_year', $this->sortDirection);
        } else {
            $query->orderBy($this->sortField, $this->sortDirection);
        }

        return $query->paginate(10);
    }

    public function showSingleForm()
    {
        $this->showSingleForm = true;
        $this->showMassiveForm = false;
        $this->resetForm();
    }

    public function showMassiveForm()
    {
        $this->showMassiveForm = true;
        $this->showSingleForm = false;
        $this->beneficiarios = [
            [
                'search_identifier' => '',
                'last_name' => '',
                'mother_last_name' => '',
                'first_names' => '',
                'birth_year' => '',
                'gender' => '',
                'phone' => '',
                'signature' => '',
            ]
        ];
    }

    public function addBeneficiaryRow()
    {
        $this->beneficiarios[] = [
            'search_identifier' => '',
            'last_name' => '',
            'mother_last_name' => '',
            'first_names' => '',
            'birth_year' => '',
            'gender' => '',
            'phone' => '',
            'signature' => '',
        ];
    }

    public function removeBeneficiaryRow($index)
    {
        unset($this->beneficiarios[$index]);
        $this->beneficiarios = array_values($this->beneficiarios);
    }

    public function saveSingleBeneficiary()
    {
        $this->validate();

        // Generar identificador automáticamente
        $identifier = BeneficiaryRegistryModel::generarIdentificador(
            $this->first_names,
            $this->last_name,
            $this->mother_last_name,
            $this->birth_year,
            $this->gender
        );

        // Buscar beneficiario existente o crear uno nuevo
        $beneficiary = Beneficiary::firstOrCreate(
            ['identifier' => $identifier],
            [
                'last_name' => $this->last_name,
                'mother_last_name' => $this->mother_last_name,
                'first_names' => $this->first_names,
                'birth_year' => $this->birth_year,
                'gender' => $this->gender,
                'phone' => $this->phone ?? null,
                'address_backup' => $this->address_backup ?? null,
                'identifier' => $identifier,
                'created_by' => auth()->id(),
            ]
        );

        // Verificar si ya existe una participación
        $existingParticipation = BeneficiaryRegistryModel::where([
            'beneficiaries_id' => $beneficiary->id,
            'activity_calendar_id' => $this->activity_calendar_id,
        ])->first();

        if ($existingParticipation) {
            session()->flash('message', 'Este beneficiario ya está registrado para esta actividad en la fecha seleccionada.');
            session()->flash('messageType', 'warning');
            return;
        }

        // Registrar en BeneficiaryRegistry
        BeneficiaryRegistryModel::create([
            'activity_calendar_id' => $this->activity_calendar_id,
            'beneficiaries_id' => $beneficiary->id,
            'data_collectors_id' => auth()->id(),
            'created_by' => auth()->id(),
            'signature' => $this->signature,
        ]);

        session()->flash('message', 'Beneficiario registrado correctamente.');
        session()->flash('messageType', 'success');

        $this->showSingleForm = false;
        $this->resetForm();
    }

    public function saveMassiveBeneficiaries()
    {
        $this->validate([
            'beneficiarios.*.last_name' => 'required|max:100',
            'beneficiarios.*.mother_last_name' => 'required|max:100',
            'beneficiarios.*.first_names' => 'required|max:100',
            'beneficiarios.*.birth_year' => 'required|max:4',
            'beneficiarios.*.gender' => 'required|in:M,F',
            'beneficiarios.*.signature' => 'required',
        ]);

        $registered = 0;
        $skipped = 0;

        foreach ($this->beneficiarios as $beneficiary) {
            $identifier = BeneficiaryRegistryModel::generarIdentificador(
                $beneficiary['first_names'] ?? '',
                $beneficiary['last_name'] ?? '',
                $beneficiary['mother_last_name'] ?? '',
                $beneficiary['birth_year'] ?? '',
                $beneficiary['gender'] ?? ''
            );

            $beneficiaryModel = Beneficiary::firstOrCreate(
                ['identifier' => $identifier],
                [
                    'last_name' => $beneficiary['last_name'],
                    'mother_last_name' => $beneficiary['mother_last_name'],
                    'first_names' => $beneficiary['first_names'],
                    'birth_year' => $beneficiary['birth_year'],
                    'gender' => $beneficiary['gender'],
                    'phone' => $beneficiary['phone'] ?? null,
                    'address_backup' => $beneficiary['address_backup'] ?? null,
                    'identifier' => $identifier,
                    'created_by' => auth()->id(),
                ]
            );

            $exists = BeneficiaryRegistryModel::where([
                'beneficiaries_id' => $beneficiaryModel->id,
                'activity_calendar_id' => $this->activity_calendar_id,
            ])->first();

            if ($exists) {
                $skipped++;
                continue;
            }

            BeneficiaryRegistryModel::create([
                'activity_calendar_id' => $this->activity_calendar_id,
                'beneficiaries_id' => $beneficiaryModel->id,
                'data_collectors_id' => auth()->id(),
                'created_by' => auth()->id(),
                'signature' => $beneficiary['signature'] ?? null,
            ]);
            $registered++;
        }

        $msg = "Se registraron $registered beneficiarios correctamente.";
        if ($skipped > 0) {
            $msg .= " Se omitieron $skipped ya existentes.";
        }

        session()->flash('message', $msg);
        session()->flash('messageType', 'success');

        $this->showMassiveForm = false;
        $this->beneficiarios = [];
    }

    public function deleteBeneficiary($id)
    {
        $registry = BeneficiaryRegistryModel::find($id);
        if ($registry) {
            $registry->delete();
            session()->flash('message', 'Registro eliminado correctamente.');
            session()->flash('messageType', 'success');
        }
    }

    public function resetForm()
    {
        $this->search_identifier = '';
        $this->last_name = '';
        $this->mother_last_name = '';
        $this->first_names = '';
        $this->birth_year = '';
        $this->gender = '';
        $this->phone = '';
        $this->address_backup = '';
        $this->signature = '';
    }

    public function cancelForm()
    {
        $this->showSingleForm = false;
        $this->showMassiveForm = false;
        $this->resetForm();
        $this->beneficiarios = [];
    }

    public function sortBy($field)
    {
        if ($this->sortField === $field) {
            $this->sortDirection = $this->sortDirection === 'asc' ? 'desc' : 'asc';
        } else {
            $this->sortField = $field;
            $this->sortDirection = 'asc';
        }
    }

    public function clearFilters()
    {
        $this->search = '';
        $this->filterGender = '';
        $this->filterYear = '';
        $this->resetPage();
    }

    public function updatedSearch()
    {
        $this->resetPage();
    }

    public function updatedFilterGender()
    {
        $this->resetPage();
    }

    public function updatedFilterYear()
    {
        $this->resetPage();
    }

    public function render()
    {
        return view('livewire.capturista.beneficiary-capture', [
            'activities' => $this->getActivities(),
            'activityCalendars' => $this->getActivityCalendars(),
            'calendarCount' => $this->getCalendarCount(),
            'activityInfo' => $this->getActivityInfo(),
            'beneficiaries' => $this->getBeneficiaries(),
        ]);
    }
}

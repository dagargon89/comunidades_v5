<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Actions\Action;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Checkbox;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Illuminate\Support\Facades\Session;

class ProjectCreationGuide extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Guía de Creación de Proyectos';
    protected static ?string $title = 'Guía de Creación de Proyectos';

    protected static string $view = 'filament.pages.project-creation-guide';

    // Propiedades para almacenar datos temporales
    public $projectData = null;
    public $objectivesData = [];
    public $kpisData = [];
    public $cofinanciersData = [];
    public $activitiesData = [];
    public $locationsData = [];
    public $scheduledActivitiesData = [];

    // Propiedades para modales
    public $showProjectModal = false;
    public $showObjectivesModal = false;
    public $showKpisModal = false;
    public $showCofinanciersModal = false;
    public $showActivitiesModal = false;
    public $showLocationsModal = false;
    public $showSchedulingModal = false;
    public $showSummaryModal = false;

    // Formularios
    public $projectForm;
    public $objectivesForm;
    public $kpisForm;
    public $cofinanciersForm;
    public $activitiesForm;
    public $locationsForm;
    public $schedulingForm;

    public function mount()
    {
        $this->loadTemporaryData();
    }

    public function loadTemporaryData()
    {
        $this->projectData = Session::get('project_creation_guide.project', null);
        $this->objectivesData = Session::get('project_creation_guide.objectives', []);
        $this->kpisData = Session::get('project_creation_guide.kpis', []);
        $this->cofinanciersData = Session::get('project_creation_guide.cofinanciers', []);
        $this->activitiesData = Session::get('project_creation_guide.activities', []);
        $this->locationsData = Session::get('project_creation_guide.locations', []);
        $this->scheduledActivitiesData = Session::get('project_creation_guide.scheduled_activities', []);
    }

    public function saveTemporaryData()
    {
        Session::put('project_creation_guide.project', $this->projectData);
        Session::put('project_creation_guide.objectives', $this->objectivesData);
        Session::put('project_creation_guide.kpis', $this->kpisData);
        Session::put('project_creation_guide.cofinanciers', $this->cofinanciersData);
        Session::put('project_creation_guide.activities', $this->activitiesData);
        Session::put('project_creation_guide.locations', $this->locationsData);
        Session::put('project_creation_guide.scheduled_activities', $this->scheduledActivitiesData);
    }

    // Métodos para abrir modales
    public function openProjectModal()
    {
        $this->showProjectModal = true;
    }

    public function openObjectivesModal()
    {
        $this->showObjectivesModal = true;
    }

    public function openKpisModal()
    {
        $this->showKpisModal = true;
    }

    public function openCofinanciersModal()
    {
        $this->showCofinanciersModal = true;
    }

    public function openActivitiesModal()
    {
        $this->showActivitiesModal = true;
    }

    public function openLocationsModal()
    {
        $this->showLocationsModal = true;
    }

    public function openSchedulingModal()
    {
        $this->showSchedulingModal = true;
    }

    public function openSummaryModal()
    {
        $this->showSummaryModal = true;
    }

    // Métodos para cerrar modales
    public function closeProjectModal()
    {
        $this->showProjectModal = false;
    }

    public function closeObjectivesModal()
    {
        $this->showObjectivesModal = false;
    }

    public function closeKpisModal()
    {
        $this->showKpisModal = false;
    }

    public function closeCofinanciersModal()
    {
        $this->showCofinanciersModal = false;
    }

    public function closeActivitiesModal()
    {
        $this->showActivitiesModal = false;
    }

    public function closeLocationsModal()
    {
        $this->showLocationsModal = false;
    }

    public function closeSchedulingModal()
    {
        $this->showSchedulingModal = false;
    }

    public function closeSummaryModal()
    {
        $this->showSummaryModal = false;
    }

    // Métodos para guardar datos de modales
    public function saveProjectData($data)
    {
        $this->projectData = $data;
        $this->saveTemporaryData();
        $this->closeProjectModal();

        Notification::make()
            ->title('Proyecto guardado temporalmente')
            ->success()
            ->send();
    }

    public function saveObjectivesData($data)
    {
        $this->objectivesData = $data;
        $this->saveTemporaryData();
        $this->closeObjectivesModal();

        Notification::make()
            ->title('Objetivos guardados temporalmente')
            ->success()
            ->send();
    }

    public function saveKpisData($data)
    {
        $this->kpisData = $data;
        $this->saveTemporaryData();
        $this->closeKpisModal();

        Notification::make()
            ->title('KPIs guardados temporalmente')
            ->success()
            ->send();
    }

    public function saveCofinanciersData($data)
    {
        $this->cofinanciersData = $data;
        $this->saveTemporaryData();
        $this->closeCofinanciersModal();

        Notification::make()
            ->title('Cofinanciadores guardados temporalmente')
            ->success()
            ->send();
    }

    public function saveActivitiesData($data)
    {
        $this->activitiesData = $data;
        $this->saveTemporaryData();
        $this->closeActivitiesModal();

        Notification::make()
            ->title('Actividades guardadas temporalmente')
            ->success()
            ->send();
    }

    public function saveLocationsData($data)
    {
        $this->locationsData = $data;
        $this->saveTemporaryData();
        $this->closeLocationsModal();

        Notification::make()
            ->title('Ubicaciones guardadas temporalmente')
            ->success()
            ->send();
    }

    public function saveSchedulingData($data)
    {
        $this->scheduledActivitiesData = $data;
        $this->saveTemporaryData();
        $this->closeSchedulingModal();

        Notification::make()
            ->title('Programación guardada temporalmente')
            ->success()
            ->send();
    }

    // Método para calcular progreso
    public function getCompletedStepsProperty()
    {
        $steps = 0;
        if ($this->projectData) $steps++;
        if ($this->objectivesData && count($this->objectivesData) > 0) $steps++;
        if ($this->kpisData && count($this->kpisData) > 0) $steps++;
        if ($this->cofinanciersData && count($this->cofinanciersData) > 0) $steps++;
        if ($this->activitiesData && count($this->activitiesData) > 0) $steps++;
        if ($this->locationsData && count($this->locationsData) > 0) $steps++;
        if ($this->scheduledActivitiesData && count($this->scheduledActivitiesData) > 0) $steps++;

        return $steps;
    }

    public function getTotalStepsProperty()
    {
        return 7;
    }

    // Método para guardar todo finalmente
    public function saveAllData()
    {
        try {
            // Aquí implementaremos la lógica para guardar todo en las tablas
            // Por ahora solo limpiaremos los datos temporales

            Session::forget('project_creation_guide');

            Notification::make()
                ->title('Proyecto creado exitosamente')
                ->success()
                ->send();

            $this->redirect('/admin/projects');

        } catch (\Exception $e) {
            Notification::make()
                ->title('Error al crear el proyecto')
                ->body($e->getMessage())
                ->danger()
                ->send();
        }
    }
}

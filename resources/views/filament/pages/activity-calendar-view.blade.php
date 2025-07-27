<x-filament-panels::page>
    <div class="mb-4">
        <a href="{{ url('/admin/gestor-actividades') }}">
            <x-filament::button color="warning" icon="heroicon-o-arrow-left">
                Regresar a Gantt de Proyectos
            </x-filament::button>
        </a>
    </div>
    <form wire:submit.prevent="submit">
        {{ $this->form }}
        <div class="flex justify-end mt-4">
            <x-filament::button type="submit" color="primary">
                Guardar actividad
            </x-filament::button>
        </div>
    </form>
</x-filament-panels::page>

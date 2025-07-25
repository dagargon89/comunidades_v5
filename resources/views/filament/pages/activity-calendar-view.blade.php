<x-filament-panels::page>
    <form wire:submit.prevent="submit">
        {{ $this->form }}
        <div class="flex justify-end mt-4">
            <x-filament::button type="submit" color="primary">
                Guardar actividad
            </x-filament::button>
        </div>
    </form>
</x-filament-panels::page>

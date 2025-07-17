<x-filament-panels::page>
    <x-slot name="header">
        <h1 class="text-2xl font-bold tracking-tight">Gestión de Archivos de Actividades</h1>
    </x-slot>

    {{-- Formulario de selección de actividad y fecha --}}
    {{ $this->form }}

    {{-- Información de la actividad seleccionada --}}
    @php $info = $this->getActivityInfo(); @endphp
    @if($info)
        <x-filament::section>
            <x-filament::grid default="1" md="3" xl="5" class="gap-4">
                <x-filament::card class="bg-primary-50 border-primary-200">
                    <div class="text-xs text-primary-600 font-semibold uppercase mb-1">Actividad</div>
                    <div class="text-base font-bold text-primary-900">{{ $info['actividad'] }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">Fecha</div>
                    <div class="text-base font-bold text-gray-900">
                        {{ \Carbon\Carbon::parse($info['fecha'])->translatedFormat('d \d\e F \d\e Y') }}
                    </div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">Hora de inicio</div>
                    <div class="text-base font-bold text-gray-900">{{ $info['hora_inicio'] }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">Hora de fin</div>
                    <div class="text-base font-bold text-gray-900">{{ $info['hora_fin'] }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">Responsable</div>
                    <div class="text-base font-bold text-gray-900">{{ $info['responsable'] }}</div>
                </x-filament::card>
            </x-filament::grid>
        </x-filament::section>
    @endif

    {{-- Tabla de archivos de la actividad --}}
    <x-filament::section>
        <h2 class="text-lg font-semibold mb-4">Archivos de la actividad</h2>
        {{ $this->table }}
    </x-filament::section>
</x-filament-panels::page>

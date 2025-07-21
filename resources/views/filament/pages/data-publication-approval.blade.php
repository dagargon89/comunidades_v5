<x-filament-panels::page>
    <x-slot name="header">
        <h1 class="text-2xl font-bold tracking-tight">Aprobar publicación de datos</h1>
    </x-slot>

    {{-- PROYECTO --}}
    <h2 class="text-lg font-semibold mt-6 mb-2">Proyecto</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <x-filament::section>
            <x-filament::grid default="1" class="gap-4">
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">1. Nombre</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingProject?->name ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">2. Descripción</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingProject?->description ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">3. Costo total</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingProject?->total_cost ?? '-' }}</div>
                </x-filament::card>
            </x-filament::grid>
        </x-filament::section>
        <x-filament::section>
            <x-filament::grid default="1" class="gap-4">
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">1. Nombre</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedProject?->name ?? 'No hay publicaciones previas.' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">2. Descripción</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedProject?->description ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">3. Costo total</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedProject?->total_cost ?? '-' }}</div>
                </x-filament::card>
            </x-filament::grid>
        </x-filament::section>
    </div>

    {{-- ACTIVIDAD --}}
    <h2 class="text-lg font-semibold mt-8 mb-2">Actividad</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <x-filament::section>
            <x-filament::grid default="1" class="gap-4">
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">1. Nombre</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingActivity?->name ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">2. Descripción</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingActivity?->description ?? '-' }}</div>
                </x-filament::card>
            </x-filament::grid>
        </x-filament::section>
        <x-filament::section>
            <x-filament::grid default="1" class="gap-4">
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">1. Nombre</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedActivity?->name ?? 'No hay publicaciones previas.' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">2. Descripción</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedActivity?->description ?? '-' }}</div>
                </x-filament::card>
            </x-filament::grid>
        </x-filament::section>
    </div>

    {{-- MÉTRICA PLANIFICADA --}}
    <h2 class="text-lg font-semibold mt-8 mb-2">Métrica planificada</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <x-filament::section>
            <x-filament::grid default="1" class="gap-4">
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">1. Unidad</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingMetric?->unit ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">2. Año</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingMetric?->year ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">3. Mes</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingMetric?->month ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">4. Meta población</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingMetric?->population_target_value ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">5. Valor real población</div>
                    <div class="text-base font-bold text-gray-900">{{ $pendingMetric?->population_real_value ?? '-' }}</div>
                </x-filament::card>
            </x-filament::grid>
        </x-filament::section>
        <x-filament::section>
            <x-filament::grid default="1" class="gap-4">
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">1. Unidad</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedMetric?->unit ?? 'No hay publicaciones previas.' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">2. Año</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedMetric?->year ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">3. Mes</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedMetric?->month ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">4. Meta población</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedMetric?->population_target_value ?? '-' }}</div>
                </x-filament::card>
                <x-filament::card>
                    <div class="text-xs text-gray-500 font-semibold uppercase mb-1">5. Valor real población</div>
                    <div class="text-base font-bold text-gray-900">{{ $lastPublishedMetric?->population_real_value ?? '-' }}</div>
                </x-filament::card>
            </x-filament::grid>
        </x-filament::section>
    </div>
</x-filament-panels::page>

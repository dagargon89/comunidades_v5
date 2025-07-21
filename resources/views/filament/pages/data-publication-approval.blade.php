<x-filament-panels::page>
    <x-slot name="header">
        <h1 class="text-2xl font-bold tracking-tight">Datos pendientes de publicación</h1>
    </x-slot>

    {{-- Proyectos no publicados --}}
    <h2 class="text-lg font-semibold mt-6 mb-2">Proyectos no publicados</h2>
    <x-filament::section>
        <x-filament::grid default="1" md="2" class="gap-4">
            @forelse($pendingProjects as $project)
                <x-filament::card>
                    <div><strong>Nombre:</strong> {{ $project->name }}</div>
                    <div><strong>Descripción:</strong> {{ $project->description }}</div>
                    <div><strong>Costo total:</strong> {{ $project->total_cost }}</div>
                </x-filament::card>
            @empty
                <div class="text-gray-500">No hay proyectos pendientes de publicación.</div>
            @endforelse
        </x-filament::grid>
    </x-filament::section>

    {{-- Actividades no publicadas --}}
    <h2 class="text-lg font-semibold mt-8 mb-2">Actividades no publicadas</h2>
    <x-filament::section>
        <x-filament::grid default="1" md="2" class="gap-4">
            @forelse($pendingActivities as $activity)
                <x-filament::card>
                    <div><strong>Nombre:</strong> {{ $activity->name }}</div>
                    <div><strong>Descripción:</strong> {{ $activity->description }}</div>
                </x-filament::card>
            @empty
                <div class="text-gray-500">No hay actividades pendientes de publicación.</div>
            @endforelse
        </x-filament::grid>
    </x-filament::section>

    {{-- Métricas no publicadas --}}
    <h2 class="text-lg font-semibold mt-8 mb-2">Métricas no publicadas</h2>
    <x-filament::section>
        <x-filament::grid default="1" md="2" class="gap-4">
            @forelse($pendingMetrics as $metric)
                <x-filament::card>
                    <div><strong>Unidad:</strong> {{ $metric->unit }}</div>
                    <div><strong>Año/Mes:</strong> {{ $metric->year }}/{{ $metric->month }}</div>
                    <div><strong>Meta población:</strong> {{ $metric->population_target_value }}</div>
                    <div><strong>Valor real población:</strong> {{ $metric->population_real_value }}</div>
                </x-filament::card>
            @empty
                <div class="text-gray-500">No hay métricas pendientes de publicación.</div>
            @endforelse
        </x-filament::grid>
    </x-filament::section>
</x-filament-panels::page>

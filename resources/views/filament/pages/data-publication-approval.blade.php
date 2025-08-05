<x-filament-panels::page>
    <x-slot name="header">
        <h1 class="text-2xl font-bold tracking-tight">Datos pendientes de publicación</h1>
    </x-slot>

    {{-- Resumen de estadísticas --}}
    <x-filament::section>
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="bg-blue-50 p-4 rounded-lg">
                <div class="text-2xl font-bold text-blue-600">{{ $pendingProjects->count() }}</div>
                <div class="text-sm text-gray-600">Proyectos pendientes</div>
            </div>
            <div class="bg-green-50 p-4 rounded-lg">
                <div class="text-2xl font-bold text-green-600">{{ $pendingActivities->count() }}</div>
                <div class="text-sm text-gray-600">Actividades pendientes</div>
            </div>
            <div class="bg-yellow-50 p-4 rounded-lg">
                <div class="text-2xl font-bold text-yellow-600">{{ $pendingMetrics->count() }}</div>
                <div class="text-sm text-gray-600">Métricas pendientes</div>
            </div>
            <div class="bg-purple-50 p-4 rounded-lg">
                <div class="text-2xl font-bold text-purple-600">{{ $pendingProjects->count() + $pendingActivities->count() + $pendingMetrics->count() }}</div>
                <div class="text-sm text-gray-600">Total de elementos</div>
            </div>
        </div>
    </x-filament::section>

    {{-- Campo para notas de publicación --}}
    <x-filament::section>
        <div class="space-y-4">
            <h2 class="text-lg font-semibold">Notas de publicación (opcional)</h2>
            <x-filament::input.wrapper>
                <x-filament::input
                    wire:model="publicationNotes"
                    placeholder="Ingrese notas sobre esta publicación..."
                    type="textarea"
                    rows="3"
                />
            </x-filament::input.wrapper>
        </div>
    </x-filament::section>

    {{-- Botones de aprobación --}}
    <x-filament::section>
        <div class="space-y-4">
            <h2 class="text-lg font-semibold">Acciones de aprobación</h2>
            <div class="flex flex-wrap gap-4">
                <x-filament::button
                    wire:click="approvePublication"
                    color="success"
                    size="lg"
                    icon="heroicon-o-check-circle"
                >
                    Aprobar todo
                </x-filament::button>

                <x-filament::button
                    wire:click="approveProjectsOnly"
                    color="primary"
                    size="lg"
                    icon="heroicon-o-document-text"
                >
                    Aprobar solo proyectos
                </x-filament::button>

                <x-filament::button
                    wire:click="approveActivitiesOnly"
                    color="warning"
                    size="lg"
                    icon="heroicon-o-calendar"
                >
                    Aprobar solo actividades
                </x-filament::button>

                <x-filament::button
                    wire:click="approveMetricsOnly"
                    color="info"
                    size="lg"
                    icon="heroicon-o-chart-bar"
                >
                    Aprobar solo métricas
                </x-filament::button>
            </div>
        </div>
    </x-filament::section>

    {{-- Proyectos no publicados --}}
    <h2 class="text-lg font-semibold mt-6 mb-2">Proyectos no publicados ({{ $pendingProjects->count() }})</h2>
    <x-filament::section>
        <x-filament::grid default="1" md="2" class="gap-4">
            @forelse($pendingProjects as $project)
                <x-filament::card>
                    <div class="space-y-2">
                        <div><strong>Nombre:</strong> {{ $project->name }}</div>
                        <div><strong>Financiador:</strong> {{ $project->financiers->name ?? 'No definido' }}</div>
                        <div><strong>Costo total:</strong> ${{ number_format($project->total_cost ?? 0, 2) }}</div>
                        <div><strong>Monto financiado:</strong> ${{ number_format($project->funded_amount ?? 0, 2) }}</div>
                        <div><strong>Cofinanciamiento:</strong> ${{ number_format($project->cofunding_amount ?? 0, 2) }}</div>
                        <div><strong>Período:</strong> {{ $project->start_date?->format('d/m/Y') ?? 'No definida' }} - {{ $project->end_date?->format('d/m/Y') ?? 'No definida' }}</div>
                        <div><strong>Oficial de seguimiento:</strong> {{ $project->followup_officer ?? 'No asignado' }}</div>
                    </div>
                </x-filament::card>
            @empty
                <div class="text-gray-500">No hay proyectos pendientes de publicación.</div>
            @endforelse
        </x-filament::grid>
    </x-filament::section>

    {{-- Actividades no publicadas --}}
    <h2 class="text-lg font-semibold mt-8 mb-2">Actividades no publicadas ({{ $pendingActivities->count() }})</h2>
    <x-filament::section>
        <x-filament::grid default="1" md="2" class="gap-4">
            @forelse($pendingActivities as $activity)
                <x-filament::card>
                    <div class="space-y-2">
                        <div><strong>Nombre:</strong> {{ $activity->name }}</div>
                        <div><strong>Descripción:</strong> {{ Str::limit($activity->description ?? 'Sin descripción', 100) }}</div>
                        <div><strong>Meta:</strong> {{ Str::limit($activity->goal->description ?? 'Sin meta', 80) }}</div>
                        <div><strong>Proyecto:</strong> {{ $activity->goal->project->name ?? 'Sin proyecto' }}</div>
                        <div><strong>Objetivo específico:</strong> {{ Str::limit($activity->specificObjective->description ?? 'Sin objetivo específico', 80) }}</div>
                    </div>
                </x-filament::card>
            @empty
                <div class="text-gray-500">No hay actividades pendientes de publicación.</div>
            @endforelse
        </x-filament::grid>
    </x-filament::section>

    {{-- Métricas no publicadas --}}
    <h2 class="text-lg font-semibold mt-8 mb-2">Métricas no publicadas ({{ $pendingMetrics->count() }})</h2>
    <x-filament::section>
        <x-filament::grid default="1" md="2" class="gap-4">
            @forelse($pendingMetrics as $metric)
                <x-filament::card>
                    <div class="space-y-2">
                        <div><strong>Actividad:</strong> {{ $metric->activity->name ?? 'Sin actividad' }}</div>
                        <div><strong>Unidad:</strong> {{ $metric->unit ?? 'No definida' }}</div>
                        <div><strong>Período:</strong> {{ $metric->year ?? 'N/A' }}/{{ $metric->month ?? 'N/A' }}</div>
                        <div><strong>Meta población:</strong> {{ number_format($metric->population_target_value ?? 0) }}</div>
                        <div><strong>Valor real población:</strong> {{ number_format($metric->population_real_value ?? 0) }}</div>
                        <div><strong>Meta producto:</strong> {{ number_format($metric->product_target_value ?? 0) }}</div>
                        <div><strong>Valor real producto:</strong> {{ number_format($metric->product_real_value ?? 0) }}</div>
                        <div><strong>Proyecto:</strong> {{ $metric->activity->goal->project->name ?? 'Sin proyecto' }}</div>
                    </div>
                </x-filament::card>
            @empty
                <div class="text-gray-500">No hay métricas pendientes de publicación.</div>
            @endforelse
        </x-filament::grid>
    </x-filament::section>
</x-filament-panels::page>

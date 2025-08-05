<x-filament-panels::page>
    <x-slot name="header">
        <h1 class="text-2xl font-bold tracking-tight">Datos pendientes de publicación</h1>
    </x-slot>

    {{-- Resumen de estadísticas --}}
    <x-filament::section>
        <div class="flex flex-wrap gap-4 justify-center">
            <div class="bg-blue-50 p-3 rounded-lg min-w-[120px] text-center">
                <div class="text-xl font-bold text-blue-600">{{ $pendingProjects->count() }}</div>
                <div class="text-xs text-gray-600">Proyectos</div>
            </div>
            <div class="bg-green-50 p-3 rounded-lg min-w-[120px] text-center">
                <div class="text-xl font-bold text-green-600">{{ collect($projectsWithData)->sum('activities_count') }}</div>
                <div class="text-xs text-gray-600">Actividades</div>
            </div>
            <div class="bg-yellow-50 p-3 rounded-lg min-w-[120px] text-center">
                <div class="text-xl font-bold text-yellow-600">{{ collect($projectsWithData)->sum('metrics_count') }}</div>
                <div class="text-xs text-gray-600">Métricas</div>
            </div>
            <div class="bg-purple-50 p-3 rounded-lg min-w-[120px] text-center">
                <div class="text-xl font-bold text-purple-600">{{ $pendingProjects->count() + collect($projectsWithData)->sum('activities_count') + collect($projectsWithData)->sum('metrics_count') }}</div>
                <div class="text-xs text-gray-600">Total</div>
            </div>
        </div>
    </x-filament::section>

    {{-- Datos organizados por proyecto --}}
    @forelse($projectsWithData as $projectData)
        <x-filament::section>
            <div class="space-y-6">
                {{-- Información del proyecto --}}
                <div class="border-b pb-4">
                    <h2 class="text-xl font-bold text-gray-800 mb-3">{{ $projectData['project']->name }}</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 text-sm">
                        <div><strong>Financiador:</strong> {{ $projectData['project']->financiers->name ?? 'No definido' }}</div>
                        <div><strong>Costo total:</strong> ${{ number_format($projectData['project']->total_cost ?? 0, 2) }}</div>
                        <div><strong>Período:</strong> {{ $projectData['project']->start_date?->format('d/m/Y') ?? 'No definida' }} - {{ $projectData['project']->end_date?->format('d/m/Y') ?? 'No definida' }}</div>
                        <div><strong>Oficial:</strong> {{ $projectData['project']->followup_officer ?? 'No asignado' }}</div>
                    </div>
                </div>

                {{-- Actividades del proyecto --}}
                @if($projectData['activities']->count() > 0)
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-3">Actividades pendientes ({{ $projectData['activities_count'] }})</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            @foreach($projectData['activities'] as $activity)
                                <x-filament::card>
                                    <div class="space-y-2">
                                        <div><strong>Nombre:</strong> {{ $activity->name }}</div>
                                        <div><strong>Descripción:</strong> {{ Str::limit($activity->description ?? 'Sin descripción', 100) }}</div>
                                        <div><strong>Meta:</strong> {{ Str::limit($activity->goal->description ?? 'Sin meta', 80) }}</div>
                                        <div><strong>Objetivo específico:</strong> {{ Str::limit($activity->specificObjective->description ?? 'Sin objetivo específico', 80) }}</div>
                                    </div>
                                </x-filament::card>
                            @endforeach
                        </div>
                    </div>
                @endif

                {{-- Métricas del proyecto --}}
                @if($projectData['metrics']->count() > 0)
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-3">Métricas pendientes ({{ $projectData['metrics_count'] }})</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            @foreach($projectData['metrics'] as $metric)
                                <x-filament::card>
                                    <div class="space-y-2">
                                        <div><strong>Actividad:</strong> {{ $metric->activity->name ?? 'Sin actividad' }}</div>
                                        <div><strong>Unidad:</strong> {{ $metric->unit ?? 'No definida' }}</div>
                                        <div><strong>Período:</strong> {{ $metric->year ?? 'N/A' }}/{{ $metric->month ?? 'N/A' }}</div>
                                        <div><strong>Meta población:</strong> {{ number_format($metric->population_target_value ?? 0) }}</div>
                                        <div><strong>Valor real población:</strong> {{ number_format($metric->population_real_value ?? 0) }}</div>
                                        <div><strong>Meta producto:</strong> {{ number_format($metric->product_target_value ?? 0) }}</div>
                                        <div><strong>Valor real producto:</strong> {{ number_format($metric->product_real_value ?? 0) }}</div>
                                    </div>
                                </x-filament::card>
                            @endforeach
                        </div>
                    </div>
                @endif
            </div>
        </x-filament::section>
    @empty
        <x-filament::section>
            <div class="text-center text-gray-500 py-8">
                <p class="text-lg">No hay proyectos pendientes de publicación.</p>
            </div>
        </x-filament::section>
    @endforelse

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

    {{-- Botón de aprobación --}}
    <x-filament::section>
        <div class="space-y-4">
            <h2 class="text-lg font-semibold">Acción de aprobación</h2>
            <div class="flex justify-center">
                <x-filament::button
                    wire:click="approvePublication"
                    color="success"
                    size="lg"
                    icon="heroicon-o-check-circle"
                >
                    Aprobar todo
                </x-filament::button>
            </div>
        </div>
    </x-filament::section>
</x-filament-panels::page>

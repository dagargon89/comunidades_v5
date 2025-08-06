<x-filament-panels::page>
    <x-slot name="header">
        <h1 class="text-2xl font-bold tracking-tight">Análisis y publicación de datos</h1>
    </x-slot>

    @if(count($allProjects) > 0)
        {{-- Selección de proyectos --}}
        <x-filament::section>
            <div class="space-y-4">
                <h2 class="text-lg font-semibold">Seleccionar proyectos para publicar/actualizar</h2>

                                <div class="space-y-2">
                    <label class="text-sm font-medium text-gray-700">Seleccionar proyectos:</label>
                    <div class="border rounded-lg p-3 max-h-60 overflow-y-auto">
                        @if(count($allProjects) > 0)
                            @foreach($allProjects as $projectAnalysis)
                                <label class="flex items-center space-x-2 py-1 hover:bg-gray-50 rounded px-2 cursor-pointer">
                                    <input
                                        type="checkbox"
                                        wire:click="toggleProjectSelection({{ $projectAnalysis['project']->id }})"
                                        @if(in_array($projectAnalysis['project']->id, $selectedProjects)) checked @endif
                                        class="rounded border-gray-300 text-primary-600 focus:ring-primary-500"
                                    >
                                    <span class="text-sm">
                                        <span class="font-medium">{{ $projectAnalysis['project']->name }}</span>
                                        <span class="ml-2 px-2 py-1 text-xs rounded-full {{ $projectAnalysis['action_type'] === 'publish' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800' }}">
                                            {{ $projectAnalysis['action_type'] === 'publish' ? 'NUEVO' : 'ACTUALIZAR' }}
                                        </span>
                                    </span>
                                </label>

                            @endforeach
                        @else
                            <p class="text-gray-500 text-sm">No hay proyectos disponibles para seleccionar</p>
                        @endif
                    </div>
                </div>

                @if(count($allProjects) > 0)
                    <div class="text-sm text-gray-600 mt-2">
                        <p>Proyectos disponibles: {{ count($allProjects) }}</p>
                        <p>Nuevos: {{ count($projectsToPublish) }} | Actualizar: {{ count($projectsToUpdate) }}</p>
                    </div>
                @endif
            </div>
        </x-filament::section>

        {{-- Detalles de proyectos seleccionados --}}
        @if(count($selectedProjects) > 0)
            <x-filament::section>
                <div class="space-y-6">
                    <h2 class="text-lg font-semibold">Detalles de proyectos seleccionados</h2>

                    @foreach($allProjects as $projectAnalysis)
                        @if(in_array($projectAnalysis['project']->id, $selectedProjects))
                            <div class="border rounded-lg p-4 {{ $projectAnalysis['action_type'] === 'publish' ? 'bg-green-50' : 'bg-yellow-50' }}">
                                <div class="flex justify-between items-start mb-3">
                                    <h3 class="text-lg font-semibold {{ $projectAnalysis['action_type'] === 'publish' ? 'text-green-800' : 'text-yellow-800' }}">
                                        {{ $projectAnalysis['project']->name }}
                                    </h3>
                                    <span class="px-2 py-1 text-xs font-semibold rounded-full {{ $projectAnalysis['action_type'] === 'publish' ? 'bg-green-200 text-green-800' : 'bg-yellow-200 text-yellow-800' }}">
                                        {{ $projectAnalysis['action_type'] === 'publish' ? 'NUEVO' : 'ACTUALIZAR' }}
                                    </span>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm mb-3">
                                    <div><strong>Financiador:</strong> {{ $projectAnalysis['project']->financiers->name ?? 'No definido' }}</div>
                                    <div><strong>Costo total:</strong> ${{ number_format($projectAnalysis['project']->total_cost ?? 0, 2) }}</div>
                                    <div><strong>Oficial:</strong> {{ $projectAnalysis['project']->followup_officer ?? 'No asignado' }}</div>
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm mb-3">
                                    <div><strong>Actividades actuales:</strong> {{ $projectAnalysis['current_activities_count'] }}</div>
                                    <div><strong>Métricas actuales:</strong> {{ $projectAnalysis['current_metrics_count'] }}</div>
                                </div>

                                @if($projectAnalysis['action_type'] === 'update')
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm mb-3">
                                        <div><strong>Actividades publicadas:</strong> {{ $projectAnalysis['published_activities_count'] }}</div>
                                        <div><strong>Métricas publicadas:</strong> {{ $projectAnalysis['published_metrics_count'] }}</div>
                                    </div>

                                    @if($projectAnalysis['last_publication_date'])
                                        <div class="text-xs text-gray-600 mb-3">
                                            Última publicación: {{ $projectAnalysis['last_publication_date']->format('d/m/Y H:i') }}
                                        </div>
                                    @endif
                                @endif

                                @if(count($projectAnalysis['changes_summary']) > 0)
                                    <div class="bg-white p-3 rounded border">
                                        <h4 class="font-semibold text-sm mb-2">Cambios detectados:</h4>

                                        @if(isset($projectAnalysis['detailed_changes']))
                                            {{-- Tabla detallada de cambios --}}
                                            <div class="w-full">
                                                <table class="w-full text-xs border-collapse">
                                                    <thead>
                                                        <tr class="bg-gray-50">
                                                            <th class="border px-2 py-1 text-left font-medium w-1/3">Campo</th>
                                                            <th class="border px-2 py-1 text-left font-medium w-1/3">Valor anterior</th>
                                                            <th class="border px-2 py-1 text-left font-medium w-1/3">Valor nuevo</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        @foreach($projectAnalysis['detailed_changes']['project'] as $change)
                                                            <tr class="border-b">
                                                                <td class="border px-2 py-1 font-medium">{{ $change['field'] }}</td>
                                                                <td class="border px-2 py-1 text-red-600">
                                                                    @if(isset($change['highlighted']) && $change['highlighted'])
                                                                        {!! $change['old_value'] !!}
                                                                    @else
                                                                        {{ $change['old_value'] }}
                                                                    @endif
                                                                </td>
                                                                <td class="border px-2 py-1 text-green-600">
                                                                    @if(isset($change['highlighted']) && $change['highlighted'])
                                                                        {!! $change['new_value'] !!}
                                                                    @else
                                                                        {{ $change['new_value'] }}
                                                                    @endif
                                                                </td>
                                                            </tr>
                                                        @endforeach
                                                        @foreach($projectAnalysis['detailed_changes']['activities'] as $change)
                                                            <tr class="border-b bg-blue-50">
                                                                <td class="border px-2 py-1 font-medium">{{ $change['field'] }}</td>
                                                                <td class="border px-2 py-1 text-red-600">
                                                                    @if(isset($change['highlighted']) && $change['highlighted'])
                                                                        {!! $change['old_value'] !!}
                                                                    @else
                                                                        {{ $change['old_value'] }}
                                                                    @endif
                                                                </td>
                                                                <td class="border px-2 py-1 text-green-600">
                                                                    @if(isset($change['highlighted']) && $change['highlighted'])
                                                                        {!! $change['new_value'] !!}
                                                                    @else
                                                                        {{ $change['new_value'] }}
                                                                    @endif
                                                                </td>
                                                            </tr>
                                                        @endforeach
                                                        @foreach($projectAnalysis['detailed_changes']['metrics'] as $change)
                                                            <tr class="border-b bg-purple-50">
                                                                <td class="border px-2 py-1 font-medium">{{ $change['field'] }}</td>
                                                                <td class="border px-2 py-1 text-red-600">
                                                                    @if(isset($change['highlighted']) && $change['highlighted'])
                                                                        {!! $change['old_value'] !!}
                                                                    @else
                                                                        {{ $change['old_value'] }}
                                                                    @endif
                                                                </td>
                                                                <td class="border px-2 py-1 text-green-600">
                                                                    @if(isset($change['highlighted']) && $change['highlighted'])
                                                                        {!! $change['new_value'] !!}
                                                                    @else
                                                                        {{ $change['new_value'] }}
                                                                    @endif
                                                                </td>
                                                            </tr>
                                                        @endforeach
                                                    </tbody>
                                                </table>
                                            </div>
                                        @else
                                            {{-- Resumen simple para compatibilidad --}}
                                            <ul class="text-sm space-y-1">
                                                @foreach($projectAnalysis['changes_summary'] as $change)
                                                    <li class="flex items-center">
                                                        <span class="w-2 h-2 bg-red-500 rounded-full mr-2"></span>
                                                        {{ $change }}
                                                    </li>
                                                @endforeach
                                            </ul>
                                        @endif
                                    </div>
                                @endif

                            </div>
                        @endif
                    @endforeach
                </div>
            </x-filament::section>
        @endif

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
                        Publicar proyectos seleccionados
                    </x-filament::button>
                </div>
            </div>
        </x-filament::section>
    @else
        {{-- Mensaje cuando no hay proyectos --}}
        <x-filament::section>
            <div class="space-y-4">
                <h2 class="text-lg font-semibold">No hay proyectos que requieran acción</h2>
                <p class="text-gray-600">Todos los proyectos están actualizados o no tienen actividades/métricas para publicar.</p>
            </div>
        </x-filament::section>
    @endif
</x-filament-panels::page>

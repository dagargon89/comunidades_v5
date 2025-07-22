<x-filament-panels::page>
    <x-slot name="header">
        <h1 class="text-2xl font-bold tracking-tight">Guía de Creación de Proyectos</h1>
    </x-slot>

    {{-- Formulario principal --}}
    {{ $this->form }}

    {{-- Lista de cofinanciadores agregados --}}
    @if($cofinanciersData && count($cofinanciersData) > 0)
        <x-filament::section>
            <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Cofinanciadores agregados</h3>
            <div class="space-y-3">
                @foreach($cofinanciersData as $idx => $cofinancier)
                    <div class="flex justify-between items-center border-b border-gray-200 pb-2">
                        <span class="text-gray-900 dark:text-white">
                            {{ \App\Models\Financier::find($cofinancier['financier_id'])->name ?? 'N/A' }}
                        </span>
                        <span class="text-green-600 font-medium">${{ number_format($cofinancier['amount'], 2) }}</span>
                        <x-filament::button color="danger" size="sm" wire:click="removeCofinancier({{ $idx }})">Eliminar</x-filament::button>
                    </div>
                @endforeach
            </div>
        </x-filament::section>
    @endif

    {{-- Modal para agregar cofinanciador --}}
    {{-- Eliminado: ahora se usa Action de Filament --}}

                    {{-- Botón para ver resumen cuando esté completo --}}
                @if($this->progress == 100)
        <x-filament::section>
            <div class="text-center">
                <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
                    ¡Proyecto Completo!
                </h3>
                <p class="text-gray-600 dark:text-gray-400 mb-6">
                    Todos los datos han sido completados. Revisa el resumen y guarda el proyecto.
                </p>
                <x-filament::button
                    wire:click="showSummary"
                    color="success"
                    size="lg">
                    Ver Resumen y Guardar
                </x-filament::button>
            </div>
        </x-filament::section>
    @endif

    {{-- Modal de Resumen --}}
    <x-filament::modal wire:model="showSummaryModal">
        <x-slot name="header">
            <h2 class="text-2xl font-bold text-gray-900 dark:text-white">
                Resumen del Proyecto
            </h2>
        </x-slot>

        <div class="space-y-6">
            {{-- Información del Proyecto --}}
            @if($projectData)
                <x-filament::card>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Información del Proyecto</h3>
                    <x-filament::grid cols="1" md:cols="2" class="gap-4">
                        <div>
                            <span class="text-sm font-medium text-gray-500">Nombre:</span>
                            <p class="text-gray-900 dark:text-white">{{ $projectData['name'] }}</p>
                        </div>
                        <div>
                            <span class="text-sm font-medium text-gray-500">Antecedentes:</span>
                            <p class="text-gray-900 dark:text-white">{{ $projectData['background'] ?? 'No especificado' }}</p>
                        </div>
                    </x-filament::grid>
                </x-filament::card>
            @endif

            {{-- Objetivos Específicos --}}
            @if($objectivesData && count($objectivesData) > 0)
                <x-filament::card>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Objetivos Específicos</h3>
                    <div class="space-y-3">
                        @foreach($objectivesData as $objective)
                            <div class="border-l-4 border-blue-500 pl-4">
                                <p class="text-gray-600 dark:text-gray-400 text-sm">{{ $objective['description'] }}</p>
                            </div>
                        @endforeach
                    </div>
                </x-filament::card>
            @endif

            {{-- KPIs --}}
            @if($kpisData && count($kpisData) > 0)
                <x-filament::card>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Indicadores de Rendimiento</h3>
                    <x-filament::grid cols="1" md:cols="3" class="gap-4">
                        @foreach($kpisData as $kpi)
                            <div class="border border-gray-200 rounded p-3">
                                <h4 class="font-medium text-gray-900 dark:text-white">{{ $kpi['name'] }}</h4>
                                <p class="text-gray-600 dark:text-gray-400 text-sm">{{ $kpi['description'] }}</p>
                                <p class="text-blue-600 font-medium">
                                    Valor Inicial: {{ $kpi['initial_value'] }} |
                                    Valor Final: {{ $kpi['final_value'] }}
                                    @if($kpi['is_percentage']) (Porcentaje) @endif
                                </p>
                            </div>
                        @endforeach
                    </x-filament::grid>
                </x-filament::card>
            @endif

            {{-- Cofinanciadores --}}
            @if($cofinanciersData && count($cofinanciersData) > 0)
                <x-filament::card>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Cofinanciadores</h3>
                    <div class="space-y-3">
                        @foreach($cofinanciersData as $cofinancier)
                            <div class="flex justify-between items-center border-b border-gray-200 pb-2">
                                <span class="text-gray-900 dark:text-white">
                                    {{ \App\Models\Financier::find($cofinancier['financier_id'])->name ?? 'N/A' }}
                                </span>
                                <span class="text-green-600 font-medium">${{ number_format($cofinancier['amount'], 2) }}</span>
                            </div>
                        @endforeach
                    </div>
                </x-filament::card>
            @endif

            {{-- Ubicaciones --}}
            @if($locationsData && count($locationsData) > 0)
                <x-filament::card>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Ubicaciones</h3>
                    <div class="space-y-3">
                        @foreach($locationsData as $location)
                            <div class="border-l-4 border-green-500 pl-4">
                                <h4 class="font-medium text-gray-900 dark:text-white">{{ $location['name'] }}</h4>
                                <p class="text-gray-600 dark:text-gray-400 text-sm">
                                    Categoría: {{ $location['category'] ?? 'N/A' }}<br>
                                    Dirección: {{ $location['street'] ?? 'N/A' }}<br>
                                    Colonia: {{ $location['neighborhood'] ?? 'N/A' }}
                                </p>
                            </div>
                        @endforeach
                    </div>
                </x-filament::card>
            @endif

            {{-- Actividades --}}
            @if($activitiesData && count($activitiesData) > 0)
                <x-filament::card>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Actividades</h3>
                    <div class="space-y-3">
                        @foreach($activitiesData as $aIdx => $activity)
                            <div class="border-l-4 border-purple-500 pl-4 mb-2">
                                <h4 class="font-medium text-gray-900 dark:text-white">{{ $activity['name'] }}</h4>
                                <p class="text-gray-600 dark:text-gray-400 text-sm">{{ $activity['description'] }}</p>
                                <p class="text-purple-600 text-sm">
                                    Objetivo: {{ \App\Models\SpecificObjective::find($activity['specific_objective_id'])->description ?? 'N/A' }}
                                </p>
                                {{-- Mostrar planned metrics asociadas --}}
                                @if(isset($activity['planned_metrics']) && is_array($activity['planned_metrics']) && count($activity['planned_metrics']) > 0)
                                    <div class="mt-2 ml-2">
                                        <h5 class="font-semibold text-sm text-gray-700 dark:text-gray-200 mb-1">Métricas planeadas:</h5>
                                        <ul class="list-disc ml-4">
                                            @foreach($activity['planned_metrics'] as $mIdx => $metric)
                                                <li class="flex items-center justify-between">
                                                    <span>
                                                        Población: {{ $metric['population_target_value'] ?? '-' }}, Producto: {{ $metric['product_target_value'] ?? '-' }}
                                                    </span>
                                                    <x-filament::button color="danger" size="xs" wire:click="removePlannedMetric({{ $aIdx }}, {{ $mIdx }})">Eliminar</x-filament::button>
                                                </li>
                                            @endforeach
                                        </ul>
                                    </div>
                                @endif
                            </div>
                        @endforeach
                    </div>
                </x-filament::card>
            @endif

            {{-- Programación --}}
            @if($scheduledActivitiesData && count($scheduledActivitiesData) > 0)
                <x-filament::card>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Programación de Actividades</h3>
                    <div class="space-y-3">
                        @foreach($scheduledActivitiesData as $scheduled)
                            <div class="border border-gray-200 rounded p-3">
                                <h4 class="font-medium text-gray-900 dark:text-white">
                                    {{ \App\Models\Activity::find($scheduled['activity_id'])->name ?? 'N/A' }}
                                </h4>
                                <x-filament::grid cols="2" class="gap-4 text-sm">
                                    <div>
                                        <span class="text-gray-500">Inicio:</span>
                                        <span class="text-gray-900 dark:text-white">{{ $scheduled['start_date'] }}</span>
                                    </div>
                                    <div>
                                        <span class="text-gray-500">Fin:</span>
                                        <span class="text-gray-900 dark:text-white">{{ $scheduled['end_date'] }}</span>
                                    </div>
                                </x-filament::grid>
                            </div>
                        @endforeach
                    </div>
                </x-filament::card>
            @endif
        </div>

        <x-slot name="footer">
            <div class="flex justify-end space-x-4">
                <x-filament::button
                    wire:click="closeSummary"
                    color="gray">
                    Cancelar
                </x-filament::button>
                <x-filament::button
                    wire:click="editProject"
                    color="warning">
                    Editar
                </x-filament::button>
                <x-filament::button
                    wire:click="saveProject"
                    color="success">
                    Confirmar y Guardar
                </x-filament::button>
            </div>
        </x-slot>
    </x-filament::modal>
</x-filament-panels::page>

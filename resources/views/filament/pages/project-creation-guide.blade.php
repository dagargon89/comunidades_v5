<x-filament-panels::page>
    <div class="space-y-6">
        <!-- Header -->
        <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
            <h1 class="text-2xl font-bold text-gray-900 dark:text-white mb-2">
                Guía de Creación de Proyectos
            </h1>
            <p class="text-gray-600 dark:text-gray-400">
                Completa cada sección en orden para crear tu proyecto completo
            </p>
        </div>

        <!-- Progress Indicator -->
        <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-lg font-semibold text-gray-900 dark:text-white">
                    Progreso de Creación
                </h2>
                <span class="text-sm text-gray-500 dark:text-gray-400">
                    {{ $this->completedSteps }}/{{ $this->totalSteps }} completados
                </span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-2.5">
                <div class="bg-blue-600 h-2.5 rounded-full" style="width: {{ ($this->completedSteps / $this->totalSteps) * 100 }}%"></div>
            </div>
        </div>

        <!-- Secciones principales -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

            <!-- 1. Información Básica del Proyecto -->
            <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-3">
                        <div class="w-8 h-8 bg-blue-100 dark:bg-blue-900 rounded-full flex items-center justify-center">
                            <span class="text-blue-600 dark:text-blue-400 font-semibold">1</span>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Información Básica del Proyecto
                        </h3>
                    </div>
                    @if($projectData)
                        <span class="text-green-600 dark:text-green-400 text-sm">✓ Completado</span>
                    @endif
                </div>
                <p class="text-gray-600 dark:text-gray-400 mb-4">
                    Define los datos principales del proyecto
                </p>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                    @if($projectData)
                        <strong>Proyecto:</strong> {{ $projectData['name'] ?? 'Sin nombre' }}
                    @else
                        No se ha creado ningún proyecto aún
                    @endif
                </div>
            </div>

            <!-- 2. Objetivos Específicos -->
            <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6 {{ !$projectData ? 'opacity-50' : '' }}">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-3">
                        <div class="w-8 h-8 {{ $projectData ? 'bg-green-100 dark:bg-green-900' : 'bg-gray-100 dark:bg-gray-700' }} rounded-full flex items-center justify-center">
                            <span class="{{ $projectData ? 'text-green-600 dark:text-green-400' : 'text-gray-400' }} font-semibold">2</span>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Objetivos Específicos
                        </h3>
                    </div>
                    @if($objectivesData && count($objectivesData) > 0)
                        <span class="text-green-600 dark:text-green-400 text-sm">✓ Completado</span>
                    @endif
                </div>
                <p class="text-gray-600 dark:text-gray-400 mb-4">
                    Define los objetivos específicos del proyecto
                </p>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                    @if($objectivesData && count($objectivesData) > 0)
                        {{ count($objectivesData) }} objetivo(s) creado(s)
                    @else
                        No se han creado objetivos aún
                    @endif
                </div>
            </div>

            <!-- 3. KPIs -->
            <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6 {{ !$projectData ? 'opacity-50' : '' }}">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-3">
                        <div class="w-8 h-8 {{ $projectData ? 'bg-purple-100 dark:bg-purple-900' : 'bg-gray-100 dark:bg-gray-700' }} rounded-full flex items-center justify-center">
                            <span class="{{ $projectData ? 'text-purple-600 dark:text-purple-400' : 'text-gray-400' }} font-semibold">3</span>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Indicadores de Rendimiento (KPIs)
                        </h3>
                    </div>
                    @if($kpisData && count($kpisData) > 0)
                        <span class="text-green-600 dark:text-green-400 text-sm">✓ Completado</span>
                    @endif
                </div>
                <p class="text-gray-600 dark:text-gray-400 mb-4">
                    Define los indicadores clave del proyecto
                </p>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                    @if($kpisData && count($kpisData) > 0)
                        {{ count($kpisData) }} KPI(s) creado(s)
                    @else
                        No se han creado KPIs aún
                    @endif
                </div>
            </div>

            <!-- 4. Cofinanciadores -->
            <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6 {{ !$projectData ? 'opacity-50' : '' }}">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-3">
                        <div class="w-8 h-8 {{ $projectData ? 'bg-orange-100 dark:bg-orange-900' : 'bg-gray-100 dark:bg-gray-700' }} rounded-full flex items-center justify-center">
                            <span class="{{ $projectData ? 'text-orange-600 dark:text-orange-400' : 'text-gray-400' }} font-semibold">4</span>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Cofinanciadores
                        </h3>
                    </div>
                    @if($cofinanciersData && count($cofinanciersData) > 0)
                        <span class="text-green-600 dark:text-green-400 text-sm">✓ Completado</span>
                    @endif
                </div>
                <p class="text-gray-600 dark:text-gray-400 mb-4">
                    Agrega cofinanciadores del proyecto
                </p>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                    @if($cofinanciersData && count($cofinanciersData) > 0)
                        {{ count($cofinanciersData) }} cofinanciador(es) agregado(s)
                    @else
                        No se han agregado cofinanciadores aún
                    @endif
                </div>
            </div>

            <!-- 5. Actividades -->
            <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6 {{ !$objectivesData || count($objectivesData) == 0 ? 'opacity-50' : '' }}">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-3">
                        <div class="w-8 h-8 {{ ($objectivesData && count($objectivesData) > 0) ? 'bg-indigo-100 dark:bg-indigo-900' : 'bg-gray-100 dark:bg-gray-700' }} rounded-full flex items-center justify-center">
                            <span class="{{ ($objectivesData && count($objectivesData) > 0) ? 'text-indigo-600 dark:text-indigo-400' : 'text-gray-400' }} font-semibold">5</span>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Actividades
                        </h3>
                    </div>
                    @if($activitiesData && count($activitiesData) > 0)
                        <span class="text-green-600 dark:text-green-400 text-sm">✓ Completado</span>
                    @endif
                </div>
                <p class="text-gray-600 dark:text-gray-400 mb-4">
                    Define las actividades del proyecto
                </p>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                    @if($activitiesData && count($activitiesData) > 0)
                        {{ count($activitiesData) }} actividad(es) creada(s)
                    @else
                        No se han creado actividades aún
                    @endif
                </div>
            </div>

            <!-- 6. Ubicaciones -->
            <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-3">
                        <div class="w-8 h-8 bg-teal-100 dark:bg-teal-900 rounded-full flex items-center justify-center">
                            <span class="text-teal-600 dark:text-teal-400 font-semibold">6</span>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Ubicaciones
                        </h3>
                    </div>
                    @if($locationsData && count($locationsData) > 0)
                        <span class="text-green-600 dark:text-green-400 text-sm">✓ Completado</span>
                    @endif
                </div>
                <p class="text-gray-600 dark:text-gray-400 mb-4">
                    Registra las ubicaciones del proyecto
                </p>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                    @if($locationsData && count($locationsData) > 0)
                        {{ count($locationsData) }} ubicación(es) registrada(s)
                    @else
                        No se han registrado ubicaciones aún
                    @endif
                </div>
            </div>

            <!-- 7. Programación de Actividades -->
            <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6 {{ !$activitiesData || count($activitiesData) == 0 || !$locationsData || count($locationsData) == 0 ? 'opacity-50' : '' }}">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-3">
                        <div class="w-8 h-8 {{ ($activitiesData && count($activitiesData) > 0 && $locationsData && count($locationsData) > 0) ? 'bg-pink-100 dark:bg-pink-900' : 'bg-gray-100 dark:bg-gray-700' }} rounded-full flex items-center justify-center">
                            <span class="{{ ($activitiesData && count($activitiesData) > 0 && $locationsData && count($locationsData) > 0) ? 'text-pink-600 dark:text-pink-400' : 'text-gray-400' }} font-semibold">7</span>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Programación de Actividades
                        </h3>
                    </div>
                    @if($scheduledActivitiesData && count($scheduledActivitiesData) > 0)
                        <span class="text-green-600 dark:text-green-400 text-sm">✓ Completado</span>
                    @endif
                </div>
                <p class="text-gray-600 dark:text-gray-400 mb-4">
                    Programa las actividades en el calendario
                </p>
                <div class="text-sm text-gray-500 dark:text-gray-400">
                    @if($scheduledActivitiesData && count($scheduledActivitiesData) > 0)
                        {{ count($scheduledActivitiesData) }} actividad(es) programada(s)
                    @else
                        No se han programado actividades aún
                    @endif
                </div>
            </div>

        </div>

        <!-- Botón de Resumen y Guardado -->
        <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
            <div class="flex items-center justify-between">
                <div>
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">
                        Resumen y Guardado
                    </h3>
                    <p class="text-gray-600 dark:text-gray-400">
                        Revisa toda la información antes de crear el proyecto
                    </p>
                </div>
                <button
                    wire:click="saveAllData"
                    class="bg-green-600 hover:bg-green-700 text-white font-medium py-3 px-6 rounded-lg transition duration-200"
                >
                    Ver Resumen y Guardar
                </button>
            </div>
        </div>
    </div>
</x-filament-panels::page>

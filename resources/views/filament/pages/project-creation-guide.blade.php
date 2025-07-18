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
                <button
                    wire:click="openProjectModal"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition duration-200"
                >
                    {{ $projectData ? 'Editar Proyecto' : 'Crear Proyecto' }}
                </button>
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
                <button
                    wire:click="openObjectivesModal"
                    class="w-full {{ $projectData ? 'bg-green-600 hover:bg-green-700' : 'bg-gray-400 cursor-not-allowed' }} text-white font-medium py-2 px-4 rounded-lg transition duration-200"
                    {{ !$projectData ? 'disabled' : '' }}
                >
                    {{ $objectivesData && count($objectivesData) > 0 ? 'Editar Objetivos' : 'Crear Objetivos' }}
                </button>
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
                <button
                    wire:click="openKpisModal"
                    class="w-full {{ $projectData ? 'bg-purple-600 hover:bg-purple-700' : 'bg-gray-400 cursor-not-allowed' }} text-white font-medium py-2 px-4 rounded-lg transition duration-200"
                    {{ !$projectData ? 'disabled' : '' }}
                >
                    {{ $kpisData && count($kpisData) > 0 ? 'Editar KPIs' : 'Crear KPIs' }}
                </button>
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
                <button
                    wire:click="openCofinanciersModal"
                    class="w-full {{ $projectData ? 'bg-orange-600 hover:bg-orange-700' : 'bg-gray-400 cursor-not-allowed' }} text-white font-medium py-2 px-4 rounded-lg transition duration-200"
                    {{ !$projectData ? 'disabled' : '' }}
                >
                    {{ $cofinanciersData && count($cofinanciersData) > 0 ? 'Editar Cofinanciadores' : 'Agregar Cofinanciadores' }}
                </button>
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
                <button
                    wire:click="openActivitiesModal"
                    class="w-full {{ ($objectivesData && count($objectivesData) > 0) ? 'bg-indigo-600 hover:bg-indigo-700' : 'bg-gray-400 cursor-not-allowed' }} text-white font-medium py-2 px-4 rounded-lg transition duration-200"
                    {{ !($objectivesData && count($objectivesData) > 0) ? 'disabled' : '' }}
                >
                    {{ $activitiesData && count($activitiesData) > 0 ? 'Editar Actividades' : 'Crear Actividades' }}
                </button>
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
                <button
                    wire:click="openLocationsModal"
                    class="w-full bg-teal-600 hover:bg-teal-700 text-white font-medium py-2 px-4 rounded-lg transition duration-200"
                >
                    {{ $locationsData && count($locationsData) > 0 ? 'Editar Ubicaciones' : 'Crear Ubicaciones' }}
                </button>
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
                <button
                    wire:click="openSchedulingModal"
                    class="w-full {{ ($activitiesData && count($activitiesData) > 0 && $locationsData && count($locationsData) > 0) ? 'bg-pink-600 hover:bg-pink-700' : 'bg-gray-400 cursor-not-allowed' }} text-white font-medium py-2 px-4 rounded-lg transition duration-200"
                    {{ !($activitiesData && count($activitiesData) > 0 && $locationsData && count($locationsData) > 0) ? 'disabled' : '' }}
                >
                    {{ $scheduledActivitiesData && count($scheduledActivitiesData) > 0 ? 'Editar Programación' : 'Programar Actividades' }}
                </button>
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
                    wire:click="openSummaryModal"
                    class="bg-green-600 hover:bg-green-700 text-white font-medium py-3 px-6 rounded-lg transition duration-200"
                >
                    Ver Resumen y Guardar
                </button>
            </div>
        </div>
    </div>

    <!-- Modales se incluirán aquí -->
</x-filament-panels::page>

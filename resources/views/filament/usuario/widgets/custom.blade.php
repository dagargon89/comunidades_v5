<x-filament-widgets::widget>
    <x-filament::section>
        @php
            $data = $this->getData();
        @endphp

        <div class="space-y-6">
            <!-- Header con información del usuario -->
            <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                <div class="flex justify-between items-center">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900 dark:text-white">
                            Dashboard de Actividades
                        </h2>
                        <p class="text-gray-600 dark:text-gray-400">
                            Bienvenido, {{ $data['user']->name }}
                        </p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-gray-500 dark:text-gray-400">Última actualización</p>
                        <p class="text-sm font-medium text-gray-900 dark:text-white">
                            {{ now()->format('d/m/Y H:i') }}
                        </p>
                    </div>
                </div>
            </div>

            <!-- Tarjetas de estadísticas -->
            <div class="grid grid-cols-1 gap-6 md:grid-cols-3">
                <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="flex justify-center items-center w-8 h-8 bg-blue-500 rounded-md">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
                                </svg>
                            </div>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Total Actividades</p>
                            <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ $data['totalActivities'] }}</p>
                        </div>
                    </div>
                </div>

                <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="flex justify-center items-center w-8 h-8 bg-green-500 rounded-md">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                </svg>
                            </div>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Este Mes</p>
                            <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ $data['activitiesThisMonth'] }}</p>
                        </div>
                    </div>
                </div>

                <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div class="flex justify-center items-center w-8 h-8 bg-yellow-500 rounded-md">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Esta Semana</p>
                            <p class="text-2xl font-bold text-gray-900 dark:text-white">{{ $data['activitiesThisWeek'] }}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabla de actividades recientes -->
            <div class="bg-white rounded-lg shadow dark:bg-gray-800">
                <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
                    <h3 class="text-lg font-medium text-gray-900 dark:text-white">
                        Actividades Recientes
                    </h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                        <thead class="bg-gray-50 dark:bg-gray-700">
                            <tr>
                                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-300">
                                    Actividad
                                </th>
                                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-300">
                                    Proyecto
                                </th>
                                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-300">
                                    Fecha Creación
                                </th>
                                <th class="px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-500 uppercase dark:text-gray-300">
                                    Estado
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700">
                            @forelse($data['recentActivities'] as $activity)
                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-700">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900 dark:text-white">
                                            {{ Str::limit($activity->name ?? $activity->description, 50) }}
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900 dark:text-white">
                                            {{ $activity->goal->project->name ?? 'Sin proyecto' }}
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900 dark:text-white">
                                            {{ $activity->created_at->format('d/m/Y H:i') }}
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="inline-flex px-2 py-1 text-xs font-semibold text-green-800 bg-green-100 rounded-full dark:bg-green-900 dark:text-green-200">
                                            Creada
                                        </span>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="px-6 py-4 text-sm text-center text-gray-500 dark:text-gray-400">
                                        No hay actividades recientes
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Top proyectos -->
            <div class="p-6 bg-white rounded-lg shadow dark:bg-gray-800">
                <h3 class="mb-4 text-lg font-medium text-gray-900 dark:text-white">
                    Proyectos Más Activos
                </h3>
                <div class="space-y-4">
                    @forelse($data['topProjects'] as $projectName => $count)
                        <div class="flex justify-between items-center p-4 bg-gray-50 rounded-lg dark:bg-gray-700">
                            <div class="flex items-center">
                                <div class="mr-3 w-3 h-3 bg-blue-500 rounded-full"></div>
                                <span class="text-sm font-medium text-gray-900 dark:text-white">
                                    {{ $projectName }}
                                </span>
                            </div>
                            <div class="flex items-center">
                                <span class="mr-2 text-sm text-gray-500 dark:text-gray-400">
                                    {{ $count }} actividades
                                </span>
                                <div class="w-20 h-2 bg-gray-200 rounded-full dark:bg-gray-600">
                                    <div class="h-2 bg-blue-500 rounded-full" style="width: {{ ($count / max($data['topProjects']->values()->toArray())) * 100 }}%"></div>
                                </div>
                            </div>
                        </div>
                    @empty
                        <p class="text-sm text-center text-gray-500 dark:text-gray-400">
                            No hay proyectos con actividades
                        </p>
                    @endforelse
                </div>
            </div>
        </div>
    </x-filament::section>
</x-filament-widgets::widget>

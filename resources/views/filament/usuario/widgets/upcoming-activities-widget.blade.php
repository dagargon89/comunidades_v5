<x-filament-widgets::widget>
    <x-filament::section>
        <div class="space-y-4">
            @php
                $activities = $this->getUpcomingActivities();
            @endphp

            @if($activities->count() > 0)
                <div class="space-y-3">
                    @foreach($activities as $activity)
                        <div class="flex items-center justify-between p-4 bg-white rounded-lg border border-gray-200 hover:border-gray-300 transition-colors">
                            <div class="flex-1 min-w-0">
                                <div class="flex items-center space-x-3">
                                    <!-- Icono de calendario -->
                                    <div class="flex-shrink-0">
                                        <div class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center">
                                            <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                            </svg>
                                        </div>
                                    </div>

                                    <!-- Información de la actividad -->
                                    <div class="flex-1 min-w-0">
                                        <div class="flex items-center space-x-2">
                                            <h3 class="text-sm font-medium text-gray-900 truncate">
                                                {{ $activity['name'] }}
                                            </h3>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-{{ $activity['status_color'] }}-100 text-{{ $activity['status_color'] }}-800">
                                                {{ $activity['status'] }}
                                            </span>
                                        </div>

                                        <div class="mt-1 flex items-center space-x-4 text-sm text-gray-500">
                                            <div class="flex items-center space-x-1">
                                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                                </svg>
                                                <span>{{ $activity['date'] }}</span>
                                            </div>

                                            @if($activity['time'])
                                                <div class="flex items-center space-x-1">
                                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                    </svg>
                                                    <span>{{ $activity['time'] }}</span>
                                                </div>
                                            @endif

                                            @if($activity['location'] && $activity['location'] !== 'Sin ubicación')
                                                <div class="flex items-center space-x-1">
                                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                    </svg>
                                                    <span class="truncate">{{ $activity['location'] }}</span>
                                                </div>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Botón de acción -->
                            <div class="flex-shrink-0 ml-4">
                                <button class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-md text-blue-700 bg-blue-100 hover:bg-blue-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                                    Ver detalles
                                </button>
                            </div>
                        </div>
                    @endforeach
                </div>

                @if($activities->count() >= 8)
                    <div class="text-center pt-2">
                        <span class="text-sm text-gray-500">Mostrando las próximas 8 actividades</span>
                    </div>
                @endif
            @else
                <div class="text-center py-8">
                    <div class="w-16 h-16 mx-auto mb-4 bg-gray-100 rounded-full flex items-center justify-center">
                        <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                    </div>
                    <h3 class="text-sm font-medium text-gray-900 mb-1">No hay actividades próximas</h3>
                    <p class="text-sm text-gray-500">No tienes actividades programadas para los próximos días.</p>
                </div>
            @endif
        </div>
    </x-filament::section>
</x-filament-widgets::widget>

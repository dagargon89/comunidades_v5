<x-filament-widgets::widget>
    <x-filament::section>
        <div class="space-y-4 w-full">
            @php
                $activities = $this->getUpcomingActivities();
            @endphp

            @if($activities->count() > 0)
                <div class="space-y-3 w-full">
                    @foreach($activities as $activity)
                        <div class="flex justify-between items-center p-4 w-full bg-white rounded-lg border border-gray-200 transition-colors hover:border-gray-300">
                            <div class="flex-1 min-w-0">
                                <div class="flex items-center space-x-3">
                                    <!-- Icono de calendario -->
                                    <div class="flex-shrink-0">
                                        <div class="flex justify-center items-center w-10 h-10 bg-blue-100 rounded-full">
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

                                        <div class="flex items-center mt-1 space-x-4 text-sm text-gray-500">
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
                                <button
                                    wire:click="openActivityModal({{ $activity['id'] }})"
                                    class="inline-flex items-center px-3 py-1.5 text-xs font-medium text-blue-700 bg-blue-100 rounded-md border border-transparent transition-colors hover:bg-blue-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    <svg class="mr-1 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                    </svg>
                                    Ver detalles
                                </button>
                            </div>
                        </div>
                    @endforeach
                </div>

                @if($activities->count() >= 8)
                    <div class="pt-2 text-center">
                        <span class="text-sm text-gray-500">Mostrando las próximas 8 actividades</span>
                    </div>
                @endif
            @else
                <div class="py-8 text-center">
                    <div class="flex justify-center items-center mx-auto mb-4 w-16 h-16 bg-gray-100 rounded-full">
                        <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                    </div>
                    <h3 class="mb-1 text-sm font-medium text-gray-900">No hay actividades próximas</h3>
                    <p class="text-sm text-gray-500">No tienes actividades programadas para los próximos días.</p>
                </div>
            @endif
        </div>
    </x-filament::section>

    <!-- Modal de detalles de la actividad -->
    <x-filament::modal id="activity-details-modal" width="lg">
        @php
            $selectedActivity = $this->getSelectedActivity();
        @endphp

        @if($selectedActivity)
            <x-slot name="header">
                <div class="flex items-center space-x-4">
                    <div class="flex justify-center items-center w-12 h-12 bg-blue-100 rounded-full">
                        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                        </svg>
                    </div>
                    <div class="flex-1">
                        <h2 class="text-xl font-bold text-gray-900 leading-tight">
                            {{ $selectedActivity->activity->name ?? 'Sin nombre' }}
                        </h2>
                        <p class="text-sm text-gray-500 mt-1">Actividad calendarizada</p>
                    </div>
                </div>
            </x-slot>

            <div class="space-y-6">
                <!-- Estado y fecha principal -->
                @php
                    $startDate = \Carbon\Carbon::parse($selectedActivity->start_date);
                    $endDate = $selectedActivity->end_date ? \Carbon\Carbon::parse($selectedActivity->end_date) : null;
                    $today = \Carbon\Carbon::today();

                    if ($startDate->isToday() || ($startDate->lte($today) && $endDate && $endDate->gte($today))) {
                        $status = 'En Curso';
                        $statusColor = 'success';
                        $statusIcon = 'M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z';
                    } elseif ($startDate->isTomorrow()) {
                        $status = 'Mañana';
                        $statusColor = 'warning';
                        $statusIcon = 'M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z';
                    } elseif ($startDate->isThisWeek()) {
                        $status = 'Esta Semana';
                        $statusColor = 'info';
                        $statusIcon = 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z';
                    } elseif ($startDate->isNextWeek()) {
                        $status = 'Próxima Semana';
                        $statusColor = 'gray';
                        $statusIcon = 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z';
                    } else {
                        $status = 'Próximamente';
                        $statusColor = 'gray';
                        $statusIcon = 'M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z';
                    }
                @endphp

                <div class="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg p-4 border border-blue-200">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="flex justify-center items-center w-10 h-10 bg-{{ $statusColor }}-100 rounded-full">
                                <svg class="w-5 h-5 text-{{ $statusColor }}-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="{{ $statusIcon }}"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-lg font-semibold text-gray-900">{{ $status }}</h3>
                                <p class="text-sm text-gray-600">
                                    {{ $startDate->locale('es')->isoFormat('dddd, DD [de] MMMM YYYY') }}
                                    @if($endDate && $endDate->ne($startDate))
                                        - {{ $endDate->locale('es')->isoFormat('DD [de] MMMM YYYY') }}
                                    @endif
                                </p>
                            </div>
                        </div>
                        @if($selectedActivity->start_hour)
                            <div class="text-right">
                                <div class="text-2xl font-bold text-blue-600">
                                    {{ \Carbon\Carbon::parse($selectedActivity->start_hour)->format('H:i') }}
                                </div>
                                <div class="text-sm text-gray-500">Hora de inicio</div>
                            </div>
                        @endif
                    </div>
                </div>

                <!-- Información detallada -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Columna izquierda -->
                    <div class="space-y-4">
                        <!-- Ubicación -->
                        @if($selectedActivity->location)
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <div class="flex items-center space-x-3 mb-3">
                                    <div class="flex justify-center items-center w-8 h-8 bg-green-100 rounded-full">
                                        <svg class="w-4 h-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                        </svg>
                                    </div>
                                    <h4 class="text-sm font-semibold text-gray-900">Ubicación</h4>
                                </div>
                                <p class="text-gray-700">{{ $selectedActivity->location->name }}</p>
                            </div>
                        @endif

                        <!-- Meta asociada -->
                        @if($selectedActivity->activity && $selectedActivity->activity->goal)
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <div class="flex items-center space-x-3 mb-3">
                                    <div class="flex justify-center items-center w-8 h-8 bg-purple-100 rounded-full">
                                        <svg class="w-4 h-4 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                        </svg>
                                    </div>
                                    <h4 class="text-sm font-semibold text-gray-900">Meta asociada</h4>
                                </div>
                                <div class="text-sm text-gray-700 leading-relaxed">
                                    {{ Str::limit($selectedActivity->activity->goal->description, 200) }}
                                    @if(strlen($selectedActivity->activity->goal->description) > 200)
                                        <button class="text-blue-600 hover:text-blue-800 text-xs ml-1" onclick="this.previousElementSibling.textContent = '{{ $selectedActivity->activity->goal->description }}'; this.style.display='none'">
                                            Ver más
                                        </button>
                                    @endif
                                </div>
                            </div>
                        @endif
                    </div>

                    <!-- Columna derecha -->
                    <div class="space-y-4">
                        <!-- Descripción de la actividad -->
                        @if($selectedActivity->activity && $selectedActivity->activity->description)
                            <div class="bg-white rounded-lg border border-gray-200 p-4">
                                <div class="flex items-center space-x-3 mb-3">
                                    <div class="flex justify-center items-center w-8 h-8 bg-orange-100 rounded-full">
                                        <svg class="w-4 h-4 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                        </svg>
                                    </div>
                                    <h4 class="text-sm font-semibold text-gray-900">Descripción</h4>
                                </div>
                                <div class="text-sm text-gray-700 leading-relaxed">
                                    {{ $selectedActivity->activity->description }}
                                </div>
                            </div>
                        @endif

                        <!-- Información adicional -->
                        <div class="bg-white rounded-lg border border-gray-200 p-4">
                            <div class="flex items-center space-x-3 mb-3">
                                <div class="flex justify-center items-center w-8 h-8 bg-gray-100 rounded-full">
                                    <svg class="w-4 h-4 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                </div>
                                <h4 class="text-sm font-semibold text-gray-900">Información adicional</h4>
                            </div>
                            <div class="space-y-2 text-sm text-gray-600">
                                <div class="flex justify-between">
                                    <span>Duración:</span>
                                    <span class="font-medium">
                                        @if($selectedActivity->start_hour && $selectedActivity->end_hour)
                                            {{ \Carbon\Carbon::parse($selectedActivity->start_hour)->format('H:i') }} - {{ \Carbon\Carbon::parse($selectedActivity->end_hour)->format('H:i') }}
                                        @else
                                            Por definir
                                        @endif
                                    </span>
                                </div>
                                <div class="flex justify-between">
                                    <span>Tipo de evento:</span>
                                    <span class="font-medium">
                                        @if($endDate && $endDate->ne($startDate))
                                            Evento de múltiples días
                                        @else
                                            Evento de un día
                                        @endif
                                    </span>
                                </div>
                                <div class="flex justify-between">
                                    <span>Asignado por:</span>
                                    <span class="font-medium">
                                        @php
                                            $createdBy = \App\Models\User::find($selectedActivity->created_by);
                                        @endphp
                                        {{ $createdBy ? $createdBy->name : 'No disponible' }}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Acciones rápidas -->
                {{--
                <div class="bg-gray-50 rounded-lg p-4">
                    <h4 class="text-sm font-semibold text-gray-900 mb-3">Acciones rápidas</h4>
                    <div class="flex flex-wrap gap-2">
                        <button class="inline-flex items-center px-3 py-2 text-sm font-medium text-blue-700 bg-blue-100 rounded-md hover:bg-blue-200 transition-colors">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                            </svg>
                            Agregar a mi calendario
                        </button>
                        <button class="inline-flex items-center px-3 py-2 text-sm font-medium text-green-700 bg-green-100 rounded-md hover:bg-green-200 transition-colors">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                            </svg>
                            Crear recordatorio
                        </button>
                        <button class="inline-flex items-center px-3 py-2 text-sm font-medium text-purple-700 bg-purple-100 rounded-md hover:bg-purple-200 transition-colors">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.367 2.684 3 3 0 00-5.367-2.684z"></path>
                            </svg>
                            Compartir
                        </button>
                    </div>
                </div>
                --}}
            </div>

            <x-slot name="footer">
                <div class="flex justify-between items-center">
                    <div class="text-sm text-gray-500">
                        ID: {{ $selectedActivity->id }} • Creado: {{ \Carbon\Carbon::parse($selectedActivity->created_at)->format('d/m/Y H:i') }}
                    </div>
                    <div class="flex space-x-3">
                        <x-filament::button
                            x-on:click="close"
                            color="gray">
                            Cerrar
                        </x-filament::button>
                        <a href="{{ route('filament.usuario.pages.activity-calendar-view') }}"
                           target="_blank"
                           class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-md border border-transparent hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <svg class="mr-2 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
                            </svg>
                            Ver en calendario completo
                        </a>
                    </div>
                </div>
            </x-slot>
        @endif
    </x-filament::modal>
</x-filament-widgets::widget>

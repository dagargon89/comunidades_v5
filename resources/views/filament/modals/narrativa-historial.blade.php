<div class="space-y-4">
    @if($versiones->isEmpty())
        <div class="text-center py-8 text-gray-500">
            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <p class="mt-2 text-sm">No hay historial de versiones para esta narrativa</p>
        </div>
    @else
        <div class="relative">
            <!-- Timeline visual -->
            <div class="absolute left-8 top-0 bottom-0 w-0.5 bg-gray-200 dark:bg-gray-700"></div>

            @foreach($versiones as $version)
            <div class="relative pl-16 pb-8 last:pb-0">
                <!-- Punto en timeline -->
                <div class="absolute left-6 top-2 w-4 h-4 rounded-full border-2 border-white dark:border-gray-900
                            {{ $loop->first ? 'bg-success-500' : 'bg-gray-400' }}">
                </div>

                <!-- Card de versión -->
                <div class="bg-gray-50 dark:bg-gray-800 rounded-lg p-4 border border-gray-200 dark:border-gray-700">
                    <!-- Header -->
                    <div class="flex justify-between items-start mb-3">
                        <div class="flex items-center gap-2">
                            <span class="font-bold text-lg text-gray-900 dark:text-white">
                                Versión {{ $version->version_number }}
                            </span>
                            @if($loop->first)
                                <span class="text-xs bg-success-100 dark:bg-success-500/20 text-success-700 dark:text-success-400 px-2 py-1 rounded font-medium">
                                    ACTUAL
                                </span>
                            @endif
                            <span class="text-xs px-2 py-1 rounded font-medium
                                        @if($version->tipo_cambio === 'generacion_inicial') bg-success-100 dark:bg-success-500/20 text-success-700 dark:text-success-400
                                        @elseif($version->tipo_cambio === 'regeneracion_automatica') bg-warning-100 dark:bg-warning-500/20 text-warning-700 dark:text-warning-400
                                        @elseif($version->tipo_cambio === 'edicion_manual') bg-info-100 dark:bg-info-500/20 text-info-700 dark:text-info-400
                                        @else bg-primary-100 dark:bg-primary-500/20 text-primary-700 dark:text-primary-400
                                        @endif">
                                {{ $version->tipo_cambio_formatted }}
                            </span>
                        </div>
                        <span class="text-sm text-gray-500 dark:text-gray-400">
                            {{ $version->created_at->diffForHumans() }}
                        </span>
                    </div>

                    <!-- Metadata -->
                    <div class="grid grid-cols-2 gap-3 text-sm mb-3">
                        <div>
                            <span class="text-gray-500 dark:text-gray-400">Creado por:</span>
                            <span class="font-medium text-gray-900 dark:text-white ml-1">
                                {{ $version->createdBy?->name ?? 'Sistema' }}
                            </span>
                        </div>
                        @if($version->modelo_usado)
                        <div>
                            <span class="text-gray-500 dark:text-gray-400">Modelo IA:</span>
                            <span class="font-medium text-gray-900 dark:text-white ml-1">
                                {{ $version->modelo_usado }}
                            </span>
                        </div>
                        @endif
                        @if($version->tiempo_generacion)
                        <div>
                            <span class="text-gray-500 dark:text-gray-400">Tiempo:</span>
                            <span class="font-medium text-gray-900 dark:text-white ml-1">
                                {{ number_format($version->tiempo_generacion, 2) }}s
                            </span>
                        </div>
                        @endif
                        @if($version->temperatura)
                        <div>
                            <span class="text-gray-500 dark:text-gray-400">Temperatura:</span>
                            <span class="font-medium text-gray-900 dark:text-white ml-1">
                                {{ $version->temperatura }}
                            </span>
                        </div>
                        @endif
                    </div>

                    @if($version->motivo_cambio)
                    <div class="text-sm mb-3 bg-gray-100 dark:bg-gray-700 p-2 rounded">
                        <span class="text-gray-500 dark:text-gray-400">Motivo:</span>
                        <span class="italic text-gray-700 dark:text-gray-300 ml-1">{{ $version->motivo_cambio }}</span>
                    </div>
                    @endif

                    <!-- Preview de narrativa (colapsable) -->
                    <details class="text-sm">
                        <summary class="cursor-pointer text-primary-600 dark:text-primary-400 hover:text-primary-700 dark:hover:text-primary-300 font-medium">
                            <svg class="inline w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                            </svg>
                            Ver narrativa completa
                        </summary>
                        <div class="mt-2 p-3 bg-white dark:bg-gray-900 rounded border border-gray-200 dark:border-gray-700">
                            <p class="text-gray-700 dark:text-gray-300 whitespace-pre-line leading-relaxed">
                                {{ Str::limit($version->narrativa_generada, 500) }}
                            </p>
                            @if(strlen($version->narrativa_generada) > 500)
                                <p class="text-gray-500 dark:text-gray-400 text-xs mt-2">
                                    ... y {{ strlen($version->narrativa_generada) - 500 }} caracteres más
                                </p>
                            @endif
                        </div>
                    </details>

                    <!-- Estadísticas adicionales -->
                    @if($version->participantes_count || $version->organizaciones_participantes)
                    <div class="mt-3 pt-3 border-t border-gray-200 dark:border-gray-700 text-sm">
                        <div class="flex gap-4">
                            @if($version->participantes_count)
                            <div class="flex items-center gap-1 text-gray-600 dark:text-gray-400">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                </svg>
                                <span>{{ $version->participantes_count }} participantes</span>
                            </div>
                            @endif
                            @if($version->organizaciones_participantes)
                            <div class="flex items-center gap-1 text-gray-600 dark:text-gray-400">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                                </svg>
                                <span>{{ count(explode(',', $version->organizaciones_participantes)) }} organizaciones</span>
                            </div>
                            @endif
                        </div>
                    </div>
                    @endif
                </div>
            </div>
            @endforeach
        </div>
    @endif
</div>

<div class="space-y-4">
    {{-- Encabezado del evento --}}
    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
        <h3 class="font-semibold text-lg mb-2">
            {{ $narrativa->fecha_formateada }} — {{ $narrativa->activityCalendar->activity->name }}
        </h3>

        @if($narrativa->activityCalendar->location)
        <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
            📍 {{ $narrativa->activityCalendar->location->name }}
        </p>
        @elseif($narrativa->activityCalendar->address_backup)
        <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
            📍 {{ $narrativa->activityCalendar->address_backup }}
        </p>
        @endif

        {{-- Narrativa generada --}}
        @if($narrativa->narrativa_generada)
        <div class="prose dark:prose-invert max-w-none text-justify leading-relaxed mt-4">
            {!! nl2br(e($narrativa->narrativa_generada)) !!}
        </div>
        @else
        <div class="text-center py-8">
            <x-heroicon-o-document-text class="w-12 h-12 mx-auto text-gray-400 mb-3" />
            <p class="text-gray-500 dark:text-gray-400">
                No hay narrativa generada aún.
            </p>
            <p class="text-sm text-gray-400 dark:text-gray-500 mt-2">
                Completa los campos de contexto, desarrollo y resultados, luego genera la narrativa.
            </p>
        </div>
        @endif
    </div>

    {{-- Estado de aprobación --}}
    <div class="flex items-center justify-between p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
        <div class="flex items-center space-x-2">
            @if($narrativa->narrativa_aprobada)
                <x-heroicon-o-check-circle class="w-5 h-5 text-green-600" />
                <span class="text-sm text-green-700 dark:text-green-400 font-medium">
                    Narrativa aprobada
                </span>
            @elseif($narrativa->narrativa_generada)
                <x-heroicon-o-clock class="w-5 h-5 text-yellow-600" />
                <span class="text-sm text-yellow-700 dark:text-yellow-400 font-medium">
                    Pendiente de aprobación
                </span>
            @else
                <x-heroicon-o-exclamation-circle class="w-5 h-5 text-gray-600" />
                <span class="text-sm text-gray-700 dark:text-gray-400 font-medium">
                    Sin generar
                </span>
            @endif
        </div>

        @if($narrativa->narrativa_regenerada_at)
        <span class="text-xs text-gray-500">
            Generada: {{ $narrativa->narrativa_regenerada_at->diffForHumans() }}
        </span>
        @endif
    </div>

    {{-- Información adicional del evento --}}
    <div class="grid grid-cols-2 gap-4 p-4 bg-gray-100 dark:bg-gray-700 rounded-lg text-sm">
        <div>
            <strong class="text-gray-700 dark:text-gray-300">Participantes:</strong>
            <span class="text-gray-900 dark:text-gray-100">
                {{ $narrativa->participantes_count ?? 'No especificado' }}
            </span>
        </div>
        <div>
            <strong class="text-gray-700 dark:text-gray-300">Fecha del evento:</strong>
            <span class="text-gray-900 dark:text-gray-100">
                {{ $narrativa->activityCalendar->start_date->format('d/m/Y') }}
            </span>
        </div>
        @if($narrativa->organizaciones_participantes)
        <div class="col-span-2">
            <strong class="text-gray-700 dark:text-gray-300">Organizaciones:</strong><br>
            <span class="text-gray-900 dark:text-gray-100">
                {{ $narrativa->organizaciones_participantes }}
            </span>
        </div>
        @endif

        @if($narrativa->activityCalendar->activity->goal)
        <div class="col-span-2">
            <strong class="text-gray-700 dark:text-gray-300">Meta:</strong><br>
            <span class="text-gray-900 dark:text-gray-100 text-xs">
                {{ $narrativa->activityCalendar->activity->goal->description }}
            </span>
        </div>
        @endif
    </div>

    {{-- Información de entrada manual (si existe) --}}
    @if($narrativa->narrativa_contexto || $narrativa->narrativa_desarrollo || $narrativa->narrativa_resultados)
    <div class="border-t pt-4">
        <h4 class="font-semibold text-sm text-gray-700 dark:text-gray-300 mb-3">
            Información proporcionada para generación:
        </h4>

        @if($narrativa->narrativa_contexto)
        <div class="mb-3">
            <strong class="text-xs text-gray-600 dark:text-gray-400">Contexto:</strong>
            <p class="text-sm text-gray-700 dark:text-gray-300 mt-1">
                {{ $narrativa->narrativa_contexto }}
            </p>
        </div>
        @endif

        @if($narrativa->narrativa_desarrollo)
        <div class="mb-3">
            <strong class="text-xs text-gray-600 dark:text-gray-400">Desarrollo:</strong>
            <p class="text-sm text-gray-700 dark:text-gray-300 mt-1">
                {{ $narrativa->narrativa_desarrollo }}
            </p>
        </div>
        @endif

        @if($narrativa->narrativa_resultados)
        <div class="mb-3">
            <strong class="text-xs text-gray-600 dark:text-gray-400">Resultados:</strong>
            <p class="text-sm text-gray-700 dark:text-gray-300 mt-1">
                {{ $narrativa->narrativa_resultados }}
            </p>
        </div>
        @endif
    </div>
    @endif
</div>

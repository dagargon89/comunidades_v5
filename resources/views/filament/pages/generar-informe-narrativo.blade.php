<x-filament-panels::page>
    {{-- Estadísticas del proyecto seleccionado --}}
    @if($this->data['project_id'] ?? null)
        <x-filament::section>
            <x-slot name="heading">
                Estadísticas del proyecto
            </x-slot>

            @php
                $stats = $this->getEstadisticas();
            @endphp

            <div class="grid grid-cols-2 md:grid-cols-5 gap-4">
                <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                    <div class="text-3xl font-bold text-primary-600 dark:text-primary-400">
                        {{ $stats['objetivos'] }}
                    </div>
                    <div class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                        Objetivos
                    </div>
                </div>

                <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                    <div class="text-3xl font-bold text-primary-600 dark:text-primary-400">
                        {{ $stats['metas'] }}
                    </div>
                    <div class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                        Metas
                    </div>
                </div>

                <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                    <div class="text-3xl font-bold text-primary-600 dark:text-primary-400">
                        {{ $stats['eventos'] }}
                    </div>
                    <div class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                        Eventos totales
                    </div>
                </div>

                <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                    <div class="text-3xl font-bold text-success-600 dark:text-success-400">
                        {{ $stats['narrativas_generadas'] }}
                    </div>
                    <div class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                        Narrativas generadas
                    </div>
                </div>

                <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                    <div class="text-3xl font-bold text-success-600 dark:text-success-400">
                        {{ $stats['narrativas_aprobadas'] }}
                    </div>
                    <div class="text-sm text-gray-600 dark:text-gray-400 mt-1">
                        Narrativas aprobadas
                    </div>
                </div>
            </div>
        </x-filament::section>
    @endif

    {{-- Formulario de configuración --}}
    <form wire:submit="generar">
        {{ $this->form }}

        {{-- Botón de generación --}}
        <div class="flex justify-end mt-6">
            <x-filament::button
                type="submit"
                size="lg"
                icon="heroicon-o-document-text"
                wire:loading.attr="disabled"
                wire:target="generar"
            >
                <span wire:loading.remove wire:target="generar">
                    Generar Informe Narrativo
                </span>
                <span wire:loading wire:target="generar" class="flex items-center gap-2">
                    <svg class="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    Generando informe, por favor espere...
                </span>
            </x-filament::button>
        </div>

        {{-- Mensaje de progreso --}}
        <div wire:loading wire:target="generar" class="mt-4">
            <x-filament::section>
                <div class="flex items-center gap-3">
                    <svg class="animate-spin h-6 w-6 text-primary-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    <div>
                        <p class="text-sm font-medium text-gray-900 dark:text-white">
                            Generando informe narrativo...
                        </p>
                        <p class="text-xs text-gray-500 dark:text-gray-400">
                            Este proceso puede tardar varios minutos dependiendo de la cantidad de eventos y si se están regenerando narrativas con IA.
                        </p>
                    </div>
                </div>
            </x-filament::section>
        </div>
    </form>

    {{-- Información adicional --}}
    <x-filament::section class="mt-6">
        <x-slot name="heading">
            Información importante
        </x-slot>

        <div class="prose dark:prose-invert max-w-none">
            <ul class="text-sm space-y-2">
                <li>
                    <strong>Narrativas generadas:</strong> El informe incluirá todas las narrativas generadas por IA en el periodo seleccionado.
                </li>
                <li>
                    <strong>Cache de narrativas:</strong> Si está activado, se usarán las narrativas ya generadas. Si lo desactivas, se regenerarán todas con IA (puede tardar varios minutos).
                </li>
                <li>
                    <strong>Solo aprobadas:</strong> Si está activado, solo se incluirán eventos cuyas narrativas hayan sido marcadas como aprobadas.
                </li>
                <li>
                    <strong>Formato PDF:</strong> El informe se generará en formato PDF con diseño institucional formal, listo para imprimir o compartir.
                </li>
                <li>
                    <strong>Tiempo de generación:</strong> Dependiendo de la cantidad de eventos y si se regeneran narrativas, el proceso puede tardar desde unos segundos hasta varios minutos.
                </li>
            </ul>
        </div>
    </x-filament::section>

    {{-- Script para manejar la descarga --}}
    @script
    <script>
        $wire.on('descargar-informe', () => {
            // Usar window.location para forzar la descarga
            setTimeout(() => {
                window.location.href = '{{ route('admin.informe-narrativo.descargar') }}';
            }, 500);
        });
    </script>
    @endscript
</x-filament-panels::page>

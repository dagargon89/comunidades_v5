<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Información de ayuda --}}
        <x-filament::section>
            <x-slot name="heading">
                Información
            </x-slot>

            <x-slot name="description">
                Esta página muestra el progreso en tiempo real de la generación de narrativas. Se actualiza automáticamente cada 5 segundos.
            </x-slot>

            <div class="prose prose-sm dark:prose-invert">
                <ul>
                    <li><strong>Pendiente:</strong> El proceso está en cola esperando para comenzar</li>
                    <li><strong>Procesando:</strong> Se están generando las narrativas activamente</li>
                    <li><strong>Completado:</strong> Todas las narrativas fueron generadas exitosamente</li>
                    <li><strong>Cancelado:</strong> El proceso fue cancelado manualmente</li>
                </ul>

                <p class="text-sm text-gray-500 dark:text-gray-400">
                    💡 <strong>Tip:</strong> Una vez completado el proceso, recibirás una notificación en la campana 🔔 de la esquina superior derecha.
                </p>
            </div>
        </x-filament::section>

        {{-- Tabla de batches --}}
        <x-filament::section>
            {{ $this->table }}
        </x-filament::section>
    </div>
</x-filament-panels::page>

<div class="space-y-4">
    <div class="grid grid-cols-2 gap-4">
        {{-- Información general --}}
        <div class="bg-gray-50 dark:bg-gray-800 rounded-lg p-4">
            <h4 class="font-semibold text-sm text-gray-700 dark:text-gray-300 mb-2">Información General</h4>
            <dl class="space-y-1 text-sm">
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Batch ID:</dt>
                    <dd class="font-mono text-xs text-gray-900 dark:text-white">{{ Str::limit($batch->id, 12) }}</dd>
                </div>
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Nombre:</dt>
                    <dd class="text-gray-900 dark:text-white">{{ $batch->name ?? 'Sin nombre' }}</dd>
                </div>
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Creado:</dt>
                    <dd class="text-gray-900 dark:text-white">{{ \Carbon\Carbon::parse($batch->created_at)->format('d/m/Y H:i:s') }}</dd>
                </div>
                @if($batch->finished_at)
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Finalizado:</dt>
                    <dd class="text-gray-900 dark:text-white">{{ \Carbon\Carbon::parse($batch->finished_at)->format('d/m/Y H:i:s') }}</dd>
                </div>
                @endif
            </dl>
        </div>

        {{-- Progreso --}}
        <div class="bg-gray-50 dark:bg-gray-800 rounded-lg p-4">
            <h4 class="font-semibold text-sm text-gray-700 dark:text-gray-300 mb-2">Progreso</h4>
            <dl class="space-y-1 text-sm">
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Total de jobs:</dt>
                    <dd class="text-gray-900 dark:text-white font-semibold">{{ $batch->total_jobs }}</dd>
                </div>
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Pendientes:</dt>
                    <dd class="text-gray-900 dark:text-white">{{ $batch->pending_jobs }}</dd>
                </div>
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Completados:</dt>
                    <dd class="text-success-600 dark:text-success-400 font-semibold">{{ $batch->total_jobs - $batch->pending_jobs }}</dd>
                </div>
                <div class="flex justify-between">
                    <dt class="text-gray-500 dark:text-gray-400">Fallidos:</dt>
                    <dd class="text-danger-600 dark:text-danger-400 font-semibold">{{ $batch->failed_jobs }}</dd>
                </div>
            </dl>
        </div>
    </div>

    {{-- Barra de progreso --}}
    <div>
        @php
            $total = $batch->total_jobs;
            $completed = $batch->total_jobs - $batch->pending_jobs;
            $failed = $batch->failed_jobs;
            $percentage = $total > 0 ? round(($completed / $total) * 100) : 0;
        @endphp

        <div class="mb-2 flex justify-between text-sm">
            <span class="text-gray-700 dark:text-gray-300 font-medium">Progreso General</span>
            <span class="text-gray-900 dark:text-white font-bold">{{ $percentage }}%</span>
        </div>

        <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-4 overflow-hidden">
            <div class="h-full bg-success-500 transition-all duration-500 flex items-center justify-end pr-2"
                 style="width: {{ $percentage }}%">
                @if($percentage > 10)
                    <span class="text-xs text-white font-semibold">{{ $completed }}/{{ $total }}</span>
                @endif
            </div>
        </div>

        @if($failed > 0)
        <div class="mt-2">
            <div class="bg-danger-100 dark:bg-danger-500/20 text-danger-700 dark:text-danger-400 px-3 py-2 rounded text-sm">
                <svg class="inline w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
                </svg>
                {{ $failed }} {{ $failed === 1 ? 'job falló' : 'jobs fallaron' }} durante el procesamiento
            </div>
        </div>
        @endif
    </div>

    {{-- Estado --}}
    <div class="border-t border-gray-200 dark:border-gray-700 pt-4">
        <div class="flex items-center gap-2">
            <span class="text-sm text-gray-500 dark:text-gray-400">Estado:</span>
            @if($batch->cancelled_at)
                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-danger-100 dark:bg-danger-500/20 text-danger-700 dark:text-danger-400">
                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                    Cancelado
                </span>
            @elseif($batch->finished_at)
                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-success-100 dark:bg-success-500/20 text-success-700 dark:text-success-400">
                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    Completado
                </span>
            @elseif($batch->pending_jobs < $batch->total_jobs)
                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-warning-100 dark:bg-warning-500/20 text-warning-700 dark:text-warning-400">
                    <svg class="animate-spin w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                    </svg>
                    Procesando
                </span>
            @else
                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-gray-100 dark:bg-gray-500/20 text-gray-700 dark:text-gray-400">
                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    Pendiente
                </span>
            @endif
        </div>
    </div>

    {{-- Información adicional --}}
    @if($batch->options)
    <div class="border-t border-gray-200 dark:border-gray-700 pt-4">
        <h4 class="font-semibold text-sm text-gray-700 dark:text-gray-300 mb-2">Opciones</h4>
        <pre class="text-xs bg-gray-100 dark:bg-gray-900 p-2 rounded overflow-auto max-h-32">{{ json_encode(json_decode($batch->options), JSON_PRETTY_PRINT) }}</pre>
    </div>
    @endif
</div>

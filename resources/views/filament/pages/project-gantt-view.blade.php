@php
    use Carbon\Carbon;
    // RESPALDO DEL ARCHIVO project-gantt-view.blade.php ANTES DE MOVER LA LÓGICA DE LOS MODALES
    // Determinar el rango de fechas a mostrar (ejemplo: de la fecha más temprana a la más lejana de las tareas)
    $dates = collect($ganttTasks)->flatMap(fn($t) => [$t['start'], $t['end']])->filter()->sort()->values();
    $startDate = $dates->first() ? Carbon::parse($dates->first()) : Carbon::now();
    $endDate = $dates->last() ? Carbon::parse($dates->last()) : Carbon::now()->addDays(30);
    $period = new DatePeriod($startDate, new DateInterval('P1D'), $endDate->copy()->addDay());
    $dateHeaders = collect(iterator_to_array($period));
@endphp
<x-filament-panels::page>
    <div class="p-6 bg-white rounded-lg shadow-lg">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-4">
            <div class="flex gap-2">
                <select id="project-filter" class="filament-input rounded border-gray-300">
                    <option value="">Todos los proyectos</option>
                    @foreach($projects as $id => $name)
                        <option value="{{ $id }}">{{ $name }}</option>
                    @endforeach
                </select>
                <select id="responsible-filter" class="filament-input rounded border-gray-300">
                    <option value="">Todos los responsables</option>
                    @foreach($users as $id => $name)
                        <option value="{{ $id }}">{{ $name }}</option>
                    @endforeach
                </select>
            </div>
            <div class="flex gap-2">
                <a href="{{ url('/admin/activity-calendar-view') }}">
                    <x-filament::button color="primary" icon="heroicon-o-plus">
                        Programar actividad
                    </x-filament::button>
                </a>
            </div>
        </div>
        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-200 rounded-lg">
                <thead>
                    <tr>
                        <th class="bg-gray-50 px-2 py-1 text-xs font-bold text-gray-700 border-r border-gray-200">Actividad</th>
                        @foreach($dateHeaders as $date)
                            <th class="bg-gray-50 px-1 py-1 text-[10px] font-bold text-gray-500 border-r border-gray-100 whitespace-nowrap">
                                {{ $date->format('d/m') }}
                            </th>
                        @endforeach
                    </tr>
                </thead>
                <tbody>
                    @foreach($ganttTasks as $task)
                        <tr>
                            <td class="bg-white px-2 py-1 text-xs font-semibold text-gray-700 border-r border-gray-100 whitespace-nowrap">
                                {{ $task['name'] }}
                            </td>
                            @foreach($dateHeaders as $date)
                                @php
                                    $start = Carbon::parse($task['start']);
                                    $end = Carbon::parse($task['end']);
                                    $isInRange = ($start <= $date && $date <= $end);
                                    $color = $projectColors[$task['project_id']] ?? '#6b7280';
                                @endphp
                                <td class="px-1 py-1 border-r border-gray-100 text-center">
                                    @if($isInRange)
                                        <div style="height:18px; border-radius:4px; background:{{ $color }}; min-width:16px;" title="{{ $task['name'] }}"></div>
                                    @endif
                                </td>
                            @endforeach
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</x-filament-panels::page>

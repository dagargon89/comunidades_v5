@php
    $projectColors = [
        1 => '#4caf50',
        2 => '#2196f3',
        3 => '#ff9800',
        4 => '#e91e63',
        5 => '#9c27b0',
        // ...agrega más si tienes más proyectos
    ];
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
                <button id="today-btn" class="filament-button">Hoy</button>
                <select id="view-mode" class="filament-input rounded border-gray-300">
                    <option value="Day">Día</option>
                    <option value="Week">Semana</option>
                    <option value="Month" selected>Mes</option>
                </select>
            </div>
        </div>
        <div id="gantt-container" class="bg-white rounded-lg border border-gray-200 shadow-inner overflow-x-auto" style="min-height: 400px;">
            <div id="gantt"></div>
            <div id="no-tasks" style="display: none;">
                <p class="mb-4 text-gray-500">No hay actividades calendarizadas.</p>
            </div>
        </div>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/frappe-gantt/dist/frappe-gantt.css">
        <style>
            /* Fondo y bordes tipo Filament */
            #gantt-container {
                background: #fff;
                border-radius: 0.75rem;
                border: 1px solid #e5e7eb;
                box-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05);
                padding: 1rem;
            }
            /* Barras del Gantt más intensas y sin opacidad */
            .bar {
                stroke: #374151 !important; /* gris oscuro */
                stroke-width: 2px !important;
                opacity: 1 !important;
                filter: none !important;
            }
            .bar:hover {
                filter: brightness(1.1) drop-shadow(0 2px 6px #0002);
            }
            /* Colores pastel más intensos */
            .bar[fill='#4caf50'] { fill: #22c55e !important; } /* verde */
            .bar[fill='#2196f3'] { fill: #2563eb !important; } /* azul */
            .bar[fill='#ff9800'] { fill: #f59e42 !important; } /* naranja */
            .bar[fill='#e91e63'] { fill: #e11d48 !important; } /* rosa */
            .bar[fill='#9c27b0'] { fill: #a21caf !important; } /* morado */
            .bar[fill='#9e9e9e'] { fill: #6b7280 !important; } /* gris */
            /* Texto de las barras más grande y oscuro */
            .bar-label {
                font-family: inherit !important;
                font-size: 1rem !important;
                fill: #1f2937 !important; /* gris muy oscuro */
                font-weight: 600 !important;
                text-shadow: 0 1px 2px #fff8;
            }
            /* Ejes y líneas */
            .grid .row-line {
                stroke: #e5e7eb !important;
            }
            .grid .tick {
                stroke: #d1d5db !important;
            }
            /* Tooltip */
            .popup-wrapper {
                font-family: inherit !important;
                font-size: 1rem !important;
                background: #fff !important;
                border: 1px solid #e5e7eb !important;
                border-radius: 0.5rem !important;
                box-shadow: 0 2px 8px #0001 !important;
                color: #374151 !important;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/frappe-gantt/dist/frappe-gantt.umd.js"></script>
        <script>
            let allTasks = @json($ganttTasks);
            const projectColors = @json($projectColors);
            // Asigna el color a cada tarea según el project_id
            allTasks = allTasks.map(task => ({
                ...task,
                color: projectColors[task.project_id] || '#9e9e9e'
            }));
            let gantt = null;

            function renderGantt(tasks, viewMode = 'Month') {
                document.getElementById('gantt').innerHTML = '';
                if (tasks.length > 0) {
                    document.getElementById('gantt').style.display = '';
                    document.getElementById('no-tasks').style.display = 'none';
                    gantt = new Gantt("#gantt", tasks, {
                        view_mode: viewMode,
                        today_button: true,
                        language: 'es',
                        bar_height: 38, // más grueso
                        bar_corner_radius: 8,
                        padding: 32,
                        show_expected_progress: true,
                        lines: 'both',
                        popup_on: 'click',
                        scroll_to: 'today',
                    });
                    setTimeout(() => {
                        tasks.forEach(task => {
                            const bar = document.querySelector(`.bar[data-id='${task.id}']`);
                            if (bar && task.color) {
                                bar.setAttribute('fill', task.color);
                                bar.style.fill = task.color;
                            }
                        });
                    }, 100);
                } else {
                    document.getElementById('gantt').style.display = 'none';
                    document.getElementById('no-tasks').style.display = '';
                }
            }

            function filterTasks() {
                const projectId = document.getElementById('project-filter').value;
                const responsibleId = document.getElementById('responsible-filter').value;
                let filtered = allTasks;
                if (projectId) {
                    filtered = filtered.filter(t => t.project_id == projectId);
                }
                if (responsibleId) {
                    filtered = filtered.filter(t => t.assigned_person == responsibleId);
                }
                return filtered;
            }

            document.addEventListener('DOMContentLoaded', function () {
                renderGantt(allTasks);

                document.getElementById('project-filter').addEventListener('change', function () {
                    renderGantt(filterTasks(), document.getElementById('view-mode').value);
                });
                document.getElementById('responsible-filter').addEventListener('change', function () {
                    renderGantt(filterTasks(), document.getElementById('view-mode').value);
                });
                document.getElementById('view-mode').addEventListener('change', function () {
                    renderGantt(filterTasks(), this.value);
                });
                document.getElementById('today-btn').addEventListener('click', function () {
                    if (gantt) gantt.scroll_current();
                });
            });
        </script>
    </div>
</x-filament-panels::page>

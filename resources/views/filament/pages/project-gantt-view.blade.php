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
        <div id="gantt" style="min-height: 400px;"></div>
        <div id="no-tasks" style="display: none;">
            <p class="mb-4 text-gray-500">No hay actividades calendarizadas.</p>
        </div>
    </div>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/frappe-gantt/dist/frappe-gantt.css">
    <script src="https://cdn.jsdelivr.net/npm/frappe-gantt/dist/frappe-gantt.umd.js"></script>
    <script>
        let allTasks = @json($ganttTasks);
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
                    bar_height: 32,
                    bar_corner_radius: 6,
                    padding: 24,
                    show_expected_progress: true,
                    lines: 'both',
                    popup_on: 'click',
                    scroll_to: 'today',
                });
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
</x-filament-panels::page>

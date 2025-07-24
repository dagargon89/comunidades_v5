<x-filament-panels::page>
    <div class="p-6">
        <h1 class="text-2xl font-bold mb-4">Diagrama de Gantt de Proyectos</h1>
        <div id="gantt" style="min-height: 350px;"></div>
        <div id="no-tasks" style="display: none;">
            <p class="mb-4 text-gray-500">No hay actividades calendarizadas.</p>
        </div>
    </div>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/frappe-gantt/dist/frappe-gantt.css">
    <script src="https://cdn.jsdelivr.net/npm/frappe-gantt/dist/frappe-gantt.umd.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            let tasks = @json($ganttTasks);
            if (tasks.length > 0) {
                document.getElementById('gantt').style.display = '';
                document.getElementById('no-tasks').style.display = 'none';
                new Gantt("#gantt", tasks);
            } else {
                document.getElementById('gantt').style.display = 'none';
                document.getElementById('no-tasks').style.display = '';
            }
        });
    </script>
</x-filament-panels::page>

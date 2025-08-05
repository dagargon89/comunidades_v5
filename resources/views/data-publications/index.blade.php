<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicaciones de Datos</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
</head>
<body class="bg-gray-100">
    <div class="min-h-screen">
        <!-- Header -->
        <header class="bg-white shadow">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between h-16">
                    <div class="flex items-center">
                        <h1 class="text-2xl font-bold text-gray-900">Publicaciones de Datos</h1>
                    </div>
                    <div class="flex items-center">
                        <a href="{{ route('welcome') }}" class="text-gray-600 hover:text-gray-900">
                            Volver al inicio
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
            <div x-data="publicationApp()" class="space-y-6">
                <!-- Estadísticas -->
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">Estadísticas Generales</h3>
                        <div class="grid grid-cols-1 gap-5 sm:grid-cols-4">
                            <div class="bg-blue-50 p-4 rounded-lg">
                                <div class="text-sm font-medium text-blue-600">Total Publicaciones</div>
                                <div class="text-2xl font-bold text-blue-900" x-text="stats.total_publications || 0"></div>
                            </div>
                            <div class="bg-green-50 p-4 rounded-lg">
                                <div class="text-sm font-medium text-green-600">Proyectos Publicados</div>
                                <div class="text-2xl font-bold text-green-900" x-text="stats.total_projects_published || 0"></div>
                            </div>
                            <div class="bg-yellow-50 p-4 rounded-lg">
                                <div class="text-sm font-medium text-yellow-600">Actividades Publicadas</div>
                                <div class="text-2xl font-bold text-yellow-900" x-text="stats.total_activities_published || 0"></div>
                            </div>
                            <div class="bg-purple-50 p-4 rounded-lg">
                                <div class="text-sm font-medium text-purple-600">Métricas Publicadas</div>
                                <div class="text-2xl font-bold text-purple-900" x-text="stats.total_metrics_published || 0"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Formulario de Publicación -->
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">Nueva Publicación</h3>
                        <form @submit.prevent="publishData" class="space-y-4">
                            <div>
                                <label for="notes" class="block text-sm font-medium text-gray-700">Notas de la Publicación</label>
                                <textarea
                                    id="notes"
                                    x-model="form.notes"
                                    rows="3"
                                    class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                    placeholder="Descripción opcional de la publicación..."
                                ></textarea>
                            </div>

                            <div class="grid grid-cols-1 gap-4 sm:grid-cols-2">
                                <div>
                                    <label for="period_from" class="block text-sm font-medium text-gray-700">Período Desde (Opcional)</label>
                                    <input
                                        type="date"
                                        id="period_from"
                                        x-model="form.period_from"
                                        class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                    >
                                </div>
                                <div>
                                    <label for="period_to" class="block text-sm font-medium text-gray-700">Período Hasta (Opcional)</label>
                                    <input
                                        type="date"
                                        id="period_to"
                                        x-model="form.period_to"
                                        class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                    >
                                </div>
                            </div>

                            <div class="flex justify-end">
                                <button
                                    type="submit"
                                    :disabled="loading"
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 disabled:opacity-50"
                                >
                                    <span x-show="!loading">Publicar Datos</span>
                                    <span x-show="loading" class="flex items-center">
                                        <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                        </svg>
                                        Publicando...
                                    </span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Historial de Publicaciones -->
                <div class="bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">Historial de Publicaciones</h3>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fecha</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Publicado Por</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Notas</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Proyectos</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actividades</th>
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Métricas</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <template x-for="publication in publications" :key="publication.id">
                                        <tr>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" x-text="formatDate(publication.publication_date)"></td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" x-text="publication.published_by_name"></td>
                                            <td class="px-6 py-4 text-sm text-gray-900" x-text="publication.publication_notes || '-'"></td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" x-text="publication.projects_count"></td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" x-text="publication.activities_count"></td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900" x-text="publication.metrics_count"></td>
                                        </tr>
                                    </template>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        function publicationApp() {
            return {
                loading: false,
                form: {
                    notes: '',
                    period_from: '',
                    period_to: ''
                },
                publications: [],
                stats: {},

                async init() {
                    await this.loadStats();
                    await this.loadHistory();
                },

                async loadStats() {
                    try {
                        const response = await fetch('/data-publications/stats');
                        const data = await response.json();
                        if (data.success) {
                            this.stats = data.data;
                        }
                    } catch (error) {
                        console.error('Error cargando estadísticas:', error);
                    }
                },

                async loadHistory() {
                    try {
                        const response = await fetch('/data-publications/history');
                        const data = await response.json();
                        if (data.success) {
                            this.publications = data.data;
                        }
                    } catch (error) {
                        console.error('Error cargando historial:', error);
                    }
                },

                async publishData() {
                    this.loading = true;

                    try {
                        const response = await fetch('/data-publications/publish', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
                            },
                            body: JSON.stringify(this.form)
                        });

                        const data = await response.json();

                        if (data.success) {
                            alert('Publicación completada exitosamente');
                            this.form = { notes: '', period_from: '', period_to: '' };
                            await this.loadStats();
                            await this.loadHistory();
                        } else {
                            alert('Error: ' + data.message);
                        }
                    } catch (error) {
                        console.error('Error en la publicación:', error);
                        alert('Error al ejecutar la publicación');
                    } finally {
                        this.loading = false;
                    }
                },

                formatDate(dateString) {
                    return new Date(dateString).toLocaleDateString('es-ES', {
                        year: 'numeric',
                        month: 'short',
                        day: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit'
                    });
                }
            }
        }
    </script>
</body>
</html>

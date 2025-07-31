<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Plataforma de Planeación Estratégica</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=instrument-sans:400,500,600" rel="stylesheet" />

        <!-- Styles -->
        @vite(['resources/css/app.css', 'resources/js/app.js'])

        <!-- Alpine.js -->
        <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

        <!-- Fallback para Tailwind si Vite no está disponible -->
        <script>
            if (typeof window !== 'undefined' && !window.Vite) {
                document.write('<script src="https://cdn.tailwindcss.com"><\/script>');
            }
        </script>

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body class="bg-gray-50">
        <!-- Header con navbar -->
        <header class="bg-white border-b border-gray-200 shadow-sm">
            <div class="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <div class="flex items-center space-x-8">
                        <div class="flex items-center space-x-3">
                            <div class="flex justify-center items-center w-8 h-8 bg-amber-600 rounded-lg">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                            </div>
                            <div>
                                <h1 class="text-xl font-semibold text-gray-900">Planeación Estratégica</h1>
                                <p class="text-sm text-gray-600">Plan Estratégico de Juárez</p>
                            </div>
                        </div>

                        <!-- Menú de navegación -->
                        <nav class="flex items-center space-x-6">
                            <a href="/admin"
                               class="flex items-center px-4 py-2 text-sm font-medium text-gray-700 rounded-md transition-colors duration-200 hover:text-amber-600 hover:bg-amber-50">
                                <svg class="mr-2 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                Panel Administrativo
                            </a>

                            <a href="/usuario"
                               class="flex items-center px-4 py-2 text-sm font-medium text-gray-700 rounded-md transition-colors duration-200 hover:text-amber-600 hover:bg-amber-50">
                                <svg class="mr-2 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                                </svg>
                                Panel de Usuarios
                            </a>
                        </nav>
                    </div>
                </div>
            </div>
        </header>

        <!-- Contenido principal -->
        <main class="px-4 py-12 mx-auto max-w-7xl sm:px-6 lg:px-8">
            <!-- Sección de bienvenida -->
            <div class="mb-16 text-center">
                <h2 class="mb-4 text-4xl font-bold text-gray-900">
                    Bienvenido a la Plataforma de Planeación Estratégica
                </h2>
                <p class="mx-auto max-w-3xl text-xl text-gray-600">
                    Sistema integral para la gestión y seguimiento de proyectos estratégicos
                    del Plan Estratégico de Juárez. Gestiona actividades, métricas y
                    reportes de manera eficiente.
                </p>
            </div>

            <!-- Estadísticas rápidas -->
            <div class="grid grid-cols-1 gap-6 mb-12 md:grid-cols-4">
                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="flex justify-center items-center w-12 h-12 bg-blue-100 rounded-lg">
                            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Proyectos Activos</p>
                            <p class="text-2xl font-bold text-gray-900">24</p>
                        </div>
                    </div>
                </div>

                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="flex justify-center items-center w-12 h-12 bg-green-100 rounded-lg">
                            <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Actividades Completadas</p>
                            <p class="text-2xl font-bold text-gray-900">156</p>
                        </div>
                    </div>
                </div>

                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="flex justify-center items-center w-12 h-12 bg-purple-100 rounded-lg">
                            <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Beneficiarios</p>
                            <p class="text-2xl font-bold text-gray-900">2,847</p>
                        </div>
                    </div>
                </div>

                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <div class="flex items-center">
                        <div class="flex justify-center items-center w-12 h-12 bg-amber-100 rounded-lg">
                            <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1"></path>
                            </svg>
                        </div>
                        <div class="ml-4">
                            <p class="text-sm font-medium text-gray-600">Presupuesto Ejecutado</p>
                            <p class="text-2xl font-bold text-gray-900">78%</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Gráficas de muestra -->
            <div class="grid grid-cols-1 gap-8 mb-16 lg:grid-cols-2">
                <!-- Gráfico de barras - Progreso por Eje Estratégico -->
                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <h3 class="mb-4 text-lg font-semibold text-gray-900">Progreso por Eje Estratégico</h3>
                    <div class="h-64">
                        <canvas id="barChart"></canvas>
                    </div>
                </div>

                <!-- Gráfico de líneas - Actividades por Mes -->
                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <h3 class="mb-4 text-lg font-semibold text-gray-900">Actividades Completadas por Mes</h3>
                    <div class="h-64">
                        <canvas id="lineChart"></canvas>
                    </div>
                </div>

                <!-- Gráfico de dona - Distribución de Recursos -->
                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <h3 class="mb-4 text-lg font-semibold text-gray-900">Distribución de Recursos</h3>
                    <div class="h-64">
                        <canvas id="doughnutChart"></canvas>
                    </div>
                </div>

                <!-- Gráfico de área - Indicadores de Impacto -->
                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <h3 class="mb-4 text-lg font-semibold text-gray-900">Indicadores de Impacto</h3>
                    <div class="h-64">
                        <canvas id="areaChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Características principales -->
            <div class="grid grid-cols-1 gap-8 mb-16 md:grid-cols-3">
                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <div class="flex items-center mb-4">
                        <div class="flex justify-center items-center w-10 h-10 bg-amber-100 rounded-lg">
                            <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                            </svg>
                        </div>
                        <h3 class="ml-3 text-lg font-semibold text-gray-900">Gestión de Proyectos</h3>
                    </div>
                    <p class="text-gray-600">
                        Administra proyectos, actividades y métricas de manera centralizada con herramientas avanzadas de seguimiento.
                    </p>
                </div>

                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <div class="flex items-center mb-4">
                        <div class="flex justify-center items-center w-10 h-10 bg-amber-100 rounded-lg">
                            <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                        </div>
                        <h3 class="ml-3 text-lg font-semibold text-gray-900">Colaboración</h3>
                    </div>
                    <p class="text-gray-600">
                        Trabaja en equipo con diferentes roles y permisos. Coordina esfuerzos entre organizaciones.
                    </p>
                </div>

                <div class="p-6 bg-white rounded-lg border border-gray-200 shadow-sm">
                    <div class="flex items-center mb-4">
                        <div class="flex justify-center items-center w-10 h-10 bg-amber-100 rounded-lg">
                            <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                        </div>
                        <h3 class="ml-3 text-lg font-semibold text-gray-900">Reportes y Análisis</h3>
                    </div>
                    <p class="text-gray-600">
                        Genera reportes detallados y visualiza el progreso de los proyectos con dashboards interactivos.
                    </p>
                </div>
            </div>

            <!-- Información adicional -->
            <div class="p-8 bg-white rounded-lg border border-gray-200 shadow-sm">
                <div class="text-center">
                    <h3 class="mb-4 text-2xl font-semibold text-gray-900">
                        Accede a los paneles del sistema
                    </h3>
                    <p class="mb-6 text-gray-600">
                        Selecciona el panel que corresponda a tu rol y permisos en la organización.
                    </p>
                    <div class="flex justify-center space-x-4">
                        <a href="/admin"
                           class="inline-flex items-center px-6 py-3 text-base font-medium text-white bg-amber-600 rounded-md border border-transparent transition-colors duration-200 hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                            <svg class="mr-2 w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            Panel Administrativo
                        </a>
                        <a href="/usuario"
                           class="inline-flex items-center px-6 py-3 text-base font-medium text-gray-700 bg-white rounded-md border border-gray-300 transition-colors duration-200 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                            <svg class="mr-2 w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                            </svg>
                            Panel de Usuarios
                        </a>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="mt-16 bg-white border-t border-gray-200">
            <div class="px-4 py-8 mx-auto max-w-7xl sm:px-6 lg:px-8">
                <div class="text-center text-gray-600">
                    <p>&copy; 2025 Plan Estratégico de Juárez. Todos los derechos reservados.</p>
                </div>
            </div>
        </footer>

        <!-- Scripts para las gráficas -->
        <script>
            // Configuración de colores
            const colors = {
                primary: '#d97706',
                secondary: '#059669',
                accent: '#7c3aed',
                warning: '#dc2626',
                info: '#2563eb'
            };

            // Gráfico de barras - Progreso por Eje Estratégico
            const barCtx = document.getElementById('barChart').getContext('2d');
            new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: ['Desarrollo Social', 'Infraestructura', 'Economía', 'Medio Ambiente', 'Gobernanza'],
                    datasets: [{
                        label: 'Progreso (%)',
                        data: [85, 72, 68, 91, 78],
                        backgroundColor: [
                            colors.primary,
                            colors.secondary,
                            colors.accent,
                            colors.info,
                            colors.warning
                        ],
                        borderRadius: 4,
                        borderSkipped: false,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100,
                            ticks: {
                                callback: function(value) {
                                    return value + '%';
                                }
                            }
                        }
                    }
                }
            });

            // Gráfico de líneas - Actividades por Mes
            const lineCtx = document.getElementById('lineChart').getContext('2d');
            new Chart(lineCtx, {
                type: 'line',
                data: {
                    labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Actividades Completadas',
                        data: [12, 19, 15, 25, 22, 30],
                        borderColor: colors.primary,
                        backgroundColor: colors.primary + '20',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Gráfico de dona - Distribución de Recursos
            const doughnutCtx = document.getElementById('doughnutChart').getContext('2d');
            new Chart(doughnutCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Personal', 'Equipamiento', 'Materiales', 'Servicios', 'Otros'],
                    datasets: [{
                        data: [35, 25, 20, 15, 5],
                        backgroundColor: [
                            colors.primary,
                            colors.secondary,
                            colors.accent,
                            colors.info,
                            colors.warning
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                padding: 20,
                                usePointStyle: true
                            }
                        }
                    }
                }
            });

            // Gráfico de área - Indicadores de Impacto
            const areaCtx = document.getElementById('areaChart').getContext('2d');
            new Chart(areaCtx, {
                type: 'line',
                data: {
                    labels: ['Q1', 'Q2', 'Q3', 'Q4'],
                    datasets: [{
                        label: 'Beneficiarios Directos',
                        data: [450, 520, 680, 720],
                        borderColor: colors.secondary,
                        backgroundColor: colors.secondary + '20',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: 'Beneficiarios Indirectos',
                        data: [1200, 1350, 1580, 1820],
                        borderColor: colors.accent,
                        backgroundColor: colors.accent + '20',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </body>
</html>

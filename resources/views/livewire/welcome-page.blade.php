<div class="min-h-screen bg-gray-50">
    <!-- Header simple -->
    <header class="bg-white border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 bg-amber-600 rounded-lg flex items-center justify-center">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                    </div>
                    <div>
                        <h1 class="text-xl font-semibold text-gray-900">Planeación Estratégica</h1>
                        <p class="text-sm text-gray-600">Plan Estratégico de Juárez</p>
                    </div>
                </div>

                <div class="flex items-center space-x-4">
                    <a href="{{ route('login') }}"
                       class="inline-flex items-center px-4 py-2 bg-amber-600 border border-transparent rounded-lg font-medium text-sm text-white shadow-sm hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500 transition-colors duration-200">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"></path>
                        </svg>
                        Iniciar Sesión
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Contenido principal -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <!-- Sección de bienvenida -->
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-gray-900 mb-4">
                {{ $welcomeMessage }}
            </h2>
            <p class="text-xl text-gray-600 max-w-3xl mx-auto">
                Sistema integral para la gestión y seguimiento de proyectos estratégicos
                del Plan Estratégico de Juárez. Gestiona actividades, métricas y
                reportes de manera eficiente.
            </p>
        </div>

        <!-- Características principales -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
            <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
                <div class="flex items-center justify-center w-12 h-12 bg-amber-100 rounded-lg mb-4">
                    <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                    </svg>
                </div>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">Gestión de Proyectos</h3>
                <p class="text-gray-600">Administra proyectos, actividades y métricas de manera centralizada con herramientas avanzadas de seguimiento.</p>
            </div>

            <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
                <div class="flex items-center justify-center w-12 h-12 bg-amber-100 rounded-lg mb-4">
                    <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                    </svg>
                </div>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">Colaboración</h3>
                <p class="text-gray-600">Trabaja en equipo con diferentes roles y permisos. Coordina esfuerzos entre organizaciones.</p>
            </div>

            <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200">
                <div class="flex items-center justify-center w-12 h-12 bg-amber-100 rounded-lg mb-4">
                    <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                </div>
                <h3 class="text-lg font-semibold text-gray-900 mb-2">Reportes y Análisis</h3>
                <p class="text-gray-600">Genera reportes detallados y visualiza el progreso de los proyectos con dashboards interactivos.</p>
            </div>
        </div>

        <!-- Información adicional -->
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
            <div class="text-center">
                <h3 class="text-2xl font-semibold text-gray-900 mb-4">
                    ¿Necesitas acceso al sistema?
                </h3>
                <p class="text-gray-600 mb-6">
                    Contacta a tu administrador para obtener credenciales de acceso
                    según tu rol en la organización.
                </p>
                <div class="flex justify-center space-x-4">
                    <a href="{{ route('login') }}"
                       class="inline-flex items-center px-6 py-3 bg-amber-600 border border-transparent rounded-lg font-medium text-sm text-white shadow-sm hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500 transition-colors duration-200">
                        Iniciar Sesión
                        <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-gray-200 mt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="text-center text-gray-600">
                <p>&copy; 2025 Plan Estratégico de Juárez. Todos los derechos reservados.</p>
            </div>
        </div>
    </footer>
</div>

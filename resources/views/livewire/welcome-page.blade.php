<div class="min-h-screen bg-gray-50">
    <!-- Header con botón de inicio de sesión -->
    <header class="bg-white border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 bg-primary-600 rounded-lg flex items-center justify-center">
                        <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                    </div>
                    <h1 class="text-lg font-semibold text-gray-900">Plataforma de Planeación Estratégica</h1>
                </div>

                <x-welcome.login-button />
            </div>
        </div>
    </header>

    <!-- Contenido principal -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="text-center">
            <!-- Mensaje de bienvenida -->
            <div class="mb-12">
                <h2 class="text-4xl md:text-5xl font-bold text-gray-900 mb-6">
                    Bienvenido a la
                    <span class="text-primary-600">Plataforma de Planeación Estratégica</span>
                </h2>
                <p class="text-xl text-gray-600 leading-relaxed max-w-3xl mx-auto">
                    Herramienta integral para la gestión y seguimiento de proyectos estratégicos.
                    Optimice sus procesos de planeación con nuestra plataforma avanzada.
                </p>
            </div>

            <!-- Características principales -->
            <div class="grid md:grid-cols-3 gap-8">
                <x-welcome.feature-card
                    icon="chart-bar"
                    title="Gestión de Proyectos"
                    description="Administre y monitoree todos sus proyectos estratégicos desde una interfaz unificada."
                />

                <x-welcome.feature-card
                    icon="users"
                    title="Colaboración en Equipo"
                    description="Trabaje en equipo de manera eficiente con herramientas de colaboración integradas."
                />

                <x-welcome.feature-card
                    icon="chart-pie"
                    title="Análisis Avanzado"
                    description="Obtenga insights valiosos con reportes y análisis detallados de sus proyectos."
                />
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-gray-200 mt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
            <div class="text-center">
                <p class="text-gray-600">
                    © {{ date('Y') }} Plataforma de Planeación Estratégica. Todos los derechos reservados.
                </p>
            </div>
        </div>
    </footer>
</div>

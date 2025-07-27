<div class="min-h-screen bg-gray-50">
    <!-- Header con navbar -->
    <x-layout.navbar />

    <!-- Contenido principal -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <!-- Sección de bienvenida -->
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-gray-900 mb-4">
                Bienvenido a la Plataforma de Planeación Estratégica
            </h2>
            <p class="text-xl text-gray-600 max-w-3xl mx-auto">
                Sistema integral para la gestión y seguimiento de proyectos estratégicos
                del Plan Estratégico de Juárez. Gestiona actividades, métricas y
                reportes de manera eficiente.
            </p>
        </div>

        <!-- Características principales -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
            <x-welcome.feature-card
                icon="chart-bar"
                title="Gestión de Proyectos"
                description="Administra proyectos, actividades y métricas de manera centralizada con herramientas avanzadas de seguimiento."
            />

            <x-welcome.feature-card
                icon="users"
                title="Colaboración"
                description="Trabaja en equipo con diferentes roles y permisos. Coordina esfuerzos entre organizaciones."
            />

            <x-welcome.feature-card
                icon="document-text"
                title="Reportes y Análisis"
                description="Genera reportes detallados y visualiza el progreso de los proyectos con dashboards interactivos."
            />
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
                    <x-welcome.primary-button
                        text="Iniciar Sesión"
                        url="{{ route('login') }}"
                    />
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

# Plataforma de Seguimiento de Proyectos - Comunidades V5

## Descripción
Plataforma para el seguimiento y gestión de proyectos con objetivos, metas, actividades y beneficiarios. Sistema multi-panel para diferentes roles (Administración, Capturistas, Financieras).

## Stack Tecnológico

### Backend
- **PHP**: ^8.2
  - [Documentación PHP 8.2](https://www.php.net/releases/8.2/en.php)
- **Laravel**: ^12.0
  - [Documentación Laravel 12.x](https://laravel.com/docs/12.x)
  - [Novedades Laravel 12](https://laravel.com/docs/12.x/releases)
- **Livewire**: ^3.6
  - [Documentación Livewire 3.x](https://livewire.laravel.com/docs)

### Frontend/Admin
- **FilamentPHP**: ^3.3
  - [Documentación Filament 3.x](https://filamentphp.com/docs/3.x)
  - [Panel Builder](https://filamentphp.com/docs/3.x/panels/installation)
  - [Form Builder](https://filamentphp.com/docs/3.x/forms/installation)
  - [Table Builder](https://filamentphp.com/docs/3.x/tables/installation)
  - [Actions](https://filamentphp.com/docs/3.x/actions/overview)
  - [Widgets](https://filamentphp.com/docs/3.x/widgets/overview)
- **Filament Shield**: ^3.3 (gestión de roles y permisos)
  - [Documentación Shield](https://filamentphp.com/plugins/bezhansalleh-shield)
  - [GitHub Repository](https://github.com/bezhanSalleh/filament-shield)
- **Filament Excel**: ^2.5 (exportación de datos Excel/CSV/PDF)
  - [Documentación Excel](https://filamentphp.com/plugins/pxlrbt-excel)
  - [GitHub Repository](https://github.com/pxlrbt/filament-excel)
- **Filament Table Repeater**: ^3.1 (tablas repetidoras)
  - [Documentación Table Repeater](https://filamentphp.com/plugins/awcodes-table-repeater)
  - [GitHub Repository](https://github.com/awcodes/filament-table-repeater)
- **Filament Autograph**: ^3.2 (captura de firmas)
  - [Documentación Autograph](https://filamentphp.com/plugins/saade-autograph)
  - [GitHub Repository](https://github.com/saade/filament-autograph)

### Desarrollo
- **Laravel Pint**: ^1.13 (code styling)
  - [Documentación Laravel Pint](https://laravel.com/docs/12.x/pint)
- **PestPHP**: ^3.8 (testing)
  - [Documentación Pest 3.x](https://pestphp.com/docs)
  - [Pest Laravel Plugin](https://pestphp.com/docs/plugins/laravel)
- **Laravel Blueprint**: ^2.12 (generación de código)
  - [Documentación Blueprint](https://blueprint.laravelshift.com/)
  - [GitHub Repository](https://github.com/laravel-shift/blueprint)
- **Laravel Sail**: ^1.41 (Docker)
  - [Documentación Laravel Sail](https://laravel.com/docs/12.x/sail)
- **Laravel Pail**: ^1.2.2 (logs)
  - [Documentación Laravel Pail](https://laravel.com/docs/12.x/pail)

## Estructura de Paneles

### 1. Panel Admin (`/admin`)
- **Path**: `/admin`
- **Color**: Amber
- **Panel por defecto**: Sí
- **Navegación**: Sidebar
- **Plugin**: FilamentShield (gestión completa de roles y permisos)
- **Recursos**: Ubicados en `app/Filament/Resources/`

### 2. Panel Usuario/Capturistas (`/usuario`)
- **Path**: `/usuario`
- **Navegación**: Sidebar
- **Recursos**: Específicos del panel en `app/Filament/Usuario/`

### 3. Panel Financiera (`/financiera`)
- **Path**: `/financiera`
- **Color**: Blue
- **Navegación**: Top Navigation
- **Max Width**: Full
- **Recursos**: Ubicados en `app/Filament/Financiera/`

## Estructura de Directorios

```
app/
├── Filament/
│   ├── Resources/          # Recursos del panel Admin
│   │   ├── ProjectResource.php
│   │   ├── ProgramResource.php
│   │   ├── ActivityResource.php
│   │   ├── BeneficiaryResource.php
│   │   └── ...
│   ├── Pages/              # Páginas personalizadas Admin
│   ├── Widgets/            # Widgets del panel Admin
│   ├── Financiera/         # Panel Financiera
│   │   ├── Pages/
│   │   │   └── Dashboard.php
│   │   └── Widgets/
│   │       ├── ActivityPerformanceDetails.php
│   │       ├── EventTimelineActivity.php
│   │       └── ...
│   └── Usuario/            # Panel Usuario/Capturistas
│       ├── Pages/
│       └── Widgets/
├── Models/
│   ├── Project.php
│   ├── Program.php
│   ├── Activity.php
│   ├── Goal.php
│   └── ...
└── Providers/
    └── Filament/
        ├── AdminPanelProvider.php
        ├── UsuarioPanelProvider.php
        └── FinancieraPanelProvider.php
```

## Modelos Principales

### Gestión de Proyectos
- **Project**: Proyectos principales
- **Program**: Programas
- **SpecificObjective**: Objetivos específicos
- **Goal**: Metas
- **Activity**: Actividades
- **ActionLine**: Líneas de acción
- **Component**: Componentes

### Métricas y Seguimiento
- **Kpi**: Indicadores clave de desempeño
- **ProgramIndicator**: Indicadores de programa
- **PlannedMetric**: Métricas planificadas
- **PublishedMetric**: Métricas publicadas
- **VistaProgresoProyecto**: Vista de progreso de proyectos

### Beneficiarios
- **Beneficiary**: Beneficiarios
- **BeneficiaryRegistry**: Registro de beneficiarios
- **PadronBeneficiario**: Padrón de beneficiarios

### Financiero
- **ProjectDisbursement**: Desembolsos de proyectos
- **ProjectReport**: Reportes de proyectos
- **Financier**: Financiadores

### Organizaciones
- **Organization**: Organizaciones
- **Axe**: Ejes

### Publicaciones
- **PublishedProject**: Proyectos publicados
- **PublishedActivity**: Actividades publicadas
- **DataPublication**: Publicaciones de datos

### Ubicación
- **Location**: Ubicaciones
- **Polygon**: Polígonos

### Sistema
- **User**: Usuarios
- **ActivityLog**: Registro de actividades
- **ActivityCalendar**: Calendario de actividades
- **ActivityFile**: Archivos de actividades

## Recursos Filament (Panel Admin)

El panel administrativo incluye recursos para gestionar:
- Proyectos y Programas
- Actividades y Líneas de acción
- Metas y Objetivos específicos
- Beneficiarios y sus registros
- Desembolsos y Reportes
- Organizaciones y Financiadores
- KPIs e Indicadores
- Métricas planificadas y publicadas
- Publicaciones de datos
- Ubicaciones y Polígonos
- Usuarios y Roles (Shield)
- Calendarios de actividades

## Características Especiales

### Exportación de Datos
- Integración con `pxlrbt/filament-excel`
- Formatos: Excel, CSV, PDF
- Implementado en widgets como:
  - `ActivityPerformanceDetails`
  - `ProjectDetails`

### Gestión de Permisos
- FilamentShield para control de acceso basado en roles
- Middleware de autenticación en todos los paneles
- Gestión granular de permisos por recurso

### Widgets Financieros
- Dashboard personalizado en panel Financiera
- `ActivityPerformanceDetails`: Detalles de rendimiento de actividades
- `EventTimelineActivity`: Línea de tiempo de eventos

## Scripts Composer

### Desarrollo
```bash
composer dev
```
Ejecuta concurrentemente:
- Servidor Laravel (`php artisan serve`)
- Cola de trabajos (`php artisan queue:listen`)
- Vite dev server (`npm run dev`)

### Testing
```bash
composer test
```
Limpia configuración y ejecuta suite de tests

## Base de Datos

El proyecto utiliza migraciones de Laravel para gestionar el esquema de base de datos. Los modelos están organizados según dominios funcionales (proyectos, beneficiarios, financiero, etc.).

## Git

- **Rama principal**: `main`
- Archivos modificados actualmente:
  - `app/Filament/Financiera/Widgets/ActivityPerformanceDetails.php`
  - `app/Filament/Financiera/Widgets/EventTimelineActivity.php`

## Notas de Desarrollo

### Convenciones
- Se utiliza Laravel 12 con las últimas características
- FilamentPHP 3.x para toda la interfaz administrativa
- Pest para testing (framework de testing moderno)
- Laravel Pint para mantener consistencia de código

### Panel Financiera
- Usa navegación superior (topNavigation)
- Ancho completo de contenido (MaxWidth::Full)
- Dashboard personalizado con widgets especializados
- Funcionalidad de exportación integrada

### Panel Usuario
- Diseñado para capturistas/usuarios operativos
- Permisos limitados vs panel Admin

### Panel Admin
- Control total del sistema
- Gestión de usuarios y roles con Shield
- Acceso a todos los recursos
- Panel por defecto del sistema

## Mejoras Recientes

Según el historial de commits:
- Agregada funcionalidad de exportación en widgets (Excel, CSV, PDF)
- Refactorización de widgets para mejor rendimiento
- Optimización de consultas en StatsOverview
- Limpieza de archivos de configuración

## Próximos Pasos Sugeridos

1. Documentar APIs específicas de cada recurso
2. Crear tests automatizados para recursos críticos
3. Documentar flujos de trabajo principales
4. Establecer guía de estilos de código
5. Configurar CI/CD pipeline

## Enlaces Útiles Adicionales

### Recursos de Aprendizaje
- [Laracasts - Laravel](https://laracasts.com/topics/laravel)
- [Laravel Daily - Filament Tutorials](https://www.youtube.com/@LaravelDaily)
- [Filament Examples](https://filamentexamples.com/)
- [Laravel News](https://laravel-news.com/)

### Comunidad y Soporte
- [Laravel Discord](https://discord.gg/laravel)
- [Filament Discord](https://discord.com/invite/filamentphp)
- [Filament Forum](https://github.com/filamentphp/filament/discussions)
- [Stack Overflow - Laravel](https://stackoverflow.com/questions/tagged/laravel)
- [Stack Overflow - Filament](https://stackoverflow.com/questions/tagged/filament)

### Guías de Actualización
- [Laravel Upgrade Guide](https://laravel.com/docs/12.x/upgrade)
- [Filament Upgrade Guide](https://filamentphp.com/docs/3.x/support/upgrade-guide)
- [Livewire Upgrade Guide](https://livewire.laravel.com/docs/upgrading)

### Herramientas de Desarrollo
- [Laravel Debugbar](https://github.com/barryvdh/laravel-debugbar)
- [Laravel Telescope](https://laravel.com/docs/12.x/telescope)
- [Laravel IDE Helper](https://github.com/barryvdh/laravel-ide-helper)
- [Filament Spatie Media Library Plugin](https://filamentphp.com/plugins/filament-spatie-media-library)

### Repositorios Oficiales
- [Laravel Framework](https://github.com/laravel/framework)
- [FilamentPHP](https://github.com/filamentphp/filament)
- [Livewire](https://github.com/livewire/livewire)

### Paquetes Relacionados Útiles
- [Laravel Permission (Spatie)](https://spatie.be/docs/laravel-permission/v6/introduction)
- [Laravel Excel](https://docs.laravel-excel.com/3.1/getting-started/)
- [Laravel Activity Log](https://spatie.be/docs/laravel-activitylog/v4/introduction)

# Documentación Técnica - Plataforma Comunidades V5

## Índice
1. [Introducción](#introducción)
2. [Stack Tecnológico](#stack-tecnológico)
3. [Arquitectura del Proyecto](#arquitectura-del-proyecto)
4. [Estructura de Base de Datos](#estructura-de-base-de-datos)
5. [Recursos Filament](#recursos-filament)
6. [Páginas Personalizadas](#páginas-personalizadas)
7. [Widgets](#widgets)
8. [Sistema de Permisos](#sistema-de-permisos)
9. [Flujos de Trabajo Principales](#flujos-de-trabajo-principales)
10. [Guía de Desarrollo](#guía-de-desarrollo)

---

## Introducción

Comunidades V5 es una plataforma integral para el seguimiento y gestión de proyectos con objetivos, metas, actividades y beneficiarios. El sistema está diseñado con una arquitectura multi-panel que soporta diferentes roles de usuario (Administración, Capturistas, Financieras).

### Características Principales
- Gestión completa de proyectos con jerarquía de objetivos, metas y actividades
- Sistema multi-panel con interfaces especializadas por rol
- Control granular de permisos basado en roles (RBAC)
- Generación de informes narrativos con IA (Ollama)
- Dashboards financieros con métricas y análisis
- Gestión de beneficiarios y registro de eventos
- Exportación de datos en múltiples formatos (Excel, CSV, PDF)

---

## Stack Tecnológico

### Backend

#### PHP 8.2
- [Documentación Oficial](https://www.php.net/releases/8.2/en.php)
- Características utilizadas: tipos de unión, atributos, enums, readonly properties

#### Laravel 12.x
- [Documentación Oficial](https://laravel.com/docs/12.x)
- Framework principal de la aplicación
- Eloquent ORM para gestión de base de datos
- Sistema de migraciones y seeders
- Colas de trabajo para procesos largos
- Eventos y listeners para lógica de negocio

#### Livewire 3.6
- [Documentación Oficial](https://livewire.laravel.com/docs)
- Componentes reactivos del lado del servidor
- Base para los componentes de Filament
- Manejo de interactividad sin necesidad de JavaScript complejo

### Frontend/Admin Panel

#### FilamentPHP 3.3
- [Documentación Oficial](https://filamentphp.com/docs/3.x)
- Panel de administración completo
- Componentes principales:
  - **Panel Builder**: Construcción de paneles multi-tenancy
  - **Form Builder**: Formularios dinámicos y validación
  - **Table Builder**: Tablas con búsqueda, filtros y acciones
  - **Actions**: Sistema de acciones modales
  - **Widgets**: Componentes reutilizables para dashboards

#### Plugins de Filament

**Filament Shield 3.3** (Gestión de Roles y Permisos)
- [Documentación](https://filamentphp.com/plugins/bezhansalleh-shield)
- Integración con Spatie Laravel Permission
- Generación automática de permisos por recurso
- Super Admin bypass

**Filament Excel 2.5** (Exportación de Datos)
- [Documentación](https://filamentphp.com/plugins/pxlrbt-excel)
- Exportación a Excel, CSV y PDF
- Personalización de columnas y estilos
- Implementado en widgets financieros

**Filament Table Repeater 3.1**
- [Documentación](https://filamentphp.com/plugins/awcodes-table-repeater)
- Campos repetidores en formato de tabla
- Útil para formularios complejos con datos tabulares

**Filament Autograph 3.2**
- [Documentación](https://filamentphp.com/plugins/saade-autograph)
- Captura de firmas digitales
- Utilizado en registro de beneficiarios

### Generación de Documentos

#### DomPDF (Laravel)
- Generación de PDFs desde HTML
- Utilizado para informes narrativos
- Configuración en `config/dompdf.php`

#### PHPWord
- Generación de documentos Word (.docx)
- Procesamiento de plantillas
- Extracción de contenido de documentos

### Servicios de IA

#### Ollama AI
- Integración local/cloud para generación de narrativas
- Configuración en `config/services.php`:
  - URL del servicio
  - API Key
  - Modelo (por defecto: llama3.1)
  - Timeout: 180 segundos
  - Temperatura: 0.3
  - Max tokens: 1500

### Herramientas de Desarrollo

**Laravel Pint 1.13** (Code Styling)
- [Documentación](https://laravel.com/docs/12.x/pint)
- Formateo automático de código
- Estándar PSR-12

**PestPHP 3.8** (Testing)
- [Documentación](https://pestphp.com/docs)
- Framework de testing moderno
- Sintaxis expresiva y legible

**Laravel Blueprint 2.12** (Generación de Código)
- [Documentación](https://blueprint.laravelshift.com/)
- Generación de modelos, migraciones y recursos desde YAML

**Laravel Sail 1.41** (Docker)
- [Documentación](https://laravel.com/docs/12.x/sail)
- Entorno de desarrollo basado en Docker

**Laravel Pail 1.2.2** (Logs)
- [Documentación](https://laravel.com/docs/12.x/pail)
- Visualización en tiempo real de logs

---

## Arquitectura del Proyecto

### Arquitectura Multi-Panel

El proyecto implementa una arquitectura de 3 paneles independientes, cada uno con su propio propósito y audiencia:

```
┌─────────────────────────────────────────────────────────────────┐
│                     COMUNIDADES V5 - LARAVEL 12                 │
└─────────────────────────────────────────────────────────────────┘
                                  │
                ┌─────────────────┼─────────────────┐
                │                 │                 │
        ┌───────▼──────┐  ┌──────▼───────┐  ┌─────▼──────┐
        │ PANEL ADMIN  │  │    PANEL     │  │   PANEL    │
        │   /admin     │  │  FINANCIERA  │  │  USUARIO   │
        │              │  │ /financiera  │  │  /usuario  │
        └──────────────┘  └──────────────┘  └────────────┘
               │                 │                 │
        ┌──────▼──────┐   ┌─────▼─────┐    ┌─────▼─────┐
        │ 29 Recursos │   │ Dashboard │    │ Dashboard │
        │  9 Páginas  │   │ Widgets   │    │ Widgets   │
        │  5 Widgets  │   │ Filtros   │    │ Gestión   │
        │  Shield     │   │ Análisis  │    │ Captura   │
        └─────────────┘   └───────────┘    └───────────┘
```

#### 1. Panel Admin (`/admin`)

**Configuración:**
```php
// app/Providers/Filament/AdminPanelProvider.php
->id('admin')
->path('admin')
->colors(['primary' => Color::Amber])
->default()
->plugin(FilamentShieldPlugin::make())
```

**Características:**
- Panel por defecto del sistema
- Navegación lateral (sidebar)
- Color principal: Amber
- Plugin Shield para gestión completa de roles y permisos
- Acceso completo a todos los recursos del sistema
- Dashboard con estadísticas generales

**Usuarios Típicos:**
- Administradores del sistema
- Gestores de proyectos
- Personal técnico con permisos elevados

**Recursos Disponibles:** 29 recursos CRUD completos (ver sección de Recursos)

#### 2. Panel Financiera (`/financiera`)

**Configuración:**
```php
// app/Providers/Filament/FinancieraPanelProvider.php
->id('financiera')
->path('financiera')
->colors(['primary' => Color::Blue])
->topNavigation()
->maxContentWidth(MaxContentWidth::Full)
```

**Características:**
- Navegación superior (topNavigation)
- Ancho completo de contenido
- Color principal: Blue
- Especializado en análisis financiero y métricas
- 17 widgets personalizados para reportes
- Dashboard con filtros avanzados

**Usuarios Típicos:**
- Personal de finanzas
- Coordinadores de área financiera
- Responsables de monitoreo y evaluación

**Widgets Principales:**
- StatsOverview: Resumen de métricas clave
- CostBeneficiaryProject: Costo por beneficiario
- CostProductProject: Costo por producto
- PopulationProgressProject: Progreso de población atendida
- ProductProgressProject: Progreso de productos entregados
- ProjectDetails: Detalles financieros del proyecto

#### 3. Panel Usuario (`/usuario`)

**Configuración:**
```php
// app/Providers/Filament/UsuarioPanelProvider.php
->id('usuario')
->path('usuario')
->colors(['primary' => Color::Emerald])
->topNavigation()
->maxContentWidth(MaxContentWidth::Full)
->registration()
->profile()
```

**Características:**
- Navegación superior
- Ancho completo de contenido
- Color principal: Emerald
- Registro de usuarios habilitado
- Gestión de perfil de usuario
- Interfaz simplificada para capturistas

**Usuarios Típicos:**
- Capturistas de campo
- Personal operativo
- Usuarios con permisos limitados

**Páginas Principales:**
- Dashboard con resumen de actividades
- ActivityFileManager: Gestión de archivos
- BeneficiaryRegistryView: Vista de registro de beneficiarios
- ActivityCalendarView: Vista de calendario

### Estructura de Directorios

```
C:\laragon\www\comunidades_v5
│
├── app/
│   ├── Filament/
│   │   ├── Resources/              # 29 Recursos del Panel Admin
│   │   │   ├── ProjectResource.php
│   │   │   ├── ProjectResource/
│   │   │   │   └── Pages/
│   │   │   │       ├── ListProjects.php
│   │   │   │       ├── CreateProject.php
│   │   │   │       └── EditProject.php
│   │   │   ├── ActivityResource.php
│   │   │   ├── BeneficiaryResource.php
│   │   │   └── ... (26 más)
│   │   │
│   │   ├── Pages/                  # Páginas Admin
│   │   │   ├── Dashboard.php
│   │   │   ├── GenerarInformeNarrativo.php
│   │   │   ├── ProjectWizard.php
│   │   │   └── ...
│   │   │
│   │   ├── Widgets/                # Widgets Admin
│   │   │   ├── DashboardStats.php
│   │   │   ├── RecentProjects.php
│   │   │   └── ActivityOverview.php
│   │   │
│   │   ├── Financiera/             # Panel Financiera
│   │   │   ├── Pages/
│   │   │   │   ├── Dashboard.php
│   │   │   │   ├── ActivityTracking.php
│   │   │   │   ├── EventManagement.php
│   │   │   │   └── ProjectPerformanceDashboard.php
│   │   │   │
│   │   │   └── Widgets/
│   │   │       ├── StatsOverview.php
│   │   │       ├── ActivityPerformanceDetails.php
│   │   │       ├── EventTimelineActivity.php
│   │   │       └── ... (14 más)
│   │   │
│   │   └── Usuario/                # Panel Usuario/Capturistas
│   │       ├── Pages/
│   │       │   ├── Dashboard.php
│   │       │   ├── ActivityFileManager.php
│   │       │   ├── BeneficiaryRegistryView.php
│   │       │   └── ...
│   │       │
│   │       └── Widgets/
│   │           ├── ActivityCalendarTable.php
│   │           ├── BeneficiaryRegistryTable.php
│   │           └── ... (12 más)
│   │
│   ├── Models/                     # 31 Modelos Eloquent
│   │   ├── Project.php
│   │   ├── Program.php
│   │   ├── Activity.php
│   │   ├── ActivityNarrative.php
│   │   ├── Beneficiary.php
│   │   └── ...
│   │
│   ├── Http/
│   │   └── Controllers/
│   │       ├── Controller.php
│   │       ├── DataPublicationController.php
│   │       └── InformeNarrativoController.php
│   │
│   ├── Services/                   # Servicios de negocio
│   │   └── NarrativaGenerator.php
│   │
│   └── Providers/
│       ├── AppServiceProvider.php
│       └── Filament/
│           ├── AdminPanelProvider.php
│           ├── FinancieraPanelProvider.php
│           └── UsuarioPanelProvider.php
│
├── database/
│   ├── migrations/                 # 74 migraciones
│   ├── seeders/
│   └── factories/
│
├── config/
│   ├── filament-shield.php
│   ├── services.php               # Configuración Ollama
│   ├── permission.php
│   ├── dompdf.php
│   └── ...
│
├── routes/
│   ├── web.php
│   └── console.php
│
└── resources/
    └── views/
        └── filament/
            └── pages/
```

---

## Estructura de Base de Datos

### Esquema de Relaciones Principales

```
organizations (Organizaciones)
    │
    ├── axes (Ejes)
    │   └── programs (Programas)
    │       └── action_lines (Líneas de Acción)
    │           └── components (Componentes)
    │
    └── financiers (Financiadores)
        └── projects (Proyectos)
            ├── specific_objectives (Objetivos Específicos)
            ├── goals (Metas)
            │   └── activities (Actividades)
            │       ├── activity_calendars (Eventos/Calendario)
            │       │   ├── activity_narratives (Narrativas IA)
            │       │   └── activity_files (Archivos)
            │       ├── planned_metrics (Métricas Planificadas)
            │       └── activity_logs (Registros)
            ├── kpis (Indicadores KPI)
            ├── locations (Ubicaciones)
            ├── polygons (Polígonos)
            ├── project_reports (Reportes)
            └── project_disbursements (Desembolsos)
```

### Tablas Principales

#### 1. Tabla `projects` (Proyectos)

Tabla central del sistema que almacena los proyectos principales.

**Campos:**
```sql
id                    BIGINT PRIMARY KEY
name                  VARCHAR(500) NOT NULL
background            TEXT
justification         TEXT
general_objective     TEXT
financiers_id         BIGINT FOREIGN KEY → financiers.id
co_financier_id       BIGINT FOREIGN KEY → financiers.id (nullable)
start_date            DATE
end_date              DATE
total_cost            FLOAT
funded_amount         FLOAT
cofunding_amount      FLOAT
monthly_disbursement  FLOAT
followup_officer      TEXT
agreement_file        TEXT
project_base_file     TEXT
created_by            BIGINT FOREIGN KEY → users.id
created_at            TIMESTAMP
updated_at            TIMESTAMP
```

**Relaciones:**
- `belongsTo` Financier (financiers_id)
- `belongsTo` CoFinancier (co_financier_id)
- `belongsTo` User (created_by)
- `hasMany` SpecificObjectives
- `hasMany` Goals
- `hasMany` Kpis
- `hasMany` Locations
- `hasMany` Polygons

**Lógica de Cascada (Model):**
```php
// Al eliminar un proyecto se ejecuta:
static::deleting(function ($project) {
    // 1. Eliminar PlannedMetric de todas las actividades
    // 2. Eliminar actividades relacionadas a través de metas
    // 3. Eliminar metas del proyecto
    // 4. Eliminar objetivos específicos
    // 5. Eliminar KPIs
    // Logging en cada paso para auditoría
});
```

#### 2. Tabla `activities` (Actividades)

Almacena las actividades vinculadas a objetivos específicos y metas.

**Campos:**
```sql
id                      BIGINT PRIMARY KEY
name                    VARCHAR(255) NOT NULL
description             TEXT
specific_objective_id   BIGINT FOREIGN KEY → specific_objectives.id
goals_id                BIGINT FOREIGN KEY → goals.id
created_by              BIGINT FOREIGN KEY → users.id
created_at              TIMESTAMP
updated_at              TIMESTAMP
```

**Triggers de Base de Datos:**
- Triggers automáticos para calcular progreso de actividades
- Funciones de cálculo en base de datos para métricas

#### 3. Tabla `activity_calendars` (Eventos/Calendario)

Eventos específicos de las actividades con fecha programada.

**Campos:**
```sql
id                    BIGINT PRIMARY KEY
activity_id           BIGINT FOREIGN KEY → activities.id
event_date            DATE
start_time            TIME
end_time              TIME
location              TEXT
participants_count    INTEGER
notes                 TEXT
status                ENUM('scheduled', 'completed', 'cancelled')
created_at            TIMESTAMP
updated_at            TIMESTAMP
```

**Relación 1:1:**
- `hasOne` ActivityNarrative

#### 4. Tabla `activity_narratives` (Narrativas IA) - NUEVO Nov 2025

Almacena narrativas generadas por IA para eventos de actividades.

**Campos:**
```sql
id                              BIGINT PRIMARY KEY
activity_calendar_id            BIGINT UNIQUE FOREIGN KEY → activity_calendars.id
narrativa_contexto              TEXT      -- Entrada manual
narrativa_desarrollo            TEXT      -- Entrada manual
narrativa_resultados            TEXT      -- Entrada manual
organizaciones_participantes    TEXT
participantes_count             INTEGER
narrativa_generada              LONGTEXT  -- Generada por IA
narrativa_aprobada              BOOLEAN DEFAULT false
narrativa_regenerada_at         TIMESTAMP
created_at                      TIMESTAMP
updated_at                      TIMESTAMP
```

**Índices:**
```sql
INDEX idx_narrativa_aprobada (narrativa_aprobada)
INDEX idx_created_at (created_at)
```

**Métodos del Modelo:**
```php
public function regenerarNarrativa(): void
public function marcarAprobada(): void
public function requiresNarrativa(): bool
public function tieneDatosSuficientes(): bool

// Scopes
public function scopeConNarrativaAprobada($query)
public function scopeSinNarrativaGenerada($query)
public function scopePendientesAprobacion($query)
```

#### 5. Tabla `beneficiaries` (Beneficiarios)

**Campos:**
```sql
id                BIGINT PRIMARY KEY
identifier        VARCHAR(255) UNIQUE
first_name        VARCHAR(255) NOT NULL
last_name         VARCHAR(255) NOT NULL
date_of_birth     DATE
gender            ENUM('M', 'F', 'Otro')
phone             VARCHAR(50)
email             VARCHAR(255)
address           TEXT
city              VARCHAR(100)
state             VARCHAR(100)
zip_code          VARCHAR(20)
signature         TEXT          -- Firma digital (Autograph)
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

#### 6. Tabla `beneficiary_registries` (Registro de Beneficiarios)

Relación muchos a muchos entre beneficiarios y actividades.

**Campos:**
```sql
id                BIGINT PRIMARY KEY
beneficiary_id    BIGINT FOREIGN KEY → beneficiaries.id
activity_id       BIGINT FOREIGN KEY → activities.id
registration_date DATE
notes             TEXT
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

#### 7. Tabla `planned_metrics` (Métricas Planificadas)

**Campos:**
```sql
id                    BIGINT PRIMARY KEY
activity_id           BIGINT FOREIGN KEY → activities.id
metric_name           VARCHAR(255) NOT NULL
planned_value         DECIMAL(10,2)
actual_value          DECIMAL(10,2)
unit                  VARCHAR(50)
measurement_date      DATE
notes                 TEXT
created_at            TIMESTAMP
updated_at            TIMESTAMP
```

#### 8. Tablas de Publicación (Sistema de Versionado)

**data_publications:**
```sql
id                BIGINT PRIMARY KEY
version           VARCHAR(50)
published_by      BIGINT FOREIGN KEY → users.id
published_at      TIMESTAMP
status            ENUM('draft', 'published', 'archived')
notes             TEXT
```

**published_projects, published_activities, published_metrics:**
- Snapshots de datos en momento de publicación
- Permite auditoría y comparación histórica

#### 9. Tablas de Sistema

**users:**
```sql
id                BIGINT PRIMARY KEY
name              VARCHAR(255) NOT NULL
email             VARCHAR(255) UNIQUE NOT NULL
password          VARCHAR(255) NOT NULL
deleted_at        TIMESTAMP     -- Soft deletes (Oct 2025)
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

**permission_tables (Spatie):**
- `permissions`: Permisos del sistema
- `roles`: Roles de usuario
- `model_has_permissions`: Permisos directos a modelos
- `model_has_roles`: Roles asignados a modelos
- `role_has_permissions`: Permisos asignados a roles

### Vistas de Base de Datos

#### vista_progreso_proyectos
Vista materializada para reportes de progreso de proyectos.

**Campos calculados:**
- Progreso total del proyecto
- Número de actividades completadas
- Población atendida
- Productos entregados
- Year y mes de actividad

#### padron_beneficiarios
Vista para generar padrón de beneficiarios con datos completos.

**Campos incluidos:**
- Datos del beneficiario
- Actividades asociadas
- Proyecto vinculado
- Fechas de registro

---

## Recursos Filament

### ¿Qué es un Recurso en Filament?

Un Recurso (Resource) en Filament es una clase que representa un modelo Eloquent y define cómo se debe crear, leer, actualizar y eliminar (CRUD) a través de la interfaz de usuario.

### Estructura de un Recurso

```
app/Filament/Resources/
└── ProjectResource.php          # Clase principal del recurso
    └── ProjectResource/
        └── Pages/                # Páginas del recurso
            ├── ListProjects.php   # Listado
            ├── CreateProject.php  # Creación
            └── EditProject.php    # Edición
```

### Anatomía de un Recurso

```php
<?php

namespace App\Filament\Resources;

use App\Models\Project;
use Filament\Resources\Resource;
use Filament\Forms\Form;
use Filament\Tables\Table;

class ProjectResource extends Resource
{
    // 1. CONFIGURACIÓN BÁSICA
    protected static ?string $model = Project::class;
    protected static ?string $navigationIcon = 'heroicon-o-folder';
    protected static ?string $navigationGroup = 'Sección de Captura de Proyectos';
    protected static ?string $navigationLabel = 'Proyectos';
    protected static ?string $modelLabel = 'Proyecto';
    protected static ?string $pluralModelLabel = 'Proyectos';
    protected static ?string $slug = 'proyectos';

    // 2. DEFINICIÓN DEL FORMULARIO
    public static function form(Form $form): Form
    {
        return $form->schema([
            // Componentes de formulario
            Forms\Components\Section::make('Información del Proyecto')
                ->schema([
                    Forms\Components\TextInput::make('name')
                        ->label('Nombre del Proyecto')
                        ->required()
                        ->maxLength(500),

                    Forms\Components\Select::make('financiers_id')
                        ->label('Financiador')
                        ->relationship('financiers', 'name')
                        ->searchable()
                        ->preload()
                        ->required(),

                    Forms\Components\DatePicker::make('start_date')
                        ->label('Fecha de Inicio'),

                    // ... más campos
                ])
                ->columns(2),
        ]);
    }

    // 3. DEFINICIÓN DE LA TABLA
    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Nombre del Proyecto')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('financiers.name')
                    ->label('Financiador')
                    ->searchable(),

                // ... más columnas
            ])
            ->filters([
                // Filtros personalizados
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    // 4. PÁGINAS DEL RECURSO
    public static function getPages(): array
    {
        return [
            'index' => Pages\ListProjects::route('/'),
            'create' => Pages\CreateProject::route('/create'),
            'edit' => Pages\EditProject::route('/{record}/edit'),
        ];
    }
}
```

### Componentes de Formulario Comunes

#### Campos de Texto
```php
Forms\Components\TextInput::make('name')
    ->label('Nombre')
    ->required()
    ->maxLength(255)
    ->placeholder('Ingrese el nombre'),

Forms\Components\Textarea::make('description')
    ->label('Descripción')
    ->rows(3)
    ->maxLength(500),
```

#### Campos de Selección
```php
// Select simple
Forms\Components\Select::make('status')
    ->label('Estado')
    ->options([
        'draft' => 'Borrador',
        'published' => 'Publicado',
        'archived' => 'Archivado',
    ])
    ->native(false),

// Select con relación
Forms\Components\Select::make('financiers_id')
    ->label('Financiador')
    ->relationship('financiers', 'name')
    ->searchable()
    ->preload()
    ->required(),
```

#### Campos de Fecha
```php
Forms\Components\DatePicker::make('start_date')
    ->label('Fecha de Inicio')
    ->native(false)
    ->displayFormat('d/m/Y')
    ->required(),
```

#### Campos Numéricos
```php
Forms\Components\TextInput::make('total_cost')
    ->label('Costo Total')
    ->numeric()
    ->prefix('$')
    ->step(0.01),
```

### Componentes de Tabla Comunes

#### Columnas de Texto
```php
Tables\Columns\TextColumn::make('name')
    ->label('Nombre')
    ->searchable()
    ->sortable()
    ->limit(50),

Tables\Columns\TextColumn::make('financiers.name')
    ->label('Financiador')
    ->searchable(),
```

#### Columnas de Fecha
```php
Tables\Columns\TextColumn::make('created_at')
    ->label('Fecha de Creación')
    ->dateTime('d/m/Y H:i')
    ->sortable(),
```

#### Columnas con Badges
```php
Tables\Columns\BadgeColumn::make('status')
    ->label('Estado')
    ->colors([
        'success' => 'published',
        'warning' => 'draft',
        'danger' => 'archived',
    ]),
```

### Recursos del Proyecto (29 Total)

#### Gestión de Proyectos
1. **ProjectResource** - Proyectos principales
2. **ProgramResource** - Programas
3. **SpecificObjectiveResource** - Objetivos específicos
4. **GoalResource** - Metas
5. **ActivityResource** - Actividades
6. **ActionLineResource** - Líneas de acción
7. **ComponentResource** - Componentes

#### Métricas e Indicadores
8. **KpiResource** - Indicadores KPI
9. **ProgramIndicatorResource** - Indicadores de programa
10. **PlannedMetricResource** - Métricas planificadas
11. **PublishedMetricResource** - Métricas publicadas

#### Beneficiarios
12. **BeneficiaryResource** - Beneficiarios
13. **BeneficiaryRegistryResource** - Registro de beneficiarios

#### Actividades y Eventos
14. **ActivityCalendarResource** - Calendario de actividades
15. **ActivityFileResource** - Archivos de actividades
16. **ActivityLogResource** - Registros de actividades
17. **ActivityNarrativeResource** - Narrativas de actividades (NUEVO)

#### Financiero
18. **ProjectDisbursementResource** - Desembolsos
19. **ProjectReportResource** - Reportes de proyectos
20. **FinancierResource** - Financiadores

#### Organizacional
21. **OrganizationResource** - Organizaciones
22. **AxeResource** - Ejes estratégicos

#### Publicaciones
23. **DataPublicationResource** - Publicaciones de datos
24. **PublishedProjectResource** - Proyectos publicados
25. **PublishedActivityResource** - Actividades publicadas

#### Geográfico
26. **LocationResource** - Ubicaciones
27. **PolygonResource** - Polígonos

#### Sistema
28. **UserResource** - Usuarios
29. **RoleResource** - Roles (Shield)

---

## Páginas Personalizadas

### ¿Qué son las Custom Pages?

Las páginas personalizadas (Custom Pages) en Filament son clases que permiten crear interfaces completamente personalizadas fuera del contexto de un recurso CRUD estándar. Son útiles para:

- Dashboards personalizados
- Asistentes (wizards)
- Páginas de reportes
- Formularios complejos que no corresponden a un modelo único

### Estructura de una Custom Page

```php
<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;

class CustomPage extends Page
{
    // 1. Vista de la página
    protected static string $view = 'filament.pages.custom-page';

    // 2. Configuración de navegación
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Mi Página';
    protected static ?string $navigationGroup = 'Grupo';
    protected static ?int $navigationSort = 1;

    // 3. Título de la página
    protected static ?string $title = 'Mi Página Personalizada';

    // 4. Lógica personalizada
    public function mount(): void
    {
        // Inicialización
    }
}
```

### Tipos de Páginas Personalizadas

#### 1. Dashboard Personalizado

```php
<?php

namespace App\Filament\Pages;

use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;

class Dashboard extends BaseDashboard
{
    use HasFiltersForm;

    protected static ?string $title = 'Dashboard de Administración';

    // Widgets del dashboard
    public function getWidgets(): array
    {
        return [
            \App\Filament\Widgets\DashboardStats::class,
            \App\Filament\Widgets\RecentProjects::class,
        ];
    }

    // Distribución de columnas
    public function getColumns(): int | string | array
    {
        return [
            'md' => 4,
            'xl' => 6,
        ];
    }

    // Filtros del dashboard
    protected function getHeaderActions(): array
    {
        return [
            FilterAction::make()
                ->form([
                    DatePicker::make('startDate')
                        ->label('Fecha de Inicio'),
                    DatePicker::make('endDate')
                        ->label('Fecha de Fin'),
                ]),
        ];
    }
}
```

**Ejemplo Real: Dashboard Financiera**

```php
// app/Filament/Financiera/Pages/Dashboard.php

public function filtersForm(Form $form): Form
{
    return $form->schema([
        Section::make('Filtros del Dashboard')
            ->schema([
                DatePicker::make('startDate')
                    ->label('Fecha de inicio'),
                DatePicker::make('endDate')
                    ->label('Fecha de fin'),
                Select::make('financier_id')
                    ->label('Financiadora')
                    ->options(fn() => DB::table('financiers')->pluck('name', 'id'))
                    ->searchable(),
                Select::make('project_id')
                    ->label('Proyecto')
                    ->options(fn() => DB::table('projects')->pluck('name', 'id'))
                    ->searchable(),
            ])
            ->collapsible()
            ->collapsed(),
    ]);
}

public function getWidgets(): array
{
    return [
        \App\Filament\Financiera\Widgets\StatsOverview::class,
        \App\Filament\Financiera\Widgets\CostBeneficiaryProject::class,
        \App\Filament\Financiera\Widgets\ProjectDetails::class,
    ];
}
```

#### 2. Página con Formulario Complejo

```php
<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Form;

class GenerarInformeNarrativo extends Page implements HasForms
{
    use InteractsWithForms;

    protected static string $view = 'filament.pages.generar-informe-narrativo';
    protected static ?string $navigationLabel = 'Generar Informe Narrativo';
    protected static ?string $navigationGroup = 'Informes y Reportes';

    public ?array $data = [];

    // Inicialización del formulario
    public function mount(): void
    {
        $this->form->fill([
            'incluir_introduccion' => true,
            'formato_salida' => 'pdf',
        ]);
    }

    // Definición del formulario
    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Proyecto a reportar')
                    ->schema([
                        Forms\Components\Select::make('project_id')
                            ->label('Proyecto')
                            ->options(Project::pluck('name', 'id'))
                            ->searchable()
                            ->required()
                            ->reactive(),
                    ]),

                Forms\Components\Section::make('Periodo del Informe')
                    ->schema([
                        Forms\Components\DatePicker::make('fecha_inicio')
                            ->label('Fecha de inicio')
                            ->required(),
                        Forms\Components\DatePicker::make('fecha_fin')
                            ->label('Fecha de fin')
                            ->required(),
                    ])
                    ->columns(2),
            ])
            ->statePath('data');
    }

    // Acciones
    protected function getFormActions(): array
    {
        return [
            Action::make('generar')
                ->label('Generar Informe')
                ->action('generarInforme'),
        ];
    }

    // Lógica de negocio
    public function generarInforme(): void
    {
        $data = $this->form->getState();
        // Lógica de generación de informe
    }
}
```

#### 3. Wizard (Asistente Multi-paso)

```php
<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Forms\Components\Wizard;

class ProjectWizard extends Page
{
    protected static string $view = 'filament.pages.project-wizard';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Wizard::make([
                    Wizard\Step::make('Información Básica')
                        ->schema([
                            TextInput::make('name')->required(),
                            Textarea::make('description'),
                        ]),

                    Wizard\Step::make('Financiamiento')
                        ->schema([
                            Select::make('financiers_id')->required(),
                            TextInput::make('total_cost')->numeric(),
                        ]),

                    Wizard\Step::make('Confirmación')
                        ->schema([
                            // Vista de resumen
                        ]),
                ]),
            ]);
    }
}
```

### Páginas del Proyecto

#### Panel Admin (9 Páginas)

1. **Dashboard.php**
   - Dashboard principal con estadísticas
   - Filtros de fecha
   - Widgets de resumen

2. **GenerarInformeNarrativo.php**
   - Generación de informes narrativos con IA
   - Selección de proyecto y periodo
   - Filtros de objetivos y metas
   - Generación de PDF/Word

3. **ProjectWizard.php**
   - Asistente de creación de proyectos
   - Proceso multi-paso
   - Validación por etapas

4. **ActivityCalendarView.php**
   - Vista de calendario de actividades
   - Gestión de eventos
   - Integración con ActivityCalendar model

5. **ActivityFileManager.php**
   - Gestor de archivos de actividades
   - Subida y descarga de archivos
   - Organización por actividad

6. **BeneficiaryRegistryView.php**
   - Vista de registro de beneficiarios
   - Vinculación con actividades
   - Firmas digitales

7. **DataPublicationApproval.php**
   - Aprobación de publicaciones de datos
   - Sistema de versionado
   - Auditoría de cambios

8. **ProjectGanttView.php**
   - Vista Gantt de proyectos
   - Cronograma de actividades
   - Visualización de dependencias

9. **ProjectManagement.php**
   - Gestión avanzada de proyectos
   - Operaciones en lote
   - Reportes personalizados

---

## Widgets

### ¿Qué son los Widgets?

Los widgets en Filament son componentes reutilizables que muestran información o funcionalidad en dashboards y páginas. Pueden mostrar estadísticas, gráficos, tablas o cualquier contenido personalizado.

### Tipos de Widgets

#### 1. Stats Overview Widget (Resumen de Estadísticas)

```php
<?php

namespace App\Filament\Widgets;

use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class DashboardStats extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Total Proyectos', Project::count())
                ->description('Proyectos activos en el sistema')
                ->descriptionIcon('heroicon-m-folder')
                ->color('success')
                ->chart([7, 2, 10, 3, 15, 4, 17]),

            Stat::make('Beneficiarios', Beneficiary::count())
                ->description('Total de beneficiarios registrados')
                ->descriptionIcon('heroicon-m-user-group')
                ->color('warning'),

            Stat::make('Inversión Total', '$' . number_format(Project::sum('total_cost'), 2))
                ->description('Costo total de proyectos')
                ->descriptionIcon('heroicon-m-currency-dollar')
                ->color('danger'),
        ];
    }
}
```

#### 2. Chart Widget (Gráficos)

```php
<?php

namespace App\Filament\Widgets;

use Filament\Widgets\ChartWidget;

class ProjectsChart extends ChartWidget
{
    protected static ?string $heading = 'Proyectos por Mes';

    protected function getData(): array
    {
        return [
            'datasets' => [
                [
                    'label' => 'Proyectos creados',
                    'data' => [12, 19, 3, 5, 2, 3, 9, 10, 8, 12, 15, 20],
                ],
            ],
            'labels' => ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
        ];
    }

    protected function getType(): string
    {
        return 'line'; // 'bar', 'pie', 'doughnut', etc.
    }
}
```

#### 3. Table Widget (Tabla)

```php
<?php

namespace App\Filament\Widgets;

use Filament\Tables;
use Filament\Widgets\TableWidget as BaseWidget;

class RecentProjects extends BaseWidget
{
    protected static ?string $heading = 'Proyectos Recientes';
    protected int | string | array $columnSpan = 'full';

    protected function getTableQuery()
    {
        return Project::query()
            ->latest()
            ->limit(5);
    }

    protected function getTableColumns(): array
    {
        return [
            Tables\Columns\TextColumn::make('name')
                ->label('Nombre')
                ->searchable(),
            Tables\Columns\TextColumn::make('financiers.name')
                ->label('Financiador'),
            Tables\Columns\TextColumn::make('created_at')
                ->label('Fecha de Creación')
                ->dateTime('d/m/Y'),
        ];
    }
}
```

#### 4. Custom Widget (Widget Personalizado)

```php
<?php

namespace App\Filament\Financiera\Widgets;

use Filament\Widgets\Widget;

class ActivityPerformanceDetails extends Widget
{
    protected static string $view = 'filament.financiera.widgets.activity-performance-details';
    protected int | string | array $columnSpan = 'full';

    // Datos reactivos
    public ?array $filters = null;

    protected function getViewData(): array
    {
        return [
            'activities' => $this->getActivities(),
            'stats' => $this->calculateStats(),
        ];
    }

    protected function getActivities()
    {
        $query = Activity::query();

        if ($this->filters) {
            if (isset($this->filters['project_id'])) {
                $query->whereHas('goal', function($q) {
                    $q->where('project_id', $this->filters['project_id']);
                });
            }
        }

        return $query->get();
    }
}
```

### Widgets del Proyecto

#### Panel Admin (5 Widgets)

1. **DashboardStats** - Estadísticas generales
2. **RecentProjects** - Proyectos recientes
3. **ActivityOverview** - Resumen de actividades
4. **ProjectCount** - Contador de proyectos
5. **ActivityCalendarCount** - Contador de eventos

#### Panel Financiera (17 Widgets)

**Widgets de Estadísticas:**
1. **StatsOverview** - Resumen general de métricas
2. **ActivityTrackStatsOverview** - Estadísticas de seguimiento
3. **EventManagementStatsOverview** - Estadísticas de gestión de eventos
4. **ProjectPerformanceStatsOverview** - Estadísticas de desempeño

**Widgets de Análisis:**
5. **ActivityPerformanceDetails** - Detalles de rendimiento de actividades
6. **ActivityDetails** - Detalles de actividades
7. **ProjectDetails** - Detalles del proyecto
8. **EventTimelineActivity** - Línea de tiempo de eventos

**Widgets de Costos:**
9. **CostBeneficiaryProject** - Costo por beneficiario
10. **CostProductProject** - Costo por producto

**Widgets de Progreso:**
11. **PopulationProgressProject** - Progreso de población atendida
12. **ProductProgressProject** - Progreso de productos

**Widgets de Tablas:**
13. **BeneficiariesTable** - Tabla de beneficiarios

#### Panel Usuario (14 Widgets)

1. **ActivityCalendarTable** - Tabla de calendario
2. **ActivityCalendarCount** - Contador de eventos
3. **ActivityFileTable** - Tabla de archivos
4. **ActivityFileStats** - Estadísticas de archivos
5. **BeneficiaryRegistryTable** - Tabla de registro de beneficiarios
6. **BeneficiaryStats** - Estadísticas de beneficiarios
7. **ProjectActivitySummary** - Resumen de actividades del proyecto
8. **UpcomingActivitiesWidget** - Actividades próximas
9. **Custom** - Widget personalizado

### Filtros en Widgets

Los widgets pueden recibir filtros del dashboard:

```php
// En el Dashboard
protected $listeners = ['filtersChanged' => 'updateFilters'];

public function updateFilters($filters)
{
    $this->filters = $filters;
}

// En el Widget
use Livewire\Attributes\On;

#[On('filtersChanged')]
public function updateFilters(): void
{
    // Widget se recarga automáticamente
}

protected function getTableQuery()
{
    $query = Activity::query();

    $filters = $this->getPage()->getFilters();

    if ($filters['startDate'] ?? null) {
        $query->where('created_at', '>=', $filters['startDate']);
    }

    return $query;
}
```

---

## Sistema de Permisos

### Filament Shield

El proyecto utiliza **Filament Shield** para la gestión de roles y permisos, que se basa en **Spatie Laravel Permission**.

### Configuración

```php
// config/filament-shield.php

return [
    'shield_resource' => [
        'should_register_navigation' => true,
        'slug' => 'shield/roles',
        'navigation_sort' => -1,
        'navigation_badge' => true,
        'navigation_group' => true,
        'is_globally_searchable' => false,
        'show_model_path' => true,
    ],

    'super_admin' => [
        'enabled' => true,
        'name' => 'super_admin',
        'define_via_gate' => false,
        'intercept_gate' => 'before',
    ],

    'permission_prefixes' => [
        'resource' => [
            'view',
            'view_any',
            'create',
            'update',
            'restore',
            'restore_any',
            'replicate',
            'reorder',
            'delete',
            'delete_any',
            'force_delete',
            'force_delete_any',
        ],

        'page' => 'page',
        'widget' => 'widget',
    ],
];
```

### Permisos por Recurso

Shield genera automáticamente permisos para cada recurso:

**Ejemplo: ProjectResource**
- `view_project` - Ver un proyecto
- `view_any_project` - Ver listado de proyectos
- `create_project` - Crear proyecto
- `update_project` - Actualizar proyecto
- `delete_project` - Eliminar proyecto
- `delete_any_project` - Eliminación masiva
- `force_delete_project` - Eliminación permanente
- `restore_project` - Restaurar proyecto eliminado

### Roles del Sistema

#### 1. Super Admin
- Bypass completo de permisos
- Acceso total al sistema
- Configurado en `config/filament-shield.php`

#### 2. Admin
- Acceso al panel Admin
- Gestión de todos los recursos
- Gestión de usuarios y roles

#### 3. Financiera
- Acceso al panel Financiera
- Solo lectura de proyectos
- Acceso completo a dashboards financieros

#### 4. Capturista/Usuario
- Acceso al panel Usuario
- Captura de actividades
- Registro de beneficiarios
- Subida de archivos

### Implementación en Políticas

```php
<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Project;
use Illuminate\Auth\Access\HandlesAuthorization;

class ProjectPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user): bool
    {
        return $user->can('view_any_project');
    }

    public function view(User $user, Project $project): bool
    {
        return $user->can('view_project');
    }

    public function create(User $user): bool
    {
        return $user->can('create_project');
    }

    public function update(User $user, Project $project): bool
    {
        return $user->can('update_project');
    }

    public function delete(User $user, Project $project): bool
    {
        return $user->can('delete_project');
    }

    public function forceDelete(User $user, Project $project): bool
    {
        return $user->can('force_delete_project');
    }
}
```

### Uso en Recursos

```php
// En el recurso
public static function canViewAny(): bool
{
    return auth()->user()->can('view_any_project');
}

// En widgets
public static function canView(): bool
{
    return auth()->user()->can('widget_DashboardStats');
}
```

### Comandos Útiles

```bash
# Generar permisos para un recurso
php artisan shield:generate --resource=ProjectResource

# Generar todos los permisos
php artisan shield:generate

# Instalar Shield
php artisan shield:install

# Crear Super Admin
php artisan shield:super-admin
```

---

## Flujos de Trabajo Principales

### 1. Creación de un Proyecto Completo

```
1. Usuario accede al Panel Admin (/admin)
   ↓
2. Navega a "Proyectos" → "Crear Proyecto"
   ↓
3. Completa formulario:
   - Información básica (nombre, objetivo general)
   - Selecciona financiador
   - Define fechas y costos
   - Adjunta archivos (convenio, base del proyecto)
   ↓
4. Sistema crea registro en tabla 'projects'
   - Asigna created_by = usuario actual
   - Genera timestamps
   ↓
5. Usuario define Objetivos Específicos
   - Navega a "Objetivos Específicos" → "Crear"
   - Vincula con proyecto creado
   ↓
6. Usuario crea Metas
   - Vincula con objetivo específico
   - Define indicadores de meta
   ↓
7. Usuario crea Actividades
   - Vincula con meta
   - Define descripción y responsables
   ↓
8. Sistema genera relaciones:
   Project → SpecificObjective → Goal → Activity
```

### 2. Registro de Eventos y Narrativas

```
1. Capturista accede al Panel Usuario (/usuario)
   ↓
2. Navega a "Calendario de Actividades"
   ↓
3. Crea evento (ActivityCalendar):
   - Selecciona actividad padre
   - Define fecha y hora
   - Registra ubicación
   - Número de participantes
   ↓
4. Completa narrativa manual (ActivityNarrative):
   - Narrativa de contexto
   - Narrativa de desarrollo
   - Narrativa de resultados
   - Organizaciones participantes
   ↓
5. Sistema llama servicio de IA (Ollama):
   - Envía datos de contexto
   - Genera narrativa formal
   - Almacena en campo 'narrativa_generada'
   ↓
6. Supervisor revisa narrativa:
   - Puede regenerar si es necesario
   - Marca como aprobada
   - Campo 'narrativa_aprobada' = true
   ↓
7. Narrativa disponible para informes
```

### 3. Generación de Informes Narrativos

```
1. Usuario accede a "Generar Informe Narrativo"
   ↓
2. Selecciona parámetros:
   - Proyecto
   - Rango de fechas
   - Objetivos/Metas específicos (opcional)
   - Formato (PDF/Word)
   ↓
3. Sistema consulta:
   - ActivityCalendar del periodo
   - ActivityNarrative aprobadas
   - Métricas asociadas
   - Beneficiarios registrados
   ↓
4. Genera documento estructurado:
   - Introducción del proyecto
   - Narrativas por actividad
   - Logros y resultados
   - Anexos estadísticos
   ↓
5. Usuario descarga documento
   - PDF: vía DomPDF
   - Word: vía PHPWord
```

### 4. Análisis Financiero (Panel Financiera)

```
1. Usuario Financiera accede a /financiera
   ↓
2. Dashboard carga con filtros:
   - Rango de fechas
   - Financiadora
   - Proyecto específico
   - Estado de eventos
   ↓
3. Widgets procesan datos:
   - StatsOverview: métricas generales
   - CostBeneficiaryProject: costo/beneficiario
   - PopulationProgressProject: avance poblacional
   ↓
4. Usuario aplica filtros:
   - Widgets se actualizan reactivamente
   - Queries optimizadas con índices
   ↓
5. Usuario exporta datos:
   - Selecciona widget con exportación
   - Elige formato (Excel/CSV/PDF)
   - Descarga archivo procesado
```

### 5. Publicación de Datos

```
1. Admin navega a "Publicaciones de Datos"
   ↓
2. Crea nueva publicación:
   - Define versión (ej: "2025-Q1")
   - Selecciona datos a publicar
   - Añade notas de versión
   ↓
3. Sistema crea snapshot:
   - Copia proyectos → published_projects
   - Copia actividades → published_activities
   - Copia métricas → published_metrics
   ↓
4. Registro en data_publications:
   - Estado: 'published'
   - published_by: usuario actual
   - published_at: timestamp
   ↓
5. Datos públicos disponibles:
   - API pública consulta tablas 'published_*'
   - Versionado permite auditoría
```

---

## Guía de Desarrollo

### Setup del Entorno

#### Requisitos
- PHP 8.2+
- Composer
- Node.js y npm
- MySQL/MariaDB
- (Opcional) Docker con Laravel Sail

#### Instalación

```bash
# Clonar repositorio
cd C:\laragon\www\comunidades_v5

# Instalar dependencias PHP
composer install

# Instalar dependencias Node
npm install

# Copiar archivo de entorno
cp .env.example .env

# Generar key de aplicación
php artisan key:generate

# Configurar base de datos en .env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=comunidades_v5
DB_USERNAME=root
DB_PASSWORD=

# Ejecutar migraciones
php artisan migrate

# Ejecutar seeders (si existen)
php artisan db:seed

# Generar permisos de Shield
php artisan shield:generate

# Crear Super Admin
php artisan shield:super-admin
```

#### Configuración de Ollama AI

```bash
# En .env
OLLAMA_URL=http://localhost:11434
OLLAMA_API_KEY=tu_api_key
OLLAMA_MODEL=llama3.1
OLLAMA_TIMEOUT=180
OLLAMA_TEMPERATURE=0.3
OLLAMA_MAX_TOKENS=1500
```

#### Ejecutar Desarrollo

```bash
# Opción 1: Script composer (recomendado)
composer dev
# Ejecuta: server + queue + vite concurrentemente

# Opción 2: Manual
php artisan serve
php artisan queue:listen
npm run dev
```

### Crear un Nuevo Recurso

```bash
# Generar recurso
php artisan make:filament-resource Nombre --generate

# Generar con soft deletes
php artisan make:filament-resource Nombre --soft-deletes --generate

# Generar permisos para el recurso
php artisan shield:generate --resource=NombreResource
```

### Crear una Custom Page

```bash
# Generar página en panel por defecto
php artisan make:filament-page NombrePagina

# Generar en panel específico
php artisan make:filament-page NombrePagina --panel=financiera

# Con tipo específico
php artisan make:filament-page Dashboard --type=dashboard
```

### Crear un Widget

```bash
# Widget básico
php artisan make:filament-widget NombreWidget

# Stats widget
php artisan make:filament-widget StatsWidget --stats-overview

# Chart widget
php artisan make:filament-widget ChartWidget --chart

# Table widget
php artisan make:filament-widget TableWidget --table

# En panel específico
php artisan make:filament-widget NombreWidget --panel=financiera
```

### Testing

```bash
# Ejecutar todos los tests
composer test

# O manualmente
php artisan test

# Con cobertura
php artisan test --coverage

# Filtrar por nombre
php artisan test --filter=ProjectTest
```

### Code Styling

```bash
# Formatear código
./vendor/bin/pint

# Solo verificar (sin cambios)
./vendor/bin/pint --test

# Archivo específico
./vendor/bin/pint app/Models/Project.php
```

### Migraciones y Base de Datos

```bash
# Crear migración
php artisan make:migration create_nombre_table

# Ejecutar migraciones
php artisan migrate

# Rollback última migración
php artisan migrate:rollback

# Refresh (rollback + migrate)
php artisan migrate:refresh

# Reset completo
php artisan migrate:fresh

# Con seeding
php artisan migrate:fresh --seed
```

### Logs y Debugging

```bash
# Ver logs en tiempo real
php artisan pail

# Limpiar logs
php artisan log:clear

# Limpiar caché
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan route:clear
```

### Convenciones de Código

#### Nombres de Archivos y Clases
- **Modelos**: Singular, PascalCase (`Project.php`)
- **Migraciones**: Snake_case (`create_projects_table.php`)
- **Recursos**: Sufijo `Resource` (`ProjectResource.php`)
- **Controladores**: Sufijo `Controller` (`ProjectController.php`)

#### Nombres de Métodos
- **Eloquent Scopes**: Prefijo `scope` (`scopeActive()`)
- **Accessors**: Prefijo `get`, sufijo `Attribute` (`getFullNameAttribute()`)
- **Mutators**: Prefijo `set`, sufijo `Attribute` (`setNameAttribute()`)

#### Estructura de Código
```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Project extends Model
{
    // 1. Traits
    use SoftDeletes;

    // 2. Constantes
    const STATUS_DRAFT = 'draft';

    // 3. Propiedades
    protected $fillable = [];
    protected $casts = [];

    // 4. Boot y eventos
    protected static function booted() {}

    // 5. Relaciones
    public function financier(): BelongsTo {}

    // 6. Scopes
    public function scopeActive($query) {}

    // 7. Accessors y Mutators
    public function getFullNameAttribute() {}

    // 8. Métodos públicos
    public function calculateProgress() {}

    // 9. Métodos protected/private
    protected function internalLogic() {}
}
```

### Mejores Prácticas

#### 1. Consultas Eloquent Eficientes

```php
// ❌ MAL - Problema N+1
$projects = Project::all();
foreach ($projects as $project) {
    echo $project->financier->name;
}

// ✅ BIEN - Eager Loading
$projects = Project::with('financier')->get();
foreach ($projects as $project) {
    echo $project->financier->name;
}

// ✅ MEJOR - Eager Loading selectivo
$projects = Project::with('financier:id,name')->get();
```

#### 2. Validación en Recursos

```php
// En el recurso Filament
Forms\Components\TextInput::make('email')
    ->label('Email')
    ->email()
    ->required()
    ->unique(ignoreRecord: true)
    ->maxLength(255),
```

#### 3. Uso de Query Scopes

```php
// En el modelo
public function scopeActive($query)
{
    return $query->where('status', 'active');
}

// Uso
$activeProjects = Project::active()->get();
```

#### 4. Eventos de Modelo para Lógica Compleja

```php
// En el modelo Project
protected static function booted()
{
    static::deleting(function ($project) {
        // Cascada personalizada
        $project->goals()->delete();
        $project->specificObjectives()->delete();
    });
}
```

#### 5. Service Classes para Lógica de Negocio

```php
// app/Services/NarrativaGenerator.php
class NarrativaGenerator
{
    public function generate(ActivityCalendar $event): string
    {
        // Lógica compleja de generación
        return $this->callOllamaAPI($event);
    }
}

// Uso en controlador
$generator = app(NarrativaGenerator::class);
$narrativa = $generator->generate($event);
```

### Debugging Tips

#### Filament Debugging

```php
// En un recurso o página
use Filament\Notifications\Notification;

// Mostrar notificación
Notification::make()
    ->title('Saved successfully')
    ->success()
    ->send();

// En desarrollo, inspeccionar datos
dd($this->form->getState());
```

#### Query Debugging

```php
// Ver SQL generado
DB::enableQueryLog();
$projects = Project::with('financier')->get();
dd(DB::getQueryLog());

// En Tinker
php artisan tinker
> Project::with('financier')->toSql()
```

### Deployment

#### Preparación

```bash
# Optimizar autoloader
composer install --optimize-autoloader --no-dev

# Cachear configuraciones
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Ejecutar migraciones en producción
php artisan migrate --force

# Build de assets
npm run build
```

#### Variables de Entorno (.env)

```bash
APP_ENV=production
APP_DEBUG=false
APP_URL=https://tu-dominio.com

# Optimizaciones
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_CONNECTION=redis
```

---

## Apéndices

### Glosario de Términos

- **Resource**: Clase que define CRUD para un modelo
- **Page**: Página personalizada fuera del contexto de recursos
- **Widget**: Componente reutilizable para dashboards
- **Panel**: Instancia separada de Filament con su propia configuración
- **Shield**: Plugin de gestión de roles y permisos
- **Eloquent**: ORM de Laravel
- **Livewire**: Framework de componentes reactivos
- **Blade**: Motor de plantillas de Laravel

### Enlaces Útiles

#### Documentación Oficial
- [Laravel 12.x](https://laravel.com/docs/12.x)
- [FilamentPHP 3.x](https://filamentphp.com/docs/3.x)
- [Livewire 3.x](https://livewire.laravel.com/docs)
- [PestPHP](https://pestphp.com/docs)

#### Plugins
- [Filament Shield](https://filamentphp.com/plugins/bezhansalleh-shield)
- [Filament Excel](https://filamentphp.com/plugins/pxlrbt-excel)
- [Filament Table Repeater](https://filamentphp.com/plugins/awcodes-table-repeater)


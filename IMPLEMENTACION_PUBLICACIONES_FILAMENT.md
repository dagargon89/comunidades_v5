# Sistema de Publicaciones de Datos - Implementación Completa

## Resumen del Problema

El procedimiento almacenado `PublishDataSnapshot` actual publica todas las actividades y métricas sin mantener las relaciones proyecto-actividad en las tablas publicadas, causando productos cartesianos en las consultas JOIN.

## Solución Implementada

### 1. Modificaciones a la Base de Datos

#### Migración para agregar project_id a published_activities

```bash
php artisan migrate
```

La migración agrega:

-   Columna `project_id` a la tabla `published_activities`
-   Índice compuesto `idx_published_activities_project` para mejorar performance

#### Procedimiento Almacenado Mejorado

El archivo `database/procedures/PublishDataSnapshot.sql` contiene el procedimiento actualizado que:

-   **Mantiene las relaciones proyecto-actividad**: Usa JOIN entre `activities` y `specific_objectives`
-   **Evita productos cartesianos**: Cada actividad publicada incluye su `project_id` correspondiente
-   **Filtrado por período**: Permite filtrar métricas por rango de fechas
-   **Transaccional**: Garantiza consistencia de datos
-   **Estadísticas**: Actualiza contadores en `data_publications`

### 2. Componentes de Laravel

#### Modelo DataPublication

`app/Models/DataPublication.php` proporciona:

-   Relaciones con usuarios y datos publicados
-   Scopes para filtrado
-   Métodos para estadísticas y validaciones
-   Atributos calculados para estado y período

#### Servicio de Publicaciones

`app/Services/DataPublicationService.php` maneja:

-   Ejecución del procedimiento almacenado
-   Validación de datos
-   Historial de publicaciones
-   Estadísticas
-   Consultas por período

#### Comandos Artisan

```bash
# Publicación básica
php artisan data:publish-snapshot

# Con parámetros específicos
php artisan data:publish-snapshot --user-id=1 --notes="Publicación mensual" --period-from=2025-01-01 --period-to=2025-01-31

# Habilitar permisos de publicación
php artisan users:enable-publication 1

# Deshabilitar permisos de publicación
php artisan users:enable-publication 1 --disable
```

### 3. Página Personalizada de Filament

#### DataPublicationView

`app/Filament/Pages/DataPublicationView.php` proporciona:

-   **Verificación de permisos**: Solo usuarios con `can_publish_data = 1` pueden acceder
-   **Interfaz completa**: Formularios, tablas y estadísticas
-   **Acciones de publicación**: Botón para ejecutar nuevas publicaciones
-   **Historial**: Tabla con todas las publicaciones realizadas
-   **Filtros**: Por fecha, usuario y período
-   **Estadísticas en tiempo real**: Muestra totales de publicaciones

#### Características de la Página

-   **Dashboard con estadísticas**: 4 tarjetas con métricas principales
-   **Formulario de configuración**: Campos para notas y período
-   **Tabla de historial**: Con acciones para ver detalles y exportar
-   **Filtros avanzados**: Por rango de fechas y usuario
-   **Acciones masivas**: Exportar múltiples publicaciones
-   **Validación de permisos**: Control de acceso basado en `can_publish_data`

### 4. Control de Acceso

#### Campo can_publish_data

-   Solo usuarios con `can_publish_data = 1` pueden acceder a la página
-   Verificación automática al cargar la página
-   Redirección si no tiene permisos
-   Filtrado de usuarios en formularios

#### Comando para Gestión de Permisos

```bash
# Habilitar permisos
php artisan users:enable-publication 1

# Deshabilitar permisos
php artisan users:enable-publication 1 --disable
```

### 5. Interfaz Web (Alternativa)

#### Rutas Web

```php
// Página principal de publicaciones
GET /data-publications

// API endpoints
POST /data-publications/publish
GET /data-publications/history
GET /data-publications/stats
GET /data-publications/by-period
```

#### Controlador Web

`app/Http/Controllers/DataPublicationController.php` maneja:

-   Interfaz web para publicaciones
-   API endpoints para AJAX
-   Validación de formularios

## Instrucciones de Implementación

### Paso 1: Ejecutar Migraciones

```bash
php artisan migrate
```

### Paso 2: Crear el Procedimiento Almacenado

```bash
# Conectar a MySQL y ejecutar el contenido de:
# database/procedures/PublishDataSnapshot.sql
```

### Paso 3: Habilitar Permisos de Usuario

```bash
# Para el usuario con ID 1
php artisan users:enable-publication 1

# Verificar usuarios disponibles
php artisan tinker
>>> App\Models\User::pluck('name', 'id')
```

### Paso 4: Acceder a la Página de Filament

1. Ir a `/admin/publicaciones-datos`
2. Verificar que aparecen las estadísticas
3. Probar el formulario de publicación
4. Revisar el historial de publicaciones

### Paso 5: Probar el Sistema

#### Desde Filament

1. Navegar a `/admin/publicaciones-datos`
2. Completar el formulario (opcional)
3. Hacer clic en "Nueva Publicación"
4. Confirmar la acción

#### Desde Línea de Comandos

```bash
# Publicación básica
php artisan data:publish-snapshot

# Con parámetros
php artisan data:publish-snapshot --user-id=1 --notes="Primera publicación" --period-from=2025-01-01 --period-to=2025-01-31
```

### Paso 6: Verificar los Resultados

#### Consultar las Tablas Publicadas

```sql
-- Verificar que las actividades tienen project_id
SELECT pa.*, pp.name as project_name
FROM published_activities pa
JOIN published_projects pp ON pa.project_id = pp.original_project_id
WHERE pa.publication_id = [ID_DE_PUBLICACION];

-- Verificar métricas publicadas
SELECT * FROM published_metrics
WHERE publication_id = [ID_DE_PUBLICACION];

-- Verificar proyectos publicados
SELECT * FROM published_projects
WHERE publication_id = [ID_DE_PUBLICACION];
```

## Estructura de Archivos Creados

```
database/
├── migrations/
│   └── 2025_01_15_000001_add_project_id_to_published_activities.sql
└── procedures/
    └── PublishDataSnapshot.sql

app/
├── Console/Commands/
│   ├── PublishDataSnapshot.php
│   └── EnableDataPublicationPermission.php
├── Filament/Pages/
│   └── DataPublicationView.php
├── Http/Controllers/
│   └── DataPublicationController.php
├── Models/
│   └── DataPublication.php
└── Services/
    └── DataPublicationService.php

resources/views/
├── data-publications/
│   └── index.blade.php
└── filament/pages/
    └── data-publication-view.blade.php

routes/
└── web.php (modificado)
```

## Ventajas de la Solución

1. **Integridad de Datos**: Mantiene las relaciones proyecto-actividad
2. **Performance**: Índices optimizados para consultas JOIN
3. **Flexibilidad**: Filtrado por período opcional
4. **Trazabilidad**: Historial completo de publicaciones
5. **Control de Acceso**: Basado en permisos de usuario
6. **Interfaz Amigable**: Filament UI para usuarios no técnicos
7. **Automatización**: Comando Artisan para programación
8. **Estadísticas**: Dashboard con métricas en tiempo real

## Características de Seguridad

1. **Verificación de Permisos**: Solo usuarios autorizados pueden publicar
2. **Validación de Datos**: Fechas y parámetros validados
3. **Transacciones**: Garantiza consistencia de datos
4. **Logs de Actividad**: Registro de todas las publicaciones
5. **Confirmación**: Modal de confirmación antes de publicar

## Troubleshooting

### Error: "No tienes permisos para realizar publicaciones"

-   Verificar que el usuario tiene `can_publish_data = 1`
-   Usar el comando: `php artisan users:enable-publication [user_id]`

### Error: "Procedure PublishDataSnapshot does not exist"

-   Verificar que el procedimiento se creó correctamente en MySQL
-   Ejecutar manualmente el script SQL en la base de datos

### Error: "Column project_id does not exist"

-   Verificar que la migración se ejecutó correctamente
-   Ejecutar `php artisan migrate:status` para ver el estado

### Error: "Access denied for user"

-   Verificar permisos del usuario de la aplicación en MySQL
-   Asegurar que tiene permisos para CALL procedures

### La página no aparece en Filament

-   Verificar que el archivo está en `app/Filament/Pages/`
-   Limpiar cache: `php artisan config:clear && php artisan cache:clear`
-   Verificar permisos de Shield si está configurado

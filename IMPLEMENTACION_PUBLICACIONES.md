# Implementación del Sistema de Publicaciones de Datos

## Resumen del Problema

El procedimiento almacenado `PublishDataSnapshot` actual publica todas las actividades y métricas sin mantener las relaciones proyecto-actividad en las tablas publicadas, causando productos cartesianos en las consultas JOIN.

## Solución Implementada

### 1. Modificaciones a la Base de Datos

#### Migración para agregar project_id a published_activities

```sql
-- Ejecutar la migración
php artisan migrate
```

La migración `2025_01_15_000001_add_project_id_to_published_activities.sql` agrega:

-   Columna `project_id` a la tabla `published_activities`
-   Índice compuesto `idx_published_activities_project` para mejorar performance

### 2. Procedimiento Almacenado Mejorado

El archivo `database/procedures/PublishDataSnapshot.sql` contiene el procedimiento actualizado que:

-   **Mantiene las relaciones proyecto-actividad**: Usa JOIN entre `activities` y `specific_objectives` para obtener el `project_id`
-   **Evita productos cartesianos**: Cada actividad publicada incluye su `project_id` correspondiente
-   **Filtrado por período**: Permite filtrar métricas por rango de fechas
-   **Transaccional**: Garantiza consistencia de datos
-   **Estadísticas**: Actualiza contadores en `data_publications`

### 3. Componentes de Laravel

#### Comando Artisan

```bash
# Publicación básica
php artisan data:publish-snapshot

# Con parámetros específicos
php artisan data:publish-snapshot --user-id=1 --notes="Publicación mensual" --period-from=2025-01-01 --period-to=2025-01-31
```

#### Servicio de Publicaciones

`app/Services/DataPublicationService.php` proporciona:

-   Ejecución del procedimiento almacenado
-   Validación de datos
-   Historial de publicaciones
-   Estadísticas
-   Consultas por período

#### Controlador Web

`app/Http/Controllers/DataPublicationController.php` maneja:

-   Interfaz web para publicaciones
-   API endpoints para AJAX
-   Validación de formularios

### 4. Interfaz Web

#### Rutas Disponibles

```php
// Página principal de publicaciones
GET /data-publications

// API endpoints
POST /data-publications/publish
GET /data-publications/history
GET /data-publications/stats
GET /data-publications/by-period
```

#### Características de la Interfaz

-   **Estadísticas en tiempo real**: Muestra totales de publicaciones
-   **Formulario de publicación**: Con campos opcionales para notas y período
-   **Historial de publicaciones**: Tabla con todas las publicaciones realizadas
-   **Validación en tiempo real**: Usando Alpine.js
-   **Diseño responsivo**: Con Tailwind CSS

## Instrucciones de Implementación

### Paso 1: Ejecutar la Migración

```bash
php artisan migrate
```

### Paso 2: Crear el Procedimiento Almacenado

```bash
# Conectar a MySQL y ejecutar el contenido de:
# database/procedures/PublishDataSnapshot.sql
```

### Paso 3: Probar el Sistema

#### Desde la Línea de Comandos

```bash
# Publicación básica
php artisan data:publish-snapshot

# Con parámetros
php artisan data:publish-snapshot --user-id=1 --notes="Primera publicación" --period-from=2025-01-01 --period-to=2025-01-31
```

#### Desde la Interfaz Web

1. Navegar a `/data-publications`
2. Completar el formulario (opcional)
3. Hacer clic en "Publicar Datos"

### Paso 4: Verificar los Resultados

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

## Ventajas de la Solución

1. **Integridad de Datos**: Mantiene las relaciones proyecto-actividad
2. **Performance**: Índices optimizados para consultas JOIN
3. **Flexibilidad**: Filtrado por período opcional
4. **Trazabilidad**: Historial completo de publicaciones
5. **Interfaz Amigable**: Web UI para usuarios no técnicos
6. **Automatización**: Comando Artisan para programación

## Estructura de Archivos Creados

```
database/
├── migrations/
│   └── 2025_01_15_000001_add_project_id_to_published_activities.sql
└── procedures/
    └── PublishDataSnapshot.sql

app/
├── Console/Commands/
│   └── PublishDataSnapshot.php
├── Http/Controllers/
│   └── DataPublicationController.php
└── Services/
    └── DataPublicationService.php

resources/views/
└── data-publications/
    └── index.blade.php

routes/
└── web.php (modificado)
```

## Notas Importantes

1. **Backup**: Hacer backup de la base de datos antes de ejecutar la migración
2. **Permisos**: Asegurar que el usuario de la aplicación tiene permisos para crear procedimientos almacenados
3. **Testing**: Probar en un entorno de desarrollo antes de producción
4. **Monitoreo**: Revisar los logs después de las primeras publicaciones

## Troubleshooting

### Error: "Procedure PublishDataSnapshot does not exist"

-   Verificar que el procedimiento se creó correctamente en MySQL
-   Ejecutar manualmente el script SQL en la base de datos

### Error: "Column project_id does not exist"

-   Verificar que la migración se ejecutó correctamente
-   Ejecutar `php artisan migrate:status` para ver el estado

### Error: "Access denied for user"

-   Verificar permisos del usuario de la aplicación en MySQL
-   Asegurar que tiene permisos para CALL procedures

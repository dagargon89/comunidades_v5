# Correcciones de Relaciones - Widgets de Seguimiento

## Problemas Identificados y Corregidos

### 1. Error de relación anidada en ProjectActivitySummary

**Problema:** `Call to undefined method App\Models\Project::goals.activities()`
**Causa:** Sintaxis incorrecta para relaciones anidadas en `withCount`
**Solución:** Corregida la sintaxis de las relaciones anidadas

**Archivo:** `app/Filament/Usuario/Widgets/ProjectActivitySummary.php`

```php
// Antes (incorrecto)
->withCount([
    'goals.activities.activityCalendars' => function (Builder $query) use ($userId) {
        $query->where('assigned_person', $userId);
    },
])

// Después (correcto)
->withCount([
    'goals as total_goals',
    'goals.activities as total_activities',
    'goals.activities.activityCalendars as total_calendars' => function (Builder $query) use ($userId) {
        $query->where('assigned_person', $userId);
    },
])
```

### 2. Error en referencias de columnas en ProjectActivitySummary

**Problema:** Referencias incorrectas a las columnas de conteo
**Solución:** Corregidas las referencias a las columnas generadas

```php
// Antes (incorrecto)
->make('goals_activities_activity_calendars_count')

// Después (correcto)
->make('total_calendars_count')
```

### 3. Error en consulta de ActivityFileStats

**Problema:** Uso incorrecto de `activity_calendar_id` en lugar de `id`
**Solución:** Corregida la consulta para usar el campo correcto

**Archivo:** `app/Filament/Usuario/Widgets/ActivityFileStats.php`

```php
// Antes (incorrecto)
$userActivityIds = $activityQuery->pluck('activity_calendar_id')->toArray();

// Después (correcto)
$userActivityIds = $activityQuery->pluck('id')->toArray();
```

### 4. Error en consulta de ActivityFileTable

**Problema:** Uso incorrecto de `activity_calendar_id` en lugar de `id`
**Solución:** Corregida la consulta para usar el campo correcto

**Archivo:** `app/Filament/Usuario/Widgets/ActivityFileTable.php`

```php
// Antes (incorrecto)
$userActivityIds = $activityQuery->pluck('activity_calendar_id')->toArray();

// Después (correcto)
$userActivityIds = $activityQuery->pluck('id')->toArray();
```

## Estructura de Relaciones Verificada

### Modelo Project

```php
public function goals()
{
    return $this->hasMany(\App\Models\Goal::class, 'project_id');
}
```

### Modelo Goal

```php
public function activities()
{
    return $this->hasMany(\App\Models\Activity::class, 'goals_id');
}
```

### Modelo Activity

```php
public function activityCalendars()
{
    return $this->hasMany(\App\Models\ActivityCalendar::class, 'activity_id');
}
```

### Modelo ActivityCalendar

```php
public function activity()
{
    return $this->belongsTo(\App\Models\Activity::class, 'activity_id');
}
```

## Consultas Corregidas

### 1. Consulta de Proyectos con Actividades

```php
$query = Project::query()
    ->withCount([
        'goals as total_goals',
        'goals.activities as total_activities',
        'goals.activities.activityCalendars as total_calendars' => function (Builder $query) use ($userId) {
            $query->where('assigned_person', $userId);
        },
        'goals.activities.activityCalendars as cancelled_activities' => function (Builder $query) use ($userId) {
            $query->where('assigned_person', $userId)->where('cancelled', 1);
        },
        'goals.activities.activityCalendars as active_activities' => function (Builder $query) use ($userId) {
            $query->where('assigned_person', $userId)->where('cancelled', 0);
        }
    ])
    ->whereHas('goals.activities.activityCalendars', function (Builder $query) use ($userId) {
        $query->where('assigned_person', $userId);
    });
```

### 2. Consulta de Actividades Calendarizadas

```php
$activityQuery = ActivityCalendar::where('assigned_person', $userId);

// Aplicar filtros
if ($startDate) {
    $activityQuery->where('start_date', '>=', $startDate);
}
if ($endDate) {
    $activityQuery->where('end_date', '<=', $endDate);
}
if ($projectId) {
    $activityQuery->whereHas('activity.goal', function (Builder $q) use ($projectId) {
        $q->where('project_id', $projectId);
    });
}

$userActivityIds = $activityQuery->pluck('id')->toArray();
```

## Verificación de Funcionamiento

### Widgets Corregidos

-   ✅ **ProjectActivitySummary** - Relaciones anidadas corregidas
-   ✅ **ActivityFileStats** - Consulta de IDs corregida
-   ✅ **ActivityFileTable** - Consulta de IDs corregida
-   ✅ **BeneficiaryStats** - Ya estaba correcto
-   ✅ **ActivityCalendarTable** - Ya estaba correcto
-   ✅ **BeneficiaryRegistryTable** - Ya estaba correcto

### Consultas Verificadas

-   ✅ Relaciones Project → Goal → Activity → ActivityCalendar
-   ✅ Filtros por usuario autenticado
-   ✅ Filtros por fechas
-   ✅ Filtros por proyecto
-   ✅ Conteos correctos en todas las consultas

## Notas Técnicas

### Relaciones Anidadas en Laravel

-   Para `withCount()` con relaciones anidadas, usar la notación de punto
-   Para `whereHas()` con relaciones anidadas, usar la notación de punto
-   Los alias en `withCount()` deben ser únicos y descriptivos

### Campos de ID

-   `ActivityCalendar.id` - ID de la actividad calendarizada
-   `ActivityCalendar.activity_id` - ID de la actividad
-   `Activity.goals_id` - ID de la meta
-   `Goal.project_id` - ID del proyecto

### Optimizaciones Aplicadas

-   Uso de `with()` para cargar relaciones
-   Consultas optimizadas con `whereHas()`
-   Conteos eficientes con `withCount()`
-   Filtros aplicados correctamente

## Documentación Relacionada

-   `WIDGETS_DOCUMENTATION.md` - Documentación detallada de widgets
-   `TEST_WIDGETS.md` - Problemas corregidos en widgets
-   `PANEL_CONFIGURATION.md` - Configuración del panel

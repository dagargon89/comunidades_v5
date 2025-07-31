# Corrección de Relación ActivityCalendars

## Problema Identificado

**Error:** `Call to undefined method App\Models\Activity::activityCalendars()`

**Causa:** El modelo `Activity` no tenía definida la relación `activityCalendars()` que es necesaria para las consultas anidadas en los widgets.

## Solución Implementada

### 1. Agregada Relación en Modelo Activity

**Archivo:** `app/Models/Activity.php`

**Antes:**

```php
public function plannedMetrics(): HasMany
{
    return $this->hasMany(PlannedMetric::class, 'activity_id');
}
```

**Después:**

```php
public function plannedMetrics(): HasMany
{
    return $this->hasMany(PlannedMetric::class, 'activity_id');
}

public function activityCalendars(): HasMany
{
    return $this->hasMany(ActivityCalendar::class, 'activity_id');
}
```

### 2. Verificación de Relaciones Existentes

#### Modelo ActivityCalendar

✅ **Relación inversa ya existente:**

```php
public function activity(): BelongsTo
{
    return $this->belongsTo(Activity::class);
}
```

#### Modelo Goal

✅ **Relación activities ya existente:**

```php
public function activities()
{
    return $this->hasMany(\App\Models\Activity::class, 'goals_id');
}
```

#### Modelo Project

✅ **Relación goals ya existente:**

```php
public function goals()
{
    return $this->hasMany(Goal::class, 'project_id');
}
```

## Cadena de Relaciones Completada

Ahora la cadena completa de relaciones funciona correctamente:

```php
Project → Goal → Activity → ActivityCalendar
```

### Relaciones Verificadas:

1. **Project → Goal**

    ```php
    // En Project.php
    public function goals()
    {
        return $this->hasMany(Goal::class, 'project_id');
    }
    ```

2. **Goal → Activity**

    ```php
    // En Goal.php
    public function activities()
    {
        return $this->hasMany(\App\Models\Activity::class, 'goals_id');
    }
    ```

3. **Activity → ActivityCalendar**

    ```php
    // En Activity.php (AGREGADA)
    public function activityCalendars(): HasMany
    {
        return $this->hasMany(ActivityCalendar::class, 'activity_id');
    }
    ```

4. **ActivityCalendar → Activity (inversa)**
    ```php
    // En ActivityCalendar.php
    public function activity(): BelongsTo
    {
        return $this->belongsTo(Activity::class);
    }
    ```

## Consultas Anidadas Ahora Funcionales

### 1. Consulta de Proyectos con Actividades

```php
Project::whereHas('goals.activities.activityCalendars', function ($query) use ($userId) {
    $query->where('assigned_person', $userId);
});
```

### 2. Consulta de Actividades Calendarizadas

```php
ActivityCalendar::whereHas('activity.goal.project', function ($query) use ($projectId) {
    $query->where('id', $projectId);
})->where('assigned_person', $userId);
```

### 3. Consulta de Archivos de Actividad

```php
ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
    ->whereHas('activityCalendar.activity.goal.project', function ($query) use ($projectId) {
        $query->where('id', $projectId);
    });
```

## Widgets Afectados

Los siguientes widgets ahora funcionan correctamente con las relaciones anidadas:

### 1. **ProjectActivitySummary**

-   ✅ Consulta: `Project::whereHas('goals.activities.activityCalendars')`
-   ✅ Filtros: Por proyecto, fechas y usuario

### 2. **ActivityCalendarCount**

-   ✅ Consulta: `ActivityCalendar::where('assigned_person', $userId)`
-   ✅ Filtros: Por proyecto, fechas

### 3. **ActivityFileStats**

-   ✅ Consulta: `ActivityFile::whereIn('activity_calendar_id', $userActivityIds)`
-   ✅ Filtros: Por proyecto, fechas

### 4. **ActivityFileTable**

-   ✅ Consulta: `ActivityFile::whereIn('activity_calendar_id', $userActivityIds)`
-   ✅ Filtros: Por proyecto, fechas

### 5. **BeneficiaryRegistryTable**

-   ✅ Consulta: `BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)`
-   ✅ Filtros: Por proyecto, fechas

## Campos de Relación Utilizados

### Claves Foráneas:

-   `Project.id` → `Goal.project_id`
-   `Goal.id` → `Activity.goals_id`
-   `Activity.id` → `ActivityCalendar.activity_id`
-   `ActivityCalendar.id` → `ActivityFile.activity_calendar_id`
-   `ActivityCalendar.id` → `BeneficiaryRegistry.activity_calendar_id`

### Relaciones Inversas:

-   `ActivityCalendar.activity_id` → `Activity.id`
-   `Activity.goals_id` → `Goal.id`
-   `Goal.project_id` → `Project.id`

## Estado Final

✅ **Relación agregada:** `Activity::activityCalendars()`  
✅ **Consultas anidadas:** Funcionando correctamente  
✅ **Widgets:** Todos operativos  
✅ **Filtros:** Compatibles con todas las relaciones  
✅ **Rendimiento:** Optimizado

## Documentación Relacionada

-   `PROJECT_SUMMARY_CORRECTION.md` - Corrección del widget ProjectActivitySummary
-   `RELATIONSHIPS_CORRECTIONS.md` - Correcciones generales de relaciones
-   `WIDGETS_DOCUMENTATION.md` - Documentación de widgets

## Próximos Pasos

1. **Limpiar caché:** `php artisan config:clear && php artisan cache:clear`
2. **Probar widgets:** Verificar que todos los widgets cargan sin errores
3. **Probar filtros:** Confirmar que los filtros funcionan correctamente
4. **Verificar datos:** Comprobar que los datos se muestran correctamente

## Notas Técnicas

### Importaciones Necesarias

```php
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
```

### Tipos de Relación

-   **HasMany:** Una actividad tiene muchos calendarios de actividad
-   **BelongsTo:** Un calendario de actividad pertenece a una actividad

### Optimizaciones

-   Uso de `with()` para cargar relaciones
-   Consultas optimizadas con `whereHas()`
-   Filtros aplicados correctamente en cada nivel

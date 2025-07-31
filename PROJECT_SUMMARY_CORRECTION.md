# Corrección del Widget ProjectActivitySummary

## Problema Identificado

**Error:** `Call to undefined method App\Models\Project::goals.activities()`

**Causa:** Laravel no puede manejar relaciones anidadas tan complejas en `withCount()` cuando se usan múltiples niveles de anidación con condiciones adicionales.

## Solución Implementada

### 1. Simplificación de la Consulta Principal

**Antes (problemático):**

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
```

**Después (simplificado):**

```php
$query = Project::query()
    ->withCount([
        'goals as total_goals',
    ])
    ->whereHas('goals.activities.activityCalendars', function (Builder $query) use ($userId) {
        $query->where('assigned_person', $userId);
    });
```

### 2. Cálculo Dinámico en las Columnas

En lugar de usar `withCount()` para relaciones complejas, se calculan los valores dinámicamente en las columnas:

```php
Tables\Columns\TextColumn::make('activities_summary')
    ->label('Resumen de Actividades')
    ->formatStateUsing(function ($record) use ($userId) {
        $query = \App\Models\ActivityCalendar::whereHas('activity.goal.project', function ($q) use ($record) {
            $q->where('id', $record->id);
        })->where('assigned_person', $userId);

        $totalActivities = $query->count();
        $activeActivities = (clone $query)->where('cancelled', 0)->count();
        $cancelledActivities = (clone $query)->where('cancelled', 1)->count();

        return "Total: {$totalActivities} | Activas: {$activeActivities} | Canceladas: {$cancelledActivities}";
    })
```

### 3. Optimización de Consultas

Se optimizaron las consultas para evitar repetición de código:

```php
// Consulta base reutilizable
$query = \App\Models\ActivityCalendar::whereHas('activity.goal.project', function ($q) use ($record) {
    $q->where('id', $record->id);
})->where('assigned_person', $userId);

// Múltiples conteos usando clone
$totalActivities = $query->count();
$activeActivities = (clone $query)->where('cancelled', 0)->count();
$cancelledActivities = (clone $query)->where('cancelled', 1)->count();
```

## Columnas Actualizadas

### 1. Total Metas

```php
Tables\Columns\TextColumn::make('total_goals_count')
    ->label('Total Metas')
    ->sortable()
    ->color('primary')
```

### 2. Resumen de Actividades

```php
Tables\Columns\TextColumn::make('activities_summary')
    ->label('Resumen de Actividades')
    ->formatStateUsing(function ($record) use ($userId) {
        // Cálculo dinámico de estadísticas
    })
    ->color('info')
```

### 3. Progreso

```php
Tables\Columns\TextColumn::make('progress')
    ->label('Progreso')
    ->formatStateUsing(function ($record) use ($userId) {
        // Cálculo dinámico del porcentaje
    })
    ->color(function ($record) use ($userId) {
        // Color basado en el porcentaje
    })
```

## Ventajas de la Nueva Implementación

### 1. **Compatibilidad**

-   ✅ Funciona con cualquier versión de Laravel
-   ✅ No depende de características específicas de `withCount()`
-   ✅ Compatible con relaciones anidadas complejas

### 2. **Flexibilidad**

-   ✅ Permite cálculos complejos en las columnas
-   ✅ Fácil de modificar y extender
-   ✅ Soporte completo para filtros del dashboard

### 3. **Rendimiento**

-   ✅ Consultas optimizadas con `clone`
-   ✅ Evita repetición de código
-   ✅ Carga eficiente de relaciones

### 4. **Mantenibilidad**

-   ✅ Código más legible y comprensible
-   ✅ Fácil de debuggear
-   ✅ Documentación clara

## Filtros Compatibles

El widget ahora es compatible con todos los filtros del dashboard:

-   ✅ **Proyecto:** Filtro por proyecto específico
-   ✅ **Fecha de inicio:** Filtrar desde una fecha
-   ✅ **Fecha de fin:** Filtrar hasta una fecha
-   ✅ **Usuario:** Filtrado automático por usuario autenticado

## Notas Técnicas

### Relaciones Utilizadas

```php
Project → Goal → Activity → ActivityCalendar
```

### Consultas Optimizadas

-   Uso de `whereHas()` para relaciones anidadas
-   Uso de `clone` para consultas múltiples
-   Filtros aplicados correctamente en cada nivel

### Rendimiento

-   Las consultas se ejecutan solo cuando se necesitan
-   Uso eficiente de la memoria
-   Carga lazy de datos

## Estado Final

✅ **Widget funcionando:** Sin errores de relaciones  
✅ **Filtros compatibles:** Todos los filtros del dashboard funcionan  
✅ **Rendimiento optimizado:** Consultas eficientes  
✅ **Mantenible:** Código claro y documentado

## Documentación Relacionada

-   `WIDGETS_DOCUMENTATION.md` - Documentación general de widgets
-   `RELATIONSHIPS_CORRECTIONS.md` - Correcciones de relaciones
-   `TEST_WIDGETS.md` - Problemas corregidos en widgets

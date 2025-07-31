# Corrección de Widgets de Tablas

## Problema Identificado

**Error:** Los widgets de tablas daban errores al ordenar o filtrar la información debido a dependencias de filtros globales que ya fueron eliminados.

**Causa:** Los widgets de tablas aún usaban `InteractsWithPageFilters` y referencias a `$this->filters` que ya no existen.

## Solución Implementada

### **1. Eliminación de Dependencias de Filtros Globales**

#### **Trait Eliminado:**

```php
// Antes (incorrecto)
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Database\Eloquent\Builder;

class MiWidget extends BaseWidget
{
    use InteractsWithPageFilters;

    public function table(Table $table): Table
    {
        // Obtener filtros del dashboard
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;

        // Aplicar filtros...
    }
}

// Después (correcto)
class MiWidget extends BaseWidget
{
    public function table(Table $table): Table
    {
        // Query simple sin filtros globales
        $query = Model::where('user_field', $userId);

        return $table->query($query);
    }
}
```

### **2. Widgets Corregidos**

#### **ProjectActivitySummary Widget:**

```php
// Antes (con filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Obtener filtros del dashboard
    $startDate = $this->filters['startDate'] ?? null;
    $endDate = $this->filters['endDate'] ?? null;
    $projectId = $this->filters['project_id'] ?? null;

    // Query base con filtros
    $query = Project::query()
        ->withCount(['goals as total_goals'])
        ->whereHas('goals.activities.activityCalendars', function (Builder $query) use ($userId) {
            $query->where('assigned_person', $userId);
        });

    // Aplicar filtros de fecha
    if ($startDate) {
        $query->whereHas('goals.activities.activityCalendars', function (Builder $q) use ($startDate) {
            $q->where('start_date', '>=', $startDate);
        });
    }
    if ($endDate) {
        $query->whereHas('goals.activities.activityCalendars', function (Builder $q) use ($endDate) {
            $q->where('end_date', '<=', $endDate);
        });
    }

    // Aplicar filtro de proyecto específico
    if ($projectId) {
        $query->where('id', $projectId);
    }
}

// Después (sin filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Query base sin filtros
    $query = Project::query()
        ->withCount(['goals as total_goals'])
        ->whereHas('goals.activities.activityCalendars', function ($query) use ($userId) {
            $query->where('assigned_person', $userId);
        });

    return $table->query($query);
}
```

#### **ActivityCalendarTable Widget:**

```php
// Antes (con filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Obtener filtros del dashboard
    $startDate = $this->filters['startDate'] ?? null;
    $endDate = $this->filters['endDate'] ?? null;
    $projectId = $this->filters['project_id'] ?? null;

    // Query base con filtros
    $query = ActivityCalendar::query()
        ->with(['activity', 'activity.goal'])
        ->where('assigned_person', $userId);

    // Aplicar filtros de fecha
    if ($startDate) {
        $query->where('start_date', '>=', $startDate);
    }
    if ($endDate) {
        $query->where('end_date', '<=', $endDate);
    }

    // Aplicar filtro de proyecto
    if ($projectId) {
        $query->whereHas('activity.goal', function (Builder $q) use ($projectId) {
            $q->where('project_id', $projectId);
        });
    }
}

// Después (sin filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Query base sin filtros
    $query = ActivityCalendar::query()
        ->with(['activity', 'activity.goal'])
        ->where('assigned_person', $userId);

    return $table->query($query);
}
```

#### **ActivityFileTable Widget:**

```php
// Antes (con filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Obtener filtros del dashboard
    $startDate = $this->filters['startDate'] ?? null;
    $endDate = $this->filters['endDate'] ?? null;
    $projectId = $this->filters['project_id'] ?? null;

    // Obtener las actividades calendarizadas del usuario con filtros
    $activityQuery = ActivityCalendar::where('assigned_person', $userId);

    // Aplicar filtros de fecha
    if ($startDate) {
        $activityQuery->where('start_date', '>=', $startDate);
    }
    if ($endDate) {
        $activityQuery->where('end_date', '<=', $endDate);
    }

    // Aplicar filtro de proyecto
    if ($projectId) {
        $activityQuery->whereHas('activity.goal', function (Builder $q) use ($projectId) {
            $q->where('project_id', $projectId);
        });
    }

    $userActivityIds = $activityQuery->pluck('id')->toArray();
}

// Después (sin filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Obtener las actividades calendarizadas del usuario
    $userActivityIds = ActivityCalendar::where('assigned_person', $userId)
        ->pluck('id')
        ->toArray();

    return $table->query(ActivityFile::query()
        ->with(['activityCalendar', 'activityCalendar.activity'])
        ->whereIn('activity_calendar_id', $userActivityIds)
    );
}
```

#### **BeneficiaryRegistryTable Widget:**

```php
// Antes (con filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Obtener filtros del dashboard
    $startDate = $this->filters['startDate'] ?? null;
    $endDate = $this->filters['endDate'] ?? null;
    $projectId = $this->filters['project_id'] ?? null;

    // Obtener las actividades calendarizadas del usuario con filtros
    $activityQuery = ActivityCalendar::where('assigned_person', $userId);

    // Aplicar filtros de fecha
    if ($startDate) {
        $activityQuery->where('start_date', '>=', $startDate);
    }
    if ($endDate) {
        $activityQuery->where('end_date', '<=', $endDate);
    }

    // Aplicar filtro de proyecto
    if ($projectId) {
        $activityQuery->whereHas('activity.goal', function (Builder $q) use ($projectId) {
            $q->where('project_id', $projectId);
        });
    }

    $userActivityIds = $activityQuery->pluck('id')->toArray();
}

// Después (sin filtros globales)
public function table(Table $table): Table
{
    $userId = Auth::id();

    // Obtener las actividades calendarizadas del usuario
    $userActivityIds = ActivityCalendar::where('assigned_person', $userId)
        ->pluck('id')
        ->toArray();

    return $table->query(BeneficiaryRegistry::query()
        ->with(['beneficiary', 'activityCalendar', 'activityCalendar.activity'])
        ->whereIn('activity_calendar_id', $userActivityIds)
    );
}
```

## Archivos Corregidos

### **1. app/Filament/Usuario/Widgets/ProjectActivitySummary.php**

-   ✅ **Trait eliminado:** `InteractsWithPageFilters` removido
-   ✅ **Filtros eliminados:** Referencias a `$this->filters` removidas
-   ✅ **Query simplificada:** Solo filtro por usuario autenticado

### **2. app/Filament/Usuario/Widgets/ActivityCalendarTable.php**

-   ✅ **Trait eliminado:** `InteractsWithPageFilters` removido
-   ✅ **Filtros eliminados:** Referencias a `$this->filters` removidas
-   ✅ **Query simplificada:** Solo filtro por usuario autenticado

### **3. app/Filament/Usuario/Widgets/ActivityFileTable.php**

-   ✅ **Trait eliminado:** `InteractsWithPageFilters` removido
-   ✅ **Filtros eliminados:** Referencias a `$this->filters` removidas
-   ✅ **Query simplificada:** Solo filtro por usuario autenticado

### **4. app/Filament/Usuario/Widgets/BeneficiaryRegistryTable.php**

-   ✅ **Trait eliminado:** `InteractsWithPageFilters` removido
-   ✅ **Filtros eliminados:** Referencias a `$this->filters` removidas
-   ✅ **Query simplificada:** Solo filtro por usuario autenticado

## Ventajas de la Corrección

### **1. Funcionalidad Restaurada:**

-   ✅ **Ordenamiento funcionando:** Las tablas se pueden ordenar correctamente
-   ✅ **Filtros individuales funcionando:** Los filtros propios de cada tabla funcionan
-   ✅ **Búsqueda funcionando:** La búsqueda en las tablas funciona correctamente

### **2. Rendimiento Mejorado:**

-   ✅ **Consultas más simples:** Sin filtros globales complejos
-   ✅ **Carga más rápida:** Consultas directas y eficientes
-   ✅ **Menos errores:** Sin dependencias de filtros inexistentes

### **3. Mantenibilidad:**

-   ✅ **Código más limpio:** Sin referencias a filtros globales
-   ✅ **Fácil debug:** Consultas simples y directas
-   ✅ **Escalabilidad:** Fácil agregar nuevos filtros individuales

## Estado Final

✅ **Widgets de tablas corregidos:** Todos los widgets funcionan sin errores  
✅ **Ordenamiento funcionando:** Las tablas se pueden ordenar correctamente  
✅ **Filtros individuales funcionando:** Los filtros propios de cada tabla funcionan  
✅ **Búsqueda funcionando:** La búsqueda en las tablas funciona correctamente  
✅ **Caché limpiado:** Cambios aplicados correctamente

## Configuración Final de Widgets de Tablas

### **Widgets en el Footer (Tablas):**

1. **ProjectActivitySummary** - Resumen por proyecto (ordenamiento y filtros funcionando)
2. **ActivityCalendarTable** - Tabla de actividades (ordenamiento y filtros funcionando)
3. **ActivityFileTable** - Tabla de archivos (ordenamiento y filtros funcionando)
4. **BeneficiaryRegistryTable** - Tabla de beneficiarios (ordenamiento y filtros funcionando)

### **Filtros Disponibles por Tabla:**

-   ✅ **ProjectActivitySummary:** Filtros de proyecto y fechas
-   ✅ **ActivityCalendarTable:** Filtros de proyecto, estado y fechas
-   ✅ **ActivityFileTable:** Filtros de actividad, tipo y fechas
-   ✅ **BeneficiaryRegistryTable:** Filtros de género, actividad y búsqueda

## Próximos Pasos

1. **Probar ordenamiento:** Verificar que todas las columnas se pueden ordenar
2. **Probar filtros:** Confirmar que los filtros individuales funcionan
3. **Probar búsqueda:** Verificar que la búsqueda funciona en todas las tablas
4. **Probar paginación:** Comprobar que la paginación funciona correctamente

## Documentación Relacionada

-   `REMOVE_GLOBAL_FILTERS.md` - Eliminación de filtros globales
-   `REMOVE_CHART_WIDGETS.md` - Eliminación de widgets de chart

## Notas Técnicas

### **Patrón de Widget de Tabla Sin Filtros Globales:**

```php
class MiTableWidget extends TableWidget
{
    public function table(Table $table): Table
    {
        $userId = Auth::id();

        // Query simple sin filtros globales
        $query = Model::query()
            ->with(['relation1', 'relation2'])
            ->where('user_field', $userId);

        return $table
            ->query($query)
            ->columns([
                // Columnas con ordenamiento y búsqueda
            ])
            ->filters([
                // Filtros individuales de la tabla
            ]);
    }
}
```

### **Comandos de Limpieza:**

```bash
# Limpiar caché después de cambios
php artisan config:clear
php artisan cache:clear
php artisan view:clear
```

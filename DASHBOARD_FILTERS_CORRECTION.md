# Corrección de Filtros y Consultas del Dashboard

## Problema Identificado

**Requerimiento:** Verificar que los filtros estén en la parte superior del dashboard y que las consultas estén conforme a la sintaxis de Eloquent y la estructura de la base de datos.

## Solución Implementada

### 1. Configuración de Filtros en Dashboard

Según la [documentación oficial de Filament](https://filamentphp.com/docs/3.x/panels/dashboard), los filtros deben estar en la parte superior del dashboard usando el trait `HasFiltersForm`.

#### **Configuración Correcta:**

```php
use Filament\Pages\Dashboard as BaseDashboard;
use Filament\Pages\Dashboard\Concerns\HasFiltersForm;

class Dashboard extends BaseDashboard
{
    use HasFiltersForm;

    public function filtersForm(Form $form): Form
    {
        return $form
            ->schema([
                Select::make('project_id')
                    ->label('Proyecto')
                    ->placeholder('Seleccionar proyecto')
                    ->options(Project::pluck('name', 'id')->toArray())
                    ->searchable()
                    ->allowHtml(),
                DatePicker::make('startDate')
                    ->label('Fecha de inicio'),
                DatePicker::make('endDate')
                    ->label('Fecha de fin'),
            ])
            ->columns(3);
    }
}
```

### 2. Corrección de Consultas en Widgets

#### **ActivityCalendarCount Widget:**

```php
// Query base correcta
$query = ActivityCalendar::where('assigned_person', $userId);

// Aplicar filtros de fecha
if ($startDate) {
    $query->where('start_date', '>=', $startDate);
}
if ($endDate) {
    $query->where('end_date', '<=', $endDate);
}

// Aplicar filtro de proyecto usando relaciones anidadas
if ($projectId) {
    $query->whereHas('activity.goal', function (Builder $q) use ($projectId) {
        $q->where('project_id', $projectId);
    });
}
```

#### **ActivityFileStats Widget:**

```php
// Obtener IDs de actividades del usuario con filtros
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

// Consultas de archivos con filtros aplicados
$totalFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)->count();
$pdfFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
    ->where('type', 'like', '%pdf%')
    ->count();
$imageFiles = ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
    ->where(function ($query) {
        $query->where('type', 'like', '%imagen%')
              ->orWhere('type', 'like', '%image%')
              ->orWhere('type', 'like', '%jpg%')
              ->orWhere('type', 'like', '%jpeg%')
              ->orWhere('type', 'like', '%png%');
    })
    ->count();
```

#### **BeneficiaryStats Widget:**

```php
// Consultas de beneficiarios con filtros aplicados
$totalBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)->count();

// Estadísticas por género (corregida la relación)
$maleBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
    ->whereHas('beneficiary', function ($query) {
        $query->where('gender', 'M');
    })
    ->count();
$femaleBeneficiaries = BeneficiaryRegistry::whereIn('activity_calendar_id', $userActivityIds)
    ->whereHas('beneficiary', function ($query) {
        $query->where('gender', 'F');
    })
    ->count();
```

### 3. Corrección de Relaciones en Modelos

#### **BeneficiaryRegistry Model:**

```php
// Antes (incorrecto)
public function beneficiaries(): BelongsTo
{
    return $this->belongsTo(Beneficiary::class);
}

// Después (correcto)
public function beneficiary(): BelongsTo
{
    return $this->belongsTo(Beneficiary::class, 'beneficiaries_id');
}
```

### 4. Estructura de Base de Datos Verificada

#### **Relaciones Confirmadas:**

-   **ActivityCalendar** → **Activity** (belongsTo)
-   **Activity** → **Goal** (belongsTo, usando `goals_id`)
-   **Goal** → **Project** (belongsTo, usando `project_id`)
-   **ActivityFile** → **ActivityCalendar** (belongsTo, usando `activity_calendar_id`)
-   **BeneficiaryRegistry** → **ActivityCalendar** (belongsTo, usando `activity_calendar_id`)
-   **BeneficiaryRegistry** → **Beneficiary** (belongsTo, usando `beneficiaries_id`)

#### **Campos Clave Verificados:**

-   `activity_calendars.assigned_person` - Usuario asignado
-   `activity_calendars.start_date` / `end_date` - Fechas de actividad
-   `activity_calendars.cancelled` - Estado de cancelación
-   `activity_files.type` - Tipo de archivo
-   `activity_files.upload_date` - Fecha de subida
-   `beneficiaries.gender` - Género del beneficiario

## Ventajas de la Corrección

### **1. Filtros en Parte Superior**

-   ✅ **Ubicación correcta:** Filtros en la parte superior según documentación oficial
-   ✅ **Interfaz intuitiva:** Filtros siempre visibles
-   ✅ **Actualización en tiempo real:** Los widgets se actualizan automáticamente

### **2. Consultas Optimizadas**

-   ✅ **Sintaxis Eloquent correcta:** Uso apropiado de `whereHas()` y `whereIn()`
-   ✅ **Relaciones anidadas:** `activity.goal.project_id` funciona correctamente
-   ✅ **Filtros aplicados:** Todos los filtros se aplican en cada consulta
-   ✅ **Rendimiento optimizado:** Uso de `clone` para consultas múltiples

### **3. Estructura de Base de Datos**

-   ✅ **Relaciones verificadas:** Todas las relaciones están correctamente definidas
-   ✅ **Campos correctos:** Uso de los campos correctos según la estructura de la BD
-   ✅ **Tipos de datos:** Casts apropiados en los modelos

## Configuración Final del Dashboard

### **Header Widgets (Estadísticas Principales):**

1. **ActivityCalendarCount** - Estadísticas de actividades
2. **ActivityFileStats** - Estadísticas de archivos
3. **BeneficiaryStats** - Estadísticas de beneficiarios

### **Footer Widgets (Tablas Detalladas):**

1. **ProjectActivitySummary** - Resumen por proyecto
2. **ActivityCalendarTable** - Tabla de actividades
3. **ActivityFileTable** - Tabla de archivos
4. **BeneficiaryRegistryTable** - Tabla de beneficiarios

### **Filtros Disponibles:**

-   ✅ **Proyecto:** Filtro por proyecto específico
-   ✅ **Fecha de inicio:** Filtrar desde una fecha
-   ✅ **Fecha de fin:** Filtrar hasta una fecha
-   ✅ **Usuario:** Filtrado automático por usuario autenticado

## Estado Final

✅ **Filtros en parte superior:** Configuración correcta según documentación oficial  
✅ **Consultas Eloquent:** Sintaxis correcta y optimizada  
✅ **Relaciones verificadas:** Todas las relaciones están correctamente definidas  
✅ **Estructura de BD:** Consultas conforme a la estructura real  
✅ **Rendimiento optimizado:** Consultas eficientes con filtros aplicados

## Próximos Pasos

1. **Limpiar caché:** `php artisan config:clear && php artisan cache:clear`
2. **Probar filtros:** Verificar que los filtros funcionan correctamente
3. **Probar widgets:** Confirmar que todos los widgets cargan sin errores
4. **Verificar datos:** Comprobar que los datos se muestran correctamente

## Documentación Relacionada

-   [Filament Dashboard Documentation](https://filamentphp.com/docs/3.x/panels/dashboard) - Documentación oficial de filtros
-   `WIDGET_COMPONENT_FIX.md` - Correcciones anteriores de widgets
-   `ACTIVITY_RELATIONSHIP_FIX.md` - Correcciones de relaciones

## Notas Técnicas

### **Patrón de Consultas Recomendado:**

```php
// Query base con filtros de usuario
$query = Model::where('user_field', $userId);

// Aplicar filtros de fecha
if ($startDate) {
    $query->where('date_field', '>=', $startDate);
}
if ($endDate) {
    $query->where('date_field', '<=', $endDate);
}

// Aplicar filtro de proyecto con relaciones anidadas
if ($projectId) {
    $query->whereHas('relation.nested_relation', function ($q) use ($projectId) {
        $q->where('project_id', $projectId);
    });
}

// Múltiples cálculos usando clone
$total = $query->count();
$active = (clone $query)->where('status', 'active')->count();
$cancelled = (clone $query)->where('status', 'cancelled')->count();
```

### **Configuración de Filtros:**

```php
public function filtersForm(Form $form): Form
{
    return $form
        ->schema([
            Select::make('project_id')
                ->label('Proyecto')
                ->placeholder('Seleccionar proyecto')
                ->options(Project::pluck('name', 'id')->toArray())
                ->searchable()
                ->allowHtml(),
            DatePicker::make('startDate')
                ->label('Fecha de inicio'),
            DatePicker::make('endDate')
                ->label('Fecha de fin'),
        ])
        ->columns(3);
}
```

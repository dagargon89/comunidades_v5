# Widgets de Seguimiento - Sistema de Comunidades

## Descripción General

Se han creado una serie de widgets para el panel de usuario que permiten el seguimiento completo de actividades, archivos y beneficiarios. Todos los widgets están habilitados con filtros conforme a la documentación oficial de Filament.

## Widgets Creados

### 1. ActivityCalendarCount

**Ubicación:** `app/Filament/Usuario/Widgets/ActivityCalendarCount.php`
**Tipo:** Widget de estadísticas
**Descripción:** Muestra estadísticas generales de actividades calendarizadas

-   Total de actividades
-   Actividades activas
-   Actividades canceladas
-   Actividades de hoy
-   Actividades de la semana

### 2. ActivityFileStats

**Ubicación:** `app/Filament/Usuario/Widgets/ActivityFileStats.php`
**Tipo:** Widget de estadísticas
**Descripción:** Muestra estadísticas de archivos de actividades

-   Total de archivos
-   Archivos del mes
-   Archivos de la semana
-   Archivos de hoy
-   Archivos PDF
-   Archivos de imagen

### 3. BeneficiaryStats

**Ubicación:** `app/Filament/Usuario/Widgets/BeneficiaryStats.php`
**Tipo:** Widget de estadísticas
**Descripción:** Muestra estadísticas de beneficiarios registrados

-   Total de registros
-   Beneficiarios únicos
-   Registros del mes
-   Registros de la semana
-   Registros de hoy
-   Distribución por género

### 4. ActivityCalendarTable

**Ubicación:** `app/Filament/Usuario/Widgets/ActivityCalendarTable.php`
**Tipo:** Widget de tabla
**Descripción:** Tabla con todas las actividades calendarizadas

-   Filtros por proyecto, estado y rango de fechas
-   Columnas: Actividad, fechas, horas, estado
-   Paginación configurable

### 5. ActivityFileTable

**Ubicación:** `app/Filament/Usuario/Widgets/ActivityFileTable.php`
**Tipo:** Widget de tabla
**Descripción:** Tabla con archivos de actividades

-   Filtros por actividad, tipo de archivo, fechas y búsqueda
-   Columnas: Actividad, archivo, mes, tipo, fechas
-   Paginación configurable

### 6. BeneficiaryRegistryTable

**Ubicación:** `app/Filament/Usuario/Widgets/BeneficiaryRegistryTable.php`
**Tipo:** Widget de tabla
**Descripción:** Tabla con registros de beneficiarios

-   Filtros por actividad, género, año de nacimiento, fechas y búsqueda
-   Columnas: Datos personales, actividad, fecha de registro
-   Paginación configurable

### 7. ProjectActivitySummary

**Ubicación:** `app/Filament/Usuario/Widgets/ProjectActivitySummary.php`
**Tipo:** Widget de tabla
**Descripción:** Resumen de actividades por proyecto

-   Muestra estadísticas por proyecto
-   Columnas: Proyecto, fechas, total actividades, activas, canceladas, progreso
-   Cálculo automático de porcentaje de progreso

## Dashboard Personalizado

**Ubicación:** `app/Filament/Usuario/Pages/Dashboard.php`

### Características:

-   **Filtros habilitados:** Proyecto, fecha de inicio, fecha de fin
-   **Widgets de encabezado:** ActivityCalendarCount, ActivityFileStats, BeneficiaryStats
-   **Widgets de pie:** ProjectActivitySummary, ActivityCalendarTable, ActivityFileTable, BeneficiaryRegistryTable
-   **Persistencia de filtros:** Los filtros se mantienen en la sesión del usuario

### Filtros Disponibles:

1. **Proyecto:** Filtro por proyecto específico
2. **Fecha de inicio:** Filtrar actividades desde una fecha
3. **Fecha de fin:** Filtrar actividades hasta una fecha

## Compatibilidad con Filtros

Todos los widgets utilizan el trait `InteractsWithPageFilters` para ser compatibles con los filtros del dashboard:

```php
use Filament\Widgets\Concerns\InteractsWithPageFilters;

class MiWidget extends BaseWidget
{
    use InteractsWithPageFilters;

    protected function getStats(): array
    {
        // Acceder a los filtros
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;

        // Aplicar filtros a las consultas
        // ...
    }
}
```

## Configuración de Seguridad

Todos los widgets incluyen:

-   Filtrado por usuario autenticado (`Auth::id()`)
-   Trait `HasWidgetShield` comentado (puede habilitarse si es necesario)
-   Validación de datos de entrada

## Orden de Visualización

Los widgets se muestran en el siguiente orden:

1. ActivityCalendarCount (sort: 1)
2. ActivityCalendarTable (sort: 2)
3. ActivityFileStats (sort: 3)
4. BeneficiaryStats (sort: 4)
5. ActivityFileTable (sort: 5)
6. BeneficiaryRegistryTable (sort: 6)
7. ProjectActivitySummary (sort: 7)

## Características Técnicas

### Filtros Implementados:

-   **SelectFilter:** Para filtros de selección única
-   **Filter:** Para filtros personalizados con formularios
-   **DatePicker:** Para filtros de fechas
-   **TextInput:** Para búsquedas de texto

### Relaciones Utilizadas:

-   ActivityCalendar → Activity → Goal → Project
-   ActivityFile → ActivityCalendar
-   BeneficiaryRegistry → ActivityCalendar
-   BeneficiaryRegistry → Beneficiary

### Optimizaciones:

-   Uso de `with()` para cargar relaciones
-   Consultas optimizadas con `whereHas()`
-   Paginación configurable
-   Búsqueda y ordenamiento en columnas relevantes

## Uso

1. Los widgets se cargan automáticamente en el dashboard del usuario
2. Los filtros se aplican en tiempo real a todos los widgets
3. Los datos se filtran automáticamente por el usuario autenticado
4. Las tablas incluyen paginación y búsqueda
5. Los filtros persisten en la sesión del usuario

## Documentación de Referencia

Basado en la documentación oficial de Filament:

-   [Dashboard Documentation](https://filamentphp.com/docs/3.x/panels/dashboard)
-   [Widgets Documentation](https://filamentphp.com/docs/3.x/panels/dashboard#custom-widgets)
-   [Filters Documentation](https://filamentphp.com/docs/3.x/panels/dashboard#filtering-widget-data)

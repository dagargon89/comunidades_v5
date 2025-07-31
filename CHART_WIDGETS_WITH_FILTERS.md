# Gráficas con Filtros de Tiempo

## Implementación de Chart Widgets con Filtros

Basándome en la [documentación oficial de Filament Chart Widgets](https://filamentphp.com/docs/3.x/widgets/charts), he implementado cuatro widgets de gráficas con filtros de tiempo que permiten cambiar dinámicamente los datos mostrados.

## Widgets Implementados

### **1. ActivitiesBarChart - Gráfica de Barras**

#### **Características:**

-   ✅ **Tipo:** Gráfica de barras (Bar Chart)
-   ✅ **Filtros:** Hoy, Esta semana, Este mes, Este trimestre, Este año
-   ✅ **Datos:** Actividades por proyecto (Total, Activas, Canceladas)
-   ✅ **Colores:** Azul (Total), Verde (Activas), Rojo (Canceladas)

#### **Funcionalidad:**

```php
class ActivitiesBarChart extends ChartWidget
{
    public ?string $filter = 'month'; // Filtro por defecto

    protected function getFilters(): ?array
    {
        return [
            'today' => 'Hoy',
            'week' => 'Esta semana',
            'month' => 'Este mes',
            'quarter' => 'Este trimestre',
            'year' => 'Este año',
        ];
    }

    protected function getData(): array
    {
        $activeFilter = $this->filter;
        $dateRange = $this->getDateRange($activeFilter);

        // Consulta con filtros de fecha
        $activitiesByProject = ActivityCalendar::where('assigned_person', $userId)
            ->whereBetween('start_date', [$dateRange['start'], $dateRange['end']])
            ->with(['activity.goal.project'])
            ->get()
            ->groupBy('activity.goal.project.name');
    }
}
```

### **2. ActivitiesLineChart - Gráfica de Líneas**

#### **Características:**

-   ✅ **Tipo:** Gráfica de líneas (Line Chart)
-   ✅ **Filtros:** Esta semana, Este mes, Este trimestre, Este año
-   ✅ **Datos:** Evolución temporal de actividades
-   ✅ **Características:** Líneas suaves con tensión 0.4

#### **Funcionalidad:**

```php
class ActivitiesLineChart extends ChartWidget
{
    protected function getData(): array
    {
        $groupedData = $this->groupActivitiesByPeriod($activities, $activeFilter);

        return [
            'datasets' => [
                [
                    'label' => 'Total de Actividades',
                    'borderColor' => '#36A2EB',
                    'backgroundColor' => 'rgba(54, 162, 235, 0.1)',
                    'tension' => 0.4, // Líneas suaves
                ],
            ],
        ];
    }

    private function groupActivitiesByPeriod($activities, string $filter)
    {
        // Agrupación inteligente por período:
        // - Semana: Por días
        // - Mes: Por días del mes
        // - Trimestre: Por meses
        // - Año: Por meses del año
    }
}
```

### **3. FilesDoughnutChart - Gráfica de Dona**

#### **Características:**

-   ✅ **Tipo:** Gráfica de dona (Doughnut Chart)
-   ✅ **Filtros:** Hoy, Esta semana, Este mes, Este trimestre, Este año
-   ✅ **Datos:** Distribución de tipos de archivos
-   ✅ **Categorías:** Imágenes, Documentos, Videos, Audio, Otros

#### **Funcionalidad:**

```php
class FilesDoughnutChart extends ChartWidget
{
    private function categorizeFileType(string $type): string
    {
        $type = strtolower($type);

        // Imágenes
        if (str_contains($type, 'image') || str_contains($type, 'jpg') ||
            str_contains($type, 'jpeg') || str_contains($type, 'png')) {
            return 'Imágenes';
        }

        // Documentos
        if (str_contains($type, 'pdf') || str_contains($type, 'doc') ||
            str_contains($type, 'docx') || str_contains($type, 'xls')) {
            return 'Documentos';
        }

        // Videos, Audio, Otros...
    }
}
```

### **4. BeneficiariesRadarChart - Gráfica de Radar**

#### **Características:**

-   ✅ **Tipo:** Gráfica de radar (Radar Chart)
-   ✅ **Filtros:** Hoy, Esta semana, Este mes, Este trimestre, Este año
-   ✅ **Datos:** Estadísticas demográficas de beneficiarios
-   ✅ **Métricas:** Total, Hombres, Mujeres, Jóvenes, Adultos, Adultos Mayores

#### **Funcionalidad:**

```php
class BeneficiariesRadarChart extends ChartWidget
{
    protected function getData(): array
    {
        // Calcular estadísticas demográficas
        $totalBeneficiaries = $beneficiaryStats->count();
        $maleBeneficiaries = $beneficiaryStats->where('beneficiary.gender', 'M')->count();
        $femaleBeneficiaries = $beneficiaryStats->where('beneficiary.gender', 'F')->count();

        // Calcular rangos de edad
        $youngBeneficiaries = $beneficiaryStats->filter(function ($registry) {
            $age = Carbon::now()->year - $registry->beneficiary->birth_year;
            return $age >= 0 && $age <= 17;
        })->count();
    }
}
```

## Características de los Filtros

### **1. Filtros de Tiempo Disponibles:**

-   ✅ **Hoy:** Datos del día actual
-   ✅ **Esta semana:** Datos de la semana actual
-   ✅ **Este mes:** Datos del mes actual
-   ✅ **Este trimestre:** Datos del trimestre actual
-   ✅ **Este año:** Datos del año actual

### **2. Implementación de Filtros:**

```php
public ?string $filter = 'month'; // Filtro por defecto

protected function getFilters(): ?array
{
    return [
        'today' => 'Hoy',
        'week' => 'Esta semana',
        'month' => 'Este mes',
        'quarter' => 'Este trimestre',
        'year' => 'Este año',
    ];
}

protected function getData(): array
{
    $activeFilter = $this->filter; // Obtener filtro activo
    $dateRange = $this->getDateRange($activeFilter); // Calcular rango de fechas

    // Aplicar filtros a la consulta
    $query->whereBetween('start_date', [$dateRange['start'], $dateRange['end']]);
}
```

### **3. Cálculo de Rangos de Fecha:**

```php
private function getDateRange(string $filter): array
{
    return match ($filter) {
        'today' => [
            'start' => Carbon::today(),
            'end' => Carbon::today()->endOfDay(),
        ],
        'week' => [
            'start' => Carbon::now()->startOfWeek(),
            'end' => Carbon::now()->endOfWeek(),
        ],
        'month' => [
            'start' => Carbon::now()->startOfMonth(),
            'end' => Carbon::now()->endOfMonth(),
        ],
        'quarter' => [
            'start' => Carbon::now()->startOfQuarter(),
            'end' => Carbon::now()->endOfQuarter(),
        ],
        'year' => [
            'start' => Carbon::now()->startOfYear(),
            'end' => Carbon::now()->endOfYear(),
        ],
        default => [
            'start' => Carbon::now()->startOfMonth(),
            'end' => Carbon::now()->endOfMonth(),
        ],
    };
}
```

## Configuración del Dashboard

### **Widgets en el Footer:**

1. **ActivitiesBarChart** - Gráfica de barras de actividades por proyecto
2. **ActivitiesLineChart** - Gráfica de líneas de evolución temporal
3. **FilesDoughnutChart** - Gráfica de dona de tipos de archivos
4. **BeneficiariesRadarChart** - Gráfica de radar de estadísticas demográficas
5. **ProjectActivitySummary** - Tabla de resumen por proyecto
6. **ActivityCalendarTable** - Tabla de actividades
7. **ActivityFileTable** - Tabla de archivos
8. **BeneficiaryRegistryTable** - Tabla de beneficiarios

### **Widgets en el Header:**

1. **ActivityCalendarCount** - Estadísticas de actividades
2. **ActivityFileStats** - Estadísticas de archivos
3. **BeneficiaryStats** - Estadísticas de beneficiarios

## Características Técnicas

### **1. Tipos de Gráficas Implementadas:**

-   ✅ **Bar Chart:** Para comparaciones entre categorías
-   ✅ **Line Chart:** Para evolución temporal
-   ✅ **Doughnut Chart:** Para distribución de proporciones
-   ✅ **Radar Chart:** Para múltiples métricas en un solo gráfico

### **2. Personalización de Colores:**

```php
// Colores personalizados para cada dataset
'backgroundColor' => '#36A2EB',
'borderColor' => '#9BD0F5',
'pointBackgroundColor' => '#36A2EB',
'pointBorderColor' => '#ffffff',
```

### **3. Configuración de Gráficas:**

```php
protected static ?string $maxHeight = '300px'; // Altura máxima
protected static ?string $heading = 'Título de la Gráfica';
public function getDescription(): ?string
{
    return 'Descripción de la gráfica.';
}
```

### **4. Actualización en Tiempo Real:**

```php
// Los widgets se actualizan automáticamente cada 5 segundos
// Se puede personalizar con:
protected static ?string $pollingInterval = '10s';
// O deshabilitar con:
protected static ?string $pollingInterval = null;
```

## Ventajas de la Implementación

### **1. Interactividad:**

-   ✅ **Filtros dinámicos:** Cambio instantáneo de datos
-   ✅ **Múltiples períodos:** Flexibilidad en el análisis temporal
-   ✅ **Interfaz intuitiva:** Filtros fáciles de usar

### **2. Visualización Completa:**

-   ✅ **Diferentes tipos de gráficas:** Para diferentes tipos de análisis
-   ✅ **Colores significativos:** Codificación de colores por categoría
-   ✅ **Descripciones claras:** Contexto para cada gráfica

### **3. Rendimiento:**

-   ✅ **Consultas optimizadas:** Filtros aplicados en la base de datos
-   ✅ **Carga eficiente:** Solo datos necesarios
-   ✅ **Actualización automática:** Datos siempre actualizados

### **4. Escalabilidad:**

-   ✅ **Fácil extensión:** Agregar nuevos filtros o gráficas
-   ✅ **Reutilización:** Patrones consistentes en todos los widgets
-   ✅ **Mantenimiento:** Código limpio y bien estructurado

## Estado Final

✅ **4 gráficas implementadas:** Bar, Line, Doughnut, Radar  
✅ **Filtros de tiempo:** 5 opciones de filtrado temporal  
✅ **Datos dinámicos:** Cambio instantáneo según filtros  
✅ **Interfaz intuitiva:** Filtros fáciles de usar  
✅ **Colores significativos:** Codificación visual clara  
✅ **Documentación oficial:** Basado en Filament 3.x

## Próximos Pasos

1. **Probar gráficas:** Verificar que todas las gráficas cargan correctamente
2. **Probar filtros:** Confirmar que los filtros cambian los datos
3. **Verificar datos:** Comprobar que los datos son correctos
4. **Optimizar rendimiento:** Ajustar consultas si es necesario

## Documentación Relacionada

-   [Filament Chart Widgets Documentation](https://filamentphp.com/docs/3.x/widgets/charts)
-   `REMOVE_GLOBAL_FILTERS.md` - Eliminación de filtros globales
-   `BENEFICIARY_RELATIONSHIP_FIX.md` - Correcciones de relaciones

## Notas Técnicas

### **Patrón de Chart Widget con Filtros:**

```php
class MiChartWidget extends ChartWidget
{
    public ?string $filter = 'month'; // Filtro por defecto

    protected function getFilters(): ?array
    {
        return [
            'today' => 'Hoy',
            'week' => 'Esta semana',
            'month' => 'Este mes',
        ];
    }

    protected function getData(): array
    {
        $activeFilter = $this->filter;
        $dateRange = $this->getDateRange($activeFilter);

        // Consulta con filtros
        $data = Model::whereBetween('date', [$dateRange['start'], $dateRange['end']])
            ->get();

        return [
            'datasets' => [
                [
                    'label' => 'Mi Dataset',
                    'data' => $data->pluck('value')->toArray(),
                    'backgroundColor' => '#36A2EB',
                ],
            ],
            'labels' => $data->pluck('label')->toArray(),
        ];
    }

    protected function getType(): string
    {
        return 'bar'; // o 'line', 'doughnut', 'radar'
    }
}
```

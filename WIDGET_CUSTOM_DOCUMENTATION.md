# Widget Personalizado - Dashboard de Actividades

## Descripción

Este widget personalizado proporciona un dashboard completo con información detallada sobre las actividades del usuario actual. Incluye gráficas, tablas y estadísticas relevantes.

## Características

### 📊 Estadísticas Generales

-   **Total de Actividades**: Número total de actividades creadas por el usuario
-   **Actividades del Mes**: Actividades creadas en el mes actual
-   **Actividades de la Semana**: Actividades creadas en la semana actual

### 📈 Gráficas Interactivas

1. **Gráfica de Línea**: Muestra la evolución de actividades por mes (últimos 6 meses)
2. **Gráfica de Dona**: Distribución de actividades por proyecto

### 📋 Tabla de Actividades Recientes

-   Lista las 10 actividades más recientes del usuario
-   Incluye nombre, proyecto, fecha de creación y estado

### 🏆 Top Proyectos

-   Muestra los 5 proyectos más activos del usuario
-   Incluye barras de progreso visuales

## Archivos Creados/Modificados

### 1. Widget PHP (`app/Filament/Usuario/Widgets/Custom.php`)

```php
class Custom extends Widget
{
    protected static string $view = 'filament.usuario.widgets.custom';

    public function getData(): array
    {
        // Obtiene todos los datos necesarios para el dashboard
        // Incluye estadísticas, gráficas y tablas
    }
}
```

### 2. Vista Blade (`resources/views/filament/usuario/widgets/custom.blade.php`)

-   Dashboard completo con diseño responsive
-   Gráficas usando Chart.js
-   Tablas con información detallada
-   Diseño compatible con modo oscuro

### 3. Modelo User (`app/Models/User.php`)

-   Agregada relación `activities()` para obtener actividades del usuario

## Tecnologías Utilizadas

### Frontend

-   **Tailwind CSS**: Para el diseño y estilos
-   **Chart.js**: Para las gráficas interactivas
-   **Alpine.js**: Para interactividad (incluido en Filament)

### Backend

-   **Laravel Eloquent**: Para consultas de base de datos
-   **Filament Widgets**: Framework base del widget

## Datos Mostrados

### Estadísticas

-   Total de actividades creadas por el usuario
-   Actividades del mes actual
-   Actividades de la semana actual

### Gráficas

1. **Evolución Mensual**: Línea de tiempo de los últimos 6 meses
2. **Distribución por Proyecto**: Gráfica de dona con porcentajes

### Tablas

-   **Actividades Recientes**: Lista con paginación de las últimas 10 actividades
-   **Top Proyectos**: Ranking de proyectos más activos

## Personalización

### Agregar Nuevas Estadísticas

```php
// En el método getData()
$nuevaEstadistica = $userActivities->where('condicion', 'valor')->count();

return [
    // ... otros datos
    'nuevaEstadistica' => $nuevaEstadistica,
];
```

### Agregar Nuevas Gráficas

```javascript
// En el archivo Blade
const nuevaGrafica = document.getElementById('nuevaGrafica').getContext('2d');
new Chart(nuevaGrafica, {
    type: 'bar', // o 'line', 'doughnut', etc.
    data: {
        labels: @json($datos->keys()),
        datasets: [{
            data: @json($datos->values()),
            // configuración adicional
        }]
    },
    options: {
        // opciones de la gráfica
    }
});
```

### Modificar Colores y Estilos

```css
/* Los colores se pueden modificar en las clases de Tailwind */
.bg-blue-500 /* Color principal */
/* Color principal */
.bg-green-500 /* Color de éxito */
.bg-yellow-500; /* Color de advertencia */
```

## Consideraciones de Rendimiento

1. **Consultas Optimizadas**: Se utilizan eager loading para evitar N+1 queries
2. **Caché**: Los datos se calculan en tiempo real, pero se pueden implementar caché
3. **Paginación**: Las tablas muestran un número limitado de registros

## Extensibilidad

### Agregar Nuevas Secciones

1. Crear el método en el widget PHP
2. Agregar la vista en el archivo Blade
3. Incluir los estilos necesarios

### Integrar con Otros Widgets

-   Este widget puede ser usado junto con otros widgets de Filament
-   Se puede combinar con filtros globales del panel

## Troubleshooting

### Gráficas No Se Muestran

-   Verificar que Chart.js esté cargado correctamente
-   Revisar la consola del navegador para errores JavaScript

### Datos Vacíos

-   Verificar que el usuario tenga actividades creadas
-   Revisar las relaciones en los modelos

### Errores de Base de Datos

-   Verificar que las tablas existan y tengan datos
-   Revisar las relaciones entre modelos

## Próximas Mejoras

1. **Filtros Interactivos**: Agregar filtros por fecha, proyecto, etc.
2. **Exportación**: Permitir exportar datos a PDF/Excel
3. **Notificaciones**: Alertas para actividades pendientes
4. **Métricas Avanzadas**: KPIs más detallados
5. **Gráficas Adicionales**: Más tipos de visualizaciones

## Uso en Filament

Para usar este widget en un panel de Filament:

```php
// En el archivo de configuración del panel
use App\Filament\Usuario\Widgets\Custom;

public function widgets(): array
{
    return [
        Custom::class,
    ];
}
```

## Soporte

Este widget está diseñado para ser robusto y fácil de mantener. Cualquier modificación debe seguir las mejores prácticas de Laravel y Filament.

# Implementación de Filtros Según Documentación Oficial de Filament

## Referencias de Documentación

-   [Select filters](https://filamentphp.com/docs/3.x/tables/filters/select) - Filtros de selección
-   [Ternary filters](https://filamentphp.com/docs/3.x/tables/filters/ternary) - Filtros ternarios
-   [Query builder](https://filamentphp.com/docs/3.x/tables/filters/query-builder) - Constructor de consultas
-   [Custom filters](https://filamentphp.com/docs/3.x/tables/filters/custom) - Filtros personalizados
-   [Filter layout](https://filamentphp.com/docs/3.x/tables/filters/layout) - Diseño de filtros

## Mejoras Implementadas

### **1. SelectFilter con Relaciones**

#### **Antes (Incorrecto):**

```php
SelectFilter::make('project_id')
    ->label('Proyecto')
    ->options(Project::pluck('name', 'id')->toArray())
    ->query(function ($query, array $data) {
        if (!empty($data['project_id'])) {
            $query->whereHas('activity.goal', function ($q) use ($data) {
                $q->where('project_id', $data['project_id']);
            });
        }
        return $query;
    })
```

#### **Después (Correcto según documentación):**

```php
SelectFilter::make('project')
    ->label('Proyecto')
    ->relationship('activity.goal.project', 'name')
    ->searchable()
    ->preload()
```

### **2. Uso de `->when()` en Filtros**

#### **Antes (Incorrecto):**

```php
->query(function ($query, array $data) {
    if (!empty($data['start_date'])) {
        $query->where('start_date', '>=', $data['start_date']);
    }
    if (!empty($data['end_date'])) {
        $query->where('end_date', '<=', $data['end_date']);
    }
    return $query;
})
```

#### **Después (Correcto según documentación):**

```php
->query(function ($query, array $data) {
    return $query
        ->when(
            $data['start_date'],
            fn ($query, $date) => $query->where('start_date', '>=', $date)
        )
        ->when(
            $data['end_date'],
            fn ($query, $date) => $query->where('end_date', '<=', $date)
        );
})
```

## Widgets Optimizados

### **1. ActivityCalendarTable Widget**

#### **Filtros Implementados:**

```php
->filters([
    SelectFilter::make('project')
        ->label('Proyecto')
        ->relationship('activity.goal.project', 'name')
        ->searchable()
        ->preload(),
    SelectFilter::make('cancelled')
        ->label('Estado')
        ->options([
            0 => 'Activa',
            1 => 'Cancelada',
        ])
        ->default(0),
    Filter::make('date_range')
        ->label('Rango de fechas')
        ->form([
            DatePicker::make('start_date')->label('Fecha de inicio'),
            DatePicker::make('end_date')->label('Fecha de fin'),
        ])
        ->query(function ($query, array $data) {
            return $query
                ->when(
                    $data['start_date'],
                    fn ($query, $date) => $query->where('start_date', '>=', $date)
                )
                ->when(
                    $data['end_date'],
                    fn ($query, $date) => $query->where('end_date', '<=', $date)
                );
        }),
])
```

#### **Ventajas:**

-   ✅ **Relación automática:** Usa `relationship()` para filtros de relaciones
-   ✅ **Búsqueda habilitada:** `searchable()` para facilitar la selección
-   ✅ **Precarga:** `preload()` para cargar opciones al inicio
-   ✅ **Valor por defecto:** `default(0)` para mostrar actividades activas por defecto

### **2. ActivityFileTable Widget**

#### **Filtros Implementados:**

```php
->filters([
    SelectFilter::make('activity')
        ->label('Actividad')
        ->relationship('activityCalendar.activity', 'name')
        ->searchable()
        ->preload(),
    SelectFilter::make('type')
        ->label('Tipo de archivo')
        ->options(function () use ($userActivityIds) {
            return ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                ->whereNotNull('type')
                ->distinct()
                ->pluck('type', 'type')
                ->toArray();
        }),
    Filter::make('upload_date_range')
        ->label('Rango de fechas de subida')
        ->form([
            DatePicker::make('start_date')->label('Fecha de inicio'),
            DatePicker::make('end_date')->label('Fecha de fin'),
        ])
        ->query(function ($query, array $data) {
            return $query
                ->when(
                    $data['start_date'],
                    fn ($query, $date) => $query->where('upload_date', '>=', $date)
                )
                ->when(
                    $data['end_date'],
                    fn ($query, $date) => $query->where('upload_date', '<=', $date)
                );
        }),
    Filter::make('file_search')
        ->label('Buscar archivo')
        ->form([
            TextInput::make('file_name')
                ->label('Nombre del archivo')
                ->placeholder('Buscar por nombre...'),
        ])
        ->query(function ($query, array $data) {
            return $query->when(
                $data['file_name'],
                fn ($query, $search) => $query->where('file_path', 'like', '%' . $search . '%')
            );
        }),
])
```

#### **Ventajas:**

-   ✅ **Relación automática:** Filtro de actividad usando relaciones
-   ✅ **Búsqueda optimizada:** Uso de `->when()` para búsqueda condicional
-   ✅ **Filtros dinámicos:** Tipo de archivo basado en datos existentes

### **3. BeneficiaryRegistryTable Widget**

#### **Filtros Implementados:**

```php
->filters([
    SelectFilter::make('activity')
        ->label('Actividad')
        ->relationship('activityCalendar.activity', 'name')
        ->searchable()
        ->preload(),
    SelectFilter::make('gender')
        ->label('Género')
        ->options([
            'M' => 'Masculino',
            'F' => 'Femenino',
        ]),
    Filter::make('birth_year_range')
        ->label('Rango de año de nacimiento')
        ->form([
            TextInput::make('start_year')
                ->label('Año de inicio')
                ->numeric()
                ->placeholder('Ej: 1980'),
            TextInput::make('end_year')
                ->label('Año de fin')
                ->numeric()
                ->placeholder('Ej: 2000'),
        ])
        ->query(function ($query, array $data) {
            return $query
                ->when(
                    $data['start_year'],
                    fn ($query, $year) => $query->whereHas('beneficiary', function ($q) use ($year) {
                        $q->where('birth_year', '>=', $year);
                    })
                )
                ->when(
                    $data['end_year'],
                    fn ($query, $year) => $query->whereHas('beneficiary', function ($q) use ($year) {
                        $q->where('birth_year', '<=', $year);
                    })
                );
        }),
    Filter::make('registration_date_range')
        ->label('Rango de fechas de registro')
        ->form([
            DatePicker::make('start_date')->label('Fecha de inicio'),
            DatePicker::make('end_date')->label('Fecha de fin'),
        ])
        ->query(function ($query, array $data) {
            return $query
                ->when(
                    $data['start_date'],
                    fn ($query, $date) => $query->where('created_at', '>=', $date)
                )
                ->when(
                    $data['end_date'],
                    fn ($query, $date) => $query->where('created_at', '<=', $date)
                );
        }),
    Filter::make('beneficiary_search')
        ->label('Buscar beneficiario')
        ->form([
            TextInput::make('search_term')
                ->label('Término de búsqueda')
                ->placeholder('Nombre, apellido o identificador...'),
        ])
        ->query(function ($query, array $data) {
            return $query->when(
                $data['search_term'],
                fn ($query, $searchTerm) => $query->whereHas('beneficiary', function ($q) use ($searchTerm) {
                    $q->where(function ($subQuery) use ($searchTerm) {
                        $subQuery->where('identifier', 'like', "%{$searchTerm}%")
                                 ->orWhere('first_names', 'like', "%{$searchTerm}%")
                                 ->orWhere('last_name', 'like', "%{$searchTerm}%")
                                 ->orWhere('mother_last_name', 'like', "%{$searchTerm}%");
                    });
                })
            );
        }),
])
```

#### **Ventajas:**

-   ✅ **Búsqueda avanzada:** Múltiples campos en una sola búsqueda
-   ✅ **Filtros de rango:** Años de nacimiento y fechas de registro
-   ✅ **Relaciones optimizadas:** Uso de `whereHas()` para filtros de relaciones

## Patrones Según Documentación Oficial

### **1. SelectFilter con Relaciones:**

```php
SelectFilter::make('relationship_name')
    ->label('Etiqueta')
    ->relationship('relationship.path', 'column_name')
    ->searchable()
    ->preload()
```

### **2. SelectFilter con Opciones Estáticas:**

```php
SelectFilter::make('field_name')
    ->label('Etiqueta')
    ->options([
        'value' => 'Label',
    ])
    ->default('value')
```

### **3. Filter con `->when()`:**

```php
Filter::make('filter_name')
    ->label('Etiqueta')
    ->form([
        // Componentes del formulario
    ])
    ->query(function ($query, array $data) {
        return $query
            ->when(
                $data['field'],
                fn ($query, $value) => $query->where('field', $value)
            );
    })
```

### **4. Filter con Búsqueda Avanzada:**

```php
Filter::make('search_filter')
    ->label('Búsqueda')
    ->form([
        TextInput::make('search_term')
            ->label('Término de búsqueda')
            ->placeholder('Buscar...'),
    ])
    ->query(function ($query, array $data) {
        return $query->when(
            $data['search_term'],
            fn ($query, $search) => $query->where(function ($subQuery) use ($search) {
                $subQuery->where('field1', 'like', "%{$search}%")
                         ->orWhere('field2', 'like', "%{$search}%");
            })
        );
    })
```

## Ventajas de la Implementación Oficial

### **1. Rendimiento Mejorado:**

-   ✅ **Relaciones automáticas:** Filament maneja las consultas de relaciones
-   ✅ **Precarga optimizada:** `preload()` carga opciones al inicio
-   ✅ **Consultas eficientes:** `->when()` solo aplica filtros cuando es necesario

### **2. Experiencia de Usuario:**

-   ✅ **Búsqueda habilitada:** `searchable()` facilita encontrar opciones
-   ✅ **Valores por defecto:** `default()` mejora la experiencia inicial
-   ✅ **Interfaz intuitiva:** Filtros claros y fáciles de usar

### **3. Mantenibilidad:**

-   ✅ **Código limpio:** Sintaxis oficial de Filament
-   ✅ **Fácil debug:** Patrones estándar y predecibles
-   ✅ **Escalabilidad:** Fácil agregar nuevos filtros

## Estado Final

✅ **Filtros optimizados:** Todos los filtros siguen la documentación oficial  
✅ **Relaciones automáticas:** Uso de `relationship()` para filtros de relaciones  
✅ **Búsqueda habilitada:** `searchable()` en filtros de selección  
✅ **Precarga implementada:** `preload()` para mejor rendimiento  
✅ **Patrones oficiales:** Uso de `->when()` para filtros condicionales  
✅ **Caché limpiado:** Cambios aplicados correctamente

## Configuración Final de Filtros

### **ActivityCalendarTable:**

-   ✅ **Proyecto:** Relación automática con búsqueda y precarga
-   ✅ **Estado:** SelectFilter con valor por defecto
-   ✅ **Rango de fechas:** Filter con `->when()`

### **ActivityFileTable:**

-   ✅ **Actividad:** Relación automática con búsqueda y precarga
-   ✅ **Tipo de archivo:** SelectFilter con opciones dinámicas
-   ✅ **Rango de fechas:** Filter con `->when()`
-   ✅ **Búsqueda de archivo:** Filter con búsqueda condicional

### **BeneficiaryRegistryTable:**

-   ✅ **Actividad:** Relación automática con búsqueda y precarga
-   ✅ **Género:** SelectFilter con opciones estáticas
-   ✅ **Año de nacimiento:** Filter con rango y `->when()`
-   ✅ **Fecha de registro:** Filter con rango y `->when()`
-   ✅ **Búsqueda de beneficiario:** Filter con búsqueda avanzada

## Próximos Pasos

1. **Probar filtros:** Verificar que todos los filtros funcionan correctamente
2. **Probar relaciones:** Confirmar que los filtros de relaciones funcionan
3. **Probar búsqueda:** Verificar que la búsqueda funciona en todos los filtros
4. **Probar rendimiento:** Comprobar que la carga es más rápida

## Documentación Relacionada

-   `TABLE_FILTERS_FIX.md` - Corrección inicial de filtros
-   `TABLE_WIDGETS_FIX.md` - Corrección de widgets de tablas
-   [Select filters](https://filamentphp.com/docs/3.x/tables/filters/select) - Documentación oficial
-   [Ternary filters](https://filamentphp.com/docs/3.x/tables/filters/ternary) - Documentación oficial
-   [Query builder](https://filamentphp.com/docs/3.x/tables/filters/query-builder) - Documentación oficial
-   [Custom filters](https://filamentphp.com/docs/3.x/tables/filters/custom) - Documentación oficial
-   [Filter layout](https://filamentphp.com/docs/3.x/tables/filters/layout) - Documentación oficial

## Notas Técnicas

### **Comandos de Limpieza:**

```bash
# Limpiar caché después de cambios
php artisan config:clear
php artisan cache:clear
php artisan view:clear
```

### **Patrones Recomendados:**

```php
// Para relaciones
SelectFilter::make('relationship')
    ->relationship('relationship.path', 'column')
    ->searchable()
    ->preload()

// Para filtros condicionales
Filter::make('filter')
    ->query(function ($query, array $data) {
        return $query->when(
            $data['field'],
            fn ($query, $value) => $query->where('field', $value)
        );
    })
```

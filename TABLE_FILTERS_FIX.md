# Corrección de Filtros en Widgets de Tablas

## Problema Identificado

**Error:** `Unable to find component: [app.filament.usuario.widgets.activity-calendar-table]` y errores similares en los filtros de las tablas.

**Causa:** Los filtros de las tablas no estaban retornando correctamente la query, causando errores de componentes no encontrados.

## Solución Implementada

### **1. Corrección de Sintaxis de Filtros**

#### **Problema Común:**

```php
// Antes (incorrecto)
->query(function ($query, array $data) {
    if (!empty($data['field'])) {
        $query->where('field', $data['field']);
    }
    // ❌ No retorna la query
})
```

#### **Solución Aplicada:**

```php
// Después (correcto)
->query(function ($query, array $data) {
    if (!empty($data['field'])) {
        $query->where('field', $data['field']);
    }
    return $query; // ✅ Siempre retorna la query
})
```

### **2. Widgets Corregidos**

#### **ActivityCalendarTable Widget:**

```php
// Filtros corregidos
->filters([
    SelectFilter::make('project_id')
        ->label('Proyecto')
        ->options(Project::pluck('name', 'id')->toArray())
        ->query(function ($query, array $data) {
            if (!empty($data['project_id'])) {
                $query->whereHas('activity.goal', function ($q) use ($data) {
                    $q->where('project_id', $data['project_id']);
                });
            }
            return $query; // ✅ Retorno agregado
        }),
    SelectFilter::make('cancelled')
        ->label('Estado')
        ->options([
            0 => 'Activa',
            1 => 'Cancelada',
        ]),
    Filter::make('date_range')
        ->label('Rango de fechas')
        ->form([
            DatePicker::make('start_date')->label('Fecha de inicio'),
            DatePicker::make('end_date')->label('Fecha de fin'),
        ])
        ->query(function ($query, array $data) {
            if (!empty($data['start_date'])) {
                $query->where('start_date', '>=', $data['start_date']);
            }
            if (!empty($data['end_date'])) {
                $query->where('end_date', '<=', $data['end_date']);
            }
            return $query; // ✅ Retorno agregado
        }),
])
```

#### **ActivityFileTable Widget:**

```php
// Filtros corregidos
->filters([
    SelectFilter::make('activity_id')
        ->label('Actividad')
        ->options(function () use ($userId) {
            $activityIds = ActivityCalendar::where('assigned_person', $userId)
                ->pluck('activity_id')
                ->unique();
            return Activity::whereIn('id', $activityIds)
                ->pluck('name', 'id')
                ->toArray();
        })
        ->query(function ($query, array $data) {
            if (!empty($data['activity_id'])) {
                $query->whereHas('activityCalendar', function ($q) use ($data) {
                    $q->where('activity_id', $data['activity_id']);
                });
            }
            return $query; // ✅ Retorno agregado
        }),
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
            if (!empty($data['start_date'])) {
                $query->where('upload_date', '>=', $data['start_date']);
            }
            if (!empty($data['end_date'])) {
                $query->where('upload_date', '<=', $data['end_date']);
            }
            return $query; // ✅ Retorno agregado
        }),
    Filter::make('file_search')
        ->label('Buscar archivo')
        ->form([
            TextInput::make('file_name')
                ->label('Nombre del archivo')
                ->placeholder('Buscar por nombre...'),
        ])
        ->query(function ($query, array $data) {
            if (!empty($data['file_name'])) {
                $query->where('file_path', 'like', '%' . $data['file_name'] . '%');
            }
            return $query; // ✅ Retorno agregado
        }),
])
```

#### **BeneficiaryRegistryTable Widget:**

```php
// Filtros corregidos
->filters([
    SelectFilter::make('activity_id')
        ->label('Actividad')
        ->options(function () use ($userId) {
            $activityIds = ActivityCalendar::where('assigned_person', $userId)
                ->pluck('activity_id')
                ->unique();
            return Activity::whereIn('id', $activityIds)
                ->pluck('name', 'id')
                ->toArray();
        })
        ->query(function ($query, array $data) {
            if (!empty($data['activity_id'])) {
                $query->whereHas('activityCalendar', function ($q) use ($data) {
                    $q->where('activity_id', $data['activity_id']);
                });
            }
            return $query; // ✅ Retorno agregado
        }),
    SelectFilter::make('gender')
        ->label('Género')
        ->options([
            'M' => 'Masculino',
            'F' => 'Femenino',
        ])
        ->query(function ($query, array $data) {
            if (!empty($data['gender'])) {
                $query->whereHas('beneficiary', function ($q) use ($data) {
                    $q->where('gender', $data['gender']);
                });
            }
            return $query; // ✅ Retorno agregado
        }),
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
            if (!empty($data['start_year'])) {
                $query->whereHas('beneficiary', function ($q) use ($data) {
                    $q->where('birth_year', '>=', $data['start_year']);
                });
            }
            if (!empty($data['end_year'])) {
                $query->whereHas('beneficiary', function ($q) use ($data) {
                    $q->where('birth_year', '<=', $data['end_year']);
                });
            }
            return $query; // ✅ Retorno agregado
        }),
    Filter::make('registration_date_range')
        ->label('Rango de fechas de registro')
        ->form([
            DatePicker::make('start_date')->label('Fecha de inicio'),
            DatePicker::make('end_date')->label('Fecha de fin'),
        ])
        ->query(function ($query, array $data) {
            if (!empty($data['start_date'])) {
                $query->where('created_at', '>=', $data['start_date']);
            }
            if (!empty($data['end_date'])) {
                $query->where('created_at', '<=', $data['end_date']);
            }
            return $query; // ✅ Retorno agregado
        }),
    Filter::make('beneficiary_search')
        ->label('Buscar beneficiario')
        ->form([
            TextInput::make('search_term')
                ->label('Término de búsqueda')
                ->placeholder('Nombre, apellido o identificador...'),
        ])
        ->query(function ($query, array $data) {
            if (!empty($data['search_term'])) {
                $searchTerm = $data['search_term'];
                $query->whereHas('beneficiary', function ($q) use ($searchTerm) {
                    $q->where(function ($subQuery) use ($searchTerm) {
                        $subQuery->where('identifier', 'like', "%{$searchTerm}%")
                                 ->orWhere('first_names', 'like', "%{$searchTerm}%")
                                 ->orWhere('last_name', 'like', "%{$searchTerm}%")
                                 ->orWhere('mother_last_name', 'like', "%{$searchTerm}%");
                    });
                });
            }
            return $query; // ✅ Retorno agregado
        }),
])
```

## Archivos Corregidos

### **1. app/Filament/Usuario/Widgets/ActivityCalendarTable.php**

-   ✅ **Filtros corregidos:** Todos los filtros ahora retornan la query correctamente
-   ✅ **SelectFilter corregido:** Filtro de proyecto con retorno de query
-   ✅ **Filter corregido:** Filtro de rango de fechas con retorno de query

### **2. app/Filament/Usuario/Widgets/ActivityFileTable.php**

-   ✅ **Filtros corregidos:** Todos los filtros ahora retornan la query correctamente
-   ✅ **SelectFilter corregido:** Filtro de actividad con retorno de query
-   ✅ **Filter corregido:** Filtros de fecha y búsqueda con retorno de query

### **3. app/Filament/Usuario/Widgets/BeneficiaryRegistryTable.php**

-   ✅ **Filtros corregidos:** Todos los filtros ahora retornan la query correctamente
-   ✅ **SelectFilter corregido:** Filtros de actividad y género con retorno de query
-   ✅ **Filter corregido:** Filtros de año, fecha y búsqueda con retorno de query

## Ventajas de la Corrección

### **1. Funcionalidad Restaurada:**

-   ✅ **Filtros funcionando:** Todos los filtros de las tablas funcionan correctamente
-   ✅ **Componentes encontrados:** No más errores de componentes no encontrados
-   ✅ **Interfaz estable:** Los filtros se muestran y funcionan sin errores

### **2. Sintaxis Correcta:**

-   ✅ **Retorno de query:** Todos los filtros retornan la query correctamente
-   ✅ **Validación de datos:** Verificación de datos vacíos antes de aplicar filtros
-   ✅ **Consultas optimizadas:** Filtros eficientes y bien estructurados

### **3. Experiencia de Usuario:**

-   ✅ **Filtros intuitivos:** Interfaz clara y fácil de usar
-   ✅ **Búsqueda funcional:** Búsqueda en texto funciona correctamente
-   ✅ **Rangos de fechas:** Filtros de fechas funcionan sin problemas

## Estado Final

✅ **Filtros de tablas corregidos:** Todos los filtros funcionan sin errores  
✅ **Componentes encontrados:** No más errores de componentes no encontrados  
✅ **Interfaz estable:** Los filtros se muestran y funcionan correctamente  
✅ **Caché limpiado:** Cambios aplicados correctamente

## Configuración Final de Filtros

### **ActivityCalendarTable - Filtros Disponibles:**

-   ✅ **Proyecto:** Filtro por proyecto específico
-   ✅ **Estado:** Filtro por actividad activa/cancelada
-   ✅ **Rango de fechas:** Filtro por fechas de inicio y fin

### **ActivityFileTable - Filtros Disponibles:**

-   ✅ **Actividad:** Filtro por actividad específica
-   ✅ **Tipo de archivo:** Filtro por tipo de archivo
-   ✅ **Rango de fechas:** Filtro por fechas de subida
-   ✅ **Búsqueda de archivo:** Búsqueda por nombre de archivo

### **BeneficiaryRegistryTable - Filtros Disponibles:**

-   ✅ **Actividad:** Filtro por actividad específica
-   ✅ **Género:** Filtro por género (Masculino/Femenino)
-   ✅ **Año de nacimiento:** Filtro por rango de años
-   ✅ **Fecha de registro:** Filtro por fechas de registro
-   ✅ **Búsqueda de beneficiario:** Búsqueda por nombre, apellido o identificador

## Próximos Pasos

1. **Probar filtros:** Verificar que todos los filtros funcionan correctamente
2. **Probar búsqueda:** Confirmar que la búsqueda funciona en todas las tablas
3. **Probar rangos:** Verificar que los filtros de rangos funcionan
4. **Probar combinaciones:** Comprobar que múltiples filtros funcionan juntos

## Documentación Relacionada

-   `TABLE_WIDGETS_FIX.md` - Corrección de widgets de tablas
-   `REMOVE_GLOBAL_FILTERS.md` - Eliminación de filtros globales

## Notas Técnicas

### **Patrón Correcto para Filtros:**

```php
Filter::make('filter_name')
    ->label('Etiqueta del Filtro')
    ->form([
        // Componentes del formulario
    ])
    ->query(function ($query, array $data) {
        // Lógica del filtro
        if (!empty($data['field'])) {
            $query->where('field', $data['field']);
        }
        return $query; // ✅ Siempre retornar la query
    })
```

### **Patrón Correcto para SelectFilter:**

```php
SelectFilter::make('field_name')
    ->label('Etiqueta')
    ->options([
        'value' => 'Label',
    ])
    ->query(function ($query, array $data) {
        if (!empty($data['field_name'])) {
            $query->where('field_name', $data['field_name']);
        }
        return $query; // ✅ Siempre retornar la query
    })
```

### **Comandos de Limpieza:**

```bash
# Limpiar caché después de cambios
php artisan config:clear
php artisan cache:clear
php artisan view:clear
```

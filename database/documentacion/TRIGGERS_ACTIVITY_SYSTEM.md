# Documentación de Triggers del Sistema de Activity Tables

## Introducción

Este documento explica el funcionamiento completo de los triggers implementados en el sistema de activity tables. Los triggers se han diseñado para mantener automáticamente la sincronización de datos entre las tablas `activity_logs` y `planned_metrics`, calculando valores en tiempo real sin intervención manual.

---

## Arquitectura del Sistema

### Tablas Involucradas:

-   **`activity_logs`**: Registra actividades realizadas
-   **`activity_calendars`**: Calendario de actividades planificadas
-   **`beneficiary_registries`**: Registro de beneficiarios por actividad
-   **`planned_metrics`**: Métricas planificadas vs realizadas
-   **`activities`**: Definición de actividades

### Relaciones Clave:

```
activity_logs
├── activity_calendar_id → activity_calendars.id
├── beneficiary_registry_id → beneficiary_registries.id
└── activity_id → activities.id (relaciona con planned_metrics)
```

---

## Funciones de Apoyo

### 1. `calculate_population_value(calendar_id)`

**Propósito**: Cuenta cuántos beneficiarios están registrados para un activity_calendar específico.

```sql
SELECT COUNT(br.id)
FROM beneficiary_registries br
WHERE br.activity_calendar_id = calendar_id
```

### 2. `calculate_population_real_value(activity_id)`

**Propósito**: Suma todos los `population_value` de los activity_logs asociados a una actividad.

```sql
SELECT COALESCE(SUM(al.population_value), 0)
FROM activity_logs al
WHERE al.activity_id = activity_id
```

### 3. `calculate_product_real_value(activity_id)`

**Propósito**: Suma todos los `product_value` de los activity_logs asociados a una actividad.

```sql
SELECT COALESCE(SUM(al.product_value), 0)
FROM activity_logs al
WHERE al.activity_id = activity_id
```

---

## Triggers Implementados

## 1. TRIGGERS EN `activity_logs`

### 1.1. `update_population_value_on_insert`

**Tipo**: BEFORE INSERT  
**Tabla**: activity_logs

#### ¿Cuándo se dispara?

-   Al insertar un nuevo registro en `activity_logs`

#### ¿Qué hace?

-   Verifica si `NEW.activity_calendar_id` no es NULL
-   Si no es NULL, calcula automáticamente `population_value` usando la función `calculate_population_value()`
-   Asigna el valor calculado a `NEW.population_value` antes de guardar el registro

#### Ejemplo de disparo:

```sql
INSERT INTO activity_logs (
    activity_calendar_id,
    beneficiary_registry_id,
    activity_id,
    product_value
) VALUES (
    5,    -- activity_calendar_id
    10,   -- beneficiary_registry_id
    3,    -- activity_id
    100   -- product_value
);
```

**Resultado**:

-   El trigger calcula cuántos beneficiarios tiene el activity_calendar #5
-   Automáticamente asigna ese valor a `population_value`
-   El registro se guarda con `population_value` calculado automáticamente

---

### 1.2. `update_population_value_on_update`

**Tipo**: BEFORE UPDATE  
**Tabla**: activity_logs

#### ¿Cuándo se dispara?

-   Al actualizar un registro existente en `activity_logs`
-   Solo cuando `activity_calendar_id` cambia o pasa de NULL a un valor

#### ¿Qué hace?

-   Compara `NEW.activity_calendar_id` con `OLD.activity_calendar_id`
-   Si son diferentes, o si el nuevo no es NULL y el anterior era NULL
-   Recalcula `population_value` con la nueva relación

#### Ejemplo de disparo:

```sql
UPDATE activity_logs
SET activity_calendar_id = 8
WHERE id = 15;
```

**Resultado**:

-   El trigger detecta que `activity_calendar_id` cambió de su valor anterior a 8
-   Recalcula `population_value` basado en los beneficiarios del activity_calendar #8
-   Actualiza automáticamente el campo antes de guardar

---

## 2. TRIGGERS EN `planned_metrics` (Disparados por cambios en `activity_logs`)

### 2.1. `update_planned_metrics_after_insert`

**Tipo**: AFTER INSERT  
**Tabla**: activity_logs (afecta planned_metrics)

#### ¿Cuándo se dispara?

-   Después de insertar un nuevo registro en `activity_logs`

#### ¿Qué hace?

-   Verifica si `NEW.activity_id` no es NULL
-   Busca el registro correspondiente en `planned_metrics` donde `pm.id = NEW.activity_id`
-   Recalcula y actualiza:
    -   `population_real_value`: suma de todos los `population_value` de activity_logs para esa actividad
    -   `product_real_value`: suma de todos los `product_value` de activity_logs para esa actividad

#### Ejemplo de disparo:

```sql
INSERT INTO activity_logs (
    activity_id,
    population_value,
    product_value
) VALUES (
    25,  -- activity_id
    50,  -- population_value
    200  -- product_value
);
```

**Resultado**:

-   Se actualiza automáticamente `planned_metrics` donde `id = 25`
-   `population_real_value` se recalcula sumando todos los activity_logs de la actividad #25
-   `product_real_value` se recalcula sumando todos los product_value de la actividad #25

---

### 2.2. `update_planned_metrics_after_update`

**Tipo**: AFTER UPDATE  
**Tabla**: activity_logs (afecta planned_metrics)

#### ¿Cuándo se dispara?

-   Después de actualizar un registro en `activity_logs`

#### ¿Qué hace?

-   **Para el nuevo `activity_id`**: Actualiza `planned_metrics` con los valores recalculados
-   **Para el `activity_id` anterior**: Si cambió, también actualiza esa métrica (porque ya no incluye este activity_log)

#### Ejemplo de disparo:

```sql
UPDATE activity_logs
SET
    activity_id = 30,     -- Cambió de 25 a 30
    product_value = 150   -- Cambió de 200 a 150
WHERE id = 10;
```

**Resultado**:

-   **Planned_metrics #30**: Se recalcula incluyendo este activity_log
-   **Planned_metrics #25**: Se recalcula excluyendo este activity_log
-   Ambas métricas quedan actualizadas correctamente

---

### 2.3. `update_planned_metrics_after_delete`

**Tipo**: AFTER DELETE  
**Tabla**: activity_logs (afecta planned_metrics)

#### ¿Cuándo se dispara?

-   Después de eliminar un registro de `activity_logs`

#### ¿Qué hace?

-   Verifica si `OLD.activity_id` no era NULL
-   Recalcula `planned_metrics` para esa actividad (sin incluir ya el registro eliminado)

#### Ejemplo de disparo:

```sql
DELETE FROM activity_logs WHERE id = 10;
-- Suponiendo que tenía activity_id = 25
```

**Resultado**:

-   `planned_metrics` #25 se recalcula automáticamente
-   Los valores `population_real_value` y `product_real_value` se ajustan sin el registro eliminado

---

## Flujos de Datos Automáticos

### Flujo 1: Nuevo Activity Log

```
1. INSERT INTO activity_logs (activity_calendar_id=5, activity_id=25, product_value=100)
   ↓
2. [BEFORE INSERT] update_population_value_on_insert
   - Calcula population_value = COUNT(beneficiarios de calendar #5)
   - Asigna valor (ej: 45)
   ↓
3. Registro se guarda: (calendar_id=5, activity_id=25, population_value=45, product_value=100)
   ↓
4. [AFTER INSERT] update_planned_metrics_after_insert
   - Actualiza planned_metrics #25:
     * population_real_value = SUM(todos los population_value de actividad #25)
     * product_real_value = SUM(todos los product_value de actividad #25)
```

### Flujo 2: Actualización de Activity Log

```
1. UPDATE activity_logs SET activity_id=30 WHERE id=10 (antes era activity_id=25)
   ↓
2. [BEFORE UPDATE] update_population_value_on_update
   - Si cambió activity_calendar_id, recalcula population_value
   ↓
3. Registro se actualiza
   ↓
4. [AFTER UPDATE] update_planned_metrics_after_update
   - Actualiza planned_metrics #30 (nueva actividad)
   - Actualiza planned_metrics #25 (actividad anterior)
   - Ambas quedan con valores correctos
```

### Flujo 3: Eliminación de Activity Log

```
1. DELETE FROM activity_logs WHERE id=10 (tenía activity_id=25)
   ↓
2. Registro se elimina
   ↓
3. [AFTER DELETE] update_planned_metrics_after_delete
   - Recalcula planned_metrics #25 sin incluir el registro eliminado
```

---

## Casos de Uso Prácticos

### Caso 1: Registrar una nueva actividad realizada

**Acción del usuario**: Crear un nuevo log de actividad desde la interfaz
**SQL generado**:

```sql
INSERT INTO activity_logs (
    activity_calendar_id,
    activity_id,
    product_value,
    description
) VALUES (12, 8, 75, 'Taller de capacitación realizado');
```

**Automático**:

-   `population_value` se calcula contando beneficiarios del calendar #12
-   `planned_metrics` #8 se actualiza con nuevos totales

### Caso 2: Corregir datos de una actividad

**Acción del usuario**: Editar un activity_log existente
**SQL generado**:

```sql
UPDATE activity_logs
SET product_value = 85
WHERE id = 20;
```

**Automático**:

-   `planned_metrics` se recalcula para reflejar el nuevo product_value

### Caso 3: Reasignar actividad a otra métrica

**Acción del usuario**: Cambiar a qué actividad pertenece un log
**SQL generado**:

```sql
UPDATE activity_logs
SET activity_id = 15
WHERE id = 20; -- antes tenía activity_id = 8
```

**Automático**:

-   `planned_metrics` #15 se actualiza incluyendo este log
-   `planned_metrics` #8 se actualiza excluyendo este log

### Caso 4: Eliminar registro erróneo

**Acción del usuario**: Eliminar un activity_log
**SQL generado**:

```sql
DELETE FROM activity_logs WHERE id = 20;
```

**Automático**:

-   `planned_metrics` se ajusta automáticamente

---

## Ventajas del Sistema

### 1. **Automatización Total**

-   No requiere cálculos manuales
-   Los valores siempre están actualizados
-   Elimina errores humanos en cálculos

### 2. **Consistencia de Datos**

-   Los triggers aseguran que `planned_metrics` siempre refleje la realidad
-   No hay riesgo de datos desincronizados

### 3. **Transparencia**

-   Los usuarios no necesitan saber de la existencia de los triggers
-   Todo funciona "mágicamente" desde su perspectiva

### 4. **Rendimiento**

-   Los cálculos se realizan solo cuando es necesario
-   No hay overhead de recálculo innecesario

---

## Consideraciones Técnicas

### Orden de Ejecución

1. **BEFORE triggers** se ejecutan antes de la operación
2. **La operación** (INSERT/UPDATE/DELETE) se realiza
3. **AFTER triggers** se ejecutan después de la operación

### Transacciones

-   Si un trigger falla, toda la transacción se revierte
-   Esto asegura consistencia incluso en caso de errores

### Rendimiento

-   Los triggers son muy eficientes para operaciones individuales
-   Para operaciones masivas, considerar deshabilitar temporalmente

---

## Mantenimiento y Monitoreo

### Verificar que los triggers estén activos:

```sql
SHOW TRIGGERS LIKE 'activity_logs';
```

### Verificar funciones:

```sql
SHOW FUNCTION STATUS WHERE Name LIKE 'calculate_%';
```

### Pruebas de funcionamiento:

```sql
-- Insertar un registro de prueba
INSERT INTO activity_logs (activity_calendar_id, activity_id, product_value)
VALUES (1, 1, 50);

-- Verificar que planned_metrics se actualizó
SELECT * FROM planned_metrics WHERE id = 1;
```

---

Este sistema de triggers asegura que los datos estén siempre sincronizados y actualizados en tiempo real, proporcionando una experiencia transparente para los usuarios del sistema.

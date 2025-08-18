# Ejemplos Prácticos de Triggers en Activity System

## Escenarios Reales de Uso

Este documento muestra ejemplos prácticos de cómo se comportan los triggers en situaciones reales del sistema.

---

## Ejemplo 1: Registro de Nueva Actividad Realizada

### Situación:

El usuario registra que se realizó un "Taller de Capacitación" con 25 participantes, asociado al calendar #5 y a la actividad #12.

### Operación:

```sql
INSERT INTO activity_logs (
    activity_calendar_id,
    activity_id,
    product_value,
    description,
    created_at
) VALUES (
    5,                           -- calendar de la actividad
    12,                          -- actividad planificada
    25,                          -- 25 productos/servicios entregados
    'Taller de Capacitación',
    NOW()
);
```

### ¿Qué sucede automáticamente?

#### 1. BEFORE INSERT - `update_population_value_on_insert`

```sql
-- El trigger ejecuta internamente:
SELECT COUNT(br.id)
FROM beneficiary_registries br
WHERE br.activity_calendar_id = 5;

-- Supongamos que retorna 45 beneficiarios registrados
-- Entonces asigna: NEW.population_value = 45
```

#### 2. El registro se guarda con:

```sql
{
    id: 100,
    activity_calendar_id: 5,
    activity_id: 12,
    population_value: 45,        -- ¡Calculado automáticamente!
    product_value: 25,
    description: 'Taller de Capacitación',
    created_at: '2025-01-21 10:30:00'
}
```

#### 3. AFTER INSERT - `update_planned_metrics_after_insert`

```sql
-- El trigger ejecuta internamente:
UPDATE planned_metrics
SET
    population_real_value = (
        SELECT COALESCE(SUM(al.population_value), 0)
        FROM activity_logs al
        WHERE al.activity_id = 12
    ),
    product_real_value = (
        SELECT COALESCE(SUM(al.product_value), 0)
        FROM activity_logs al
        WHERE al.activity_id = 12
    )
WHERE id = 12;

-- Si antes había: population_real_value = 120, product_real_value = 80
-- Ahora queda: population_real_value = 165, product_real_value = 105
```

### Resultado Final:

-   ✅ `activity_logs` tiene un nuevo registro con `population_value` calculado automáticamente
-   ✅ `planned_metrics` #12 está actualizado con los nuevos totales acumulados

---

## Ejemplo 2: Corrección de Datos

### Situación:

El usuario se da cuenta que registró mal el número de productos entregados. Debe cambiar de 25 a 30.

### Operación:

```sql
UPDATE activity_logs
SET product_value = 30
WHERE id = 100;
```

### ¿Qué sucede automáticamente?

#### 1. BEFORE UPDATE - `update_population_value_on_update`

```sql
-- Como activity_calendar_id no cambió, el trigger no hace nada
-- population_value se mantiene en 45
```

#### 2. El registro se actualiza:

```sql
{
    id: 100,
    activity_calendar_id: 5,
    activity_id: 12,
    population_value: 45,        -- Sin cambios
    product_value: 30,           -- ¡Actualizado!
    description: 'Taller de Capacitación'
}
```

#### 3. AFTER UPDATE - `update_planned_metrics_after_update`

```sql
-- El trigger recalcula planned_metrics #12:
UPDATE planned_metrics
SET
    population_real_value = 165,    -- Sin cambios
    product_real_value = 110        -- Cambió de 105 a 110 (+5)
WHERE id = 12;
```

### Resultado Final:

-   ✅ El `product_value` se corrigió de 25 a 30
-   ✅ `planned_metrics` #12 refleja automáticamente el cambio (+5 en product_real_value)

---

## Ejemplo 3: Reasignación de Actividad

### Situación:

El usuario se da cuenta que el taller corresponde a otra actividad planificada. Debe cambiar de actividad #12 a actividad #15.

### Operación:

```sql
UPDATE activity_logs
SET activity_id = 15
WHERE id = 100;
```

### ¿Qué sucede automáticamente?

#### 1. BEFORE UPDATE - `update_population_value_on_update`

```sql
-- Como activity_calendar_id no cambió, no hace nada
```

#### 2. El registro se actualiza:

```sql
{
    id: 100,
    activity_calendar_id: 5,
    activity_id: 15,             -- ¡Cambió de 12 a 15!
    population_value: 45,
    product_value: 30
}
```

#### 3. AFTER UPDATE - `update_planned_metrics_after_update`

```sql
-- Actualiza la NUEVA actividad #15:
UPDATE planned_metrics
SET
    population_real_value = (SUM de todos los activity_logs con activity_id = 15),
    product_real_value = (SUM de todos los activity_logs con activity_id = 15)
WHERE id = 15;

-- Actualiza la ANTERIOR actividad #12:
UPDATE planned_metrics
SET
    population_real_value = (SUM de todos los activity_logs con activity_id = 12),
    product_real_value = (SUM de todos los activity_logs con activity_id = 12)
WHERE id = 12;
```

### Resultado Final:

-   ✅ El activity_log ahora pertenece a la actividad #15
-   ✅ `planned_metrics` #15 incluye estos valores (population: +45, product: +30)
-   ✅ `planned_metrics` #12 excluye estos valores (population: -45, product: -30)

---

## Ejemplo 4: Cambio de Calendar (Beneficiarios)

### Situación:

El usuario se da cuenta que asoció el taller al calendar incorrecto. Debe cambiar de calendar #5 a calendar #8.

### Operación:

```sql
UPDATE activity_logs
SET activity_calendar_id = 8
WHERE id = 100;
```

### ¿Qué sucede automáticamente?

#### 1. BEFORE UPDATE - `update_population_value_on_update`

```sql
-- Detecta que activity_calendar_id cambió de 5 a 8
-- Recalcula population_value:

SELECT COUNT(br.id)
FROM beneficiary_registries br
WHERE br.activity_calendar_id = 8;

-- Supongamos que retorna 60 beneficiarios
-- Asigna: NEW.population_value = 60
```

#### 2. El registro se actualiza:

```sql
{
    id: 100,
    activity_calendar_id: 8,     -- ¡Cambió de 5 a 8!
    activity_id: 15,
    population_value: 60,        -- ¡Recalculado de 45 a 60!
    product_value: 30
}
```

#### 3. AFTER UPDATE - `update_planned_metrics_after_update`

```sql
-- Actualiza planned_metrics #15 con el nuevo population_value:
UPDATE planned_metrics
SET
    population_real_value = (nuevo total que incluye 60 en lugar de 45),
    product_real_value = (sin cambios)
WHERE id = 15;
```

### Resultado Final:

-   ✅ El activity_log ahora está asociado al calendar #8
-   ✅ `population_value` se recalculó basado en los beneficiarios del calendar #8
-   ✅ `planned_metrics` #15 refleja el nuevo total de población

---

## Ejemplo 5: Eliminación de Registro Erróneo

### Situación:

El usuario elimina un registro que se creó por error.

### Estado antes de la eliminación:

```sql
-- planned_metrics #15 tiene:
{
    id: 15,
    population_real_value: 150,  -- incluye nuestros 60
    product_real_value: 85       -- incluye nuestros 30
}
```

### Operación:

```sql
DELETE FROM activity_logs WHERE id = 100;
```

### ¿Qué sucede automáticamente?

#### 1. El registro se elimina

#### 2. AFTER DELETE - `update_planned_metrics_after_delete`

```sql
-- Recalcula planned_metrics #15 SIN incluir el registro eliminado:
UPDATE planned_metrics
SET
    population_real_value = (
        SELECT COALESCE(SUM(al.population_value), 0)
        FROM activity_logs al
        WHERE al.activity_id = 15  -- ya no incluye el registro id=100
    ),
    product_real_value = (
        SELECT COALESCE(SUM(al.product_value), 0)
        FROM activity_logs al
        WHERE al.activity_id = 15  -- ya no incluye el registro id=100
    )
WHERE id = 15;
```

### Resultado Final:

```sql
-- planned_metrics #15 queda:
{
    id: 15,
    population_real_value: 90,   -- 150 - 60 = 90
    product_real_value: 55       -- 85 - 30 = 55
}
```

-   ✅ El registro se eliminó completamente
-   ✅ `planned_metrics` #15 se ajustó automáticamente restando los valores del registro eliminado

---

## Ejemplo 6: Operación Masiva

### Situación:

El usuario importa múltiples registros desde un Excel con 50 actividades realizadas.

### Operación:

```sql
INSERT INTO activity_logs (activity_calendar_id, activity_id, product_value) VALUES
(1, 5, 10),
(1, 5, 15),
(2, 7, 20),
(2, 7, 25),
-- ... 46 registros más
(3, 12, 30);
```

### ¿Qué sucede automáticamente?

#### Para cada INSERT:

1. **BEFORE INSERT**: Calcula `population_value` basado en el `activity_calendar_id`
2. **AFTER INSERT**: Actualiza el `planned_metrics` correspondiente

#### Resultado:

-   ✅ Los 50 registros tienen `population_value` calculado automáticamente
-   ✅ Todas las `planned_metrics` afectadas están actualizadas con los nuevos totales
-   ✅ Todo sucede de forma transparente sin intervención manual

---

## Ventajas Evidentes

### 1. **Cero Intervención Manual**

```sql
-- El usuario solo hace esto:
INSERT INTO activity_logs (activity_calendar_id, activity_id, product_value)
VALUES (5, 12, 25);

-- El sistema automáticamente garantiza:
-- ✓ population_value calculado correctamente
-- ✓ planned_metrics actualizado
-- ✓ Datos siempre consistentes
```

### 2. **Corrección Automática de Errores**

Si el usuario comete un error y lo corrige, el sistema se ajusta automáticamente sin cálculos manuales.

### 3. **Integridad Garantizada**

Es imposible tener `planned_metrics` desactualizado porque los triggers se ejecutan en cada operación.

### 4. **Transparencia Total**

Los usuarios no necesitan saber que existen triggers. Todo "simplemente funciona".

---

## Monitoreo en Tiempo Real

Para verificar que los triggers están funcionando correctamente:

```sql
-- Ver el estado actual de una métrica planificada
SELECT
    pm.*,
    (SELECT COUNT(*) FROM activity_logs al WHERE al.activity_id = pm.id) as logs_count,
    (SELECT SUM(al.population_value) FROM activity_logs al WHERE al.activity_id = pm.id) as calc_population,
    (SELECT SUM(al.product_value) FROM activity_logs al WHERE al.activity_id = pm.id) as calc_product
FROM planned_metrics pm
WHERE id = 12;

-- Los valores calc_population y calc_product deben coincidir exactamente
-- con population_real_value y product_real_value
```

Este sistema asegura que los datos estén siempre sincronizados y actualizados, proporcionando confiabilidad total en los reportes y métricas del sistema.

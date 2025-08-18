# Referencia Rápida - Triggers Activity System

## 🚀 Resumen Ejecutivo

Los triggers mantienen automáticamente sincronizados los datos entre `activity_logs` y `planned_metrics`. **No requieren intervención manual del desarrollador.**

---

## 📋 Lista de Triggers Activos

| Trigger                               | Tabla         | Momento       | Propósito                                                     |
| ------------------------------------- | ------------- | ------------- | ------------------------------------------------------------- |
| `update_population_value_on_insert`   | activity_logs | BEFORE INSERT | Calcula `population_value` automáticamente                    |
| `update_population_value_on_update`   | activity_logs | BEFORE UPDATE | Recalcula `population_value` si cambia `activity_calendar_id` |
| `update_planned_metrics_after_insert` | activity_logs | AFTER INSERT  | Actualiza `planned_metrics` al agregar nuevo log              |
| `update_planned_metrics_after_update` | activity_logs | AFTER UPDATE  | Actualiza `planned_metrics` al modificar log existente        |
| `update_planned_metrics_after_delete` | activity_logs | AFTER DELETE  | Actualiza `planned_metrics` al eliminar log                   |

---

## 🔧 Funciones de Apoyo

| Función                                        | Parámetro | Retorna | Uso                                 |
| ---------------------------------------------- | --------- | ------- | ----------------------------------- |
| `calculate_population_value(calendar_id)`      | BIGINT    | INT     | Cuenta beneficiarios por calendar   |
| `calculate_population_real_value(activity_id)` | BIGINT    | INT     | Suma population_value por actividad |
| `calculate_product_real_value(activity_id)`    | BIGINT    | INT     | Suma product_value por actividad    |

---

## ⚡ Campos Auto-calculados

### En `activity_logs`:

-   **`population_value`**: Se calcula automáticamente al insertar/actualizar si `activity_calendar_id` está presente

### En `planned_metrics`:

-   **`population_real_value`**: Se actualiza automáticamente cuando cambian los `activity_logs` relacionados
-   **`product_real_value`**: Se actualiza automáticamente cuando cambian los `activity_logs` relacionados

---

## 🎯 Operaciones Que Disparan Triggers

### ✅ Estas operaciones son automáticas:

```sql
-- INSERT: Calcula population_value y actualiza planned_metrics
INSERT INTO activity_logs (activity_calendar_id, activity_id, product_value) VALUES (5, 12, 25);

-- UPDATE: Recalcula valores según qué campos cambien
UPDATE activity_logs SET product_value = 30 WHERE id = 100;
UPDATE activity_logs SET activity_calendar_id = 8 WHERE id = 100;
UPDATE activity_logs SET activity_id = 15 WHERE id = 100;

-- DELETE: Ajusta planned_metrics restando los valores eliminados
DELETE FROM activity_logs WHERE id = 100;
```

### ⚠️ Campos que NO debes actualizar manualmente:

-   `activity_logs.population_value` → Calculado automáticamente
-   `planned_metrics.population_real_value` → Calculado automáticamente
-   `planned_metrics.product_real_value` → Calculado automáticamente

---

## 🔍 Verificación Rápida

### Comprobar que los triggers están activos:

```sql
SHOW TRIGGERS LIKE 'activity_logs';
```

### Comprobar que las funciones existen:

```sql
SHOW FUNCTION STATUS WHERE Name LIKE 'calculate_%';
```

### Verificar datos sincronizados:

```sql
SELECT
    pm.id,
    pm.population_real_value,
    pm.product_real_value,
    COALESCE(SUM(al.population_value), 0) as calc_population,
    COALESCE(SUM(al.product_value), 0) as calc_product
FROM planned_metrics pm
LEFT JOIN activity_logs al ON al.activity_id = pm.id
GROUP BY pm.id
HAVING pm.population_real_value != calc_population
    OR pm.product_real_value != calc_product;
-- Esta query NO debe retornar filas (todos deben estar sincronizados)
```

---

## 🚨 Resolución de Problemas

### Problema: Los valores no se actualizan

**Verificar:**

1. Que los triggers estén activos: `SHOW TRIGGERS LIKE 'activity_logs';`
2. Que las funciones existan: `SHOW FUNCTION STATUS WHERE Name LIKE 'calculate_%';`
3. Que las FK estén correctas: `SELECT * FROM activity_logs WHERE activity_id IS NOT NULL LIMIT 5;`

### Problema: Error en triggers

**Consultar logs:**

```sql
SHOW ENGINE INNODB STATUS; -- Ver errores recientes
```

### Recalculo manual (solo si es necesario):

```sql
-- Solo usar en emergencias - los triggers lo hacen automáticamente
UPDATE planned_metrics pm
SET
    population_real_value = COALESCE((
        SELECT SUM(al.population_value)
        FROM activity_logs al
        WHERE al.activity_id = pm.id
    ), 0),
    product_real_value = COALESCE((
        SELECT SUM(al.product_value)
        FROM activity_logs al
        WHERE al.activity_id = pm.id
    ), 0);
```

---

## 📱 Para el Frontend (Filament/Laravel)

### Los triggers son transparentes:

```php
// Esto dispara automáticamente todos los cálculos:
ActivityLog::create([
    'activity_calendar_id' => 5,
    'activity_id' => 12,
    'product_value' => 25,
    'description' => 'Taller realizado'
]);

// No necesitas hacer cálculos manuales
// population_value se calcula automáticamente
// planned_metrics se actualiza automáticamente
```

### Para mostrar datos en tiempo real:

```php
// Los valores siempre están actualizados
$plannedMetric = PlannedMetric::find(12);
echo $plannedMetric->population_real_value; // Siempre correcto
echo $plannedMetric->product_real_value;    // Siempre correcto
```

---

## 🎮 Comandos de Artisan Útiles

### Verificar migraciones aplicadas:

```bash
php artisan migrate:status | grep "activity"
```

### Revisar estructura de tablas:

```bash
php artisan tinker
> DB::select('DESCRIBE activity_logs');
> DB::select('DESCRIBE planned_metrics');
```

---

## 🔒 Consideraciones de Seguridad

### ✅ Seguro hacer:

-   INSERT, UPDATE, DELETE normales en `activity_logs`
-   Consultas de lectura en cualquier tabla
-   Operaciones masivas (los triggers manejan c/registro)

### ⚠️ Cuidado con:

-   Actualizaciones directas a campos calculados
-   Deshabilitar triggers sin saber el impacto
-   Operaciones masivas sin transacciones

### 🚫 Nunca hacer:

-   `UPDATE activity_logs SET population_value = X` (manual)
-   `UPDATE planned_metrics SET population_real_value = X` (manual)
-   `DROP TRIGGER` sin coordinar con el equipo

---

## 📊 Métricas de Rendimiento

Los triggers son **muy eficientes** para operaciones normales:

-   INSERT simple: ~1-2ms overhead
-   UPDATE simple: ~1-3ms overhead
-   DELETE simple: ~1-2ms overhead

Para operaciones masivas (>1000 registros), considera usar transacciones:

```php
DB::transaction(function () {
    // Múltiples operaciones en activity_logs
    // Los triggers se ejecutan pero en una sola transacción
});
```

---

## 🆘 Contacto y Soporte

Si encuentras problemas con los triggers:

1. Verifica la documentación completa en `TRIGGERS_ACTIVITY_SYSTEM.md`
2. Revisa ejemplos en `EJEMPLOS_TRIGGERS.md`
3. Ejecuta las verificaciones de esta guía
4. Si el problema persiste, contacta al equipo de desarrollo

---

**🎯 Recuerda**: Los triggers están diseñados para que **no tengas que pensar en ellos**. Simplemente trabaja con `activity_logs` normalmente y todo se mantiene sincronizado automáticamente.

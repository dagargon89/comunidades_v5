-- Script de verificación para las actualizaciones de Activity Tables
-- Ejecutar después de aplicar las migraciones

-- 1. Verificar que las columnas se agregaron a activity_logs
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'activity_logs'
    AND COLUMN_NAME IN (
        'activity_calendar_id',
        'beneficiary_registry_id',
        'activity_id',
        'population_value',
        'product_value'
    )
ORDER BY COLUMN_NAME;

-- 2. Verificar que las FK se crearon correctamente
SELECT
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME,
    DELETE_RULE,
    UPDATE_RULE
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc ON kcu.CONSTRAINT_NAME = rc.CONSTRAINT_NAME
WHERE
    kcu.TABLE_NAME = 'activity_logs'
    AND kcu.CONSTRAINT_NAME LIKE 'fk_activity_logs_%'
ORDER BY CONSTRAINT_NAME;

-- 3. Verificar que las funciones se crearon
SELECT
    ROUTINE_NAME,
    ROUTINE_TYPE,
    DATA_TYPE as RETURN_TYPE
FROM INFORMATION_SCHEMA.ROUTINES
WHERE
    ROUTINE_NAME IN (
        'calculate_population_value',
        'calculate_population_real_value',
        'calculate_product_real_value'
    )
ORDER BY ROUTINE_NAME;

-- 4. Verificar que los triggers se crearon
SELECT
    TRIGGER_NAME,
    EVENT_MANIPULATION,
    ACTION_TIMING,
    ACTION_STATEMENT
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE
    TRIGGER_NAME IN (
        'update_population_value_on_insert',
        'update_population_value_on_update',
        'update_planned_metrics_after_insert',
        'update_planned_metrics_after_update',
        'update_planned_metrics_after_delete'
    )
ORDER BY TRIGGER_NAME;

-- 5. Probar las funciones (si hay datos)
-- SELECT calculate_population_value(1) as test_population;
-- SELECT calculate_population_real_value(1) as test_population_real;
-- SELECT calculate_product_real_value(1) as test_product_real;

-- 6. Verificar datos en activity_logs (muestra las primeras 5 filas)
SELECT
    id,
    activity_calendar_id,
    beneficiary_registry_id,
    activity_id,
    population_value,
    product_value,
    created_at
FROM activity_logs
LIMIT 5;

-- 7. Verificar datos en planned_metrics (muestra las primeras 5 filas)
SELECT
    id,
    population_real_value,
    product_real_value,
    updated_at
FROM planned_metrics
LIMIT 5;
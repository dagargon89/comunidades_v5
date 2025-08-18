# Actualizaciones de Activity Tables

Este directorio contiene las migraciones necesarias para implementar las actualizaciones al sistema de activity tables según el script original `Actualizaciones a activity tables.sql`.

## Migraciones Creadas

Las migraciones se ejecutan en el siguiente orden:

1. **2025_01_21_001000_add_fk_columns_to_activity_logs.php**

    - Agrega columnas FK: `activity_calendar_id`, `beneficiary_registry_id`, `activity_id`

2. **2025_01_21_002000_add_value_columns_to_activity_logs.php**

    - Agrega columnas: `population_value` (default 0), `product_value` (nullable)

3. **2025_01_21_003000_add_foreign_keys_to_activity_logs.php**

    - Crea restricciones FK con los nombres exactos del script original
    - Configuración ON DELETE/UPDATE según especificaciones

4. **2025_01_21_004000_create_activity_calculation_functions.php**

    - Funciones: `calculate_population_value`, `calculate_population_real_value`, `calculate_product_real_value`

5. **2025_01_21_005000_update_existing_activity_records.php**

    - Actualiza registros existentes con valores calculados

6. **2025_01_21_006000_create_activity_triggers.php**
    - Crea todos los triggers automáticos para mantener datos sincronizados

## Instrucciones de Uso

### Opción 1: Ejecutar todas las migraciones de una vez

```bash
php artisan migrate
```

### Opción 2: Ejecutar paso a paso (recomendado para producción)

```bash
# Paso 1: Columnas FK
php artisan migrate --path=database/migrations/2025_01_21_001000_add_fk_columns_to_activity_logs.php

# Paso 2: Columnas de valores
php artisan migrate --path=database/migrations/2025_01_21_002000_add_value_columns_to_activity_logs.php

# Paso 3: Restricciones FK
php artisan migrate --path=database/migrations/2025_01_21_003000_add_foreign_keys_to_activity_logs.php

# Paso 4: Funciones SQL
php artisan migrate --path=database/migrations/2025_01_21_004000_create_activity_calculation_functions.php

# Paso 5: Actualizar datos
php artisan migrate --path=database/migrations/2025_01_21_005000_update_existing_activity_records.php

# Paso 6: Triggers
php artisan migrate --path=database/migrations/2025_01_21_006000_create_activity_triggers.php
```

### Opción 3: Usar el script automatizado

```bash
# Para base local
chmod +x database/scripts/run_activity_updates.sh
./database/scripts/run_activity_updates.sh local

# Para producción
./database/scripts/run_activity_updates.sh production
```

## Verificación

Después de aplicar las migraciones, ejecuta el script de verificación:

```sql
-- Conectarse a la base de datos y ejecutar:
source database/scripts/verify_activity_updates.sql;
```

O desde MySQL/phpMyAdmin, ejecuta el contenido del archivo `verify_activity_updates.sql`.

## Rollback (En caso de problemas)

Para revertir los cambios:

```bash
# Revertir en orden inverso
php artisan migrate:rollback --path=database/migrations/2025_01_21_006000_create_activity_triggers.php
php artisan migrate:rollback --path=database/migrations/2025_01_21_005000_update_existing_activity_records.php
php artisan migrate:rollback --path=database/migrations/2025_01_21_004000_create_activity_calculation_functions.php
php artisan migrate:rollback --path=database/migrations/2025_01_21_003000_add_foreign_keys_to_activity_logs.php
php artisan migrate:rollback --path=database/migrations/2025_01_21_002000_add_value_columns_to_activity_logs.php
php artisan migrate:rollback --path=database/migrations/2025_01_21_001000_add_fk_columns_to_activity_logs.php
```

## Flujo Recomendado

1. **Backup de las bases de datos** (planeacion y producción)
2. **Aplicar en local primero** (base planeacion)
3. **Ejecutar verificaciones** y pruebas
4. **Si todo está correcto, aplicar en producción**
5. **Verificar funcionamiento en producción**

## Notas Importantes

-   Las migraciones implementan exactamente el mismo comportamiento que el script SQL original
-   Los nombres de funciones, triggers y constraints son idénticos
-   Se mantiene la misma lógica de cálculo y actualización automática
-   Los triggers aseguran que los datos se mantengan sincronizados automáticamente

## Funcionalidad Implementada

-   **Nuevas relaciones**: activity_logs se relaciona con activity_calendars, beneficiary_registries y activities
-   **Cálculos automáticos**: population_value se calcula automáticamente basado en beneficiary_registries
-   **Sincronización**: planned_metrics se actualiza automáticamente cuando cambian los activity_logs
-   **Integridad**: Las FK aseguran consistencia de datos con las políticas de eliminación/actualización apropiadas

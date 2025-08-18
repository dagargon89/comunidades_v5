#!/bin/bash

# Script para aplicar las actualizaciones de activity tables
# Uso: ./run_activity_updates.sh [local|production]

ENVIRONMENT=${1:-local}

echo "=== Aplicando actualizaciones de Activity Tables ==="
echo "Entorno: $ENVIRONMENT"
echo ""

if [ "$ENVIRONMENT" = "local" ]; then
    echo "Ejecutando en base de datos LOCAL (planeacion)..."
    APP_ENV=local
elif [ "$ENVIRONMENT" = "production" ]; then
    echo "Ejecutando en base de datos de PRODUCCIÓN..."
    echo "⚠️  ADVERTENCIA: Esto afectará la base de datos de producción"
    read -p "¿Estás seguro? (y/N): " confirm
    if [[ $confirm != [yY] ]]; then
        echo "Operación cancelada."
        exit 1
    fi
    APP_ENV=production
else
    echo "Uso: $0 [local|production]"
    exit 1
fi

echo ""
echo "Paso 1: Agregando columnas FK a activity_logs..."
php artisan migrate --path=database/migrations/2025_01_21_001000_add_fk_columns_to_activity_logs.php --force

echo ""
echo "Paso 2: Agregando columnas de valores a activity_logs..."
php artisan migrate --path=database/migrations/2025_01_21_002000_add_value_columns_to_activity_logs.php --force

echo ""
echo "Paso 3: Agregando restricciones FK..."
php artisan migrate --path=database/migrations/2025_01_21_003000_add_foreign_keys_to_activity_logs.php --force

echo ""
echo "Paso 4: Creando funciones de cálculo..."
php artisan migrate --path=database/migrations/2025_01_21_004000_create_activity_calculation_functions.php --force

echo ""
echo "Paso 5: Actualizando registros existentes..."
php artisan migrate --path=database/migrations/2025_01_21_005000_update_existing_activity_records.php --force

echo ""
echo "Paso 6: Creando triggers automáticos..."
php artisan migrate --path=database/migrations/2025_01_21_006000_create_activity_triggers.php --force

echo ""
echo "✅ Todas las actualizaciones se han aplicado correctamente."
echo "Las tablas activity_logs y planned_metrics ahora tienen:"
echo "  - Nuevas columnas FK en activity_logs"
echo "  - Columnas population_value y product_value en activity_logs"
echo "  - Restricciones de integridad referencial"
echo "  - Funciones de cálculo automático"
echo "  - Triggers para mantener datos sincronizados"
echo ""
echo "Verifica que todo funcione correctamente antes de aplicar en producción."

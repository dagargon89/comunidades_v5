<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 5: Actualizar registros existentes con valores calculados

        // Actualizar population_value en activity_logs
        DB::statement('
            UPDATE activity_logs al
            SET population_value = calculate_population_value(al.activity_calendar_id)
            WHERE al.activity_calendar_id IS NOT NULL
        ');

        // Actualizar planned_metrics con valores reales calculados
        DB::statement('
            UPDATE planned_metrics pm
            SET
                population_real_value = calculate_population_real_value(pm.id),
                product_real_value = calculate_product_real_value(pm.id)
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Resetear valores a cero o null
        DB::statement('
            UPDATE activity_logs
            SET population_value = 0
        ');

        DB::statement('
            UPDATE planned_metrics
            SET
                population_real_value = NULL,
                product_real_value = NULL
        ');
    }
};

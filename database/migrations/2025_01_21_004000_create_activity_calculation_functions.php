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
        // 4: Crear funciones para valores calculados

        // Función para calcular population_value (conteo de beneficiary_registries)
        DB::statement('
            CREATE FUNCTION calculate_population_value(calendar_id BIGINT)
            RETURNS INT
            READS SQL DATA
            DETERMINISTIC
            BEGIN
                DECLARE pop_count INT DEFAULT 0;

                SELECT COUNT(br.id) INTO pop_count
                FROM beneficiary_registries br
                WHERE br.activity_calendar_id = calendar_id;

                RETURN pop_count;
            END
        ');

        // Calcular population_real_value para planned_metrics
        DB::statement('
            CREATE FUNCTION calculate_population_real_value(activity_id BIGINT)
            RETURNS INT
            READS SQL DATA
            DETERMINISTIC
            BEGIN
                DECLARE total_pop INT DEFAULT 0;

                SELECT COALESCE(SUM(al.population_value), 0) INTO total_pop
                FROM activity_logs al
                WHERE al.activity_id = activity_id;

                RETURN total_pop;
            END
        ');

        // Calcular product_real_value para planned_metrics
        DB::statement('
            CREATE FUNCTION calculate_product_real_value(activity_id BIGINT)
            RETURNS INT
            READS SQL DATA
            DETERMINISTIC
            BEGIN
                DECLARE total_prod INT DEFAULT 0;

                SELECT COALESCE(SUM(al.product_value), 0) INTO total_prod
                FROM activity_logs al
                WHERE al.activity_id = activity_id;

                RETURN total_prod;
            END
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement('DROP FUNCTION IF EXISTS calculate_population_value');
        DB::statement('DROP FUNCTION IF EXISTS calculate_population_real_value');
        DB::statement('DROP FUNCTION IF EXISTS calculate_product_real_value');
    }
};

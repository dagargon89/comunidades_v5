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
        // 6: Triggers para actualizaciones automáticas
        // Triggers para la tabla activity_logs

        DB::statement('
            CREATE TRIGGER update_population_value_on_insert
                BEFORE INSERT ON activity_logs
                FOR EACH ROW
            BEGIN
                IF NEW.activity_calendar_id IS NOT NULL THEN
                    SET NEW.population_value = calculate_population_value(NEW.activity_calendar_id);
                END IF;
            END
        ');

        DB::statement('
            CREATE TRIGGER update_population_value_on_update
                BEFORE UPDATE ON activity_logs
                FOR EACH ROW
            BEGIN
                IF NEW.activity_calendar_id != OLD.activity_calendar_id
                   OR (NEW.activity_calendar_id IS NOT NULL AND OLD.activity_calendar_id IS NULL) THEN
                    SET NEW.population_value = calculate_population_value(NEW.activity_calendar_id);
                END IF;
            END
        ');

        // Trigger para actualizar planned_metrics cuando activity_logs cambia
        DB::statement('
            CREATE TRIGGER update_planned_metrics_after_insert
                AFTER INSERT ON activity_logs
                FOR EACH ROW
            BEGIN
                IF NEW.activity_id IS NOT NULL THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(NEW.activity_id),
                        product_real_value = calculate_product_real_value(NEW.activity_id)
                    WHERE pm.id = NEW.activity_id;
                END IF;
            END
        ');

        DB::statement('
            CREATE TRIGGER update_planned_metrics_after_update
                AFTER UPDATE ON activity_logs
                FOR EACH ROW
            BEGIN
                -- Actualizar para el nuevo activity_id
                IF NEW.activity_id IS NOT NULL THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(NEW.activity_id),
                        product_real_value = calculate_product_real_value(NEW.activity_id)
                    WHERE pm.id = NEW.activity_id;
                END IF;

                -- Actualizar para el activity_id anterior si era diferente
                IF OLD.activity_id IS NOT NULL AND OLD.activity_id != NEW.activity_id THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(OLD.activity_id),
                        product_real_value = calculate_product_real_value(OLD.activity_id)
                    WHERE pm.id = OLD.activity_id;
                END IF;
            END
        ');

        DB::statement('
            CREATE TRIGGER update_planned_metrics_after_delete
                AFTER DELETE ON activity_logs
                FOR EACH ROW
            BEGIN
                IF OLD.activity_id IS NOT NULL THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(OLD.activity_id),
                        product_real_value = calculate_product_real_value(OLD.activity_id)
                    WHERE pm.id = OLD.activity_id;
                END IF;
            END
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement('DROP TRIGGER IF EXISTS update_population_value_on_insert');
        DB::statement('DROP TRIGGER IF EXISTS update_population_value_on_update');
        DB::statement('DROP TRIGGER IF EXISTS update_planned_metrics_after_insert');
        DB::statement('DROP TRIGGER IF EXISTS update_planned_metrics_after_update');
        DB::statement('DROP TRIGGER IF EXISTS update_planned_metrics_after_delete');
    }
};

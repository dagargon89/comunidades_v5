<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 3: Agregar restricciones de FKs
        // Usamos DB::statement para mantener exactamente los nombres y comportamientos del script original

        DB::statement('
            ALTER TABLE activity_logs
            ADD CONSTRAINT fk_activity_logs_calendar
                FOREIGN KEY (activity_calendar_id) REFERENCES activity_calendars(id)
                ON DELETE SET NULL ON UPDATE CASCADE
        ');

        DB::statement('
            ALTER TABLE activity_logs
            ADD CONSTRAINT fk_activity_logs_beneficiary
                FOREIGN KEY (beneficiary_registry_id) REFERENCES beneficiary_registries(id)
                ON DELETE SET NULL ON UPDATE CASCADE
        ');

        DB::statement('
            ALTER TABLE activity_logs
            ADD CONSTRAINT fk_activity_logs_activity
                FOREIGN KEY (activity_id) REFERENCES activities(id)
                ON DELETE CASCADE ON UPDATE CASCADE
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('activity_logs', function (Blueprint $table) {
            $table->dropForeign('fk_activity_logs_calendar');
            $table->dropForeign('fk_activity_logs_beneficiary');
            $table->dropForeign('fk_activity_logs_activity');
        });
    }
};

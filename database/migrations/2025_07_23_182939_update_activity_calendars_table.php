<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // 1. Corregir el nombre de la columna asigned_person -> assigned_person
        if (Schema::hasColumn('activity_calendars', 'asigned_person')) {
            Schema::table('activity_calendars', function (Blueprint $table) {
                $table->renameColumn('asigned_person', 'assigned_person');
            });
        }

        // 2. Agregar columna location_id (opcional)
        if (!Schema::hasColumn('activity_calendars', 'location_id')) {
            Schema::table('activity_calendars', function (Blueprint $table) {
                $table->foreignId('location_id')->nullable()->after('assigned_person')->constrained('locations')->nullOnDelete();
            });
        }
    }

    public function down(): void
    {
        // Revertir location_id
        if (Schema::hasColumn('activity_calendars', 'location_id')) {
            Schema::table('activity_calendars', function (Blueprint $table) {
                $table->dropForeign(['location_id']);
                $table->dropColumn('location_id');
            });
        }

        // Revertir nombre de columna
        if (Schema::hasColumn('activity_calendars', 'assigned_person')) {
            Schema::table('activity_calendars', function (Blueprint $table) {
                $table->renameColumn('assigned_person', 'asigned_person');
            });
        }
    }
};

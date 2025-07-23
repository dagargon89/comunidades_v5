<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Eliminar activity_progress_log_id de planned_metrics si existe
        if (Schema::hasColumn('planned_metrics', 'activity_progress_log_id')) {
            Schema::table('planned_metrics', function (Blueprint $table) {
                $table->dropColumn('activity_progress_log_id');
            });
        }

        // Eliminar activity_progress_log_id de activity_files si existe
        if (Schema::hasColumn('activity_files', 'activity_progress_log_id')) {
            Schema::table('activity_files', function (Blueprint $table) {
                $table->dropColumn('activity_progress_log_id');
            });
        }
    }

    public function down(): void
    {
        // Restaurar columnas eliminadas (como nullable por seguridad)
        if (!Schema::hasColumn('planned_metrics', 'activity_progress_log_id')) {
            Schema::table('planned_metrics', function (Blueprint $table) {
                $table->bigInteger('activity_progress_log_id')->unsigned()->nullable()->after('product_real_value');
            });
        }

        if (!Schema::hasColumn('activity_files', 'activity_progress_log_id')) {
            Schema::table('activity_files', function (Blueprint $table) {
                $table->bigInteger('activity_progress_log_id')->unsigned()->nullable()->after('file_path');
            });
        }
    }
};

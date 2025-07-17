<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('planned_metrics', function (Blueprint $table) {
            $table->unsignedBigInteger('activity_progress_log_id')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('planned_metrics', function (Blueprint $table) {
            $table->unsignedBigInteger('activity_progress_log_id')->nullable(false)->change();
        });
    }
};

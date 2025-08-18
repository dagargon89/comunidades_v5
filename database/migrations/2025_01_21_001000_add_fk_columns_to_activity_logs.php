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
        Schema::table('activity_logs', function (Blueprint $table) {
            // 1: Agregar columnas de FKs
            $table->unsignedBigInteger('activity_calendar_id')->nullable();
            $table->unsignedBigInteger('beneficiary_registry_id')->nullable();
            $table->unsignedBigInteger('activity_id')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('activity_logs', function (Blueprint $table) {
            $table->dropColumn(['activity_calendar_id', 'beneficiary_registry_id', 'activity_id']);
        });
    }
};

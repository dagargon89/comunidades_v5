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
        Schema::table('activity_files', function (Blueprint $table) {
            $table->unsignedBigInteger('activity_calendar_id')->nullable()->after('activity_progress_log_id');
            $table->foreign('activity_calendar_id')->references('id')->on('activity_calendars')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('activity_files', function (Blueprint $table) {
            $table->dropForeign(['activity_calendar_id']);
            $table->dropColumn('activity_calendar_id');
        });
    }
};

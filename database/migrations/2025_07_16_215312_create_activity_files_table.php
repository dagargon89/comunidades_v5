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
        Schema::create('activity_files', function (Blueprint $table) {
            $table->id();
            $table->string('month', 20)->nullable();
            $table->string('type', 100)->nullable();
            $table->text('file_path')->nullable();
            $table->timestamp('upload_date')->nullable();
            $table->foreignId('activity_progress_log_id');
            $table->foreignId('activity_log_id');
            $table->string('belongsTo');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('activity_files');
    }
};

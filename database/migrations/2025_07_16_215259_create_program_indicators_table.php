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
        Schema::create('program_indicators', function (Blueprint $table) {
            $table->id();
            $table->string('name', 45)->nullable();
            $table->text('description')->nullable();
            $table->decimal('initial_value', 10, 2)->nullable();
            $table->decimal('final_value', 10, 2)->nullable();
            $table->foreignId('program_id');
            $table->foreignId('program_axes_id');
            $table->string('belongsTo');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('program_indicators');
    }
};

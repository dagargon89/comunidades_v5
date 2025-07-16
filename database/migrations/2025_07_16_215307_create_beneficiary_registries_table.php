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
        Schema::create('beneficiary_registries', function (Blueprint $table) {
            $table->id();
            $table->foreignId('activity_calendar_id');
            $table->foreignId('beneficiaries_id');
            $table->foreignId('data_collectors_id');
            $table->foreignId('created_by');
            $table->string('belongsTo');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('beneficiary_registries');
    }
};

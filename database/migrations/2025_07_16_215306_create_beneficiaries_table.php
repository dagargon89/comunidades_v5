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
        Schema::create('beneficiaries', function (Blueprint $table) {
            $table->id();
            $table->string('last_name', 100)->nullable();
            $table->string('mother_last_name', 100)->nullable();
            $table->string('first_names', 100)->nullable();
            $table->string('birth_year', 4)->nullable();
            $table->enum('gender', ["M","F","Male","Female"])->nullable();
            $table->string('phone', 20)->nullable();
            $table->text('signature')->nullable();
            $table->text('address_backup')->nullable();
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
        Schema::dropIfExists('beneficiaries');
    }
};

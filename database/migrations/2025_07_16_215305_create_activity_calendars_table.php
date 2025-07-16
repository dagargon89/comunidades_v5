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
        Schema::create('activity_calendars', function (Blueprint $table) {
            $table->id();
            $table->foreignId('activity_id');
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->time('start_hour')->nullable();
            $table->time('end_hour')->nullable();
            $table->text('address_backup')->nullable();
            $table->timestamp('last_modified')->nullable();
            $table->boolean('cancelled')->default(false);
            $table->text('change_reason')->nullable();
            $table->foreignId('created_by');
            $table->foreignId('asigned_person');
            $table->string('belongsTo');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('activity_calendars');
    }
};

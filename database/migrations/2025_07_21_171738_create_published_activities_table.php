<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('published_activities', function (Blueprint $table) {
            $table->id();
            $table->foreignId('publication_id')->constrained('data_publications')->cascadeOnDelete();
            $table->foreignId('original_activity_id')->constrained('activities')->restrictOnDelete();
            $table->string('name', 255)->nullable();
            $table->text('description')->nullable();
            $table->foreignId('specific_objective_id')->constrained('specific_objectives')->restrictOnDelete();
            $table->foreignId('goals_id')->constrained('goals')->restrictOnDelete();
            $table->foreignId('created_by')->constrained('users')->restrictOnDelete();
            $table->timestamp('snapshot_date')->useCurrent();
            $table->index('original_activity_id', 'idx_published_activities_original');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('published_activities');
    }
};

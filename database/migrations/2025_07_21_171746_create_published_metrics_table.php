<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('published_metrics', function (Blueprint $table) {
            $table->id();
            $table->foreignId('publication_id')->constrained('data_publications')->cascadeOnDelete();
            $table->foreignId('original_metric_id')->constrained('planned_metrics')->restrictOnDelete();
            $table->foreignId('activity_id')->constrained('activities')->restrictOnDelete();
            $table->string('unit', 100)->nullable();
            $table->integer('year')->nullable();
            $table->integer('month')->nullable();
            $table->decimal('population_target_value', 10, 2)->nullable();
            $table->decimal('population_real_value', 10, 2)->nullable();
            $table->decimal('product_target_value', 10, 2)->nullable();
            $table->decimal('product_real_value', 10, 2)->nullable();
            $table->timestamp('snapshot_date')->useCurrent();
            $table->index('activity_id', 'idx_published_metrics_activity');
            $table->index(['year', 'month'], 'idx_published_metrics_period');
            $table->index('original_metric_id', 'idx_published_metrics_original');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('published_metrics');
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('data_publications', function (Blueprint $table) {
            $table->id();
            $table->timestamp('publication_date')->useCurrent();
            $table->foreignId('published_by')->constrained('users')->restrictOnDelete();
            $table->text('publication_notes')->nullable();
            $table->integer('metrics_count')->default(0);
            $table->integer('projects_count')->default(0);
            $table->integer('activities_count')->default(0);
            $table->date('period_from')->nullable();
            $table->date('period_to')->nullable();
            $table->index('publication_date', 'idx_publications_date');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('data_publications');
    }
};

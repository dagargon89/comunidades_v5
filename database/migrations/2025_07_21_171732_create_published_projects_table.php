<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('published_projects', function (Blueprint $table) {
            $table->id();
            $table->foreignId('publication_id')->constrained('data_publications')->cascadeOnDelete();
            $table->foreignId('original_project_id')->constrained('projects')->restrictOnDelete();
            $table->string('name', 500);
            $table->text('background')->nullable();
            $table->text('justification')->nullable();
            $table->text('general_objective')->nullable();
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->double('total_cost')->nullable();
            $table->double('funded_amount')->nullable();
            $table->double('cofunding_amount')->nullable();
            $table->foreignId('financiers_id')->constrained('financiers')->restrictOnDelete();
            $table->foreignId('co_financier_id')->nullable()->constrained('financiers')->restrictOnDelete();
            $table->foreignId('created_by')->constrained('users')->restrictOnDelete();
            $table->timestamp('snapshot_date')->useCurrent();
            $table->index('original_project_id', 'idx_published_projects_original');
            $table->index('financiers_id', 'idx_published_projects_financier');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('published_projects');
    }
};

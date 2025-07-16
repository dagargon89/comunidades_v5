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
        Schema::create('projects', function (Blueprint $table) {
            $table->id();
            $table->string('name', 500);
            $table->text('background')->nullable();
            $table->text('justification')->nullable();
            $table->text('general_objective')->nullable();
            $table->foreignId('financiers_id');
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable();
            $table->float('total_cost')->nullable();
            $table->float('funded_amount')->nullable();
            $table->float('cofunding_amount')->nullable();
            $table->float('monthly_disbursement')->nullable();
            $table->text('followup_officer')->nullable();
            $table->text('agreement_file')->nullable();
            $table->text('project_base_file')->nullable();
            $table->foreignId('co_financier_id')->nullable();
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
        Schema::dropIfExists('projects');
    }
};

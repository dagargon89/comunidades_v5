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
        Schema::create('narrativa_versions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('activity_narrative_id')->constrained()->cascadeOnDelete();
            $table->integer('version_number');

            // Snapshot completo de la narrativa en ese momento
            $table->longText('narrativa_generada')->nullable();
            $table->text('narrativa_contexto')->nullable();
            $table->text('narrativa_desarrollo')->nullable();
            $table->text('narrativa_resultados')->nullable();
            $table->integer('participantes_count')->nullable();
            $table->text('organizaciones_participantes')->nullable();

            // Metadata de la generación
            $table->string('modelo_usado')->nullable(); // llama3.1, gpt-4, etc.
            $table->decimal('temperatura', 3, 2)->nullable();
            $table->integer('tokens_usados')->nullable();
            $table->decimal('tiempo_generacion', 5, 2)->nullable(); // segundos

            // Prompt usado (para poder regenerar igual)
            $table->longText('prompt_usado')->nullable();

            // Quién y cuándo
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->enum('tipo_cambio', [
                'generacion_inicial',
                'regeneracion_automatica',
                'edicion_manual',
                'restauracion'
            ])->default('generacion_inicial');
            $table->text('motivo_cambio')->nullable(); // Por qué se regeneró

            $table->timestamps();

            $table->unique(['activity_narrative_id', 'version_number']);
            $table->index('created_at');
            $table->index('tipo_cambio');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('narrativa_versions');
    }
};

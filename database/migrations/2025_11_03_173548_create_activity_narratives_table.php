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
        Schema::create('activity_narratives', function (Blueprint $table) {
            $table->id();

            // Relación 1:1 con activity_calendars
            $table->foreignId('activity_calendar_id')
                ->unique()
                ->constrained('activity_calendars')
                ->onDelete('cascade')
                ->comment('Relación con el evento/calendario de actividad');

            // Campos de entrada manual (captura por usuario)
            $table->text('narrativa_contexto')->nullable()
                ->comment('Contexto y descripción de lo realizado - entrada manual');

            $table->text('narrativa_desarrollo')->nullable()
                ->comment('Desarrollo de la actividad, temas abordados, metodología - entrada manual');

            $table->text('narrativa_resultados')->nullable()
                ->comment('Resultados, acuerdos y compromisos establecidos - entrada manual');

            $table->text('organizaciones_participantes')->nullable()
                ->comment('Lista de organizaciones participantes separadas por coma');

            $table->integer('participantes_count')->nullable()
                ->comment('Número total de participantes en el evento');

            // Campos generados por IA
            $table->longText('narrativa_generada')->nullable()
                ->comment('Narrativa completa generada por IA en estilo institucional formal');

            $table->boolean('narrativa_aprobada')->default(false)
                ->comment('Indica si la narrativa fue revisada y aprobada por un humano');

            $table->timestamp('narrativa_regenerada_at')->nullable()
                ->comment('Fecha y hora de la última regeneración de narrativa');

            $table->timestamps();

            // Índices para mejorar performance en queries
            $table->index('narrativa_aprobada');
            $table->index('created_at');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('activity_narratives');
    }
};

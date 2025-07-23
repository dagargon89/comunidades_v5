<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        // Agregar columna project_id a goals
        if (!Schema::hasColumn('goals', 'project_id')) {
            Schema::table('goals', function (Blueprint $table) {
                $table->foreignId('project_id')->nullable()->after('id')->constrained('projects')->cascadeOnDelete();
            });
        }
        // Eliminar tabla pivote project_goal si existe
        if (Schema::hasTable('project_goal')) {
            Schema::drop('project_goal');
        }
    }

    public function down()
    {
        // Quitar columna project_id de goals
        if (Schema::hasColumn('goals', 'project_id')) {
            Schema::table('goals', function (Blueprint $table) {
                $table->dropForeign(['project_id']);
                $table->dropColumn('project_id');
            });
        }
        // Restaurar tabla pivote (estructura básica)
        if (!Schema::hasTable('project_goal')) {
            Schema::create('project_goal', function (Blueprint $table) {
                $table->id();
                $table->foreignId('project_id')->constrained()->cascadeOnDelete();
                $table->foreignId('goal_id')->constrained()->cascadeOnDelete();
                $table->timestamps();
                $table->unique(['project_id', 'goal_id']);
            });
        }
    }
};

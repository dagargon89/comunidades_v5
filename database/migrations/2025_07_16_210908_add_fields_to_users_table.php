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
        Schema::table('users', function (Blueprint $table) {
            // Agregar campos faltantes según la estructura de planeacion.sql
            // Todos los campos son nullable para permitir usuarios básicos
            $table->unsignedBigInteger('point_of_contact_id')->nullable();
            $table->string('phone', 45)->nullable();
            $table->string('org_role', 45)->nullable();
            $table->unsignedBigInteger('organizations_id')->nullable();
            $table->string('org_area', 100)->nullable();

            // Agregar clave foránea para organizations_id solo si no es null
            // La clave foránea se manejará a nivel de aplicación
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Intentar eliminar clave foránea si existe
            try {
                $table->dropForeign(['organizations_id']);
            } catch (\Exception $e) {
                // La clave foránea no existe, continuar
            }

            // Eliminar solo los campos agregados en up()
            $table->dropColumn([
                'point_of_contact_id',
                'phone',
                'org_role',
                'organizations_id',
                'org_area'
            ]);
        });
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Crear la vista del padrón de beneficiarios
        DB::statement("
            CREATE VIEW padron_beneficiarios AS
            SELECT DISTINCT
                b.first_names AS Nombres,
                b.last_name AS Apellido_paterno,
                b.mother_last_name AS Apellido_materno,
                b.birth_year AS nacimiento,
                b.gender AS genero,
                b.phone AS telefono,
                b.street AS calle,
                b.neighborhood AS colonia,
                a.name AS nombre_actividad,
                p.name AS nombre_proyecto,
                ac.start_date AS Evento_Fecha_Inicio,
                f.id AS financiadora
            FROM
                beneficiaries b
                LEFT JOIN beneficiary_registries br ON br.beneficiaries_id = b.id
                LEFT JOIN activity_calendars ac ON ac.id = br.activity_calendar_id
                LEFT JOIN activities a ON ac.activity_id = a.id
                LEFT JOIN specific_objectives so ON a.specific_objective_id = so.id
                LEFT JOIN projects p ON so.projects_id = p.id
                LEFT JOIN financiers f ON p.financiers_id = f.id
        ");
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Eliminar la vista
        DB::statement('DROP VIEW IF EXISTS padron_beneficiarios');
    }
};

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
        // Función helper para eliminar restricción si existe
        $dropForeignIfExists = function($table, $constraint) {
            try {
                Schema::table($table, function (Blueprint $table) use ($constraint) {
                    $table->dropForeign($constraint);
                });
            } catch (Exception $e) {
                // La restricción no existe, continuar
            }
        };

        // 1. RELACIONES DIRECTAS CON ORGANIZATIONS

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('users', 'fk_users_organizations');
        $dropForeignIfExists('goals', 'fk_goals_organizations');

        // Agregar FK para users.organizations_id -> organizations.id
        Schema::table('users', function (Blueprint $table) {
            $table->foreign('organizations_id', 'fk_users_organizations')
                  ->references('id')
                  ->on('organizations')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // Agregar FK para goals.organizations_id -> organizations.id
        Schema::table('goals', function (Blueprint $table) {
            $table->foreign('organizations_id', 'fk_goals_organizations')
                  ->references('id')
                  ->on('organizations')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // 2. RELACIONES RELACIONADAS CON USUARIOS (conexión indirecta a organizaciones)

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('projects', 'fk_projects_created_by');
        $dropForeignIfExists('activities', 'fk_activities_created_by');
        $dropForeignIfExists('beneficiaries', 'fk_beneficiaries_created_by');

        // Agregar FK para projects.created_by -> users.id
        Schema::table('projects', function (Blueprint $table) {
            $table->foreign('created_by', 'fk_projects_created_by')
                  ->references('id')
                  ->on('users')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // Agregar FK para activities.created_by -> users.id
        Schema::table('activities', function (Blueprint $table) {
            $table->foreign('created_by', 'fk_activities_created_by')
                  ->references('id')
                  ->on('users')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // Agregar FK para beneficiaries.created_by -> users.id
        Schema::table('beneficiaries', function (Blueprint $table) {
            $table->foreign('created_by', 'fk_beneficiaries_created_by')
                  ->references('id')
                  ->on('users')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // 3. RELACIONES DE JERARQUÍA DE PROYECTOS

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('activities', 'fk_activities_goals');
        $dropForeignIfExists('activities', 'fk_activities_specific_objectives');
        $dropForeignIfExists('specific_objectives', 'fk_specific_objectives_projects');

        // Agregar FK para activities.goals_id -> goals.id
        Schema::table('activities', function (Blueprint $table) {
            $table->foreign('goals_id', 'fk_activities_goals')
                  ->references('id')
                  ->on('goals')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // Agregar FK para activities.specific_objective_id -> specific_objectives.id
        Schema::table('activities', function (Blueprint $table) {
            $table->foreign('specific_objective_id', 'fk_activities_specific_objectives')
                  ->references('id')
                  ->on('specific_objectives')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // Agregar FK para specific_objectives.projects_id -> projects.id
        Schema::table('specific_objectives', function (Blueprint $table) {
            $table->foreign('projects_id', 'fk_specific_objectives_projects')
                  ->references('id')
                  ->on('projects')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });

        // 4. RELACIONES DE FINANCIAMIENTO

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('projects', 'fk_projects_financiers');
        $dropForeignIfExists('projects', 'fk_projects_co_financiers');

        // Agregar FK para projects.financiers_id -> financiers.id
        Schema::table('projects', function (Blueprint $table) {
            $table->foreign('financiers_id', 'fk_projects_financiers')
                  ->references('id')
                  ->on('financiers')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // Agregar FK para projects.co_financier_id -> financiers.id
        Schema::table('projects', function (Blueprint $table) {
            $table->foreign('co_financier_id', 'fk_projects_co_financiers')
                  ->references('id')
                  ->on('financiers')
                  ->onDelete('set null')
                  ->onUpdate('cascade');
        });

        // 5. RELACIONES DE CALENDARIO Y PROGRAMACIÓN

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('activity_calendars', 'fk_activity_calendars_activities');
        $dropForeignIfExists('activity_calendars', 'fk_activity_calendars_assigned_person');
        $dropForeignIfExists('activity_calendars', 'fk_activity_calendars_locations');

        // Agregar FK para activity_calendars.activity_id -> activities.id
        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->foreign('activity_id', 'fk_activity_calendars_activities')
                  ->references('id')
                  ->on('activities')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });

        // Modificar assigned_person para permitir NULL antes de agregar la FK
        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->unsignedBigInteger('assigned_person')->nullable()->change();
        });

        // Agregar FK para activity_calendars.assigned_person -> users.id
        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->foreign('assigned_person', 'fk_activity_calendars_assigned_person')
                  ->references('id')
                  ->on('users')
                  ->onDelete('set null')
                  ->onUpdate('cascade');
        });

        // Agregar FK para activity_calendars.location_id -> locations.id
        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->foreign('location_id', 'fk_activity_calendars_locations')
                  ->references('id')
                  ->on('locations')
                  ->onDelete('set null')
                  ->onUpdate('cascade');
        });

        // 6. RELACIONES DE REGISTRO DE BENEFICIARIOS

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('beneficiary_registries', 'fk_beneficiary_registries_activity_calendar');
        $dropForeignIfExists('beneficiary_registries', 'fk_beneficiary_registries_beneficiaries');

        // Agregar FK para beneficiary_registries.activity_calendar_id -> activity_calendars.id
        Schema::table('beneficiary_registries', function (Blueprint $table) {
            $table->foreign('activity_calendar_id', 'fk_beneficiary_registries_activity_calendar')
                  ->references('id')
                  ->on('activity_calendars')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });

        // Agregar FK para beneficiary_registries.beneficiaries_id -> beneficiaries.id
        Schema::table('beneficiary_registries', function (Blueprint $table) {
            $table->foreign('beneficiaries_id', 'fk_beneficiary_registries_beneficiaries')
                  ->references('id')
                  ->on('beneficiaries')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });

        // 7. RELACIONES DE MÉTRICAS

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('planned_metrics', 'fk_planned_metrics_activities');

        // Agregar FK para planned_metrics.activity_id -> activities.id
        Schema::table('planned_metrics', function (Blueprint $table) {
            $table->foreign('activity_id', 'fk_planned_metrics_activities')
                  ->references('id')
                  ->on('activities')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });

        // 8. RELACIONES DEL SISTEMA DE PUBLICACIÓN

        // Eliminar restricciones existentes si las hay
        $dropForeignIfExists('data_publications', 'fk_data_publications_published_by');
        $dropForeignIfExists('published_projects', 'fk_published_projects_publication');
        $dropForeignIfExists('published_activities', 'fk_published_activities_publication');
        $dropForeignIfExists('published_metrics', 'fk_published_metrics_publication');

        // Agregar FK para data_publications.published_by -> users.id
        Schema::table('data_publications', function (Blueprint $table) {
            $table->foreign('published_by', 'fk_data_publications_published_by')
                  ->references('id')
                  ->on('users')
                  ->onDelete('restrict')
                  ->onUpdate('cascade');
        });

        // Agregar FK para published_projects.publication_id -> data_publications.id
        Schema::table('published_projects', function (Blueprint $table) {
            $table->foreign('publication_id', 'fk_published_projects_publication')
                  ->references('id')
                  ->on('data_publications')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });

        // Agregar FK para published_activities.publication_id -> data_publications.id
        Schema::table('published_activities', function (Blueprint $table) {
            $table->foreign('publication_id', 'fk_published_activities_publication')
                  ->references('id')
                  ->on('data_publications')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });

        // Agregar FK para published_metrics.publication_id -> data_publications.id
        Schema::table('published_metrics', function (Blueprint $table) {
            $table->foreign('publication_id', 'fk_published_metrics_publication')
                  ->references('id')
                  ->on('data_publications')
                  ->onDelete('cascade')
                  ->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Eliminar todas las restricciones de clave foránea en orden inverso

        // 8. RELACIONES DEL SISTEMA DE PUBLICACIÓN
        Schema::table('published_metrics', function (Blueprint $table) {
            $table->dropForeign('fk_published_metrics_publication');
        });

        Schema::table('published_activities', function (Blueprint $table) {
            $table->dropForeign('fk_published_activities_publication');
        });

        Schema::table('published_projects', function (Blueprint $table) {
            $table->dropForeign('fk_published_projects_publication');
        });

        Schema::table('data_publications', function (Blueprint $table) {
            $table->dropForeign('fk_data_publications_published_by');
        });

        // 7. RELACIONES DE MÉTRICAS
        Schema::table('planned_metrics', function (Blueprint $table) {
            $table->dropForeign('fk_planned_metrics_activities');
        });

        // 6. RELACIONES DE REGISTRO DE BENEFICIARIOS
        Schema::table('beneficiary_registries', function (Blueprint $table) {
            $table->dropForeign('fk_beneficiary_registries_beneficiaries');
        });

        Schema::table('beneficiary_registries', function (Blueprint $table) {
            $table->dropForeign('fk_beneficiary_registries_activity_calendar');
        });

        // 5. RELACIONES DE CALENDARIO Y PROGRAMACIÓN
        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->dropForeign('fk_activity_calendars_locations');
        });

        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->dropForeign('fk_activity_calendars_assigned_person');
        });

        // Revertir el cambio de nullable para assigned_person
        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->unsignedBigInteger('assigned_person')->nullable(false)->change();
        });

        Schema::table('activity_calendars', function (Blueprint $table) {
            $table->dropForeign('fk_activity_calendars_activities');
        });

        // 4. RELACIONES DE FINANCIAMIENTO
        Schema::table('projects', function (Blueprint $table) {
            $table->dropForeign('fk_projects_co_financiers');
        });

        Schema::table('projects', function (Blueprint $table) {
            $table->dropForeign('fk_projects_financiers');
        });

        // 3. RELACIONES DE JERARQUÍA DE PROYECTOS
        Schema::table('specific_objectives', function (Blueprint $table) {
            $table->dropForeign('fk_specific_objectives_projects');
        });

        Schema::table('activities', function (Blueprint $table) {
            $table->dropForeign('fk_activities_specific_objectives');
        });

        Schema::table('activities', function (Blueprint $table) {
            $table->dropForeign('fk_activities_goals');
        });

        // 2. RELACIONES RELACIONADAS CON USUARIOS
        Schema::table('beneficiaries', function (Blueprint $table) {
            $table->dropForeign('fk_beneficiaries_created_by');
        });

        Schema::table('activities', function (Blueprint $table) {
            $table->dropForeign('fk_activities_created_by');
        });

        Schema::table('projects', function (Blueprint $table) {
            $table->dropForeign('fk_projects_created_by');
        });

        // 1. RELACIONES DIRECTAS CON ORGANIZATIONS
        Schema::table('goals', function (Blueprint $table) {
            $table->dropForeign('fk_goals_organizations');
        });

        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign('fk_users_organizations');
        });
    }
};

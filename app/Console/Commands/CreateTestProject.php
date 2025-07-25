<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Project;
use App\Models\SpecificObjective;
use App\Models\Kpi;
use App\Models\Goal;
use App\Models\Activity;
use App\Models\PlannedMetric;
use App\Models\Financier;
use App\Models\User;
use App\Models\Component;
use App\Models\ActionLine;
use App\Models\Program;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class CreateTestProject extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'test:create-project {count=1}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Crear múltiples proyectos de prueba con datos completos para probar el borrado';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $count = (int) $this->argument('count');
        $this->info("Creando {$count} proyecto(s) de prueba...");

        $createdProjects = [];

        for ($i = 1; $i <= $count; $i++) {
            $this->info("Creando proyecto {$i} de {$count}...");

            try {
                DB::beginTransaction();

                // Verificar que existan los datos necesarios
                $financier = Financier::first();
                if (!$financier) {
                    $financier = Financier::create(['name' => 'Financiador de Prueba']);
                }

                $user = User::first();
                if (!$user) {
                    $this->error('No hay usuarios en la base de datos');
                    return 1;
                }

                $component = Component::first();
                if (!$component) {
                    $this->error('No hay componentes en la base de datos');
                    return 1;
                }

                $organization = \App\Models\Organization::first();
                if (!$organization) {
                    $this->error('No hay organizaciones en la base de datos');
                    return 1;
                }

                // 1. Crear proyecto con datos variados
                $project = Project::create([
                    'name' => "Proyecto de Prueba {$i} - " . now()->format('Y-m-d H:i:s'),
                    'financiers_id' => $financier->id,
                    'followup_officer' => "Encargado de Prueba {$i}",
                    'general_objective' => "Objetivo general de prueba {$i}",
                    'background' => "Antecedentes de prueba {$i}",
                    'justification' => "Justificación de prueba {$i}",
                    'start_date' => now()->addDays($i),
                    'end_date' => now()->addMonths(6)->addDays($i),
                    'total_cost' => 100000 + ($i * 50000),
                    'funded_amount' => 80000 + ($i * 40000),
                    'cofunding_amount' => 20000 + ($i * 10000),
                    'created_by' => $user->id,
                ]);

                $this->info("Proyecto creado: {$project->id}");

                // 2. Crear objetivos específicos
                $objective1 = SpecificObjective::create([
                    'description' => "Objetivo específico 1 de prueba {$i}",
                    'projects_id' => $project->id,
                    'created_by' => $user->id,
                ]);

                $objective2 = SpecificObjective::create([
                    'description' => "Objetivo específico 2 de prueba {$i}",
                    'projects_id' => $project->id,
                    'created_by' => $user->id,
                ]);

                // 3. Crear KPIs
                $kpi1 = Kpi::create([
                    'name' => "KPI 1 de prueba {$i}",
                    'description' => "Descripción del KPI 1 del proyecto {$i}",
                    'initial_value' => $i * 10,
                    'final_value' => $i * 100,
                    'is_percentage' => $i % 2 == 0,
                    'org_area' => "Área de prueba {$i}",
                    'projects_id' => $project->id,
                    'created_by' => $user->id,
                ]);

                // 4. Crear metas
                $goal1 = Goal::create([
                    'project_id' => $project->id,
                    'description' => "Meta 1 de prueba {$i}",
                    'number' => $i,
                    'components_id' => $component->id,
                    'components_action_lines_id' => $component->action_lines_id,
                    'components_action_lines_program_id' => $component->action_lines_program_id,
                    'organizations_id' => $organization->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                $goal2 = Goal::create([
                    'project_id' => $project->id,
                    'description' => "Meta 2 de prueba {$i}",
                    'number' => $i + 1,
                    'components_id' => $component->id,
                    'components_action_lines_id' => $component->action_lines_id,
                    'components_action_lines_program_id' => $component->action_lines_program_id,
                    'organizations_id' => $organization->id,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);

                // 5. Crear actividades
                $activity1 = Activity::create([
                    'name' => "Actividad 1 de prueba {$i}",
                    'description' => "Descripción de la actividad 1 del proyecto {$i}",
                    'specific_objective_id' => $objective1->id,
                    'goals_id' => $goal1->id,
                    'population_target_value' => 50 + ($i * 10),
                    'product_target_value' => 100 + ($i * 20),
                    'created_by' => $user->id,
                ]);

                $activity2 = Activity::create([
                    'name' => "Actividad 2 de prueba {$i}",
                    'description' => "Descripción de la actividad 2 del proyecto {$i}",
                    'specific_objective_id' => $objective2->id,
                    'goals_id' => $goal1->id,
                    'population_target_value' => 25 + ($i * 5),
                    'product_target_value' => 50 + ($i * 10),
                    'created_by' => $user->id,
                ]);

                $activity3 = Activity::create([
                    'name' => "Actividad 3 de prueba {$i}",
                    'description' => "Descripción de la actividad 3 del proyecto {$i}",
                    'specific_objective_id' => $objective1->id,
                    'goals_id' => $goal2->id,
                    'population_target_value' => 75 + ($i * 15),
                    'product_target_value' => 150 + ($i * 30),
                    'created_by' => $user->id,
                ]);

                // 6. Crear PlannedMetrics
                PlannedMetric::create([
                    'activity_id' => $activity1->id,
                    'population_target_value' => 50 + ($i * 10),
                    'product_target_value' => 100 + ($i * 20),
                ]);

                PlannedMetric::create([
                    'activity_id' => $activity2->id,
                    'population_target_value' => 25 + ($i * 5),
                    'product_target_value' => 50 + ($i * 10),
                ]);

                PlannedMetric::create([
                    'activity_id' => $activity3->id,
                    'population_target_value' => 75 + ($i * 15),
                    'product_target_value' => 150 + ($i * 30),
                ]);

                DB::commit();

                $createdProjects[] = [
                    'id' => $project->id,
                    'name' => $project->name,
                    'activities' => 3,
                    'planned_metrics' => 3,
                ];

                $this->info("✅ Proyecto {$i} creado exitosamente!");

            } catch (\Exception $e) {
                DB::rollBack();
                $this->error("Error al crear el proyecto {$i}: " . $e->getMessage());
                return 1;
            }
        }

        $this->info("\n🎉 Resumen de proyectos creados:");
        foreach ($createdProjects as $project) {
            $this->info("   - ID: {$project['id']} | {$project['name']} | Actividades: {$project['activities']} | PlannedMetrics: {$project['planned_metrics']}");
        }

        $this->info("\n📊 Total:");
        $this->info("   - Proyectos creados: " . count($createdProjects));
        $this->info("   - Actividades totales: " . (count($createdProjects) * 3));
        $this->info("   - PlannedMetrics totales: " . (count($createdProjects) * 3));

        return 0;
    }
}

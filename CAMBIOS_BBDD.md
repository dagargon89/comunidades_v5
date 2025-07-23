# Análisis de Implementación: Script de Modificación de Base de Datos

## 📋 **Resumen Ejecutivo**

Este documento analiza la viabilidad de implementar las modificaciones propuestas en el `modification_script.sql` para el sistema de gestión de proyectos comunitarios, identificando qué cambios son seguros y cuáles representan riesgos significativos para el proyecto actual.

---

## ✅ **Cambios Implementables (Bajo Riesgo)**

### **1. Corrección Tipográfica**

```sql
ALTER TABLE `activity_calendars`
CHANGE COLUMN `asigned_person` `assigned_person` bigint UNSIGNED NOT NULL;
```

### **2. Limpieza de Columnas Problemáticas**

```sql
ALTER TABLE `planned_metrics` DROP COLUMN IF EXISTS `activity_progress_log_id`;
ALTER TABLE `activity_files` DROP COLUMN IF EXISTS `activity_progress_log_id`;
```

### **3. Agregación de Columna Opcional**

```sql
ALTER TABLE `activity_calendars` ADD COLUMN `location_id` bigint UNSIGNED NULL;
ALTER TABLE `activity_calendars`
ADD CONSTRAINT `fk_activity_calendar_locations1`
    FOREIGN KEY (`location_id`)
    REFERENCES `locations` (`id`)
    ON DELETE SET NULL;
```

---

## ❌ **Cambios NO Implementables en Esta Fase**

### **1. Foreign Keys Compuestas**

```sql
-- NO IMPLEMENTAR
ALTER TABLE `action_lines`
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `Program_id`, `Program_axes_id`);
```

**Justificación de Rechazo:**

-   Incompatibilidad con Laravel/Eloquent
-   Complejidad innecesaria
-   Riesgo de desarrollo
-   Tiempo vs valor

### **2. Desnormalización Masiva**

```sql
-- NO IMPLEMENTAR
ALTER TABLE `activities`
ADD COLUMN `projects_id` INT NOT NULL,
ADD COLUMN `components_id` INT NOT NULL,
ADD COLUMN `action_lines_id` INT NOT NULL,
-- ... 6+ columnas redundantes
```

**Justificación de Rechazo:**

-   Sobre-ingeniería
-   Mantenimiento complejo
-   Recursos limitados
-   Fase temprana del proyecto

### **3. Procedimiento Almacenado**

```sql
-- NO IMPLEMENTAR
CREATE PROCEDURE PublishDataSnapshot(...)
```

**Justificación de Rechazo:**

-   Anti-patrón Laravel
-   Mantenibilidad
-   Portabilidad
-   Filosofía del proyecto

### **4. Restructuración de Tablas Existentes**

```sql
-- NO IMPLEMENTAR
ALTER TABLE `components`
ADD COLUMN `action_lines_Program_axes_id` INT NOT NULL;
```

**Justificación de Rechazo:**

-   Impacto en producción
-   Tiempo de desarrollo
-   Riesgo de datos
-   Costo vs beneficio

---

## 🔧 **Solución para Edición de Proyectos**

### **Problema Identificado**

El método `mount()` en `ProjectWizard.php` no puede cargar correctamente los datos de un proyecto para edición debido a relaciones indirectas y lógica compleja en esta línea:

```php
// Línea problemática actual
$componentIds = \App\Models\Component::where('financiers_id', $project->financiers_id)->pluck('id');
$goals = \App\Models\Goal::whereIn('components_id', $componentIds)->get();
```

### **Solución Recomendada: Tabla Pivote**

#### **1. Crear Tabla Pivote Proyecto-Metas**

```php
// Migración: create_project_goal_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('project_goal', function (Blueprint $table) {
            $table->id();
            $table->foreignId('project_id')->constrained()->cascadeOnDelete();
            $table->foreignId('goal_id')->constrained()->cascadeOnDelete();
            $table->timestamps();
            $table->unique(['project_id', 'goal_id']);
        });
    }
    public function down()
    {
        Schema::dropIfExists('project_goal');
    }
};
```

#### **2. Actualizar Modelo Project**

```php
class Project extends Model
{
    public function goals()
    {
        return $this->belongsToMany(Goal::class, 'project_goal')->withTimestamps();
    }
    public function specificObjectives()
    {
        return $this->hasMany(SpecificObjective::class, 'projects_id');
    }
    public function kpis()
    {
        return $this->hasMany(Kpi::class, 'projects_id');
    }
}
```

#### **3. Actualizar Modelo Goal**

```php
class Goal extends Model
{
    public function projects()
    {
        return $this->belongsToMany(Project::class, 'project_goal')->withTimestamps();
    }
    public function activities()
    {
        return $this->hasMany(Activity::class, 'goals_id');
    }
    public function component()
    {
        return $this->belongsTo(Component::class, 'components_id');
    }
}
```

#### **4. Actualizar método mount() en ProjectWizard**

```php
public function mount()
{
    $editId = request()->query('edit');
    if ($editId) {
        $project = Project::with([
            'specificObjectives',
            'kpis',
            'goals.activities',
            'goals.component'
        ])->find($editId);
        if ($project) {
            $this->formData = [
                'project' => [
                    'name' => $project->name,
                    'financiers_id' => $project->financiers_id,
                    'followup_officer' => $project->followup_officer,
                    'general_objective' => $project->general_objective,
                    'background' => $project->background,
                    'justification' => $project->justification,
                    'start_date' => $project->start_date,
                    'end_date' => $project->end_date,
                    'total_cost' => $project->total_cost,
                    'funded_amount' => $project->funded_amount,
                    'cofinancier_id' => $project->co_financier_id,
                    'cofinancier_amount' => $project->cofunding_amount,
                ],
                'objectives' => $project->specificObjectives->map(fn($o) => [
                    'uuid' => (string) Str::uuid(),
                    'description' => $o->description,
                ])->toArray(),
                'kpis' => $project->kpis->map(fn($k) => [
                    'name' => $k->name,
                    'description' => $k->description,
                    'initial_value' => $k->initial_value,
                    'final_value' => $k->final_value,
                    'is_percentage' => $k->is_percentage,
                    'org_area' => $k->org_area,
                ])->toArray(),
                'goals' => $project->goals->map(function($goal) {
                    return [
                        'description' => $goal->description,
                        'number' => $goal->number,
                        'components_id' => $goal->components_id,
                        'action_lines_id' => $goal->components_action_lines_id,
                        'program_id' => $goal->components_action_lines_program_id,
                        'activities' => $goal->activities->map(function($activity) {
                            return [
                                'name' => $activity->name,
                                'specific_objective_id' => $activity->specific_objective_id,
                                'description' => $activity->description,
                                'population_target_value' => $activity->population_target_value,
                                'product_target_value' => $activity->product_target_value,
                            ];
                        })->toArray(),
                    ];
                })->toArray(),
            ];
        }
    }
    // ... resto del método existente
}
```

#### **5. Actualizar método saveProject()**

```php
public function saveProject()
{
    try {
        $data = $this->form->getState()['formData'];
        DB::beginTransaction();
        $project = \App\Models\Project::create([
            'name' => $data['project']['name'] ?? '',
            'financiers_id' => $data['project']['financiers_id'] ?? null,
            // ... resto de campos del proyecto
        ]);
        $objectiveUuidMap = [];
        if (!empty($data['objectives'])) {
            foreach ($data['objectives'] as $objective) {
                $obj = \App\Models\SpecificObjective::create([
                    'description' => $objective['description'] ?? '',
                    'projects_id' => $project->id,
                    'created_by' => Auth::id(),
                ]);
                $objectiveUuidMap[$objective['uuid']] = $obj->id;
            }
        }
        $goalIds = [];
        if (!empty($data['goals'])) {
            foreach ($data['goals'] as $goal) {
                $goalModel = \App\Models\Goal::create([
                    'description' => $goal['description'] ?? '',
                    'number' => $goal['number'] ?? null,
                    'components_id' => $goal['components_id'] ?? null,
                    'components_action_lines_id' => $goal['action_lines_id'] ?? null,
                    'components_action_lines_program_id' => $goal['program_id'] ?? null,
                    'organizations_id' => $goal['organizations_id'] ?? 1,
                ]);
                $goalIds[] = $goalModel->id;
                if (!empty($goal['activities'])) {
                    foreach ($goal['activities'] as $activity) {
                        $uuid = $activity['specific_objective_id'] ?? null;
                        $specificObjectiveId = $uuid && isset($objectiveUuidMap[$uuid])
                            ? $objectiveUuidMap[$uuid] : null;
                        \App\Models\Activity::create([
                            'name' => $activity['name'] ?? '',
                            'description' => $activity['description'] ?? '',
                            'specific_objective_id' => $specificObjectiveId,
                            'goals_id' => $goalModel->id,
                            'population_target_value' => $activity['population_target_value'] ?? 0,
                            'product_target_value' => $activity['product_target_value'] ?? 0,
                            'created_by' => Auth::id(),
                        ]);
                    }
                }
            }
        }
        if (!empty($goalIds)) {
            $project->goals()->attach($goalIds);
        }
        if (!empty($data['kpis'])) {
            foreach ($data['kpis'] as $kpi) {
                \App\Models\Kpi::create([
                    'name' => $kpi['name'] ?? '',
                    'description' => $kpi['description'] ?? '',
                    'initial_value' => $kpi['initial_value'] ?? 0,
                    'final_value' => $kpi['final_value'] ?? 0,
                    'is_percentage' => $kpi['is_percentage'] ?? false,
                    'org_area' => $kpi['org_area'] ?? '',
                    'projects_id' => $project->id,
                    'created_by' => Auth::id(),
                ]);
            }
        }
        DB::commit();
        $this->clearFormData();
        Notification::make()->title('Proyecto guardado exitosamente')->success()->send();
    } catch (\Exception $e) {
        DB::rollBack();
        Notification::make()->title('Error al guardar el proyecto')->body($e->getMessage())->danger()->send();
    }
}
```

#### **6. Migración para Datos Existentes**

```php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up()
    {
        $projects = DB::table('projects')->get();
        foreach ($projects as $project) {
            $componentIds = DB::table('components')
                ->where('financiers_id', $project->financiers_id)
                ->pluck('id');
            $goalIds = DB::table('goals')
                ->whereIn('components_id', $componentIds)
                ->pluck('id');
            foreach ($goalIds as $goalId) {
                DB::table('project_goal')->insertOrIgnore([
                    'project_id' => $project->id,
                    'goal_id' => $goalId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
    public function down()
    {
        DB::table('project_goal')->truncate();
    }
};
```

---

## 🎯 **Conclusión**

Para este proyecto en su fase actual, es recomendable:

1. **Implementar solo los cambios de bajo impacto** para mantener la estabilidad del sistema
2. **Resolver el problema de edición** usando una tabla pivote que mantiene la flexibilidad sin alterar la estructura existente
3. **Diferir las optimizaciones complejas** hasta que el volumen de datos y usuarios lo justifique
4. **Mantener la simplicidad** como principio rector para facilitar el mantenimiento

La estrategia de "hacer lo mínimo necesario" es apropiada para un sistema de gestión comunitaria donde la confiabilidad y facilidad de uso son más importantes que la optimización prematura. La solución con tabla pivote permite resolver el problema de edición manteniendo la flexibilidad para futuras necesidades del negocio.

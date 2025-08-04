<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Log;

class Project extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'background',
        'justification',
        'general_objective',
        'financiers_id',
        'start_date',
        'end_date',
        'total_cost',
        'funded_amount',
        'cofunding_amount',
        'monthly_disbursement',
        'followup_officer',
        'agreement_file',
        'project_base_file',
        'co_financier_id',
        'created_by',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'id' => 'integer',
            'financiers_id' => 'integer',
            'start_date' => 'date',
            'end_date' => 'date',
            'total_cost' => 'float',
            'funded_amount' => 'float',
            'cofunding_amount' => 'float',
            'monthly_disbursement' => 'float',
            'co_financier_id' => 'integer',
            'created_by' => 'integer',
        ];
    }

    /**
     * Boot the model and set up event listeners for cascading deletes
     */
    protected static function booted()
    {
        static::deleting(function ($project) {
            Log::info('Model Project: Iniciando borrado del proyecto: ' . $project->id);

            try {
                // PRIMERO: Eliminar PlannedMetric de todas las actividades del proyecto
                $allActivities = \App\Models\Activity::whereHas('goal', function($query) use ($project) {
                    $query->where('project_id', $project->id);
                })->get();

                Log::info('Model Project: Actividades encontradas para PlannedMetric: ' . $allActivities->count());

                foreach ($allActivities as $activity) {
                    $plannedMetrics = \App\Models\PlannedMetric::where('activity_id', $activity->id)->get();
                    Log::info('Model Project: PlannedMetrics encontrados para actividad ' . $activity->id . ': ' . $plannedMetrics->count());

                    if ($plannedMetrics->count() > 0) {
                        \App\Models\PlannedMetric::where('activity_id', $activity->id)->delete();
                        Log::info('Model Project: PlannedMetrics eliminados para actividad ' . $activity->id);
                    }
                }

                // SEGUNDO: Eliminar actividades relacionadas a través de metas
                $goals = $project->goals;
                Log::info('Model Project: Metas encontradas: ' . $goals->count());

                foreach ($goals as $goal) {
                    $goal->activities()->delete();
                }

                // TERCERO: Eliminar metas del proyecto
                $project->goals()->delete();

                // CUARTO: Eliminar objetivos específicos del proyecto
                $project->specificObjectives()->delete();

                // QUINTO: Eliminar KPIs del proyecto
                $project->kpis()->delete();

                // SEXTO: Eliminar reportes del proyecto
                \App\Models\ProjectReport::where('projects_id', $project->id)->delete();

                // SÉPTIMO: Eliminar desembolsos del proyecto
                \App\Models\ProjectDisbursement::where('projects_id', $project->id)->delete();

                // OCTAVO: Eliminar proyectos publicados relacionados
                $project->publishedProjects()->delete();

                Log::info('Model Project: Borrado del proyecto completado: ' . $project->id);
            } catch (\Exception $e) {
                Log::error('Model Project: Error durante el borrado del proyecto: ' . $e->getMessage());
                throw $e;
            }
        });
    }

    public function financiers(): BelongsTo
    {
        return $this->belongsTo(Financier::class, 'financiers_id');
    }

    public function coFinancier(): BelongsTo
    {
        return $this->belongsTo(Financier::class, 'co_financier_id');
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function publishedProjects()
    {
        return $this->hasMany(\App\Models\PublishedProject::class, 'original_project_id');
    }

    public function specificObjectives()
    {
        return $this->hasMany(\App\Models\SpecificObjective::class, 'projects_id');
    }

    public function kpis()
    {
        return $this->hasMany(\App\Models\Kpi::class, 'projects_id');
    }

    public function goals()
    {
        return $this->hasMany(\App\Models\Goal::class, 'project_id');
    }

    /**
     * Get the beneficiaries created by this project's creator.
     */
    public function beneficiariesCreados()
    {
        return $this->hasManyThrough(
            \App\Models\Beneficiary::class,
            \App\Models\User::class,
            'id', // Foreign key on users table...
            'created_by', // Foreign key on beneficiaries table...
            'created_by', // Local key on projects table...
            'id' // Local key on users table...
        );
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

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
}

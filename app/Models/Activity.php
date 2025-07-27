<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Activity extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'specific_objective_id',
        'description',
        'goals_id',
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
            'specific_objective_id' => 'integer',
            'goals_id' => 'integer',
            'created_by' => 'integer',
        ];
    }

    public function specificObjective(): BelongsTo
    {
        return $this->belongsTo(SpecificObjective::class, 'specific_objective_id');
    }

    public function goal()
    {
        return $this->belongsTo(\App\Models\Goal::class, 'goals_id');
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function publishedActivities()
    {
        return $this->hasMany(\App\Models\PublishedActivity::class, 'original_activity_id');
    }

    public function plannedMetrics(): HasMany
    {
        return $this->hasMany(PlannedMetric::class, 'activity_id');
    }
}

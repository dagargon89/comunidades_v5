<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PublishedActivity extends Model
{
    protected $fillable = [
        'publication_id',
        'original_activity_id',
        'project_id', // ← ESTE ERA EL CAMPO FALTANTE QUE CAUSABA TODO EL PROBLEMA
        'name',
        'description',
        'specific_objective_id',
        'goals_id',
        'created_by',
        'snapshot_date',
    ];

    public $timestamps = false;

    public function publication(): BelongsTo
    {
        return $this->belongsTo(DataPublication::class, 'publication_id');
    }

    public function originalActivity(): BelongsTo
    {
        return $this->belongsTo(Activity::class, 'original_activity_id');
    }

    public function specificObjective(): BelongsTo
    {
        return $this->belongsTo(SpecificObjective::class, 'specific_objective_id');
    }

    public function goal(): BelongsTo
    {
        return $this->belongsTo(Goal::class, 'goals_id');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}

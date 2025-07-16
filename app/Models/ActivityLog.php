<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ActivityLog extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'planned_metrics_id',
        'created_by',
        'belongsTo',
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
            'planned_metrics_id' => 'integer',
            'created_by' => 'integer',
        ];
    }

    public function plannedMetrics(): BelongsTo
    {
        return $this->belongsTo(PlannedMetrics::class);
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(CreatedBy::class);
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PlannedMetric extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'activity_id',
        'unit',
        'year',
        'month',
        'population_target_value',
        'population_real_value',
        'product_target_value',
        'product_real_value',
        'activity_progress_log_id',
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
            'activity_id' => 'integer',
            'population_target_value' => 'decimal:2',
            'population_real_value' => 'decimal:2',
            'product_target_value' => 'decimal:2',
            'product_real_value' => 'decimal:2',
            'activity_progress_log_id' => 'integer',
        ];
    }

    public function activity(): BelongsTo
    {
        return $this->belongsTo(Activity::class);
    }

    public function activityProgressLog(): BelongsTo
    {
        return $this->belongsTo(ActivityLog::class);
    }

    public function publishedMetrics()
    {
        return $this->hasMany(\App\Models\PublishedMetric::class, 'original_metric_id');
    }
}

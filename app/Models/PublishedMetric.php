<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PublishedMetric extends Model
{
    protected $fillable = [
        'publication_id',
        'original_metric_id',
        'activity_id',
        'unit',
        'year',
        'month',
        'population_target_value',
        'population_real_value',
        'product_target_value',
        'product_real_value',
        'snapshot_date',
    ];

    public $timestamps = false;

    public function publication(): BelongsTo
    {
        return $this->belongsTo(DataPublication::class, 'publication_id');
    }

    public function originalMetric(): BelongsTo
    {
        return $this->belongsTo(PlannedMetric::class, 'original_metric_id');
    }

    public function activity(): BelongsTo
    {
        return $this->belongsTo(Activity::class, 'activity_id');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class DataPublication extends Model
{
    protected $fillable = [
        'publication_date',
        'published_by',
        'publication_notes',
        'metrics_count',
        'projects_count',
        'activities_count',
        'period_from',
        'period_to',
    ];

    public $timestamps = false;

    public function publisher(): BelongsTo
    {
        return $this->belongsTo(User::class, 'published_by');
    }

    public function publishedProjects(): HasMany
    {
        return $this->hasMany(PublishedProject::class, 'publication_id');
    }

    public function publishedActivities(): HasMany
    {
        return $this->hasMany(PublishedActivity::class, 'publication_id');
    }

    public function publishedMetrics(): HasMany
    {
        return $this->hasMany(PublishedMetric::class, 'publication_id');
    }
}

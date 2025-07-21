<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PublishedProject extends Model
{
    protected $fillable = [
        'publication_id',
        'original_project_id',
        'name',
        'background',
        'justification',
        'general_objective',
        'start_date',
        'end_date',
        'total_cost',
        'funded_amount',
        'cofunding_amount',
        'financiers_id',
        'co_financier_id',
        'created_by',
        'snapshot_date',
    ];

    public $timestamps = false;

    public function publication(): BelongsTo
    {
        return $this->belongsTo(DataPublication::class, 'publication_id');
    }

    public function originalProject(): BelongsTo
    {
        return $this->belongsTo(Project::class, 'original_project_id');
    }

    public function financier(): BelongsTo
    {
        return $this->belongsTo(Financier::class, 'financiers_id');
    }

    public function coFinancier(): BelongsTo
    {
        return $this->belongsTo(Financier::class, 'co_financier_id');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}

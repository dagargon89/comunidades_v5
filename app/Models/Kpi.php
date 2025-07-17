<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Kpi extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'description',
        'initial_value',
        'final_value',
        'projects_id',
        'is_percentage',
        'org_area',
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
            'initial_value' => 'decimal:2',
            'final_value' => 'decimal:2',
            'projects_id' => 'integer',
            'is_percentage' => 'boolean',
        ];
    }

    public function projects(): BelongsTo
    {
        return $this->belongsTo(Project::class);
    }
}

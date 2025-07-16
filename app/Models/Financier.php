<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Financier extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
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
        ];
    }

    /**
     * Get the projects for this financier.
     */
    public function projects(): HasMany
    {
        return $this->hasMany(Project::class, 'financiers_id');
    }

    /**
     * Get the projects where this financier is the co-financier.
     */
    public function coFinancedProjects(): HasMany
    {
        return $this->hasMany(Project::class, 'co_financier_id');
    }
}

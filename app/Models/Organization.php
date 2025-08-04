<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Organization extends Model
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
     * Get the users for this organization.
     */
    public function users(): HasMany
    {
        return $this->hasMany(User::class, 'organizations_id');
    }

    /**
     * Get the goals for this organization.
     */
    public function goals(): HasMany
    {
        return $this->hasMany(Goal::class, 'organizations_id');
    }
}

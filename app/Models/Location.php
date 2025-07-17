<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Location extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'category',
        'street',
        'neighborhood',
        'ext_number',
        'int_number',
        'google_place_id',
        'polygons_id',
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
            'polygons_id' => 'integer',
            'created_by' => 'integer',
        ];
    }

    public function polygons(): BelongsTo
    {
        return $this->belongsTo(Polygon::class);
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}

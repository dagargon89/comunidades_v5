<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Beneficiary extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'last_name',
        'mother_last_name',
        'first_names',
        'birth_year',
        'gender',
        'phone',
        'street',
        'ext_number',
        'neighborhood',
        'address_backup',
        'identifier',
        'created_by',
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
            'created_by' => 'integer',
        ];
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    /**
     * Get the beneficiary registries for this beneficiary.
     */
    public function beneficiaryRegistries()
    {
        return $this->hasMany(BeneficiaryRegistry::class, 'beneficiaries_id');
    }
}

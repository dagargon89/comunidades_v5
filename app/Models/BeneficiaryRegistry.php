<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BeneficiaryRegistry extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'activity_calendar_id',
        'beneficiaries_id',
        'data_collectors_id',
        'created_by',
        'signature',
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
            'activity_calendar_id' => 'integer',
            'beneficiaries_id' => 'integer',
            'data_collectors_id' => 'integer',
            'created_by' => 'integer',
            'signature' => 'string',
        ];
    }

    public function activityCalendar(): BelongsTo
    {
        return $this->belongsTo(ActivityCalendar::class);
    }

    public function beneficiaries(): BelongsTo
    {
        return $this->belongsTo(Beneficiary::class, 'beneficiaries_id');
    }

    public function dataCollectors(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public static function generarIdentificador($first_names, $last_name, $mother_last_name, $birth_year, $gender)
    {
        $iniciales = strtoupper(
            substr($last_name, 0, 1) .
            substr($mother_last_name, 0, 1) .
            substr($first_names, 0, 1) .
            (isset(explode(' ', $first_names)[1]) ? substr(explode(' ', $first_names)[1], 0, 1) : 'X')
        );
        $anio = $birth_year;
        $sexo = strtoupper(substr($gender, 0, 1));
        $internas = strtoupper(
            (isset($last_name[1]) ? $last_name[1] : 'X') .
            (isset($mother_last_name[1]) ? $mother_last_name[1] : 'X') .
            (isset($first_names[1]) ? $first_names[1] : 'X')
        );
        return $iniciales . $anio . $sexo . $internas;
    }
}

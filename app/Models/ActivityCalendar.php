<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ActivityCalendar extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'activity_id',
        'start_date',
        'end_date',
        'start_hour',
        'end_hour',
        'address_backup',
        'last_modified',
        'cancelled',
        'change_reason',
        'created_by',
        'asigned_person',
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
            'start_date' => 'date',
            'end_date' => 'date',
            'last_modified' => 'timestamp',
            'cancelled' => 'boolean',
            'created_by' => 'integer',
            'asigned_person' => 'integer',
        ];
    }

    public function activity(): BelongsTo
    {
        return $this->belongsTo(Activity::class);
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function asignedPerson(): BelongsTo
    {
        return $this->belongsTo(User::class, 'asigned_person');
    }
}

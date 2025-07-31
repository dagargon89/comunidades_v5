<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ActivityFile extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'month',
        'type',
        'file_path',
        'upload_date',
        'activity_log_id',
        'activity_calendar_id',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'upload_date' => 'datetime',
        ];
    }



    /**
     * Get the activity log that owns the file.
     */
    public function activityLog(): BelongsTo
    {
        return $this->belongsTo(ActivityLog::class, 'activity_log_id');
    }

    /**
     * Get the activity calendar that owns the file.
     */
    public function activityCalendar(): BelongsTo
    {
        return $this->belongsTo(ActivityCalendar::class, 'activity_calendar_id');
    }
}

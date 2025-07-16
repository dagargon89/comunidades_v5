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
        'activity_progress_log_id',
        'activity_log_id',
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
            'upload_date' => 'timestamp',
            'activity_progress_log_id' => 'integer',
            'activity_log_id' => 'integer',
        ];
    }

    public function activityProgressLog(): BelongsTo
    {
        return $this->belongsTo(ActivityProgressLog::class);
    }

    public function activityLog(): BelongsTo
    {
        return $this->belongsTo(ActivityLog::class);
    }
}

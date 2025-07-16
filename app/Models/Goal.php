<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Goal extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'description',
        'number',
        'components_id',
        'components_action_lines_id',
        'components_action_lines_program_id',
        'organizations_id',
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
            'components_id' => 'integer',
            'components_action_lines_id' => 'integer',
            'components_action_lines_program_id' => 'integer',
            'organizations_id' => 'integer',
        ];
    }

    public function components(): BelongsTo
    {
        return $this->belongsTo(Components::class);
    }

    public function componentsActionLines(): BelongsTo
    {
        return $this->belongsTo(ComponentsActionLines::class);
    }

    public function componentsActionLinesProgram(): BelongsTo
    {
        return $this->belongsTo(ComponentsActionLinesProgram::class);
    }

    public function organizations(): BelongsTo
    {
        return $this->belongsTo(Organizations::class);
    }
}

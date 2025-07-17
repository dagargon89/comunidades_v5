<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Component extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'action_lines_id',
        'action_lines_program_id',
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
            'action_lines_id' => 'integer',
            'action_lines_program_id' => 'integer',
        ];
    }

    public function actionLines(): BelongsTo
    {
        return $this->belongsTo(ActionLine::class);
    }

    public function actionLinesProgram(): BelongsTo
    {
        return $this->belongsTo(Program::class);
    }
}

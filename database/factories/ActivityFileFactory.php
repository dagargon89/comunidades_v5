<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\ActivityFile;
use App\Models\ActivityLog;
use App\Models\ActivityProgressLog;

class ActivityFileFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = ActivityFile::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'month' => fake()->regexify('[A-Za-z0-9]{20}'),
            'type' => fake()->regexify('[A-Za-z0-9]{100}'),
            'file_path' => fake()->text(),
            'upload_date' => fake()->dateTime(),
            'activity_log_id' => ActivityLog::factory(),
        ];
    }
}

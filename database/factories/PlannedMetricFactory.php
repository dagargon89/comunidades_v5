<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\Activity;
use App\Models\ActivityProgressLog;
use App\Models\PlannedMetric;

class PlannedMetricFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = PlannedMetric::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'activity_id' => Activity::factory(),
            'unit' => fake()->regexify('[A-Za-z0-9]{100}'),
            'year' => fake()->numberBetween(-10000, 10000),
            'month' => fake()->numberBetween(-10000, 10000),
            'population_target_value' => fake()->randomFloat(2, 0, 99999999.99),
            'population_real_value' => fake()->randomFloat(2, 0, 99999999.99),
            'product_target_value' => fake()->randomFloat(2, 0, 99999999.99),
            'product_real_value' => fake()->randomFloat(2, 0, 99999999.99),
            'activity_progress_log_id' => ActivityProgressLog::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

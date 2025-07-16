<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\Kpi;
use App\Models\Projects;

class KpiFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Kpi::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'description' => fake()->text(),
            'initial_value' => fake()->randomFloat(2, 0, 99999999.99),
            'final_value' => fake()->randomFloat(2, 0, 99999999.99),
            'projects_id' => Projects::factory(),
            'is_percentage' => fake()->boolean(),
            'org_area' => fake()->regexify('[A-Za-z0-9]{100}'),
            'belongsTo' => fake()->word(),
        ];
    }
}

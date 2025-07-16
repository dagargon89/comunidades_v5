<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\Projects;
use App\Models\SpecificObjective;

class SpecificObjectiveFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = SpecificObjective::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'description' => fake()->text(),
            'projects_id' => Projects::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

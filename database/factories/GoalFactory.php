<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\Components;
use App\Models\ComponentsActionLines;
use App\Models\ComponentsActionLinesProgram;
use App\Models\Goal;
use App\Models\Organizations;

class GoalFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Goal::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'description' => fake()->text(),
            'number' => fake()->numberBetween(-10000, 10000),
            'components_id' => Components::factory(),
            'components_action_lines_id' => ComponentsActionLines::factory(),
            'components_action_lines_program_id' => ComponentsActionLinesProgram::factory(),
            'organizations_id' => Organizations::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

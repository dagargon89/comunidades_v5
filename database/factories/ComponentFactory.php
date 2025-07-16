<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\ActionLines;
use App\Models\ActionLinesProgram;
use App\Models\Component;

class ComponentFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Component::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'action_lines_id' => ActionLines::factory(),
            'action_lines_program_id' => ActionLinesProgram::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

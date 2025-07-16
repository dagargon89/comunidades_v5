<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\CreatedBy;
use App\Models\ProjectDisbursement;
use App\Models\Projects;

class ProjectDisbursementFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = ProjectDisbursement::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'projects_id' => Projects::factory(),
            'amount' => fake()->randomFloat(0, 0, 9999999999.),
            'disbursement_date' => fake()->date(),
            'created_by' => CreatedBy::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

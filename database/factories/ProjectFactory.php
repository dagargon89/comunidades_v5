<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\CoFinancier;
use App\Models\CreatedBy;
use App\Models\Financiers;
use App\Models\Project;

class ProjectFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Project::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'background' => fake()->text(),
            'justification' => fake()->text(),
            'general_objective' => fake()->text(),
            'financiers_id' => Financiers::factory(),
            'start_date' => fake()->date(),
            'end_date' => fake()->date(),
            'total_cost' => fake()->randomFloat(0, 0, 9999999999.),
            'funded_amount' => fake()->randomFloat(0, 0, 9999999999.),
            'cofunding_amount' => fake()->randomFloat(0, 0, 9999999999.),
            'monthly_disbursement' => fake()->randomFloat(0, 0, 9999999999.),
            'followup_officer' => fake()->text(),
            'agreement_file' => fake()->text(),
            'project_base_file' => fake()->text(),
            'co_financier_id' => CoFinancier::factory(),
            'created_by' => CreatedBy::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

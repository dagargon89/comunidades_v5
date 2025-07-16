<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\CreatedBy;
use App\Models\ProjectReport;
use App\Models\Projects;

class ProjectReportFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = ProjectReport::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'report_date' => fake()->date(),
            'report_file' => fake()->text(),
            'projects_id' => Projects::factory(),
            'created_by' => CreatedBy::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

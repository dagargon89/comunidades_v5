<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\ActivityCalendar;
use App\Models\Beneficiaries;
use App\Models\BeneficiaryRegistry;
use App\Models\CreatedBy;
use App\Models\DataCollectors;

class BeneficiaryRegistryFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = BeneficiaryRegistry::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'activity_calendar_id' => ActivityCalendar::factory(),
            'beneficiaries_id' => Beneficiaries::factory(),
            'data_collectors_id' => DataCollectors::factory(),
            'created_by' => CreatedBy::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

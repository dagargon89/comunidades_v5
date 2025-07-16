<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\Beneficiary;
use App\Models\CreatedBy;

class BeneficiaryFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Beneficiary::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'last_name' => fake()->lastName(),
            'mother_last_name' => fake()->regexify('[A-Za-z0-9]{100}'),
            'first_names' => fake()->regexify('[A-Za-z0-9]{100}'),
            'birth_year' => fake()->regexify('[A-Za-z0-9]{4}'),
            'gender' => fake()->randomElement(["M","F","Male","Female"]),
            'phone' => fake()->phoneNumber(),
            'signature' => fake()->text(),
            'address_backup' => fake()->text(),
            'created_by' => CreatedBy::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

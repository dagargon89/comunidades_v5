<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\CreatedBy;
use App\Models\Location;
use App\Models\Polygons;

class LocationFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Location::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'name' => fake()->name(),
            'category' => fake()->regexify('[A-Za-z0-9]{50}'),
            'street' => fake()->streetName(),
            'neighborhood' => fake()->regexify('[A-Za-z0-9]{100}'),
            'ext_number' => fake()->numberBetween(-10000, 10000),
            'int_number' => fake()->numberBetween(-10000, 10000),
            'google_place_id' => fake()->regexify('[A-Za-z0-9]{500}'),
            'polygons_id' => Polygons::factory(),
            'created_by' => CreatedBy::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

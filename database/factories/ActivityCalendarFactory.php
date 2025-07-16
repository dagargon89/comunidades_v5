<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;
use App\Models\Activity;
use App\Models\ActivityCalendar;
use App\Models\AsignedPerson;
use App\Models\CreatedBy;

class ActivityCalendarFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = ActivityCalendar::class;

    /**
     * Define the model's default state.
     */
    public function definition(): array
    {
        return [
            'activity_id' => Activity::factory(),
            'start_date' => fake()->date(),
            'end_date' => fake()->date(),
            'start_hour' => fake()->time(),
            'end_hour' => fake()->time(),
            'address_backup' => fake()->text(),
            'last_modified' => fake()->dateTime(),
            'cancelled' => fake()->boolean(),
            'change_reason' => fake()->text(),
            'created_by' => CreatedBy::factory(),
            'asigned_person' => AsignedPerson::factory(),
            'belongsTo' => fake()->word(),
        ];
    }
}

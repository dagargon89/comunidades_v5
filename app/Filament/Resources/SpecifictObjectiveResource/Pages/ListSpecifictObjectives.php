<?php

namespace App\Filament\Resources\SpecifictObjectiveResource\Pages;

use App\Filament\Resources\SpecifictObjectiveResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListSpecifictObjectives extends ListRecords
{
    protected static string $resource = SpecifictObjectiveResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

<?php

namespace App\Filament\Resources\SpecifictObjectiveResource\Pages;

use App\Filament\Resources\SpecifictObjectiveResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditSpecifictObjective extends EditRecord
{
    protected static string $resource = SpecifictObjectiveResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}

<?php

namespace App\Filament\Resources\SpecificObjetiveResource\Pages;

use App\Filament\Resources\SpecificObjetiveResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditSpecificObjetive extends EditRecord
{
    protected static string $resource = SpecificObjetiveResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}

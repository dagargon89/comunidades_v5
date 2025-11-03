<?php

namespace App\Filament\Resources\ActivityNarrativeResource\Pages;

use App\Filament\Resources\ActivityNarrativeResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditActivityNarrative extends EditRecord
{
    protected static string $resource = ActivityNarrativeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}

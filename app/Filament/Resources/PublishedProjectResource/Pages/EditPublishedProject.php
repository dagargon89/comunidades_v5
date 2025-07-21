<?php

namespace App\Filament\Resources\PublishedProjectResource\Pages;

use App\Filament\Resources\PublishedProjectResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditPublishedProject extends EditRecord
{
    protected static string $resource = PublishedProjectResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}

<?php

namespace App\Filament\Resources\DataPublicationResource\Pages;

use App\Filament\Resources\DataPublicationResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditDataPublication extends EditRecord
{
    protected static string $resource = DataPublicationResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}

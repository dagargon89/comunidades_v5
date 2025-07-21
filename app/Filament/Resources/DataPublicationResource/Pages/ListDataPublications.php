<?php

namespace App\Filament\Resources\DataPublicationResource\Pages;

use App\Filament\Resources\DataPublicationResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListDataPublications extends ListRecords
{
    protected static string $resource = DataPublicationResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

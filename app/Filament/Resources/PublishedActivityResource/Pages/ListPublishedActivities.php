<?php

namespace App\Filament\Resources\PublishedActivityResource\Pages;

use App\Filament\Resources\PublishedActivityResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListPublishedActivities extends ListRecords
{
    protected static string $resource = PublishedActivityResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

<?php

namespace App\Filament\Resources\PublishedProjectResource\Pages;

use App\Filament\Resources\PublishedProjectResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListPublishedProjects extends ListRecords
{
    protected static string $resource = PublishedProjectResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

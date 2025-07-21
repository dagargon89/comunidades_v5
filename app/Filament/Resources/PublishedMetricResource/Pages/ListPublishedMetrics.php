<?php

namespace App\Filament\Resources\PublishedMetricResource\Pages;

use App\Filament\Resources\PublishedMetricResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListPublishedMetrics extends ListRecords
{
    protected static string $resource = PublishedMetricResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

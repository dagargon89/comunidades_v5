<?php

namespace App\Filament\Resources\AxeResource\Pages;

use App\Filament\Resources\AxeResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListAxes extends ListRecords
{
    protected static string $resource = AxeResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

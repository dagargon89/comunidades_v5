<?php

namespace App\Filament\Resources\ProjectDisbursementResource\Pages;

use App\Filament\Resources\ProjectDisbursementResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListProjectDisbursements extends ListRecords
{
    protected static string $resource = ProjectDisbursementResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

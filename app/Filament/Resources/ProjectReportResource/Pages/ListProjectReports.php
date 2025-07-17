<?php

namespace App\Filament\Resources\ProjectReportResource\Pages;

use App\Filament\Resources\ProjectReportResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListProjectReports extends ListRecords
{
    protected static string $resource = ProjectReportResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}

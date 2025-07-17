<?php

namespace App\Filament\Resources\ProjectReportResource\Pages;

use App\Filament\Resources\ProjectReportResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditProjectReport extends EditRecord
{
    protected static string $resource = ProjectReportResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}

<?php

namespace App\Filament\Resources\ProjectResource\Pages;

use App\Filament\Resources\ProjectResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;
use Filament\Notifications\Notification;

class EditProject extends EditRecord
{
    protected static string $resource = ProjectResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make()
                ->before(function ($record) {
                    // Asegurar que se ejecute la lógica de borrado en cascada del modelo
                    $record->delete();

                    Notification::make()
                        ->title('Proyecto eliminado correctamente')
                        ->success()
                        ->send();

                    // Redirigir a la lista de proyectos
                    return redirect()->route('filament.admin.resources.proyectos.index');
                })
                ->after(function ($record) {
                    // Este método no se ejecutará porque ya eliminamos el registro en before()
                }),
        ];
    }
}

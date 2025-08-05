<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\User;

class EnableDataPublicationPermission extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'users:enable-publication
                            {user_id : ID del usuario}
                            {--disable : Deshabilitar permisos en lugar de habilitar}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Habilita o deshabilita permisos de publicación de datos para un usuario específico';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $userId = $this->argument('user_id');
        $disable = $this->option('disable');

        // Buscar el usuario
        $user = User::find($userId);

        if (!$user) {
            $this->error("No se encontró un usuario con ID: {$userId}");
            return 1;
        }

        // Actualizar permisos
        $newPermission = $disable ? 0 : 1;
        $user->update(['can_publish_data' => $newPermission]);

        $action = $disable ? 'deshabilitados' : 'habilitados';
        $this->info("Permisos de publicación {$action} para el usuario: {$user->name} ({$user->email})");

        // Mostrar estado actual
        $status = $user->can_publish_data ? 'HABILITADO' : 'DESHABILITADO';
        $this->info("Estado actual: {$status}");

        return 0;
    }
}

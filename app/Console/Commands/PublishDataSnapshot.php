<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class PublishDataSnapshot extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'data:publish-snapshot
                            {--user-id= : ID del usuario que publica}
                            {--notes= : Notas de la publicación}
                            {--period-from= : Fecha de inicio del período (YYYY-MM-DD)}
                            {--period-to= : Fecha de fin del período (YYYY-MM-DD)}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Ejecuta el procedimiento almacenado PublishDataSnapshot para publicar datos';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $userId = $this->option('user-id');
        $notes = $this->option('notes') ?? 'Publicación automática';
        $periodFrom = $this->option('period-from');
        $periodTo = $this->option('period-to');

        // Validar que el usuario existe
        if ($userId && !DB::table('users')->where('id', $userId)->exists()) {
            $this->error('El usuario especificado no existe.');
            return 1;
        }

        // Si no se especifica usuario, usar el primer usuario con permisos de publicación
        if (!$userId) {
            $user = DB::table('users')
                ->where('can_publish_data', 1)
                ->first();

            if (!$user) {
                $this->error('No se encontró un usuario con permisos de publicación.');
                return 1;
            }

            $userId = $user->id;
        }

        try {
            $this->info('Iniciando publicación de datos...');

            // Ejecutar el procedimiento almacenado
            $result = DB::select('CALL PublishDataSnapshot(?, ?, ?, ?)', [
                $userId,
                $notes,
                $periodFrom,
                $periodTo
            ]);

            if (!empty($result)) {
                $data = $result[0];
                $this->info('Publicación completada exitosamente:');
                $this->info("- ID de publicación: {$data->publication_id}");
                $this->info("- Proyectos publicados: {$data->projects_published}");
                $this->info("- Actividades publicadas: {$data->activities_published}");
                $this->info("- Métricas publicadas: {$data->metrics_published}");
                $this->info("- Estado: {$data->status}");
            } else {
                $this->error('No se recibió respuesta del procedimiento almacenado.');
                return 1;
            }

        } catch (\Exception $e) {
            $this->error('Error al ejecutar la publicación: ' . $e->getMessage());
            return 1;
        }

        return 0;
    }
}

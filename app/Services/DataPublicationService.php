<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class DataPublicationService
{
    /**
     * Ejecuta el procedimiento almacenado PublishDataSnapshot
     *
     * @param int $userId ID del usuario que publica
     * @param string|null $notes Notas de la publicación
     * @param string|null $periodFrom Fecha de inicio del período (YYYY-MM-DD)
     * @param string|null $periodTo Fecha de fin del período (YYYY-MM-DD)
     * @return array Resultado de la publicación
     * @throws \Exception
     */
    public function publishDataSnapshot($userId, $notes = null, $periodFrom = null, $periodTo = null)
    {
        // Validar que el usuario existe
        if (!DB::table('users')->where('id', $userId)->exists()) {
            throw new \Exception('El usuario especificado no existe.');
        }

        // Validar fechas si se proporcionan
        if ($periodFrom && !$this->isValidDate($periodFrom)) {
            throw new \Exception('Formato de fecha de inicio inválido. Use YYYY-MM-DD');
        }

        if ($periodTo && !$this->isValidDate($periodTo)) {
            throw new \Exception('Formato de fecha de fin inválido. Use YYYY-MM-DD');
        }

        // Validar que el rango de fechas sea válido
        if ($periodFrom && $periodTo && $periodFrom > $periodTo) {
            throw new \Exception('La fecha de inicio no puede ser posterior a la fecha de fin.');
        }

        try {
            // Ejecutar el procedimiento almacenado
            $result = DB::select('CALL PublishDataSnapshot(?, ?, ?, ?)', [
                $userId,
                $notes ?? 'Publicación desde aplicación',
                $periodFrom,
                $periodTo
            ]);

            if (empty($result)) {
                throw new \Exception('No se recibió respuesta del procedimiento almacenado.');
            }

            return (array) $result[0];

        } catch (\Exception $e) {
            // Re-lanzar la excepción con un mensaje más descriptivo
            throw new \Exception('Error al ejecutar la publicación: ' . $e->getMessage());
        }
    }

    /**
     * Obtiene el historial de publicaciones
     *
     * @param int|null $limit Límite de registros a retornar
     * @return \Illuminate\Support\Collection
     */
    public function getPublicationHistory($limit = null)
    {
        $query = \App\Models\DataPublication::with('publishedBy')
            ->orderBy('publication_date', 'desc');

        if ($limit) {
            $query->limit($limit);
        }

        return $query->get();
    }

    /**
     * Obtiene estadísticas de publicaciones
     *
     * @return array
     */
    public function getPublicationStats()
    {
        $stats = \App\Models\DataPublication::selectRaw('
                COUNT(*) as total_publications,
                SUM(projects_count) as total_projects_published,
                SUM(activities_count) as total_activities_published,
                SUM(metrics_count) as total_metrics_published,
                MAX(publication_date) as last_publication_date
            ')
            ->first();

        return $stats ? $stats->toArray() : [
            'total_publications' => 0,
            'total_projects_published' => 0,
            'total_activities_published' => 0,
            'total_metrics_published' => 0,
            'last_publication_date' => null,
        ];
    }

    /**
     * Valida si una fecha tiene el formato correcto
     *
     * @param string $date
     * @return bool
     */
    private function isValidDate($date)
    {
        return preg_match('/^\d{4}-\d{2}-\d{2}$/', $date) &&
               Carbon::createFromFormat('Y-m-d', $date) !== false;
    }

    /**
     * Obtiene las publicaciones de un período específico
     *
     * @param string $startDate Fecha de inicio (YYYY-MM-DD)
     * @param string $endDate Fecha de fin (YYYY-MM-DD)
     * @return \Illuminate\Support\Collection
     */
    public function getPublicationsByPeriod($startDate, $endDate)
    {
        return \App\Models\DataPublication::with('publishedBy')
            ->whereBetween('publication_date', [$startDate, $endDate])
            ->orderBy('publication_date', 'desc')
            ->get();
    }
}

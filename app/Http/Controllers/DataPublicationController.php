<?php

namespace App\Http\Controllers;

use App\Services\DataPublicationService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class DataPublicationController extends Controller
{
    protected $dataPublicationService;

    public function __construct(DataPublicationService $dataPublicationService)
    {
        $this->dataPublicationService = $dataPublicationService;
    }

    /**
     * Muestra la página de publicaciones
     */
    public function index()
    {
        $publications = $this->dataPublicationService->getPublicationHistory(10);
        $stats = $this->dataPublicationService->getPublicationStats();

        return view('data-publications.index', compact('publications', 'stats'));
    }

    /**
     * Ejecuta una nueva publicación
     */
    public function publish(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'notes' => 'nullable|string|max:1000',
            'period_from' => 'nullable|date_format:Y-m-d',
            'period_to' => 'nullable|date_format:Y-m-d|after_or_equal:period_from',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Datos de entrada inválidos',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $userId = Auth::id();

            $result = $this->dataPublicationService->publishDataSnapshot(
                $userId,
                $request->input('notes'),
                $request->input('period_from'),
                $request->input('period_to')
            );

            return response()->json([
                'success' => true,
                'message' => 'Publicación completada exitosamente',
                'data' => $result
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al ejecutar la publicación: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Obtiene el historial de publicaciones
     */
    public function getHistory(Request $request): JsonResponse
    {
        $limit = $request->input('limit', 10);
        $publications = $this->dataPublicationService->getPublicationHistory($limit);

        return response()->json([
            'success' => true,
            'data' => $publications
        ]);
    }

    /**
     * Obtiene estadísticas de publicaciones
     */
    public function getStats(): JsonResponse
    {
        $stats = $this->dataPublicationService->getPublicationStats();

        return response()->json([
            'success' => true,
            'data' => $stats
        ]);
    }

    /**
     * Obtiene publicaciones por período
     */
    public function getByPeriod(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'start_date' => 'required|date_format:Y-m-d',
            'end_date' => 'required|date_format:Y-m-d|after_or_equal:start_date',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Fechas inválidas',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            $publications = $this->dataPublicationService->getPublicationsByPeriod(
                $request->input('start_date'),
                $request->input('end_date')
            );

            return response()->json([
                'success' => true,
                'data' => $publications
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener publicaciones: ' . $e->getMessage()
            ], 500);
        }
    }
}

<?php

use Illuminate\Support\Facades\Route;
use App\Models\ActivityFile;
use App\Http\Controllers\DataPublicationController;
use Illuminate\Support\Facades\Storage;

// Ruta principal
Route::get('/', function () {
    return view('welcome');
})->name('welcome');

// Ruta para descargar archivos de actividades
Route::get('/download-activity-file/{id}', function ($id) {
    $activityFile = ActivityFile::findOrFail($id);

    // Verificar que el archivo existe
    if (!Storage::disk('public')->exists($activityFile->file_path)) {
        abort(404, 'Archivo no encontrado');
    }

    // Obtener la ruta completa del archivo
    $filePath = Storage::disk('public')->path($activityFile->file_path);

    // Obtener el nombre original del archivo
    $fileName = basename($activityFile->file_path);

    // Retornar la descarga del archivo
    return response()->download($filePath, $fileName);
})->name('download.activity.file');

// Rutas para publicaciones de datos
Route::middleware(['auth'])->group(function () {
    Route::get('/data-publications', [DataPublicationController::class, 'index'])->name('data-publications.index');
    Route::post('/data-publications/publish', [DataPublicationController::class, 'publish'])->name('data-publications.publish');
    Route::get('/data-publications/history', [DataPublicationController::class, 'getHistory'])->name('data-publications.history');
    Route::get('/data-publications/stats', [DataPublicationController::class, 'getStats'])->name('data-publications.stats');
    Route::get('/data-publications/by-period', [DataPublicationController::class, 'getByPeriod'])->name('data-publications.by-period');

    // Ruta para descargar informe narrativo
    Route::get('/admin/informe-narrativo/descargar', [App\Http\Controllers\InformeNarrativoController::class, 'descargar'])->name('admin.informe-narrativo.descargar');
});

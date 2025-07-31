<?php

use Illuminate\Support\Facades\Route;
use App\Models\ActivityFile;
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

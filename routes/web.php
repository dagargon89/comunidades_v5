<?php

use Illuminate\Support\Facades\Route;
// use App\Livewire\Auth\LoginForm;

// Ruta principal - redirige al panel de administración de Filament
Route::get('/', function () {
    return redirect('/admin');
})->name('welcome');

/*
// Rutas de autenticación
Route::get('/login', function () {
    return view('auth.login');
})->name('login');

// Rutas protegidas por autenticación
Route::middleware(['auth'])->group(function () {

    // Dashboard para coordinadores
    Route::get('/coordinador/dashboard', function () {
        return view('coordinador.dashboard');
    })->name('coordinador.dashboard');

    // Dashboard para capturistas
    Route::get('/capturista/dashboard', function () {
        return view('capturista.dashboard');
    })->name('capturista.dashboard');

    // Rutas del capturista
    Route::prefix('capturista')->name('capturista.')->group(function () {
        Route::get('/beneficiary-capture', function () {
            return view('capturista.beneficiary-capture');
        })->name('beneficiary-capture');
    });

    // Dashboard para financiadoras
    Route::get('/financiadora/dashboard', function () {
        return view('financiadora.dashboard');
    })->name('financiadora.dashboard');

    // Logout
    Route::post('/logout', function () {
        auth()->logout();
        return redirect()->route('welcome');
    })->name('logout');
});
*/

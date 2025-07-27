<?php

namespace App\Livewire\Auth;

use Livewire\Component;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class LoginForm extends Component
{
    public $email = '';
    public $password = '';
    public $remember = false;
    public $isLoading = false;

    protected $rules = [
        'email' => 'required|email',
        'password' => 'required|min:6',
    ];

    protected $messages = [
        'email.required' => 'El correo electrónico es obligatorio.',
        'email.email' => 'El formato del correo electrónico no es válido.',
        'password.required' => 'La contraseña es obligatoria.',
        'password.min' => 'La contraseña debe tener al menos 6 caracteres.',
    ];

    public function login()
    {
        $this->isLoading = true;

        try {
            $this->validate();

            if (Auth::attempt(['email' => $this->email, 'password' => $this->password], $this->remember)) {
                $user = Auth::user();

                // Redirigir según el rol del usuario
                return $this->redirectBasedOnRole($user);
            } else {
                throw ValidationException::withMessages([
                    'email' => ['Las credenciales proporcionadas no coinciden con nuestros registros.'],
                ]);
            }
        } catch (ValidationException $e) {
            $this->isLoading = false;
            throw $e;
        }
    }

    private function redirectBasedOnRole($user)
    {
        // Verificar si tiene rol de admin o super_admin
        if ($user->hasRole(['admin', 'super_admin'])) {
            return redirect()->route('filament.admin.pages.dashboard');
        }

        // Verificar si tiene rol de coordinador
        if ($user->hasRole('coordinador')) {
            return redirect()->route('coordinador.dashboard');
        }

        // Verificar si tiene rol de capturista
        if ($user->hasRole('capturista')) {
            return redirect()->route('capturista.dashboard');
        }

        // Verificar si es financiadora
        if ($user->hasRole('financiadora')) {
            return redirect()->route('financiadora.dashboard');
        }

        // Por defecto, redirigir a Filament si no tiene rol específico
        return redirect()->route('filament.admin.pages.dashboard');
    }

    public function render()
    {
        return view('livewire.auth.login-form');
    }
}

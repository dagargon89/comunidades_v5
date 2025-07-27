<?php

namespace App\Livewire;

use Livewire\Component;

class WelcomePage extends Component
{
    public $welcomeMessage = 'Bienvenido a la Plataforma de Planeación Estratégica';

    public function render()
    {
        return view('livewire.welcome-page');
    }
}

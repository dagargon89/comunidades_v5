<?php

require_once 'vendor/autoload.php';

use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Config;

// Cargar la aplicación Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

try {
    echo "Probando configuración de correo...\n";
    echo "MAIL_MAILER: " . config('mail.default') . "\n";
    echo "MAIL_HOST: " . config('mail.mailers.smtp.host') . "\n";
    echo "MAIL_PORT: " . config('mail.mailers.smtp.port') . "\n";
    echo "MAIL_USERNAME: " . config('mail.mailers.smtp.username') . "\n";
    echo "MAIL_FROM_ADDRESS: " . config('mail.from.address') . "\n";

    // Enviar correo de prueba
    Mail::raw('Este es un correo de prueba desde Laravel', function($message) {
        $message->to('contacto@planjuarez.org')
                ->subject('Prueba de Configuración de Correo');
    });

    echo "\n✅ Correo enviado exitosamente!\n";

} catch (Exception $e) {
    echo "\n❌ Error al enviar correo: " . $e->getMessage() . "\n";
    echo "Detalles del error: " . $e->getTraceAsString() . "\n";
}

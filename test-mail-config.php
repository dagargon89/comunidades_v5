<?php

require_once 'vendor/autoload.php';

use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Config;

// Cargar la aplicación Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "=== PRUEBA DE CONFIGURACIÓN DE CORREO ===\n\n";

// Configuración actual
echo "Configuración actual:\n";
echo "- MAIL_MAILER: " . config('mail.default') . "\n";
echo "- MAIL_HOST: " . config('mail.mailers.smtp.host') . "\n";
echo "- MAIL_PORT: " . config('mail.mailers.smtp.port') . "\n";
echo "- MAIL_USERNAME: " . config('mail.mailers.smtp.username') . "\n";
echo "- MAIL_FROM_ADDRESS: " . config('mail.from.address') . "\n\n";

// Probar con configuración de log para desarrollo
echo "=== PROBANDO CON CONFIGURACIÓN DE LOG ===\n";

// Cambiar temporalmente a log
config(['mail.default' => 'log']);

try {
    Mail::raw('Este es un correo de prueba usando LOG', function($message) {
        $message->to('contacto@planjuarez.org')
                ->subject('Prueba de Configuración - LOG');
    });

    echo "✅ Correo guardado en log exitosamente!\n";
    echo "📁 Revisa: storage/logs/laravel.log\n\n";

} catch (Exception $e) {
    echo "❌ Error con LOG: " . $e->getMessage() . "\n\n";
}

echo "=== INSTRUCCIONES PARA CONFIGURAR GMAIL ===\n";
echo "1. Ve a: https://myaccount.google.com/\n";
echo "2. Seguridad → Verificación en 2 pasos\n";
echo "3. Contraseñas de aplicación → Generar nueva\n";
echo "4. Usa esa contraseña en MAIL_PASSWORD\n";
echo "5. Agrega: MAIL_ENCRYPTION=tls\n\n";

echo "=== CONFIGURACIÓN RECOMENDADA PARA GMAIL ===\n";
echo "MAIL_MAILER=smtp\n";
echo "MAIL_HOST=smtp.gmail.com\n";
echo "MAIL_PORT=587\n";
echo "MAIL_USERNAME=contacto@planjuarez.org\n";
echo "MAIL_PASSWORD=TU_CONTRASEÑA_DE_APLICACIÓN\n";
echo "MAIL_ENCRYPTION=tls\n";
echo "MAIL_FROM_ADDRESS=contacto@planjuarez.org\n";
echo "MAIL_FROM_NAME=\"Planeación Estratégica\"\n";

<?php

namespace App\Notifications;

use App\Models\Project;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use Filament\Notifications\Notification as FilamentNotification;

class InformeGeneradoNotification extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(
        public Project $proyecto,
        public ?string $batchId = null,
        public int $totalEventos = 0,
        public int $exitosos = 0
    ) {}

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database']; // Solo database para Filament
        // Si quieres email también: return ['database', 'mail'];
    }

    /**
     * Get the mail representation of the notification (opcional).
     */
    public function toMail(object $notifiable): MailMessage
    {
        $fallidos = $this->totalEventos - $this->exitosos;

        return (new MailMessage)
            ->subject("Informe narrativo generado - {$this->proyecto->name}")
            ->greeting("¡Hola {$notifiable->name}!")
            ->line("Tu informe narrativo ha sido generado exitosamente.")
            ->line("**Proyecto:** {$this->proyecto->name}")
            ->line("**Eventos procesados:** {$this->totalEventos}")
            ->line("**Narrativas generadas:** {$this->exitosos}")
            ->when($fallidos > 0, function ($mail) use ($fallidos) {
                return $mail->line("⚠️ **Eventos con error:** {$fallidos}");
            })
            ->action('Ver Informe', url('/admin/generar-informe-narrativo'))
            ->line('El informe está listo para descargar.')
            ->salutation('Equipo de ' . config('app.name'));
    }

    /**
     * Get the array representation of the notification (para Filament).
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        $fallidos = $this->totalEventos - $this->exitosos;

        return [
            'proyecto_id' => $this->proyecto->id,
            'proyecto_nombre' => $this->proyecto->name,
            'batch_id' => $this->batchId,
            'total_eventos' => $this->totalEventos,
            'exitosos' => $this->exitosos,
            'fallidos' => $fallidos,
            'icon' => $fallidos > 0 ? 'heroicon-o-exclamation-triangle' : 'heroicon-o-check-circle',
            'color' => $fallidos > 0 ? 'warning' : 'success',
            'title' => $fallidos > 0
                ? "Informe generado con {$fallidos} errores"
                : '✅ Informe narrativo generado',
            'body' => "Se procesaron {$this->exitosos} de {$this->totalEventos} eventos para el proyecto '{$this->proyecto->name}'.",
        ];
    }

    /**
     * Enviar notificación Filament (in-app)
     */
    public function toFilament(object $notifiable): FilamentNotification
    {
        $fallidos = $this->totalEventos - $this->exitosos;

        return FilamentNotification::make()
            ->title($fallidos > 0
                ? "Informe generado con {$fallidos} errores"
                : '✅ Informe narrativo generado')
            ->body("Se procesaron {$this->exitosos} de {$this->totalEventos} eventos para el proyecto '{$this->proyecto->name}'.")
            ->icon($fallidos > 0 ? 'heroicon-o-exclamation-triangle' : 'heroicon-o-check-circle')
            ->iconColor($fallidos > 0 ? 'warning' : 'success')
            ->actions([
                \Filament\Notifications\Actions\Action::make('ver')
                    ->label('Ver Informe')
                    ->url('/admin/generar-informe-narrativo')
                    ->button(),
            ])
            ->persistent(); // No se cierra automáticamente
    }
}

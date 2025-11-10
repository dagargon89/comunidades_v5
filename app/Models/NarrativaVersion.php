<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class NarrativaVersion extends Model
{
    protected $fillable = [
        'activity_narrative_id',
        'version_number',
        'narrativa_generada',
        'narrativa_contexto',
        'narrativa_desarrollo',
        'narrativa_resultados',
        'participantes_count',
        'organizaciones_participantes',
        'modelo_usado',
        'temperatura',
        'tokens_usados',
        'tiempo_generacion',
        'prompt_usado',
        'created_by',
        'tipo_cambio',
        'motivo_cambio',
    ];

    protected $casts = [
        'temperatura' => 'decimal:2',
        'tiempo_generacion' => 'decimal:2',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    // Relaciones
    public function narrativa(): BelongsTo
    {
        return $this->belongsTo(ActivityNarrative::class, 'activity_narrative_id');
    }

    public function createdBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    // Métodos útiles
    public function restaurar(): bool
    {
        // Restaura esta versión como la actual
        $this->narrativa->update([
            'narrativa_generada' => $this->narrativa_generada,
            'narrativa_contexto' => $this->narrativa_contexto,
            'narrativa_desarrollo' => $this->narrativa_desarrollo,
            'narrativa_resultados' => $this->narrativa_resultados,
            'participantes_count' => $this->participantes_count,
            'organizaciones_participantes' => $this->organizaciones_participantes,
        ]);

        // Crea nueva versión tipo "restauracion"
        $this->narrativa->crearVersion(
            tipoCambio: 'restauracion',
            motivo: "Restaurada desde versión {$this->version_number}"
        );

        return true;
    }

    public function getTipoCambioFormattedAttribute(): string
    {
        return match($this->tipo_cambio) {
            'generacion_inicial' => 'Generación Inicial',
            'regeneracion_automatica' => 'Regeneración Automática',
            'edicion_manual' => 'Edición Manual',
            'restauracion' => 'Restauración',
            default => $this->tipo_cambio,
        };
    }

    public function getColorBadgeAttribute(): string
    {
        return match($this->tipo_cambio) {
            'generacion_inicial' => 'success',
            'regeneracion_automatica' => 'warning',
            'edicion_manual' => 'info',
            'restauracion' => 'primary',
            default => 'gray',
        };
    }
}

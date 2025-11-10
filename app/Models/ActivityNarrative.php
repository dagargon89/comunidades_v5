<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ActivityNarrative extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'activity_narratives';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'activity_calendar_id',
        'narrativa_contexto',
        'narrativa_desarrollo',
        'narrativa_resultados',
        'organizaciones_participantes',
        'participantes_count',
        'narrativa_generada',
        'narrativa_aprobada',
        'narrativa_regenerada_at',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'id' => 'integer',
            'activity_calendar_id' => 'integer',
            'participantes_count' => 'integer',
            'narrativa_aprobada' => 'boolean',
            'narrativa_regenerada_at' => 'datetime',
        ];
    }

    /**
     * Relación: Pertenece a un ActivityCalendar (evento)
     */
    public function activityCalendar(): BelongsTo
    {
        return $this->belongsTo(ActivityCalendar::class, 'activity_calendar_id');
    }

    /**
     * Regenera la narrativa (limpia para nueva generación)
     */
    public function regenerarNarrativa(): void
    {
        $this->update([
            'narrativa_generada' => null,
            'narrativa_aprobada' => false,
            'narrativa_regenerada_at' => now(),
        ]);
    }

    /**
     * Marca la narrativa como aprobada
     */
    public function marcarAprobada(): void
    {
        $this->update([
            'narrativa_aprobada' => true,
        ]);
    }

    /**
     * Marca la narrativa como no aprobada
     */
    public function marcarNoAprobada(): void
    {
        $this->update([
            'narrativa_aprobada' => false,
        ]);
    }

    /**
     * Verifica si la narrativa necesita ser generada
     */
    public function requiresNarrativa(): bool
    {
        return $this->narrativa_generada === null ||
               ($this->narrativa_aprobada === false && $this->narrativa_regenerada_at === null);
    }

    /**
     * Verifica si tiene datos suficientes para generar narrativa
     */
    public function tieneDatosSuficientes(): bool
    {
        return !empty($this->narrativa_contexto) ||
               !empty($this->narrativa_desarrollo) ||
               !empty($this->narrativa_resultados);
    }

    /**
     * Obtiene el array de organizaciones participantes
     */
    public function getOrganizacionesArray(): array
    {
        if (empty($this->organizaciones_participantes)) {
            return [];
        }

        return array_map('trim', explode(',', $this->organizaciones_participantes));
    }

    /**
     * Scope: Narrativas aprobadas
     */
    public function scopeConNarrativaAprobada($query)
    {
        return $query->where('narrativa_aprobada', true);
    }

    /**
     * Scope: Sin narrativa generada
     */
    public function scopeSinNarrativaGenerada($query)
    {
        return $query->whereNull('narrativa_generada');
    }

    /**
     * Scope: Con narrativa generada
     */
    public function scopeConNarrativaGenerada($query)
    {
        return $query->whereNotNull('narrativa_generada');
    }

    /**
     * Scope: Pendientes de aprobación
     */
    public function scopePendientesAprobacion($query)
    {
        return $query->whereNotNull('narrativa_generada')
                    ->where('narrativa_aprobada', false);
    }

    /**
     * Accessor: Obtiene la fecha formateada del evento relacionado
     */
    public function getFechaFormateadaAttribute(): ?string
    {
        if (!$this->activityCalendar || !$this->activityCalendar->start_date) {
            return null;
        }

        $meses = [
            1 => 'enero', 2 => 'febrero', 3 => 'marzo', 4 => 'abril',
            5 => 'mayo', 6 => 'junio', 7 => 'julio', 8 => 'agosto',
            9 => 'septiembre', 10 => 'octubre', 11 => 'noviembre', 12 => 'diciembre'
        ];

        $fecha = $this->activityCalendar->start_date;
        return $fecha->day . ' de ' . $meses[$fecha->month] . ' de ' . $fecha->year;
    }

    /**
     * Relación: Tiene muchas versiones
     */
    public function versions(): HasMany
    {
        return $this->hasMany(NarrativaVersion::class, 'activity_narrative_id')
            ->orderBy('version_number', 'desc');
    }

    /**
     * Obtiene la versión más reciente
     */
    public function versionActual()
    {
        return $this->versions()->latest('created_at')->first();
    }

    /**
     * Crea una nueva versión de la narrativa
     */
    public function crearVersion(
        string $tipoCambio = 'generacion_inicial',
        ?string $motivo = null,
        ?float $tiempoGeneracion = null,
        ?string $modeloUsado = null
    ): NarrativaVersion {
        $numeroVersion = $this->versions()->max('version_number') + 1;

        return $this->versions()->create([
            'version_number' => $numeroVersion,
            'narrativa_generada' => $this->narrativa_generada,
            'narrativa_contexto' => $this->narrativa_contexto,
            'narrativa_desarrollo' => $this->narrativa_desarrollo,
            'narrativa_resultados' => $this->narrativa_resultados,
            'participantes_count' => $this->participantes_count,
            'organizaciones_participantes' => $this->organizaciones_participantes,
            'modelo_usado' => $modeloUsado ?? config('services.ollama.model'),
            'temperatura' => config('services.ollama.temperature'),
            'tiempo_generacion' => $tiempoGeneracion,
            'created_by' => auth()->id(),
            'tipo_cambio' => $tipoCambio,
            'motivo_cambio' => $motivo,
        ]);
    }

    /**
     * Obtiene el total de versiones
     */
    public function getTotalVersionesAttribute(): int
    {
        return $this->versions()->count();
    }
}

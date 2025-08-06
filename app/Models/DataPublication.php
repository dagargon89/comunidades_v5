<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class DataPublication extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'publication_date',
        'published_by',
        'publication_notes',
        'period_from',
        'period_to',
        'projects_count',
        'activities_count',
        'metrics_count',
    ];

    protected $casts = [
        'publication_date' => 'datetime',
        'period_from' => 'date',
        'period_to' => 'date',
        'projects_count' => 'integer',
        'activities_count' => 'integer',
        'metrics_count' => 'integer',
    ];

    /**
     * Relación con el usuario que realizó la publicación
     */
    public function publishedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'published_by');
    }

    /**
     * Relación con los proyectos publicados
     */
    public function publishedProjects(): HasMany
    {
        return $this->hasMany(PublishedProject::class, 'publication_id');
    }

    /**
     * Relación con las actividades publicadas
     */
    public function publishedActivities(): HasMany
    {
        return $this->hasMany(PublishedActivity::class, 'publication_id');
    }

    /**
     * Relación con las métricas publicadas
     */
    public function publishedMetrics(): HasMany
    {
        return $this->hasMany(PublishedMetric::class, 'publication_id');
    }

    /**
     * Scope para filtrar por usuario
     */
    public function scopeByUser($query, $userId)
    {
        return $query->where('published_by', $userId);
    }

    /**
     * Scope para filtrar por rango de fechas
     */
    public function scopeByDateRange($query, $startDate, $endDate)
    {
        return $query->whereBetween('publication_date', [$startDate, $endDate]);
    }

    /**
     * Scope para obtener publicaciones recientes
     */
    public function scopeRecent($query, $days = 30)
    {
        return $query->where('publication_date', '>=', now()->subDays($days));
    }

    /**
     * Obtener estadísticas de la publicación
     */
    public function getStatsAttribute(): array
    {
        return [
            'projects_count' => $this->projects_count,
            'activities_count' => $this->activities_count,
            'metrics_count' => $this->metrics_count,
            'total_items' => $this->projects_count + $this->activities_count + $this->metrics_count,
        ];
    }

    /**
     * Verificar si la publicación tiene datos
     */
    public function hasData(): bool
    {
        return $this->projects_count > 0 || $this->activities_count > 0 || $this->metrics_count > 0;
    }

    /**
     * Obtener el período de la publicación como texto
     */
    public function getPeriodTextAttribute(): string
    {
        if ($this->period_from && $this->period_to) {
            return "Del " . $this->period_from->format('d/m/Y') . " al " . $this->period_to->format('d/m/Y');
        } elseif ($this->period_from) {
            return "Desde " . $this->period_from->format('d/m/Y');
        } elseif ($this->period_to) {
            return "Hasta " . $this->period_to->format('d/m/Y');
        }

        return "Todos los datos";
    }

    /**
     * Obtener el estado de la publicación
     */
    public function getStatusAttribute(): string
    {
        if ($this->hasData()) {
            return 'Completada';
        }

        return 'Pendiente';
    }

    /**
     * Obtener el color del estado
     */
    public function getStatusColorAttribute(): string
    {
        return $this->hasData() ? 'success' : 'warning';
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VistaProgresoProyecto extends Model
{
    protected $table = 'vista_progreso_proyectos';

    // La vista no tiene clave primaria, así que deshabilitamos el incremento
    public $incrementing = false;

    // No hay timestamps en la vista
    public $timestamps = false;

    // Definir los campos que pueden ser asignados masivamente
    protected $fillable = [
        'Actividad',
        'Proyecto',
        'population_progress_percent',
        'product_progress_percent',
        'Evento_estado',
        'Beneficiarios_evento'
    ];

    // Definir los tipos de datos para los campos
    protected $casts = [
        'population_progress_percent' => 'decimal:2',
        'product_progress_percent' => 'decimal:2',
        'Beneficiarios_evento' => 'integer',
    ];

    // Método para obtener una clave única para Filament
    public function getKey()
    {
        // Combinar Actividad y Proyecto para crear una clave única
        return $this->Actividad . '_' . $this->Proyecto;
    }
}

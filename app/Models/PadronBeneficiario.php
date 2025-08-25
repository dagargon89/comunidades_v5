<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PadronBeneficiario extends Model
{
    protected $table = 'padron_beneficiarios';

    public $incrementing = false;
    public $timestamps = false;

    protected $fillable = [
        'Nombres',
        'Apellido_paterno',
        'Apellido_materno',
        'nacimiento',
        'genero',
        'telefono',
        'calle',
        'colonia',
        'nombre_actividad',
        'nombre_proyecto',
        'Evento_Fecha_Inicio',
        'financiadora'
    ];

    protected $casts = [
        'Evento_Fecha_Inicio' => 'datetime',
        'nacimiento' => 'integer',
    ];

    /**
     * Generar una clave única para Filament
     */
    public function getKey()
    {
        return $this->Nombres . '_' . $this->Apellido_paterno . '_' . $this->nombre_actividad . '_' . $this->Evento_Fecha_Inicio;
    }

    /**
     * Accesor para nombre completo
     */
    public function getNombreBeneficiarioAttribute()
    {
        return trim($this->Nombres . ' ' . $this->Apellido_paterno . ' ' . ($this->Apellido_materno ?? ''));
    }

    /**
     * Accesor para edad calculada
     */
    public function getEdadAttribute()
    {
        if (!$this->nacimiento) {
            return null;
        }
        return date('Y') - $this->nacimiento;
    }

    /**
     * Accesor para identificación (usando apellidos)
     */
    public function getIdentificacionAttribute()
    {
        return trim($this->Apellido_paterno . ' ' . ($this->Apellido_materno ?? ''));
    }

    /**
     * Accesor para estado civil (por defecto)
     */
    public function getEstadoCivilAttribute()
    {
        return 'No especificado';
    }

    /**
     * Accesor para email (por defecto)
     */
    public function getEmailAttribute()
    {
        return null;
    }
}

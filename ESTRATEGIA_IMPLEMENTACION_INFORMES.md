# ESTRATEGIA DE IMPLEMENTACIÓN - SISTEMA DE INFORMES NARRATIVOS CON IA

## 📋 RESUMEN EJECUTIVO

Este documento define la estrategia completa para implementar un sistema de generación automatizada de informes narrativos usando IA (Ollama Cloud API) en la plataforma Comunidades V5.

### Objetivo
Generar automáticamente narrativas institucionales formales para reportar actividades y resultados a financiadores, utilizando IA para transformar datos estructurados en texto narrativo profesional.

### Stack Tecnológico
- **Backend**: Laravel 12.x + FilamentPHP 3.x
- **IA**: Ollama Cloud API (no local)
- **Generación PDF**: barryvdh/laravel-dompdf
- **Base de datos**: MySQL 8.x (planeacion)

---

## 🗄️ ANÁLISIS DE BASE DE DATOS

### Estructura Jerárquica del Sistema

```
Projects (Proyectos)
    ├── SpecificObjectives (Objetivos Específicos)
    ├── Goals (Metas)
    │   └── Activities (Actividades - Plantilla/Tipo)
    │       └── ActivityCalendars (Eventos/Sesiones Específicas) ⭐ AQUÍ SE GENERAN LAS NARRATIVAS
    │           ├── BeneficiaryRegistries (Registros de asistencia)
    │           ├── ActivityFiles (Evidencias/Archivos)
    │           └── Location (Ubicación del evento)
    └── Kpis (Indicadores)
```

### Tablas Clave Identificadas

#### 1. `activity_calendars` - **TABLA PRINCIPAL PARA NARRATIVAS**
Esta es la tabla donde se deben almacenar las narrativas generadas, ya que representa eventos/sesiones REALES que se llevaron a cabo.

**Campos actuales:**
- `id` - Identificador único
- `activity_id` - Relación con la actividad (tipo/plantilla)
- `start_date` / `end_date` - Fechas del evento
- `start_hour` / `end_hour` - Horarios
- `location_id` - Ubicación (relación con tabla locations)
- `address_backup` - Dirección alternativa (text)
- `cancelled` - Si el evento fue cancelado
- `change_reason` - Razón de cambios
- `created_by` / `assigned_person` - Responsables

**Campos a AGREGAR para narrativas:**
- `narrativa_contexto` (TEXT, nullable) - Contexto del evento
- `narrativa_desarrollo` (TEXT, nullable) - Desarrollo de la actividad
- `narrativa_resultados` (TEXT, nullable) - Resultados y acuerdos
- `narrativa_generada` (LONGTEXT, nullable) - Narrativa completa generada por IA
- `narrativa_aprobada` (BOOLEAN, default false) - Flag de revisión humana
- `narrativa_regenerada_at` (TIMESTAMP, nullable) - Última regeneración
- `participantes_count` (INTEGER, nullable) - Conteo de participantes
- `organizaciones_participantes` (TEXT, nullable) - Organizaciones que participaron

**Relaciones importantes:**
- `activity()` → Activity (tipo de actividad)
- `location()` → Location (ubicación)
- `beneficiaryRegistries()` → BeneficiaryRegistry (para contar participantes)
- `activityFiles()` → ActivityFile (evidencias)

#### 2. `activities` - Plantilla de Actividad
**Campos relevantes:**
- `id`, `name`, `description`
- `specific_objective_id`
- `goals_id`

#### 3. `beneficiary_registries` - Registros de Participantes
**Relación:** Permite contar cuántas personas asistieron a cada evento (activity_calendar)

#### 4. `locations` - Ubicaciones
**Campos:** Nombre del lugar donde se realizó el evento

#### 5. `organizations` - Organizaciones Participantes
**Uso:** Para listar organizaciones que participaron en eventos

---

## 🎯 ADAPTACIONES CRÍTICAS AL PROMPT ORIGINAL

### 1. **Cambio de Enfoque: Activities → ActivityCalendars**

**Decisión de diseño:**
- ❌ **NO generar narrativas en `activities`** (son plantillas/tipos)
- ✅ **SÍ generar narrativas en `activity_calendars`** (eventos reales)

**Razón:**
Un `activity` es una plantilla (ej: "Reunión de Grupo Promotor") que puede tener múltiples sesiones/eventos reales. Cada sesión real (activity_calendar) necesita su propia narrativa específica con fecha, participantes y resultados únicos.

### 2. **Configuración de Ollama Cloud (No Local)**

El usuario especificó que la API de Ollama es **cloud, no local**.

**Implicaciones:**
- URL no será `http://localhost:11434`
- Probablemente requiera API Key/Token
- Posible límite de rate limiting
- Mayor latencia vs. local

**Configuración requerida (.env):**
```env
OLLAMA_URL=https://api.ollama.cloud/v1  # URL Cloud (ejemplo)
OLLAMA_API_KEY=sk-xxxxxxxxxxxxx         # API Key requerida
OLLAMA_MODEL=llama3.1
OLLAMA_TIMEOUT=180                      # Mayor timeout para API cloud
OLLAMA_TEMPERATURE=0.3
OLLAMA_MAX_TOKENS=1500
```

### 3. **Estructura de Datos para el Prompt**

Para cada `activity_calendar`, el prompt necesitará:

```php
[
    'fecha' => '12 de junio de 2025',
    'titulo_actividad' => 'Reunión del Grupo Promotor',  // desde activity->name
    'ubicacion' => 'Edificio Participa Juárez',          // desde location->name
    'organizaciones' => [                                  // Recopilar de diversas fuentes
        'Fundación Juárez Integra',
        'Desafío Juárez A.C.',
        // ...
    ],
    'participantes_count' => 15,                          // desde beneficiary_registries
    'contexto' => '...',                                  // desde activity_calendar->narrativa_contexto
    'desarrollo' => '...',                                // desde activity_calendar->narrativa_desarrollo
    'resultados' => '...',                                // desde activity_calendar->narrativa_resultados
    'meta' => 'Meta 1.2 - Fortalecer capacidades',       // desde goal->description
    'objetivo_especifico' => 'OE1: ...',                  // desde specific_objective
]
```

---

## 📐 ARQUITECTURA DE LA SOLUCIÓN

### Componentes Principales

```
┌─────────────────────────────────────────────────────────┐
│  Panel Filament Admin (/admin)                          │
│  ┌───────────────────────────────────────────────────┐  │
│  │  ProjectResource                                  │  │
│  │  └── GenerarInforme.php (Custom Page)            │  │
│  │      ├── Formulario de selección                 │  │
│  │      │   - Periodo (fechas)                       │  │
│  │      │   - Objetivos/Metas                        │  │
│  │      │   - Opciones de generación                 │  │
│  │      └── Acción: generar()                        │  │
│  └───────────────────────────────────────────────────┘  │
│                        ↓                                 │
│  ┌───────────────────────────────────────────────────┐  │
│  │  ActivityCalendarResource (opcional)              │  │
│  │  └── Acciones individuales en tabla:             │  │
│  │      - Generar narrativa                          │  │
│  │      - Ver narrativa                              │  │
│  │      - Regenerar narrativa                        │  │
│  │      - Aprobar narrativa                          │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│  Capa de Servicios                                      │
│  ┌───────────────────────────────────────────────────┐  │
│  │  NarrativaGenerator Service                       │  │
│  │  ├── generarNarrativaEvento()                     │  │
│  │  ├── generarIntroduccionProyecto()                │  │
│  │  ├── generarSeccionLogros()                       │  │
│  │  ├── generarSeccionLecciones()                    │  │
│  │  └── llamarOllamaCloud()                          │  │
│  └───────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────┐  │
│  │  InformeExporter Service                          │  │
│  │  ├── exportarPDF()                                │  │
│  │  ├── exportarDOCX()                               │  │
│  │  └── exportarHTML()                               │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│  Integración Externa                                    │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Ollama Cloud API                                 │  │
│  │  └── POST /api/generate                           │  │
│  │      Headers: Authorization: Bearer {API_KEY}     │  │
│  │      Body: {model, prompt, options}               │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                         ↓
┌─────────────────────────────────────────────────────────┐
│  Vista Blade + PDF                                      │
│  └── resources/views/reports/informe-narrativo.blade.php│
└─────────────────────────────────────────────────────────┘
```

---

## 🚀 PLAN DE IMPLEMENTACIÓN PASO A PASO

### FASE 0: Preparación y Configuración
**Duración estimada: 30 minutos**

#### Tareas:
1. **Instalar dependencias necesarias**
   ```bash
   composer require barryvdh/laravel-dompdf
   composer require phpoffice/phpword  # Opcional para DOCX
   ```

2. **Configurar variables de entorno**
   ```bash
   # Agregar a .env
   OLLAMA_URL=https://api.ollama.cloud/v1
   OLLAMA_API_KEY=tu_api_key_aqui
   OLLAMA_MODEL=llama3.1
   OLLAMA_TIMEOUT=180
   OLLAMA_TEMPERATURE=0.3
   OLLAMA_MAX_TOKENS=1500
   ```

3. **Actualizar config/services.php**
   ```php
   'ollama' => [
       'url' => env('OLLAMA_URL', 'http://localhost:11434'),
       'api_key' => env('OLLAMA_API_KEY'),
       'model' => env('OLLAMA_MODEL', 'llama3.1'),
       'timeout' => env('OLLAMA_TIMEOUT', 180),
       'temperature' => env('OLLAMA_TEMPERATURE', 0.3),
       'max_tokens' => env('OLLAMA_MAX_TOKENS', 1500),
   ],
   ```

---

### FASE 1: Migración de Base de Datos
**Duración estimada: 1 hora**

#### 1.1 Crear migración para ActivityCalendar

**Archivo:** `database/migrations/2025_XX_XX_add_narrativa_fields_to_activity_calendars.php`

```php
public function up(): void
{
    Schema::table('activity_calendars', function (Blueprint $table) {
        // Campos para captura manual de información
        $table->text('narrativa_contexto')->nullable()
            ->comment('Contexto y descripción de lo realizado (entrada manual)');

        $table->text('narrativa_desarrollo')->nullable()
            ->comment('Desarrollo de la actividad - temas, metodología (entrada manual)');

        $table->text('narrativa_resultados')->nullable()
            ->comment('Resultados, acuerdos y compromisos (entrada manual)');

        $table->text('organizaciones_participantes')->nullable()
            ->comment('Lista de organizaciones participantes (separadas por coma)');

        $table->integer('participantes_count')->nullable()
            ->comment('Número total de participantes');

        // Campos generados por IA
        $table->longText('narrativa_generada')->nullable()
            ->comment('Narrativa completa generada por IA');

        $table->boolean('narrativa_aprobada')->default(false)
            ->comment('Indica si la narrativa fue revisada y aprobada');

        $table->timestamp('narrativa_regenerada_at')->nullable()
            ->comment('Fecha de última regeneración de narrativa');

        // Índices para mejorar queries
        $table->index('narrativa_aprobada');
        $table->index('start_date');
    });
}

public function down(): void
{
    Schema::table('activity_calendars', function (Blueprint $table) {
        $table->dropColumn([
            'narrativa_contexto',
            'narrativa_desarrollo',
            'narrativa_resultados',
            'organizaciones_participantes',
            'participantes_count',
            'narrativa_generada',
            'narrativa_aprobada',
            'narrativa_regenerada_at',
        ]);
    });
}
```

**Ejecutar migración:**
```bash
php artisan make:migration add_narrativa_fields_to_activity_calendars
# Copiar el código anterior
php artisan migrate
```

#### 1.2 Actualizar modelo ActivityCalendar

**Archivo:** `app/Models/ActivityCalendar.php`

```php
// Agregar a $fillable
protected $fillable = [
    // ... campos existentes
    'narrativa_contexto',
    'narrativa_desarrollo',
    'narrativa_resultados',
    'organizaciones_participantes',
    'participantes_count',
    'narrativa_generada',
    'narrativa_aprobada',
    'narrativa_regenerada_at',
];

// Agregar a casts()
protected function casts(): array
{
    return [
        // ... casts existentes
        'narrativa_aprobada' => 'boolean',
        'narrativa_regenerada_at' => 'datetime',
        'participantes_count' => 'integer',
    ];
}

// Agregar métodos helper
public function regenerarNarrativa(): void
{
    $this->update([
        'narrativa_generada' => null,
        'narrativa_aprobada' => false,
        'narrativa_regenerada_at' => now(),
    ]);
}

public function marcarAprobada(): void
{
    $this->update([
        'narrativa_aprobada' => true,
    ]);
}

public function requiresNarrativa(): bool
{
    return $this->narrativa_generada === null ||
           ($this->narrativa_aprobada === false && $this->narrativa_regenerada_at === null);
}

// Accessor para fecha formateada en español
public function getFechaFormateadaAttribute(): string
{
    $meses = [
        1 => 'enero', 2 => 'febrero', 3 => 'marzo', 4 => 'abril',
        5 => 'mayo', 6 => 'junio', 7 => 'julio', 8 => 'agosto',
        9 => 'septiembre', 10 => 'octubre', 11 => 'noviembre', 12 => 'diciembre'
    ];

    $fecha = $this->start_date;
    return $fecha->day . ' de ' . $meses[$fecha->month] . ' de ' . $fecha->year;
}

// Scopes para queries
public function scopeConNarrativaAprobada($query)
{
    return $query->where('narrativa_aprobada', true);
}

public function scopeSinNarrativaGenerada($query)
{
    return $query->whereNull('narrativa_generada');
}

public function scopeEnPeriodo($query, $inicio, $fin)
{
    return $query->whereBetween('start_date', [$inicio, $fin]);
}

public function scopeNoCanceladas($query)
{
    return $query->where('cancelled', false);
}
```

---

### FASE 2: Servicio de Generación de Narrativas
**Duración estimada: 3 horas**

#### 2.1 Crear servicio NarrativaGenerator

**Archivo:** `app/Services/NarrativaGenerator.php`

```php
<?php

namespace App\Services;

use App\Models\ActivityCalendar;
use App\Models\Project;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class NarrativaGenerator
{
    protected string $ollamaUrl;
    protected ?string $apiKey;
    protected string $model;
    protected int $timeout;
    protected float $temperature;
    protected int $maxTokens;

    public function __construct()
    {
        $this->ollamaUrl = config('services.ollama.url');
        $this->apiKey = config('services.ollama.api_key');
        $this->model = config('services.ollama.model');
        $this->timeout = config('services.ollama.timeout');
        $this->temperature = config('services.ollama.temperature');
        $this->maxTokens = config('services.ollama.max_tokens');
    }

    /**
     * Genera narrativa para un evento específico (ActivityCalendar)
     */
    public function generarNarrativaEvento(ActivityCalendar $evento): string
    {
        // Preparar datos del evento
        $datos = $this->prepararDatosEvento($evento);

        // Construir prompt
        $prompt = $this->construirPromptEvento($datos);

        // Llamar a Ollama Cloud
        $narrativa = $this->llamarOllamaCloud($prompt);

        // Limpiar respuesta
        return $this->limpiarRespuestaIA($narrativa);
    }

    /**
     * Genera introducción del informe del proyecto
     */
    public function generarIntroduccionProyecto(Project $proyecto, $fechaInicio, $fechaFin): string
    {
        $prompt = $this->construirPromptIntroduccion($proyecto, $fechaInicio, $fechaFin);
        $narrativa = $this->llamarOllamaCloud($prompt);
        return $this->limpiarRespuestaIA($narrativa);
    }

    /**
     * Genera sección de logros significativos
     */
    public function generarSeccionLogros($eventos): string
    {
        $prompt = $this->construirPromptLogros($eventos);
        $narrativa = $this->llamarOllamaCloud($prompt);
        return $this->limpiarRespuestaIA($narrativa);
    }

    /**
     * Genera sección de lecciones aprendidas
     */
    public function generarSeccionLecciones($eventos): string
    {
        $prompt = $this->construirPromptLecciones($eventos);
        $narrativa = $this->llamarOllamaCloud($prompt);
        return $this->limpiarRespuestaIA($narrativa);
    }

    /**
     * Prepara datos del evento para el prompt
     */
    protected function prepararDatosEvento(ActivityCalendar $evento): array
    {
        // Cargar relaciones necesarias
        $evento->load([
            'activity.goal.project',
            'activity.specificObjective',
            'location',
            'beneficiaryRegistries.beneficiary'
        ]);

        // Contar participantes reales
        $participantesReales = $evento->beneficiaryRegistries->count();
        $participantesCount = $evento->participantes_count ?? $participantesReales;

        // Obtener organizaciones
        $organizaciones = $evento->organizaciones_participantes
            ? explode(',', $evento->organizaciones_participantes)
            : [];

        return [
            'fecha' => $evento->fecha_formateada,
            'titulo' => $evento->activity->name ?? 'Actividad',
            'descripcion_actividad' => $evento->activity->description ?? '',
            'ubicacion' => $evento->location->name ?? $evento->address_backup ?? 'Ubicación no especificada',
            'participantes_count' => $participantesCount,
            'organizaciones' => $organizaciones,
            'meta' => $evento->activity->goal->description ?? '',
            'objetivo_especifico' => $evento->activity->specificObjective->description ?? '',
            'proyecto' => $evento->activity->goal->project->name ?? '',

            // Campos de entrada manual
            'contexto' => $evento->narrativa_contexto ?? '',
            'desarrollo' => $evento->narrativa_desarrollo ?? '',
            'resultados' => $evento->narrativa_resultados ?? '',
        ];
    }

    /**
     * Construye el prompt para generar narrativa de evento
     * TEMPLATE CRÍTICO - Sigue el estilo institucional exacto
     */
    protected function construirPromptEvento(array $datos): string
    {
        $organizacionesTexto = count($datos['organizaciones']) > 0
            ? implode(', ', $datos['organizaciones'])
            : 'diversas organizaciones';

        return <<<PROMPT
Eres un redactor especializado en informes narrativos para organizaciones de la sociedad civil mexicanas.
Tu tarea es redactar la descripción de una actividad siguiendo un estilo FORMAL INSTITUCIONAL muy específico.

**CONTEXTO DE LA ACTIVIDAD:**
- Fecha: {$datos['fecha']}
- Actividad: {$datos['titulo']}
- Ubicación: {$datos['ubicacion']}
- Proyecto: {$datos['proyecto']}
- Meta asociada: {$datos['meta']}
- Objetivo específico: {$datos['objetivo_especifico']}
- Participantes: {$datos['participantes_count']} personas
- Organizaciones: {$organizacionesTexto}

**INFORMACIÓN PROPORCIONADA:**

Contexto:
{$datos['contexto']}

Desarrollo:
{$datos['desarrollo']}

Resultados y acuerdos:
{$datos['resultados']}

---

**INSTRUCCIONES CRÍTICAS DE REDACCIÓN:**

1. **Estructura obligatoria (3 párrafos):**

   PÁRRAFO 1 - Contextualización:
   - Inicia con la descripción de la reunión/actividad
   - Menciona lugar exacto
   - Lista participantes (con nombres de organizaciones si aplica)
   - Usa fórmula: "La [actividad] se llevó a cabo en [lugar], con la participación de [cantidad] [tipo de participantes] de [organizaciones]"

   PÁRRAFOS INTERMEDIOS - Desarrollo:
   - Describe lo que se hizo durante la actividad
   - Menciona temas abordados
   - Explica metodología o dinámica
   - Usa conectores: "Durante la sesión", "En el encuentro", "Las y los participantes"

   PÁRRAFO FINAL - Resultados:
   - Acuerdos alcanzados
   - Compromisos establecidos
   - Próximos pasos
   - Usa conectores: "Al finalizar", "Se acordó", "Como resultado"

2. **Estilo lingüístico OBLIGATORIO:**

   ✅ SIEMPRE usar:
   - Pasado impersonal: "se realizó", "se llevó a cabo", "se abordaron", "se acordó"
   - Lenguaje inclusivo: "las y los participantes", "vecinas y vecinos", "niñas y niños"
   - Números exactos: "{$datos['participantes_count']} personas" (nunca "varias personas")
   - Conectores formales: "Durante la sesión", "Posteriormente", "Al finalizar", "Asimismo"

   ❌ NUNCA usar:
   - Primera persona: "realizamos", "hicimos", "acordamos"
   - Opiniones: "fue excelente", "estuvo muy bien", "increíble experiencia"
   - Generalizaciones: "muchas personas", "varios asistentes", "bastante gente"
   - Lenguaje informal: "estuvo chido", "fue padre", "se la pasaron bien"

3. **Terminología institucional preferida:**
   - "participación ciudadana" (no "participación de la gente")
   - "cohesión social" (no "unión de las personas")
   - "incidencia pública" (no "influencia en el gobierno")
   - "fortalecimiento institucional" (no "mejora de la organización")
   - "apropiación del espacio público" (no "usar el parque")
   - "tejido comunitario" (no "relaciones entre vecinos")

4. **FORMATO DE SALIDA:**
   - NO incluyas el título de la actividad ni la fecha (ya están en el encabezado)
   - NO uses bullets, numeración ni subtítulos
   - NO uses comillas para citar actividades
   - NO uses markdown (sin ##, **, -, etc.)
   - SOLO escribe los párrafos en texto plano
   - NO agregues comentarios como "Este texto cumple con..." o "He redactado..."

---

**EJEMPLO DE ESTILO CORRECTO (ÚSALO COMO REFERENCIA EXACTA):**

La reunión del Grupo Promotor de la Asamblea de Organizaciones se llevó a cabo en el Edificio Participa Juárez, con la participación de representantes de Fundación Juárez Integra, Desafío Juárez A.C., CFIC, Instituto Promotor de Educación y Plan Estratégico de Juárez.

Durante la sesión se revisó el "Mapa de Incidencia" para evaluar el avance de los procesos en curso. Se informó sobre la gestión de una cita con el representante del Gobierno del Estado, Lic. Carlos Ortiz Villegas, con el propósito de presentar a la gobernadora María Eugenia Campos Galván el documento de fortalecimiento de la Junta de Asistencia Social Privada (JASP).

También se inició un nuevo proceso de apoyo a la Subsecretaría de Desarrollo Humano y Bien Común (SDHyBC) para justificar un incremento presupuestal al programa de subsidios para proyectos operados por OSC, acordando elaborar un estudio técnico como sustento.

---

**AHORA REDACTA LA NARRATIVA DE LA ACTIVIDAD (SOLO LOS PÁRRAFOS, SIN NADA MÁS):**
PROMPT;
    }

    /**
     * Llamada a Ollama Cloud API con manejo de errores y retry
     */
    protected function llamarOllamaCloud(string $prompt, bool $useCache = true): string
    {
        $cacheKey = 'narrativa_' . hash('sha256', $prompt);

        if ($useCache && Cache::has($cacheKey)) {
            Log::info('NarrativaGenerator: Usando narrativa cacheada');
            return Cache::get($cacheKey);
        }

        try {
            Log::info('NarrativaGenerator: Llamando a Ollama Cloud API');

            $headers = [
                'Content-Type' => 'application/json',
            ];

            // Agregar API Key si está configurada
            if ($this->apiKey) {
                $headers['Authorization'] = "Bearer {$this->apiKey}";
            }

            $response = Http::withHeaders($headers)
                ->timeout($this->timeout)
                ->retry(3, 1000) // 3 intentos, 1 segundo entre intentos
                ->post("{$this->ollamaUrl}/api/generate", [
                    'model' => $this->model,
                    'prompt' => $prompt,
                    'stream' => false,
                    'options' => [
                        'temperature' => $this->temperature,
                        'top_p' => 0.9,
                        'num_predict' => $this->maxTokens,
                    ]
                ]);

            if (!$response->successful()) {
                $error = $response->body();
                Log::error("NarrativaGenerator: Error en Ollama Cloud API: {$error}");
                throw new \Exception("Error en Ollama Cloud API: {$error}");
            }

            $result = $response->json();
            $narrativa = $result['response'] ?? '';

            if (empty($narrativa)) {
                throw new \Exception('Ollama Cloud API retornó una respuesta vacía');
            }

            // Cachear por 30 días
            Cache::put($cacheKey, $narrativa, now()->addDays(30));

            Log::info('NarrativaGenerator: Narrativa generada exitosamente');

            return $narrativa;

        } catch (\Exception $e) {
            Log::error('NarrativaGenerator: Error al generar narrativa: ' . $e->getMessage());
            throw $e;
        }
    }

    /**
     * Limpia la respuesta de la IA
     */
    protected function limpiarRespuestaIA(string $respuesta): string
    {
        // Remover markdown extra
        $respuesta = preg_replace('/^#+\s+/m', '', $respuesta);
        $respuesta = preg_replace('/\*\*(.*?)\*\*/','$1', $respuesta);
        $respuesta = preg_replace('/\*(.*?)\*/','$1', $respuesta);

        // Normalizar espacios y saltos de línea
        $respuesta = preg_replace('/\n{3,}/', "\n\n", $respuesta);
        $respuesta = trim($respuesta);

        return $respuesta;
    }

    /**
     * Construir prompt para introducción (implementar según necesidades)
     */
    protected function construirPromptIntroduccion(Project $proyecto, $fechaInicio, $fechaFin): string
    {
        // TODO: Implementar
        return "Prompt de introducción...";
    }

    /**
     * Construir prompt para logros (implementar según necesidades)
     */
    protected function construirPromptLogros($eventos): string
    {
        // TODO: Implementar
        return "Prompt de logros...";
    }

    /**
     * Construir prompt para lecciones (implementar según necesidades)
     */
    protected function construirPromptLecciones($eventos): string
    {
        // TODO: Implementar
        return "Prompt de lecciones...";
    }

    /**
     * Limpiar cache de narrativas
     */
    public function clearCache(): void
    {
        Cache::flush();
    }
}
```

---

### FASE 3: Recurso Filament para ActivityCalendar
**Duración estimada: 2 horas**

Esta fase agrega acciones en el recurso de ActivityCalendar para generar, ver, aprobar y regenerar narrativas individuales.

#### 3.1 Actualizar ActivityCalendarResource

**Archivo:** `app/Filament/Resources/ActivityCalendarResource.php`

Agregar estas acciones a la tabla:

```php
use Filament\Notifications\Notification;
use App\Services\NarrativaGenerator;

public static function table(Table $table): Table
{
    return $table
        ->columns([
            // ... columnas existentes

            Tables\Columns\TextColumn::make('activity.name')
                ->label('Actividad')
                ->sortable()
                ->searchable(),

            Tables\Columns\TextColumn::make('start_date')
                ->label('Fecha')
                ->date('d/m/Y')
                ->sortable(),

            Tables\Columns\TextColumn::make('location.name')
                ->label('Ubicación')
                ->limit(30),

            Tables\Columns\IconColumn::make('narrativa_aprobada')
                ->boolean()
                ->label('Aprobada')
                ->alignCenter()
                ->trueIcon('heroicon-o-check-circle')
                ->falseIcon('heroicon-o-x-circle')
                ->trueColor('success')
                ->falseColor('danger'),

            Tables\Columns\TextColumn::make('participantes_count')
                ->label('Participantes')
                ->alignCenter()
                ->default('-'),

            Tables\Columns\TextColumn::make('narrativa_generada')
                ->label('Narrativa')
                ->limit(50)
                ->placeholder('Sin generar')
                ->tooltip(fn ($record) => $record->narrativa_generada),
        ])
        ->actions([
            // Acción: Generar narrativa
            Tables\Actions\Action::make('generar_narrativa')
                ->label('Generar')
                ->icon('heroicon-o-sparkles')
                ->color('success')
                ->visible(fn ($record) => !$record->narrativa_generada)
                ->requiresConfirmation()
                ->modalHeading('Generar narrativa con IA')
                ->modalDescription('Se generará una narrativa en estilo formal institucional usando IA. Asegúrate de haber completado los campos: contexto, desarrollo y resultados.')
                ->action(function ($record) {
                    try {
                        $generator = app(NarrativaGenerator::class);
                        $narrativa = $generator->generarNarrativaEvento($record);

                        $record->update([
                            'narrativa_generada' => $narrativa,
                            'narrativa_regenerada_at' => now(),
                        ]);

                        Notification::make()
                            ->title('Narrativa generada exitosamente')
                            ->success()
                            ->send();

                    } catch (\Exception $e) {
                        Notification::make()
                            ->title('Error al generar narrativa')
                            ->body($e->getMessage())
                            ->danger()
                            ->send();
                    }
                }),

            // Acción: Ver narrativa
            Tables\Actions\Action::make('ver_narrativa')
                ->label('Ver')
                ->icon('heroicon-o-eye')
                ->color('info')
                ->visible(fn ($record) => $record->narrativa_generada)
                ->modalContent(fn ($record) => view('filament.modals.narrativa-preview', [
                    'evento' => $record
                ]))
                ->modalSubmitAction(false)
                ->modalCancelActionLabel('Cerrar'),

            // Acción: Regenerar narrativa
            Tables\Actions\Action::make('regenerar_narrativa')
                ->label('Regenerar')
                ->icon('heroicon-o-arrow-path')
                ->color('warning')
                ->visible(fn ($record) => $record->narrativa_generada)
                ->requiresConfirmation()
                ->modalHeading('¿Regenerar narrativa?')
                ->modalDescription('Se eliminará la narrativa actual y se generará una nueva. Si ya fue aprobada, deberás aprobarla nuevamente.')
                ->action(function ($record) {
                    try {
                        $record->regenerarNarrativa();

                        $generator = app(NarrativaGenerator::class);
                        $narrativa = $generator->generarNarrativaEvento($record);

                        $record->update([
                            'narrativa_generada' => $narrativa,
                            'narrativa_regenerada_at' => now(),
                            'narrativa_aprobada' => false,
                        ]);

                        Notification::make()
                            ->title('Narrativa regenerada exitosamente')
                            ->success()
                            ->send();

                    } catch (\Exception $e) {
                        Notification::make()
                            ->title('Error al regenerar narrativa')
                            ->body($e->getMessage())
                            ->danger()
                            ->send();
                    }
                }),

            // Acción: Aprobar narrativa
            Tables\Actions\Action::make('aprobar_narrativa')
                ->label('Aprobar')
                ->icon('heroicon-o-check-circle')
                ->color('success')
                ->visible(fn ($record) => $record->narrativa_generada && !$record->narrativa_aprobada)
                ->requiresConfirmation()
                ->modalHeading('Aprobar narrativa')
                ->modalDescription('Una vez aprobada, esta narrativa se incluirá en los informes generados.')
                ->action(function ($record) {
                    $record->marcarAprobada();

                    Notification::make()
                        ->title('Narrativa aprobada')
                        ->success()
                        ->send();
                }),

            Tables\Actions\EditAction::make(),
        ])
        ->bulkActions([
            // Acción masiva: Generar narrativas
            Tables\Actions\BulkAction::make('generar_narrativas')
                ->label('Generar narrativas')
                ->icon('heroicon-o-sparkles')
                ->color('success')
                ->requiresConfirmation()
                ->modalHeading('Generar narrativas con IA')
                ->modalDescription('Se generarán narrativas para todos los eventos seleccionados que no tengan una. Este proceso puede tardar varios minutos.')
                ->action(function ($records) {
                    $generator = app(NarrativaGenerator::class);
                    $count = 0;
                    $errors = 0;

                    foreach ($records as $record) {
                        if (!$record->narrativa_generada) {
                            try {
                                $narrativa = $generator->generarNarrativaEvento($record);
                                $record->update([
                                    'narrativa_generada' => $narrativa,
                                    'narrativa_regenerada_at' => now(),
                                ]);
                                $count++;
                            } catch (\Exception $e) {
                                $errors++;
                            }
                        }
                    }

                    Notification::make()
                        ->title("{$count} narrativas generadas exitosamente")
                        ->body($errors > 0 ? "{$errors} errores encontrados" : '')
                        ->success()
                        ->send();
                }),
        ]);
}
```

#### 3.2 Crear vista de preview

**Archivo:** `resources/views/filament/modals/narrativa-preview.blade.php`

```blade
<div class="space-y-4">
    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
        <h3 class="font-semibold text-lg mb-2">
            {{ $evento->fecha_formateada }} — {{ $evento->activity->name }}
        </h3>

        @if($evento->location)
        <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
            📍 {{ $evento->location->name }}
        </p>
        @endif

        <div class="prose dark:prose-invert max-w-none text-justify leading-relaxed">
            {!! nl2br(e($evento->narrativa_generada)) !!}
        </div>
    </div>

    <div class="flex items-center justify-between p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
        <div class="flex items-center space-x-2">
            @if($evento->narrativa_aprobada)
                <x-heroicon-o-check-circle class="w-5 h-5 text-green-600" />
                <span class="text-sm text-green-700 dark:text-green-400">
                    Narrativa aprobada
                </span>
            @else
                <x-heroicon-o-clock class="w-5 h-5 text-yellow-600" />
                <span class="text-sm text-yellow-700 dark:text-yellow-400">
                    Pendiente de aprobación
                </span>
            @endif
        </div>

        @if($evento->narrativa_regenerada_at)
        <span class="text-xs text-gray-500">
            Generada: {{ $evento->narrativa_regenerada_at->diffForHumans() }}
        </span>
        @endif
    </div>

    {{-- Información adicional --}}
    <div class="grid grid-cols-2 gap-4 p-4 bg-gray-100 dark:bg-gray-700 rounded-lg text-sm">
        <div>
            <strong>Participantes:</strong> {{ $evento->participantes_count ?? 'No especificado' }}
        </div>
        <div>
            <strong>Ubicación:</strong> {{ $evento->location->name ?? $evento->address_backup ?? '-' }}
        </div>
        @if($evento->organizaciones_participantes)
        <div class="col-span-2">
            <strong>Organizaciones:</strong><br>
            {{ $evento->organizaciones_participantes }}
        </div>
        @endif
    </div>
</div>
```

---

### FASE 4: Página de Generación de Informes Completos
**Duración estimada: 4 horas**

Esta es la funcionalidad principal: generar informes completos en PDF/DOCX.

#### 4.1 Crear página personalizada en ProjectResource

**Comando:**
```bash
php artisan make:filament-page GenerarInforme --resource=ProjectResource --type=custom
```

**Archivo:** `app/Filament/Resources/ProjectResource/Pages/GenerarInforme.php`

```php
<?php

namespace App\Filament\Resources\ProjectResource\Pages;

use App\Filament\Resources\ProjectResource;
use Filament\Resources\Pages\Page;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use App\Services\NarrativaGenerator;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\DB;

class GenerarInforme extends Page implements Forms\Contracts\HasForms
{
    use Forms\Concerns\InteractsWithForms;

    protected static string $resource = ProjectResource::class;
    protected static string $view = 'filament.resources.project.pages.generar-informe';
    protected static ?string $title = 'Generar Informe Narrativo';

    public ?array $data = [];
    public $proyecto;

    public function mount(): void
    {
        $this->proyecto = $this->getRecord();

        // Valores por defecto
        $this->form->fill([
            'fecha_inicio' => $this->proyecto->start_date,
            'fecha_fin' => $this->proyecto->end_date,
            'incluir_introduccion' => true,
            'incluir_logros' => true,
            'incluir_lecciones' => true,
            'usar_cache_narrativas' => true,
            'formato_salida' => 'pdf',
        ]);
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Periodo del Informe')
                    ->schema([
                        Forms\Components\DatePicker::make('fecha_inicio')
                            ->label('Fecha de inicio')
                            ->required()
                            ->native(false)
                            ->displayFormat('d/m/Y'),

                        Forms\Components\DatePicker::make('fecha_fin')
                            ->label('Fecha de fin')
                            ->required()
                            ->native(false)
                            ->displayFormat('d/m/Y')
                            ->afterOrEqual('fecha_inicio'),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Contenido a Incluir')
                    ->schema([
                        Forms\Components\Select::make('objetivos_ids')
                            ->label('Objetivos Específicos')
                            ->multiple()
                            ->options(function () {
                                return $this->proyecto->specificObjectives()
                                    ->pluck('description', 'id');
                            })
                            ->placeholder('Todos los objetivos')
                            ->helperText('Dejar vacío para incluir todos'),

                        Forms\Components\Select::make('metas_ids')
                            ->label('Metas')
                            ->multiple()
                            ->options(function () {
                                return $this->proyecto->goals()
                                    ->pluck('description', 'id');
                            })
                            ->placeholder('Todas las metas')
                            ->helperText('Dejar vacío para incluir todas'),
                    ]),

                Forms\Components\Section::make('Opciones de Generación')
                    ->schema([
                        Forms\Components\Toggle::make('incluir_introduccion')
                            ->label('Incluir introducción del proyecto')
                            ->default(true)
                            ->inline(false),

                        Forms\Components\Toggle::make('incluir_logros')
                            ->label('Incluir sección de logros significativos')
                            ->default(true)
                            ->inline(false),

                        Forms\Components\Toggle::make('incluir_lecciones')
                            ->label('Incluir sección de lecciones aprendidas')
                            ->default(true)
                            ->inline(false),

                        Forms\Components\Toggle::make('usar_cache_narrativas')
                            ->label('Usar narrativas ya generadas (cache)')
                            ->default(true)
                            ->helperText('Desactivar para regenerar todas las narrativas')
                            ->inline(false),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Formato de Salida')
                    ->schema([
                        Forms\Components\Select::make('formato_salida')
                            ->label('Formato del informe')
                            ->options([
                                'pdf' => 'PDF (Recomendado)',
                                'html' => 'HTML (Vista previa)',
                                // 'docx' => 'Word (DOCX)', // Implementar después
                            ])
                            ->required()
                            ->default('pdf'),
                    ]),
            ])
            ->statePath('data');
    }

    public function generar()
    {
        $this->validate();

        Notification::make()
            ->title('Generando informe...')
            ->body('Este proceso puede tardar varios minutos')
            ->info()
            ->send();

        try {
            // 1. Obtener datos del proyecto filtrados
            $datos = $this->obtenerDatosProyecto();

            // 2. Procesar narrativas (generar las que falten)
            $this->procesarNarrativas($datos);

            // 3. Renderizar informe
            $html = $this->renderizarInforme($datos);

            // 4. Exportar según formato
            return $this->exportar($html, $this->data['formato_salida']);

        } catch (\Exception $e) {
            Notification::make()
                ->title('Error al generar informe')
                ->body($e->getMessage())
                ->danger()
                ->send();

            return null;
        }
    }

    protected function obtenerDatosProyecto(): array
    {
        $fechaInicio = $this->data['fecha_inicio'];
        $fechaFin = $this->data['fecha_fin'];
        $objetivosIds = $this->data['objetivos_ids'] ?? [];
        $metasIds = $this->data['metas_ids'] ?? [];

        // Cargar proyecto con relaciones
        $proyecto = $this->proyecto->load([
            'financiers',
            'coFinancier',
        ]);

        // Obtener objetivos específicos
        $objetivosQuery = $proyecto->specificObjectives();
        if (!empty($objetivosIds)) {
            $objetivosQuery->whereIn('id', $objetivosIds);
        }
        $objetivos = $objetivosQuery->get();

        // Obtener metas
        $metasQuery = $proyecto->goals();
        if (!empty($metasIds)) {
            $metasQuery->whereIn('id', $metasIds);
        }
        $metas = $metasQuery->with(['activities'])->get();

        // Obtener eventos del periodo (activity_calendars)
        $eventosQuery = DB::table('activity_calendars as ac')
            ->join('activities as a', 'ac.activity_id', '=', 'a.id')
            ->join('goals as g', 'a.goals_id', '=', 'g.id')
            ->where('g.project_id', $proyecto->id)
            ->whereBetween('ac.start_date', [$fechaInicio, $fechaFin])
            ->where('ac.cancelled', false);

        if (!empty($metasIds)) {
            $eventosQuery->whereIn('g.id', $metasIds);
        }

        $eventosIds = $eventosQuery->pluck('ac.id');

        $eventos = \App\Models\ActivityCalendar::whereIn('id', $eventosIds)
            ->with([
                'activity.goal.specificObjective',
                'activity.goal',
                'location',
                'beneficiaryRegistries',
            ])
            ->orderBy('start_date')
            ->get();

        // Organizar eventos por objetivo → meta
        $eventosPorObjetivo = [];
        foreach ($eventos as $evento) {
            $objetivoId = $evento->activity->goal->specificObjective->id ?? null;
            $metaId = $evento->activity->goal->id ?? null;

            if ($objetivoId && $metaId) {
                $eventosPorObjetivo[$objetivoId][$metaId][] = $evento;
            }
        }

        return [
            'proyecto' => $proyecto,
            'objetivos' => $objetivos,
            'metas' => $metas,
            'eventos' => $eventos,
            'eventos_por_objetivo' => $eventosPorObjetivo,
            'periodo' => [
                'inicio' => $fechaInicio,
                'fin' => $fechaFin,
            ],
            'estadisticas' => [
                'total_eventos' => $eventos->count(),
                'total_participantes' => $eventos->sum('participantes_count'),
                'eventos_con_narrativa' => $eventos->where('narrativa_generada', '!=', null)->count(),
            ],
        ];
    }

    protected function procesarNarrativas(array &$datos): void
    {
        $generator = app(NarrativaGenerator::class);
        $usarCache = $this->data['usar_cache_narrativas'];

        $eventosSinNarrativa = $usarCache
            ? $datos['eventos']->where('narrativa_generada', null)
            : $datos['eventos'];

        if ($eventosSinNarrativa->isEmpty()) {
            return;
        }

        foreach ($eventosSinNarrativa as $evento) {
            try {
                $narrativa = $generator->generarNarrativaEvento($evento);

                $evento->update([
                    'narrativa_generada' => $narrativa,
                    'narrativa_regenerada_at' => now(),
                ]);

            } catch (\Exception $e) {
                // Log error pero continuar
                \Log::error("Error generando narrativa para evento {$evento->id}: " . $e->getMessage());
            }
        }

        // Refrescar eventos para tener narrativas actualizadas
        $datos['eventos']->each->refresh();
    }

    protected function renderizarInforme(array $datos): string
    {
        return view('reports.informe-narrativo', $datos)->render();
    }

    protected function exportar(string $html, string $formato)
    {
        $filename = "informe_{$this->proyecto->id}_" . now()->format('Y-m-d_His');

        return match($formato) {
            'pdf' => $this->exportarPDF($html, $filename),
            'html' => response($html, 200, [
                'Content-Type' => 'text/html; charset=utf-8',
            ]),
            default => throw new \Exception('Formato no soportado'),
        };
    }

    protected function exportarPDF(string $html, string $filename)
    {
        $pdf = Pdf::loadHTML($html)
            ->setPaper('letter', 'portrait')
            ->setOption([
                'margin-top' => 20,
                'margin-bottom' => 20,
                'margin-left' => 15,
                'margin-right' => 15,
                'enable-local-file-access' => true,
            ]);

        return response()->streamDownload(function () use ($pdf) {
            echo $pdf->output();
        }, "{$filename}.pdf", [
            'Content-Type' => 'application/pdf',
        ]);
    }
}
```

#### 4.2 Crear vista de la página

**Archivo:** `resources/views/filament/resources/project/pages/generar-informe.blade.php`

```blade
<x-filament-panels::page>
    <form wire:submit.prevent="generar">
        {{ $this->form }}

        <div class="mt-6">
            <x-filament::button
                type="submit"
                size="lg"
                wire:loading.attr="disabled"
                wire:target="generar"
            >
                <x-filament::loading-indicator
                    class="h-5 w-5 mr-2"
                    wire:loading
                    wire:target="generar"
                />
                <span wire:loading.remove wire:target="generar">
                    <x-heroicon-o-document-text class="w-5 h-5 mr-2 inline" />
                    Generar Informe
                </span>
                <span wire:loading wire:target="generar">
                    Generando narrativas con IA...
                </span>
            </x-filament::button>
        </div>
    </form>

    {{-- Indicador de progreso --}}
    <div
        wire:loading
        wire:target="generar"
        class="mt-4 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg"
    >
        <div class="flex items-start space-x-3">
            <x-filament::loading-indicator class="h-5 w-5 text-blue-600" />
            <div class="flex-1">
                <p class="text-sm font-medium text-blue-800 dark:text-blue-200">
                    Generando informe narrativo
                </p>
                <p class="text-xs text-blue-600 dark:text-blue-300 mt-1">
                    Este proceso puede tomar varios minutos dependiendo de la cantidad de eventos.
                    Las narrativas se generan usando inteligencia artificial.
                </p>
            </div>
        </div>
    </div>

    {{-- Estadísticas del proyecto --}}
    <x-filament::section class="mt-6">
        <x-slot name="heading">
            Información del proyecto
        </x-slot>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                <div class="text-2xl font-bold text-primary-600">
                    {{ $proyecto->specificObjectives->count() }}
                </div>
                <div class="text-sm text-gray-600 dark:text-gray-400">
                    Objetivos Específicos
                </div>
            </div>

            <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                <div class="text-2xl font-bold text-primary-600">
                    {{ $proyecto->goals->count() }}
                </div>
                <div class="text-sm text-gray-600 dark:text-gray-400">
                    Metas
                </div>
            </div>

            <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
                <div class="text-2xl font-bold text-primary-600">
                    {{ \App\Models\ActivityCalendar::whereHas('activity.goal', function($q) {
                        $q->where('project_id', $this->proyecto->id);
                    })->count() }}
                </div>
                <div class="text-sm text-gray-600 dark:text-gray-400">
                    Eventos Registrados
                </div>
            </div>
        </div>
    </x-filament::section>

    {{-- Información sobre la generación --}}
    <x-filament::section class="mt-6">
        <x-slot name="heading">
            Información sobre la generación
        </x-slot>

        <x-slot name="description">
            <ul class="text-sm space-y-2 list-disc list-inside">
                <li>Las narrativas se generan en estilo formal institucional</li>
                <li>Se cachean en la base de datos para evitar regeneraciones</li>
                <li>Puedes desactivar el cache para regenerar todas las narrativas</li>
                <li>El proceso puede tardar 5-15 segundos por evento</li>
                <li>API Ollama: {{ config('services.ollama.url') }}</li>
                <li>Modelo: {{ config('services.ollama.model') }}</li>
            </ul>
        </x-slot>
    </x-filament::section>
</x-filament-panels::page>
```

#### 4.3 Registrar página en ProjectResource

**Archivo:** `app/Filament/Resources/ProjectResource.php`

```php
public static function getPages(): array
{
    return [
        'index' => Pages\ListProjects::route('/'),
        'create' => Pages\CreateProject::route('/create'),
        'edit' => Pages\EditProject::route('/{record}/edit'),
        'generar-informe' => Pages\GenerarInforme::route('/{record}/generar-informe'), // NUEVO
    ];
}

// Opcional: Agregar acción en la tabla
public static function table(Table $table): Table
{
    return $table
        ->columns([
            // ... columnas existentes
        ])
        ->actions([
            Tables\Actions\EditAction::make(),

            // NUEVO: Acción para generar informe
            Tables\Actions\Action::make('generar_informe')
                ->label('Generar Informe')
                ->icon('heroicon-o-document-text')
                ->color('success')
                ->url(fn ($record) => ProjectResource::getUrl('generar-informe', ['record' => $record]))
                ->openUrlInNewTab(false),
        ]);
}
```

---

### FASE 5: Vista Blade del Informe PDF
**Duración estimada: 3 horas**

#### 5.1 Crear plantilla principal

**Archivo:** `resources/views/reports/informe-narrativo.blade.php`

```blade
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informe Narrativo - {{ $proyecto->name }}</title>
    <style>
        @page {
            margin: 2cm;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            font-size: 11pt;
            line-height: 1.6;
            color: #000;
        }

        .header {
            text-align: center;
            margin-bottom: 2cm;
        }

        .header h1 {
            font-size: 16pt;
            font-weight: bold;
            margin-bottom: 0.5cm;
        }

        .ficha-tecnica {
            margin-top: 1cm;
            text-align: left;
            font-size: 10pt;
        }

        .ficha-tecnica table {
            width: 100%;
            border-collapse: collapse;
        }

        .ficha-tecnica td {
            padding: 0.2cm;
            border: 1px solid #ccc;
        }

        .ficha-tecnica td:first-child {
            font-weight: bold;
            width: 30%;
            background-color: #f5f5f5;
        }

        h2 {
            font-size: 14pt;
            font-weight: bold;
            margin-top: 1.5cm;
            margin-bottom: 0.5cm;
            page-break-after: avoid;
        }

        h3 {
            font-size: 12pt;
            font-weight: bold;
            margin-top: 1cm;
            margin-bottom: 0.3cm;
            page-break-after: avoid;
        }

        .introduccion {
            text-align: justify;
            margin-bottom: 1.5cm;
        }

        .objetivo {
            page-break-before: always;
            margin-bottom: 2cm;
        }

        .meta-section {
            margin-bottom: 1.5cm;
        }

        .meta-title {
            font-weight: bold;
            font-size: 11pt;
            margin-top: 1cm;
            margin-bottom: 0.5cm;
        }

        .evento {
            margin-bottom: 1.5cm;
            text-align: justify;
        }

        .evento-header {
            font-weight: bold;
            margin-bottom: 0.3cm;
        }

        .evento-fecha {
            font-weight: bold;
        }

        .evento-ubicacion {
            font-style: italic;
            color: #555;
        }

        .evento-narrativa {
            text-align: justify;
            line-height: 1.6;
        }

        .seccion-especial {
            page-break-before: always;
            margin-bottom: 2cm;
        }

        .firma {
            margin-top: 3cm;
            text-align: center;
        }

        .firma-linea {
            width: 50%;
            border-top: 1px solid #000;
            margin: 0 auto;
            margin-top: 2cm;
        }

        .page-break {
            page-break-after: always;
        }
    </style>
</head>
<body>
    {{-- Encabezado --}}
    <div class="header">
        <h1>INFORME NARRATIVO DE ACTIVIDADES</h1>
        <h2>{{ $proyecto->name }}</h2>

        <div class="ficha-tecnica">
            <table>
                <tr>
                    <td>Proyecto:</td>
                    <td>{{ $proyecto->name }}</td>
                </tr>
                <tr>
                    <td>Periodo del informe:</td>
                    <td>
                        {{ \Carbon\Carbon::parse($periodo['inicio'])->format('d/m/Y') }} -
                        {{ \Carbon\Carbon::parse($periodo['fin'])->format('d/m/Y') }}
                    </td>
                </tr>
                <tr>
                    <td>Financiador:</td>
                    <td>{{ $proyecto->financiers->name ?? 'N/A' }}</td>
                </tr>
                @if($proyecto->coFinancier)
                <tr>
                    <td>Co-financiador:</td>
                    <td>{{ $proyecto->coFinancier->name }}</td>
                </tr>
                @endif
                <tr>
                    <td>Total de eventos:</td>
                    <td>{{ $estadisticas['total_eventos'] }}</td>
                </tr>
                <tr>
                    <td>Total de participantes:</td>
                    <td>{{ $estadisticas['total_participantes'] }}</td>
                </tr>
            </table>
        </div>
    </div>

    {{-- Introducción (si está habilitada) --}}
    @if($data['incluir_introduccion'] ?? false)
    <div class="introduccion">
        <h2>INTRODUCCIÓN</h2>
        <p>
            El presente informe narrativo corresponde al periodo del
            {{ \Carbon\Carbon::parse($periodo['inicio'])->format('d \d\e F \d\e Y') }} al
            {{ \Carbon\Carbon::parse($periodo['fin'])->format('d \d\e F \d\e Y') }},
            en el marco del proyecto "{{ $proyecto->name }}".
        </p>
        <p style="margin-top: 0.5cm;">
            Durante este periodo se llevaron a cabo {{ $estadisticas['total_eventos'] }} eventos,
            con la participación de {{ $estadisticas['total_participantes'] }} personas.
        </p>
    </div>
    @endif

    {{-- Actividades por Objetivo Específico --}}
    @foreach($objetivos as $objetivo)
        @php
            $metasDelObjetivo = $metas->filter(function($meta) use ($objetivo, $eventos_por_objetivo) {
                return isset($eventos_por_objetivo[$objetivo->id][$meta->id]);
            });
        @endphp

        @if($metasDelObjetivo->isNotEmpty())
        <div class="objetivo">
            <h2>OBJETIVO ESPECÍFICO {{ $loop->iteration }}</h2>
            <p style="font-style: italic; margin-bottom: 1cm;">
                {{ $objetivo->description }}
            </p>

            {{-- Metas dentro del objetivo --}}
            @foreach($metasDelObjetivo as $meta)
                @php
                    $eventosDelaMeta = collect($eventos_por_objetivo[$objetivo->id][$meta->id] ?? []);
                @endphp

                @if($eventosDelaMeta->isNotEmpty())
                <div class="meta-section">
                    <h3 class="meta-title">Meta {{ $meta->number }}: {{ $meta->description }}</h3>

                    {{-- Eventos de la meta --}}
                    @foreach($eventosDelaMeta as $evento)
                        @if($evento->narrativa_generada)
                        <div class="evento">
                            <div class="evento-header">
                                <span class="evento-fecha">{{ $evento->fecha_formateada }}</span>
                                —
                                <span>{{ $evento->activity->name }}</span>
                                @if($evento->location)
                                <span class="evento-ubicacion">({{ $evento->location->name }})</span>
                                @endif
                                :
                            </div>

                            <div class="evento-narrativa">
                                {!! nl2br(e($evento->narrativa_generada)) !!}
                            </div>
                        </div>
                        @endif
                    @endforeach
                </div>
                @endif
            @endforeach
        </div>
        @endif
    @endforeach

    {{-- Sección de logros (si está habilitada) --}}
    @if($data['incluir_logros'] ?? false)
    <div class="seccion-especial">
        <h2>LOGROS SIGNIFICATIVOS Y ACONTECIMIENTOS CLAVE</h2>
        <p style="text-align: justify;">
            Durante el periodo reportado se destacan los siguientes logros y acontecimientos significativos...
        </p>
        {{-- TODO: Generar con IA --}}
    </div>
    @endif

    {{-- Sección de lecciones (si está habilitada) --}}
    @if($data['incluir_lecciones'] ?? false)
    <div class="seccion-especial">
        <h2>LECCIONES APRENDIDAS</h2>
        <p style="text-align: justify;">
            Como resultado de las actividades implementadas durante este periodo, se identifican las siguientes lecciones aprendidas...
        </p>
        {{-- TODO: Generar con IA --}}
    </div>
    @endif

    {{-- Firma --}}
    <div class="firma">
        <div class="firma-linea"></div>
        <p style="margin-top: 0.5cm;">
            <strong>{{ $proyecto->followup_officer ?? 'Representante Legal' }}</strong><br>
            {{ $proyecto->financiers->name ?? '' }}
        </p>
    </div>
</body>
</html>
```

---

## ⚙️ CONFIGURACIÓN FINAL

### Actualizar .env

```env
# Ollama Cloud Configuration
OLLAMA_URL=https://api.ollama.cloud/v1  # O tu URL cloud específica
OLLAMA_API_KEY=sk-xxxxxxxxxxxxxxxxx     # Tu API Key
OLLAMA_MODEL=llama3.1
OLLAMA_TIMEOUT=180
OLLAMA_TEMPERATURE=0.3
OLLAMA_MAX_TOKENS=1500
```

### Actualizar .env.example

Agregar las mismas variables al archivo `.env.example` para documentación.

---

## 🧪 TESTING

### Comandos útiles

```bash
# Limpiar cache
php artisan cache:clear

# Ver logs
php artisan pail

# Testing manual
php artisan tinker
>>> $evento = App\Models\ActivityCalendar::find(1);
>>> $generator = app(App\Services\NarrativaGenerator::class);
>>> $narrativa = $generator->generarNarrativaEvento($evento);
>>> echo $narrativa;
```

---

## 📊 MÉTRICAS DE ÉXITO

- ✅ Narrativas generadas con estilo institucional formal
- ✅ Reducción del 80% en tiempo de elaboración de informes
- ✅ Coherencia en el estilo de redacción
- ✅ Cache efectivo de narrativas
- ✅ PDFs generados correctamente
- ✅ Interface intuitiva en Filament

---

## 🔄 PRÓXIMOS PASOS Y MEJORAS

1. **Optimizaciones:**
   - Implementar procesamiento en background (Jobs/Queues)
   - Notificaciones cuando el informe esté listo
   - Exportación a DOCX

2. **Funcionalidades adicionales:**
   - Generación de sección de logros con IA
   - Generación de sección de lecciones aprendidas con IA
   - Editor de narrativas en Filament
   - Historial de versiones de informes

3. **Mejoras de UX:**
   - Preview del informe antes de descargar
   - Plantillas personalizables
   - Selección de idioma

---

## 📚 DOCUMENTACIÓN DE REFERENCIA

- [Laravel 12 Docs](https://laravel.com/docs/12.x)
- [Filament PHP 3 Docs](https://filamentphp.com/docs/3.x)
- [Laravel DomPDF](https://github.com/barryvdh/laravel-dompdf)
- Documento original: `reportes.md`

---

## ✅ CHECKLIST DE IMPLEMENTACIÓN

- [ ] Fase 0: Instalación de dependencias y configuración
- [ ] Fase 1: Migración de BD y actualización de modelo
- [ ] Fase 2: Servicio NarrativaGenerator
- [ ] Fase 3: Acciones en ActivityCalendarResource
- [ ] Fase 4: Página de generación de informes
- [ ] Fase 5: Vista Blade del informe
- [ ] Testing completo
- [ ] Documentación final

---

**Fecha de creación:** {{ now()->format('Y-m-d H:i:s') }}
**Versión:** 1.0

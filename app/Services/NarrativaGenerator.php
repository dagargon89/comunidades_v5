<?php

namespace App\Services;

use App\Models\ActivityCalendar;
use App\Models\ActivityNarrative;
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
     * Genera o actualiza la narrativa para un evento específico (ActivityCalendar)
     *
     * @param ActivityCalendar $evento
     * @param bool $force Forzar regeneración aunque ya exista
     * @return ActivityNarrative
     */
    public function generarNarrativaEvento(ActivityCalendar $evento, bool $force = false): ActivityNarrative
    {
        // Buscar si ya existe una narrativa para este evento
        $narrativa = ActivityNarrative::firstOrNew([
            'activity_calendar_id' => $evento->id
        ]);

        // Si ya existe y no es forzado, retornar la existente
        if (!$force && $narrativa->exists && $narrativa->narrativa_generada) {
            Log::info("NarrativaGenerator: Usando narrativa existente para evento {$evento->id}");
            return $narrativa;
        }

        // Preparar datos del evento
        $datos = $this->prepararDatosEvento($evento, $narrativa);

        // Construir prompt
        $prompt = $this->construirPromptEvento($datos);

        // Iniciar tracking de tiempo
        $startTime = microtime(true);

        // Llamar a Ollama Cloud
        $textoGenerado = $this->llamarOllamaCloud($prompt, !$force);

        // Calcular tiempo de generación
        $tiempoGeneracion = microtime(true) - $startTime;

        // Guardar o actualizar narrativa
        $narrativa->narrativa_generada = $textoGenerado;
        $narrativa->narrativa_regenerada_at = now();

        // Si es una regeneración forzada, marcar como no aprobada
        if ($force && $narrativa->exists) {
            $narrativa->narrativa_aprobada = false;
        }

        $narrativa->save();

        // Crear versión automáticamente
        $narrativa->crearVersion(
            tipoCambio: $force ? 'regeneracion_automatica' : 'generacion_inicial',
            motivo: $force ? 'Regeneración solicitada por el usuario' : 'Generación inicial de la narrativa',
            tiempoGeneracion: $tiempoGeneracion,
            modeloUsado: $this->model
        );

        Log::info("NarrativaGenerator: Narrativa generada/actualizada para evento {$evento->id}", [
            'tiempo_generacion' => round($tiempoGeneracion, 2) . 's',
            'tipo_cambio' => $force ? 'regeneracion' : 'inicial'
        ]);

        return $narrativa;
    }

    /**
     * Genera introducción del informe del proyecto
     *
     * @param Project $proyecto
     * @param string $fechaInicio
     * @param string $fechaFin
     * @return string
     */
    public function generarIntroduccionProyecto(Project $proyecto, $fechaInicio, $fechaFin): string
    {
        $prompt = $this->construirPromptIntroduccion($proyecto, $fechaInicio, $fechaFin);
        return $this->llamarOllamaCloud($prompt);
    }

    /**
     * Prepara datos del evento para el prompt
     *
     * @param ActivityCalendar $evento
     * @param ActivityNarrative|null $narrativa
     * @return array
     */
    protected function prepararDatosEvento(ActivityCalendar $evento, ?ActivityNarrative $narrativa = null): array
    {
        // Cargar relaciones necesarias
        $evento->load([
            'activity.goal.project',
            'activity.specificObjective',
            'location',
            'beneficiaryRegistries.beneficiary'
        ]);

        // Si no hay narrativa pasada, intentar cargarla
        if (!$narrativa) {
            $narrativa = ActivityNarrative::where('activity_calendar_id', $evento->id)->first();
        }

        // Contar participantes reales desde beneficiary_registries
        $participantesReales = $evento->beneficiaryRegistries->count();
        $participantesCount = $narrativa->participantes_count ?? $participantesReales;

        // Obtener organizaciones
        $organizaciones = [];
        if ($narrativa && $narrativa->organizaciones_participantes) {
            $organizaciones = $narrativa->getOrganizacionesArray();
        }

        // Obtener meta y objetivo específico
        $meta = $evento->activity->goal->description ?? '';
        $objetivoEspecifico = $evento->activity->specificObjective->description ?? '';

        $proyecto = $evento->activity->goal->project->name ?? '';

        return [
            'fecha' => $this->formatearFecha($evento->start_date),
            'titulo' => $evento->activity->name ?? 'Actividad',
            'descripcion_actividad' => $evento->activity->description ?? '',
            'ubicacion' => $evento->location->name ?? $evento->address_backup ?? 'Ubicación no especificada',
            'participantes_count' => $participantesCount,
            'organizaciones' => $organizaciones,
            'meta' => $meta,
            'objetivo_especifico' => $objetivoEspecifico,
            'proyecto' => $proyecto,

            // Campos de entrada manual desde ActivityNarrative
            'contexto' => $narrativa->narrativa_contexto ?? '',
            'desarrollo' => $narrativa->narrativa_desarrollo ?? '',
            'resultados' => $narrativa->narrativa_resultados ?? '',
        ];
    }

    /**
     * Construye el prompt para generar narrativa de evento
     * Este prompt sigue el estilo institucional formal requerido
     *
     * @param array $datos
     * @return string
     */
    protected function construirPromptEvento(array $datos): string
    {
        $organizacionesTexto = count($datos['organizaciones']) > 0
            ? implode(', ', $datos['organizaciones'])
            : 'diversas organizaciones';

        return <<<PROMPT
Eres un redactor especializado en informes narrativos institucionales para organizaciones de la sociedad civil mexicanas.
Tu tarea es redactar una narrativa detallada de una actividad siguiendo un estilo FORMAL INSTITUCIONAL específico.

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

1. **Estructura obligatoria (2 a 4 párrafos según complejidad):**

   PÁRRAFO 1 - Contextualización y descripción general:
   - Inicia describiendo dónde y cómo se realizó la actividad
   - Menciona la ubicación específica (colonia, parque, edificio, etc.)
   - Indica número exacto de participantes y su demografía (vecinas y vecinos, jóvenes, niñas y niños, personas adultas mayores, etc.)
   - Si aplica, menciona organizaciones o instituciones participantes
   - Fórmulas preferidas: "se llevó a cabo", "se realizó", "se desarrolló"

   PÁRRAFOS INTERMEDIOS - Desarrollo detallado:
   - Describe las actividades realizadas con detalle
   - Explica los temas abordados, metodología empleada, dinámicas implementadas
   - Menciona momentos clave o acciones específicas
   - Incluye reacciones, participación o comentarios de las y los asistentes
   - Usa conectores variados: "Durante la jornada", "Posteriormente", "En el transcurso de", "A través de", "Las y los participantes", "Asimismo"

   PÁRRAFO FINAL - Resultados, impacto y compromisos:
   - Logros concretos alcanzados durante la actividad
   - Acuerdos establecidos entre las y los participantes
   - Compromisos futuros o próximos pasos
   - Reflexión sobre el impacto en el tejido comunitario o social
   - Usa conectores: "Al finalizar", "Al cierre", "Se acordó", "Como resultado", "La actividad contribuyó a", "Este proceso fortaleció"

2. **Estilo lingüístico OBLIGATORIO:**

   ✅ SIEMPRE usar:
   - VOZ PASIVA IMPERSONAL: "se llevó a cabo", "se realizó", "se abordaron", "se explicaron", "se discutieron"
   - LENGUAJE INCLUSIVO: "las y los participantes", "vecinas y vecinos", "niñas y niños", "personas adultas mayores", "las y los asistentes"
   - NÚMEROS EXACTOS: "{$datos['participantes_count']} personas", "15 vecinas y vecinos", "7 organizaciones"
   - CONECTORES FORMALES VARIADOS: "Durante la jornada", "Posteriormente", "Al finalizar", "Asimismo", "De forma paralela", "En el transcurso de", "A través de esta dinámica"
   - TERMINOLOGÍA TÉCNICA: cuando sea apropiado mencionar metodologías, herramientas técnicas o conceptos específicos

   ❌ NUNCA usar:
   - Primera persona: "realizamos", "hicimos", "acordamos", "trabajamos"
   - Opiniones subjetivas: "fue excelente", "estuvo muy bien", "increíble experiencia", "genial actividad"
   - Generalizaciones vagas: "muchas personas", "varios asistentes", "bastante gente", "algunas organizaciones"
   - Lenguaje coloquial: "estuvo chido", "fue padre", "se la pasaron bien", "quedó increíble"

3. **Terminología institucional preferida:**
   - "participación ciudadana" (no "gente participando")
   - "cohesión social" (no "unión de personas")
   - "incidencia pública" (no "influir en gobierno")
   - "fortalecimiento institucional" (no "mejorar organización")
   - "apropiación del espacio público" (no "usar el parque")
   - "tejido comunitario" (no "vecinos entre sí")
   - "convivencia" (no "pasarla bien juntos")
   - "gestión vecinal" (no "organización de vecinos")
   - "transformación del territorio" (no "cambios en la colonia")

4. **TONO Y LONGITUD:**
   - Redacta 2 a 4 párrafos densos y sustanciosos
   - Cada párrafo debe tener 4-7 oraciones completas
   - Usa un tono objetivo, descriptivo y formal
   - Enfócate en hechos concretos, no en juicios de valor
   - Menciona detalles específicos (nombres de lugares, organizaciones, temas, dinámicas)

5. **FORMATO DE SALIDA:**
   - NO incluyas el título de la actividad ni la fecha (ya están en el encabezado del reporte)
   - NO uses bullets, numeración, subtítulos ni viñetas
   - NO uses comillas decorativas para citar actividades
   - NO uses markdown (sin ##, **, -, etc.)
   - SOLO escribe los párrafos en texto plano separados por doble salto de línea
   - NO agregues comentarios meta como "Este texto cumple..." o "He redactado..." o "A continuación..."

---

**EJEMPLOS DE ESTILO CORRECTO (USA ESTOS COMO REFERENCIA EXACTA):**

EJEMPLO 1:
La reunión del Grupo Promotor de la Asamblea de Organizaciones se llevó a cabo en el Edificio Participa Juárez, con la participación de representantes de Fundación Juárez Integra, Desafío Juárez A.C., CFIC, Instituto Promotor de Educación y Plan Estratégico de Juárez.

Durante la sesión se revisó el Mapa de Incidencia para evaluar el avance de los procesos en curso. Se informó sobre la gestión de una cita con el representante del Gobierno del Estado, Lic. Carlos Ortiz Villegas, con el propósito de presentar a la gobernadora María Eugenia Campos Galván el documento de fortalecimiento de la Junta de Asistencia Social Privada (JASP).

También se inició un nuevo proceso de apoyo a la Subsecretaría de Desarrollo Humano y Bien Común (SDHyBC) para justificar un incremento presupuestal al programa de subsidios para proyectos operados por OSC, acordando elaborar un estudio técnico como sustento.

EJEMPLO 2:
Se realizó la Feria del Emprendedor del programa Generando Oportunidades, con la participación de 10 emprendedoras y emprendedores que recibieron sus lonas publicitarias como apoyo para la difusión y posicionamiento de sus proyectos ante la comunidad local, especialmente entre las y los residentes de los alrededores del Parque Frida Kahlo.

El evento se llevó a cabo en un ambiente festivo y comunitario, acompañado de una programación cultural que incluyó presentaciones de música tradicional mexicana, actividades recreativas familiares, experiencias interactivas y talleres orientados al desarrollo de la creatividad y la innovación.

Como parte del acto de cierre del curso, se realizó la entrega formal de constancias y diplomas de participación, reconociendo el esfuerzo, compromiso y dedicación de las y los emprendedores que concluyeron satisfactoriamente su proceso formativo dentro del programa.

---

**AHORA REDACTA LA NARRATIVA DE LA ACTIVIDAD (SOLO LOS PÁRRAFOS, SIN NADA MÁS):**
PROMPT;
    }

    /**
     * Construye prompt para introducción del informe
     *
     * @param Project $proyecto
     * @param string $fechaInicio
     * @param string $fechaFin
     * @return string
     */
    protected function construirPromptIntroduccion(Project $proyecto, $fechaInicio, $fechaFin): string
    {
        $fechaInicioFmt = $this->formatearFecha($fechaInicio);
        $fechaFinFmt = $this->formatearFecha($fechaFin);

        return <<<PROMPT
Redacta una introducción formal para un informe narrativo institucional.

**INFORMACIÓN DEL PROYECTO:**
- Nombre: {$proyecto->name}
- Periodo: del {$fechaInicioFmt} al {$fechaFinFmt}
- Objetivo general: {$proyecto->general_objective}

**INSTRUCCIONES:**
1. Usa estilo formal institucional
2. Menciona el periodo y proyecto
3. Brevemente contextualiza los objetivos
4. 2-3 párrafos máximo
5. Usa pasado impersonal y lenguaje inclusivo

**Redacta SOLO la introducción:**
PROMPT;
    }

    /**
     * Llamada a Ollama Cloud API con manejo de errores y retry
     *
     * @param string $prompt
     * @param bool $useCache
     * @return string
     */
    protected function llamarOllamaCloud(string $prompt, bool $useCache = true): string
    {
        $cacheKey = 'narrativa_' . hash('sha256', $prompt);

        if ($useCache && Cache::has($cacheKey)) {
            Log::info('NarrativaGenerator: Usando narrativa cacheada');
            return Cache::get($cacheKey);
        }

        try {
            Log::info('NarrativaGenerator: Llamando a Ollama API', [
                'url' => $this->ollamaUrl,
                'model' => $this->model,
                'tiene_api_key' => !empty($this->apiKey),
            ]);

            $headers = [
                'Content-Type' => 'application/json',
            ];

            // Detectar si es Ollama Cloud (tiene API key) o Ollama Local
            $isOllamaCloud = !empty($this->apiKey);

            if ($isOllamaCloud) {
                $headers['Authorization'] = "Bearer {$this->apiKey}";

                // Ollama Cloud usa endpoint compatible con OpenAI
                $endpoint = "{$this->ollamaUrl}/chat/completions";
                $payload = [
                    'model' => $this->model,
                    'messages' => [
                        [
                            'role' => 'user',
                            'content' => $prompt
                        ]
                    ],
                    'temperature' => $this->temperature,
                    'max_tokens' => $this->maxTokens,
                    'stream' => false,
                ];

                Log::info('NarrativaGenerator: Usando endpoint Ollama Cloud', [
                    'endpoint' => $endpoint
                ]);
            } else {
                // Ollama Local usa endpoint nativo
                $endpoint = "{$this->ollamaUrl}/api/generate";
                $payload = [
                    'model' => $this->model,
                    'prompt' => $prompt,
                    'stream' => false,
                    'options' => [
                        'temperature' => $this->temperature,
                        'top_p' => 0.9,
                        'num_predict' => $this->maxTokens,
                    ]
                ];

                Log::info('NarrativaGenerator: Usando endpoint Ollama Local', [
                    'endpoint' => $endpoint
                ]);
            }

            $response = Http::withHeaders($headers)
                ->timeout($this->timeout)
                ->retry(3, 1000) // 3 intentos, 1 segundo entre intentos
                ->post($endpoint, $payload);

            if (!$response->successful()) {
                $error = $response->body();
                Log::error("NarrativaGenerator: Error en Ollama API", [
                    'status' => $response->status(),
                    'error' => $error,
                    'endpoint' => $endpoint
                ]);
                throw new \Exception("Error en Ollama API ({$response->status()}): {$error}");
            }

            $result = $response->json();

            // Extraer narrativa según el tipo de respuesta
            if ($isOllamaCloud) {
                // Respuesta OpenAI-compatible
                $narrativa = $result['choices'][0]['message']['content'] ?? '';
            } else {
                // Respuesta Ollama Local
                $narrativa = $result['response'] ?? '';
            }

            if (empty($narrativa)) {
                throw new \Exception('Ollama API retornó una respuesta vacía');
            }

            // Limpiar respuesta
            $narrativa = $this->limpiarRespuestaIA($narrativa);

            // Cachear por 30 días
            Cache::put($cacheKey, $narrativa, now()->addDays(30));

            Log::info('NarrativaGenerator: Narrativa generada exitosamente', [
                'length' => strlen($narrativa),
                'tipo' => $isOllamaCloud ? 'cloud' : 'local'
            ]);

            return $narrativa;

        } catch (\Exception $e) {
            Log::error('NarrativaGenerator: Error al generar narrativa', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            throw $e;
        }
    }

    /**
     * Limpia la respuesta de la IA removiendo formato markdown y normalizando
     *
     * @param string $respuesta
     * @return string
     */
    protected function limpiarRespuestaIA(string $respuesta): string
    {
        // Remover markdown extra
        $respuesta = preg_replace('/^#+\s+/m', '', $respuesta);
        $respuesta = preg_replace('/\*\*(.*?)\*\*/', '$1', $respuesta);
        $respuesta = preg_replace('/\*(.*?)\*/', '$1', $respuesta);

        // Remover bullets y numeración
        $respuesta = preg_replace('/^[\-\*]\s+/m', '', $respuesta);
        $respuesta = preg_replace('/^\d+\.\s+/m', '', $respuesta);

        // Normalizar espacios y saltos de línea
        $respuesta = preg_replace('/\n{3,}/', "\n\n", $respuesta);
        $respuesta = trim($respuesta);

        return $respuesta;
    }

    /**
     * Formatea una fecha al estilo español: "12 de junio de 2025"
     *
     * @param mixed $fecha
     * @return string
     */
    protected function formatearFecha($fecha): string
    {
        $meses = [
            1 => 'enero', 2 => 'febrero', 3 => 'marzo', 4 => 'abril',
            5 => 'mayo', 6 => 'junio', 7 => 'julio', 8 => 'agosto',
            9 => 'septiembre', 10 => 'octubre', 11 => 'noviembre', 12 => 'diciembre'
        ];

        $fechaCarbon = \Carbon\Carbon::parse($fecha);
        return $fechaCarbon->day . ' de ' . $meses[$fechaCarbon->month] . ' de ' . $fechaCarbon->year;
    }

    /**
     * Limpiar cache de narrativas
     */
    public function clearCache(): void
    {
        Cache::flush();
        Log::info('NarrativaGenerator: Cache limpiado');
    }

    /**
     * Verifica si la conexión con Ollama está funcionando
     *
     * @return bool
     */
    public function testConnection(): bool
    {
        try {
            $headers = [
                'Content-Type' => 'application/json',
            ];

            if ($this->apiKey) {
                $headers['Authorization'] = "Bearer {$this->apiKey}";
            }

            $response = Http::withHeaders($headers)
                ->timeout(10)
                ->get("{$this->ollamaUrl}/api/tags");

            return $response->successful();
        } catch (\Exception $e) {
            Log::error('NarrativaGenerator: Error al probar conexión', [
                'error' => $e->getMessage()
            ]);
            return false;
        }
    }
}

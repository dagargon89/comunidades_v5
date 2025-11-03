# PROMPT PARA CLAUDE CODE - Sistema de Generación Automatizada de Informes Narrativos

## 🎯 CONTEXTO DEL PROYECTO

Estoy desarrollando un sistema en Laravel con Filament PHP 3 para generar automáticamente informes narrativos institucionales. Los informes deben seguir un estilo formal específico usado por organizaciones de la sociedad civil para reportar actividades y resultados a sus financiadores.

**Stack actual:**
- Laravel 11.x
- Filament PHP 3.x
- MySQL 8.x
- Ollama API (local) para generación de texto con IA

**Objetivo:** Crear un sistema que tome datos estructurados de la base de datos y genere narrativas en estilo formal institucional usando Ollama, luego renderizar un documento PDF/DOCX con formato idéntico a los informes manuales actuales.

---

## 📋 ANÁLISIS DE BASE DE DATOS

**TAREA INICIAL CRÍTICA:** Antes de comenzar la implementación, analiza la estructura actual de la base de datos de la aplicación Laravel para identificar:

1. **Tablas principales relacionadas con proyectos/actividades:**
   - Tabla de proyectos (projects, programas, iniciativas, etc.)
   - Tabla de objetivos específicos o componentes del proyecto
   - Tabla de metas o indicadores
   - Tabla de actividades o eventos
   - Tablas de participantes y resultados

2. **Relaciones entre tablas:**
   - Cómo se relacionan proyectos → objetivos → metas → actividades
   - Relaciones many-to-many (participantes, organizaciones)
   - Campos de fechas y periodos de reporte

3. **Campos clave para generación de narrativas:**
   - Descripción de actividades
   - Contexto y desarrollo
   - Resultados y acuerdos
   - Conteo de participantes
   - Ubicaciones
   - Fechas

4. **Modelos Eloquent existentes:**
   - Identificar modelos ya creados
   - Verificar relaciones definidas
   - Revisar scopes y accessors actuales

**COMANDO DE ANÁLISIS:**
````bash
# Revisa las migraciones
ls -la database/migrations/

# Revisa los modelos existentes  
ls -la app/Models/

# Analiza la estructura real de la BD
php artisan db:show
php artisan db:table [nombre_tabla]
````

**Basado en este análisis**, adapta la implementación a tu estructura real de base de datos.

---

## 🎨 ESTILO DE ESCRITURA REQUERIDO

### Características del estilo institucional formal:

**1. Estructura de cada narrativa de actividad (3 párrafos):**
````
Párrafo 1: CONTEXTUALIZACIÓN
- Qué se hizo
- Quiénes participaron (con números exactos)
- Dónde se realizó
- Fecha (si relevante mencionar contexto temporal)

Párrafos intermedios: DESARROLLO
- Cómo se llevó a cabo la actividad
- Temas abordados
- Metodología empleada
- Dinámicas realizadas

Párrafo final: RESULTADOS
- Acuerdos alcanzados
- Compromisos establecidos
- Impactos observados
- Próximos pasos definidos
````

**2. Patrones lingüísticos obligatorios:**

✅ **USAR:**
- Verbos en pasado impersonal: "se realizó", "se llevó a cabo", "se abordaron"
- Conectores temporales: "Durante la sesión", "Al finalizar", "Posteriormente"
- Lenguaje inclusivo: "las y los participantes", "vecinas y vecinos", "niñas y niños"
- Cuantificación precisa: "participaron 15 personas", "asistieron 23 vecinas y vecinos"
- Terminología sectorial: "participación ciudadana", "cohesión social", "incidencia pública"

❌ **NO USAR:**
- Primera persona ("realizamos", "hicimos")
- Opiniones subjetivas ("fue excelente", "estuvo increíble")
- Lenguaje informal o coloquial
- Generalizaciones sin datos ("muchas personas", "varios asistentes")

**3. Ejemplo real del estilo esperado:**
````
12 de junio de 2025 — Seguimiento al Mapa de Incidencia y fortalecimiento de la JASP: La reunión del Grupo Promotor de la Asamblea de Organizaciones se llevó a cabo en el Edificio Participa Juárez, con la participación de representantes de Fundación Juárez Integra, Desafío Juárez A.C., CFIC, Instituto Promotor de Educación y Plan Estratégico de Juárez.

Durante la sesión se revisó el "Mapa de Incidencia" para evaluar el avance de los procesos en curso. Se informó sobre la gestión de una cita con el representante del Gobierno del Estado, Lic. Carlos Ortiz Villegas, con el propósito de presentar a la gobernadora María Eugenia Campos Galván el documento de fortalecimiento de la Junta de Asistencia Social Privada (JASP).

También se inició un nuevo proceso de apoyo a la Subsecretaría de Desarrollo Humano y Bien Común (SDHyBC) para justificar un incremento presupuestal al programa de subsidios para proyectos operados por OSC, acordando elaborar un estudio técnico como sustento.
````

---

## 🏗️ IMPLEMENTACIÓN REQUERIDA - PASO A PASO

### FASE 1: Preparación de la Base de Datos

**Tarea 1.1:** Analizar estructura actual y crear migración para campos de narrativa

Después de analizar tu estructura de BD, crea una migración para agregar campos necesarios a la tabla de actividades (o su equivalente):
````php
// Crear: database/migrations/YYYY_MM_DD_add_narrativa_fields_to_actividades.php

Campos a agregar:
- narrativa_generada (TEXT, nullable) - Cache de la narrativa generada por IA
- narrativa_aprobada (BOOLEAN, default false) - Flag de revisión humana
- narrativa_regenerada_at (TIMESTAMP, nullable) - Auditoría de regeneración
- Agregar índice en narrativa_aprobada para queries eficientes
````

**Tarea 1.2:** Actualizar modelo de Actividad (o equivalente)
````php
// Actualizar el modelo correspondiente, ejemplo: app/Models/Actividad.php

Agregar:
- Campos al $fillable
- Casts apropiados:
  - 'narrativa_aprobada' => 'boolean'
  - 'narrativa_regenerada_at' => 'datetime'
  - 'fecha' => 'date'

Crear métodos:
- regenerarNarrativa(): void - Limpia cache y marca para regeneración
- marcarAprobada(): void - Marca narrativa como revisada
- requiresNarrativa(): bool - Verifica si necesita generación

Crear scopes:
- scopeConNarrativaAprobada($query)
- scopeSinNarrativaGenerada($query)
- scopeEnPeriodo($query, $inicio, $fin)

Agregar relaciones necesarias:
- participantes, organizaciones, resultados (según tu estructura)

Agregar accessors:
- getFechaFormateadaAttribute(): string - "12 de junio de 2025"
- getParticipantesCountAttribute(): int
````

---

### FASE 2: Servicio de Generación de Narrativas con Ollama

**Tarea 2.1:** Crear configuración de Ollama
````php
// Crear/actualizar: config/services.php

Agregar sección 'ollama':
[
    'ollama' => [
        'url' => env('OLLAMA_URL', 'http://localhost:11434'),
        'model' => env('OLLAMA_MODEL', 'llama3.1'),
        'timeout' => env('OLLAMA_TIMEOUT', 120),
        'temperature' => env('OLLAMA_TEMPERATURE', 0.3),
        'max_tokens' => env('OLLAMA_MAX_TOKENS', 1500),
    ],
]
````

**Tarea 2.2:** Crear servicio NarrativaGenerator
````php
// Crear: app/Services/NarrativaGenerator.php

Clase con los siguientes métodos públicos:

1. generarNarrativaActividad($actividad): string
   - Construye el prompt con los datos de la actividad
   - Llama a Ollama
   - Retorna la narrativa generada
   - Usa cache para evitar regeneración innecesaria

2. generarIntroduccionProyecto($proyecto, $fechaInicio, $fechaFin): string
   - Genera párrafo introductorio del informe
   - Menciona periodo, organizaciones participantes, objetivos

3. generarSeccionLogros($actividades): string
   - Analiza actividades del periodo
   - Genera narrativa de logros significativos

4. generarSeccionLecciones($actividades): string
   - Analiza actividades del periodo
   - Genera narrativa de lecciones aprendidas

Métodos protegidos:

1. construirPromptActividad(array $datos): string
   - Construye prompt detallado con instrucciones de estilo
   - Incluye ejemplos del estilo esperado
   - Ver TEMPLATE DE PROMPT más abajo

2. llamarOllama(string $prompt, array $options = []): string
   - Hace llamada HTTP a Ollama API
   - Maneja errores y timeouts
   - Implementa retry logic (3 intentos)
   - Usa cache opcional

3. limpiarRespuestaIA(string $respuesta): string
   - Remueve markdown extra
   - Limpia formato
   - Normaliza espacios

4. prepararDatosActividad($actividad): array
   - Extrae y formatea datos de la actividad
   - Prepara estructura para el prompt
````

**TEMPLATE DE PROMPT PARA OLLAMA** (usa este exactamente):
````php
protected function construirPromptActividad($actividad): string
{
    $fecha = $actividad->fecha->format('d \d\e F \d\e Y');
    $participantes = $actividad->participantes_count ?? 0;
    $organizaciones = $actividad->organizaciones->pluck('nombre')->join(', ') ?? 'N/A';
    
    return <<<PROMPT
Eres un redactor especializado en informes narrativos para organizaciones de la sociedad civil mexicanas. 
Tu tarea es redactar la descripción de una actividad siguiendo un estilo FORMAL INSTITUCIONAL muy específico.

**CONTEXTO DE LA ACTIVIDAD:**
- Fecha: {$fecha}
- Actividad: {$actividad->titulo}
- Ubicación: {$actividad->ubicacion}
- Meta asociada: {$actividad->meta->titulo}
- Participantes: {$participantes} personas
- Organizaciones: {$organizaciones}

**DESCRIPCIÓN DE LO REALIZADO:**
{$actividad->descripcion}

**CONTEXTO ADICIONAL:**
{$actividad->contexto}

**DESARROLLO DE LA ACTIVIDAD:**
{$actividad->desarrollo}

**RESULTADOS Y ACUERDOS:**
{$actividad->resultados}

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
   - Números exactos: "15 personas", "23 vecinas y vecinos" (nunca "varias personas")
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
````

---

### FASE 3: Vista Blade para el Informe

**Tarea 3.1:** Crear plantilla principal del informe
````php
// Crear: resources/views/reports/informe-narrativo.blade.php

Estructura HTML/CSS con:

1. Estilos CSS internos que repliquen:
   - Márgenes de 2cm
   - Fuente Arial 11pt
   - Interlineado 1.6
   - Saltos de página por objetivo
   - Formato de títulos (H1: 16pt bold, H2: 14pt bold, H3: 12pt bold)
   - Color negro para texto principal
   - Justificación de texto

2. Secciones del documento (en este orden):
   - Encabezado con título centrado y ficha técnica
   - Introducción generada por IA
   - Loop de Objetivos Específicos
     - Para cada objetivo:
       - Título del objetivo (OE#)
       - Loop de Metas dentro del objetivo
         - Título de la meta
         - Loop de Actividades dentro de la meta
           - Fecha — Título (Ubicación): Narrativa generada
   - Sección de logros significativos / acontecimientos clave
   - Sección de lecciones aprendidas
   - Tabla de resultados y análisis de metas (opcional)
   - Acciones correctivas realizadas (opcional)
   - Firma del representante legal

3. Cada actividad debe mostrarse como:
   <span class="actividad-fecha">[FECHA FORMATEADA]</span> — 
   <span class="actividad-titulo">[TÍTULO]</span>
   @if($actividad->ubicacion)
   <span class="actividad-ubicacion">([UBICACIÓN])</span>
   @endif
   <span>:</span>
   <div class="actividad-narrativa">{!! $actividad->narrativa_generada !!}</div>

4. Clases CSS importantes:
   .header { text-align: center; margin-bottom: 2cm; }
   .objetivo { page-break-before: always; margin-bottom: 2cm; }
   .meta-title { font-weight: bold; margin-top: 1.5cm; }
   .actividad { margin-bottom: 1.5cm; text-align: justify; }
   .actividad-fecha { font-weight: bold; }
   .logros, .lecciones { page-break-before: always; }
````

**Tarea 3.2:** Crear componentes Blade reutilizables
````php
// Crear: resources/views/reports/components/actividad-narrativa.blade.php
// Props: $actividad

// Crear: resources/views/reports/components/objetivo-section.blade.php  
// Props: $objetivo

// Crear: resources/views/reports/components/meta-section.blade.php
// Props: $meta

// Crear: resources/views/reports/components/tabla-metas.blade.php
// Props: $objetivos
````

---

### FASE 4: Recurso Filament para Generación de Informes

**Tarea 4.1:** Crear página personalizada en Filament
````php
// Crear: app/Filament/Resources/ProjectResource/Pages/GenerarInforme.php

Clase que extienda Page e implemente HasForms

use Filament\Resources\Pages\Page;
use Filament\Forms;
use Filament\Notifications\Notification;

Propiedades:
- protected static string $resource = ProjectResource::class;
- protected static string $view = 'filament.resources.project.pages.generar-informe';
- public ?array $data = [];
- public $proyecto;

Debe incluir:

1. Método mount():
   - Cargar el proyecto actual
   - Inicializar formulario con valores por defecto

2. Formulario (getFormSchema) con campos:
   Forms\Components\Section::make('Periodo del Informe')
   - DatePicker: fecha_inicio (required)
   - DatePicker: fecha_fin (required)
   
   Forms\Components\Section::make('Contenido a Incluir')
   - Select multiple: objetivos_ids (options desde BD)
   - CheckboxList: metas_ids (opcionales, filtradas por objetivos)
   
   Forms\Components\Section::make('Opciones de Generación')
   - Toggle: incluir_introduccion (default true)
   - Toggle: incluir_logros (default true)
   - Toggle: incluir_lecciones (default true)
   - Toggle: usar_cache_narrativas (default true)
     - helperText: "Usar narrativas ya generadas si existen"
   
   Forms\Components\Section::make('Formato de Salida')
   - Select: formato_salida (options: pdf, docx, html)
     - default: 'pdf'

3. Acción principal: generar()
   - $this->validate()
   - Mostrar notificación de inicio
   - try-catch para manejo de errores
   - Llamar a obtenerDatosProyecto()
   - Llamar a procesarNarrativas()
   - Llamar a renderizarInforme()
   - Llamar a exportar según formato
   - Retornar descarga del archivo

4. Métodos helper protegidos:

   protected function obtenerDatosProyecto(): array
   - Consulta BD según filtros del formulario
   - Carga relaciones necesarias (eager loading)
   - Filtra por periodo
   - Ordena por fecha
   - Retorna array estructurado con:
     - proyecto
     - objetivos (con metas y actividades anidadas)
     - periodo
     - estadísticas

   protected function procesarNarrativas(array $datos): void
   - Itera sobre todas las actividades
   - Para cada actividad sin narrativa O con usar_cache=false:
     - Llama a NarrativaGenerator->generarNarrativaActividad()
     - Guarda narrativa en BD
     - Actualiza timestamp
   - Muestra progress si hay muchas actividades

   protected function renderizarInforme(array $datos): string
   - Carga vista Blade con todos los datos
   - Retorna HTML renderizado

   protected function exportar(string $html, string $formato): Response
   - Genera nombre de archivo único
   - Switch según formato:
     - 'pdf': llamar a exportarPDF()
     - 'docx': llamar a exportarDOCX()
     - 'html': retornar HTML directo
   - Retornar Response con descarga

   protected function exportarPDF(string $html): StreamedResponse
   - Usar barryvdh/laravel-dompdf
   - Configurar papel, márgenes, orientación
   - Retornar stream

   protected function exportarDOCX(string $html): StreamedResponse
   - Usar phpoffice/phpword
   - Convertir HTML a Word
   - Retornar stream

5. Wire loading indicators:
   - wire:loading.attr="disabled" en botón
   - wire:loading indicador visual
   - wire:target="generar" para especificidad
````

**Tarea 4.2:** Crear vista Filament
````php
// Crear: resources/views/filament/resources/project/pages/generar-informe.blade.php

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
                    Este proceso puede tomar varios minutos dependiendo de la cantidad de actividades. 
                    Las narrativas se generan usando inteligencia artificial y se cachean para futuras consultas.
                </p>
            </div>
        </div>
    </div>
    
    {{-- Información de ayuda --}}
    <x-filament::section class="mt-6">
        <x-slot name="heading">
            Información sobre la generación
        </x-slot>
        
        <x-slot name="description">
            <ul class="text-sm space-y-2 list-disc list-inside">
                <li>Las narrativas se generan en estilo formal institucional</li>
                <li>Se cachean en la base de datos para evitar regeneraciones</li>
                <li>Puedes desactivar el cache para regenerar todas las narrativas</li>
                <li>El proceso puede tardar 5-15 segundos por actividad</li>
                <li>Asegúrate de que Ollama esté corriendo en {{ config('services.ollama.url') }}</li>
            </ul>
        </x-slot>
    </x-filament::section>
</x-filament-panels::page>
````

**Tarea 4.3:** Registrar página en ProjectResource
````php
// Actualizar: app/Filament/Resources/ProjectResource.php

public static function getPages(): array
{
    return [
        'index' => Pages\ListProjects::route('/'),
        'create' => Pages\CreateProject::route('/create'),
        'edit' => Pages\EditProject::route('/{record}/edit'),
        'generar-informe' => Pages\GenerarInforme::route('/{record}/generar-informe'), // NUEVO
    ];
}

// Agregar acción en tabla (opcional pero recomendado)
public static function table(Table $table): Table
{
    return $table
        ->columns([...])
        ->actions([
            Tables\Actions\EditAction::make(),
            Tables\Actions\Action::make('generar_informe')
                ->label('Generar Informe')
                ->icon('heroicon-o-document-text')
                ->url(fn ($record) => ProjectResource::getUrl('generar-informe', ['record' => $record]))
                ->openUrlInNewTab(false),
        ]);
}
````

---

### FASE 5: Exportación de Documentos

**Tarea 5.1:** Instalar dependencias
````bash
composer require barryvdh/laravel-dompdf
composer require phpoffice/phpword  # Opcional para DOCX
````

**Tarea 5.2:** Publicar configuración de DomPDF (opcional)
````bash
php artisan vendor:publish --provider="Barryvdh\DomPDF\ServiceProvider"
````

**Tarea 5.3:** Crear servicio de exportación (opcional, puede estar en el Page)
````php
// Crear: app/Services/InformeExporter.php

namespace App\Services;

use Barryvdh\DomPDF\Facade\Pdf;
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\IOFactory;
use Illuminate\Http\Response;
use Symfony\Component\HttpFoundation\StreamedResponse;

class InformeExporter
{
    public function exportarPDF(string $html, string $filename): StreamedResponse
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
    
    public function exportarDOCX(string $html, string $filename): StreamedResponse
    {
        $phpWord = new PhpWord();
        
        // Configurar estilos
        $phpWord->addFontStyle('titulo', [
            'name' => 'Arial',
            'size' => 16,
            'bold' => true,
        ]);
        
        // Convertir HTML a Word (básico)
        $section = $phpWord->addSection([
            'marginTop' => 1134,    // 2cm en twips
            'marginBottom' => 1134,
            'marginLeft' => 1134,
            'marginRight' => 1134,
        ]);
        
        // Aquí necesitarías un parser HTML-to-Word más sofisticado
        // O usar \PhpOffice\PhpWord\Shared\Html::addHtml()
        
        $tempFile = tempnam(sys_get_temp_dir(), 'informe_');
        $objWriter = IOFactory::createWriter($phpWord, 'Word2007');
        $objWriter->save($tempFile);
        
        return response()->streamDownload(function () use ($tempFile) {
            echo file_get_contents($tempFile);
            unlink($tempFile);
        }, "{$filename}.docx", [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        ]);
    }
    
    public function exportarHTML(string $html): Response
    {
        return response($html, 200, [
            'Content-Type' => 'text/html; charset=utf-8',
        ]);
    }
}
````

---

### FASE 6: Job en Background (Opcional pero recomendado)

**Tarea 6.1:** Crear Job para procesamiento async
````php
// Crear: app/Jobs/GenerarInformeJob.php

namespace App\Jobs;

use App\Models\Project;
use App\Services\NarrativaGenerator;
use App\Services\InformeExporter;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Storage;

class GenerarInformeJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    
    public $timeout = 600; // 10 minutos
    
    public function __construct(
        public int $proyectoId,
        public array $configuracion,
        public int $userId
    ) {}
    
    public function handle(
        NarrativaGenerator $generator,
        InformeExporter $exporter
    ): void
    {
        $proyecto = Project::findOrFail($this->proyectoId);
        
        try {
            // 1. Obtener datos
            $datos = $this->obtenerDatos($proyecto);
            
            // 2. Generar narrativas
            $this->generarNarrativas($generator, $datos);
            
            // 3. Renderizar HTML
            $html = view('reports.informe-narrativo', $datos)->render();
            
            // 4. Exportar a archivo
            $filename = "informe_{$proyecto->id}_" . now()->format('Y-m-d_His');
            $path = "informes/{$filename}.pdf";
            
            // Guardar temporalmente
            $pdf = Pdf::loadHTML($html)->output();
            Storage::put($path, $pdf);
            
            // 5. Notificar usuario
            $user = \App\Models\User::find($this->userId);
            $user->notify(new \App\Notifications\InformeGeneradoNotification(
                $proyecto,
                $path,
                $filename
            ));
            
        } catch (\Exception $e) {
            // Notificar error
            $user = \App\Models\User::find($this->userId);
            $user->notify(new \App\Notifications\InformeErrorNotification(
                $proyecto,
                $e->getMessage()
            ));
            
            throw $e;
        }
    }
    
    protected function obtenerDatos($proyecto): array
    {
        // Lógica similar a la del Page
    }
    
    protected function generarNarrativas($generator, array &$datos): void
    {
        // Lógica de generación
    }
}
````

**Tarea 6.2:** Crear notificaciones
````php
// Crear: app/Notifications/InformeGeneradoNotification.php

namespace App\Notifications;

use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Support\Facades\Storage;

class InformeGeneradoNotification extends Notification
{
    public function __construct(
        public $proyecto,
        public string $path,
        public string $filename
    ) {}
    
    public function via($notifiable): array
    {
        return ['database', 'mail'];
    }
    
    public function toMail($notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('Informe narrativo generado')
            ->line("El informe del proyecto {$this->proyecto->nombre} ha sido generado.")
            ->action('Descargar informe', url("/descargar-informe/{$this->filename}"))
            ->line('El link estará disponible por 24 horas.');
    }
    
    public function toArray($notifiable): array
    {
        return [
            'proyecto_id' => $this->proyecto->id,
            'proyecto_nombre' => $this->proyecto->nombre,
            'path' => $this->path,
            'filename' => $this->filename,
        ];
    }
}

// Crear: app/Notifications/InformeErrorNotification.php
// Similar pero para errores
````

**Tarea 6.3:** Actualizar Page para usar Job
````php
// En GenerarInforme::generar()

public function generar()
{
    $this->validate();
    
    // Despachar job
    GenerarInformeJob::dispatch(
        $this->proyecto->id,
        $this->data,
        auth()->id()
    );
    
    Notification::make()
        ->title('Informe en proceso')
        ->body('Te notificaremos cuando el informe esté listo para descargar.')
        ->success()
        ->send();
    
    // Redirigir a lista o dashboard
    return redirect()->route('filament.admin.resources.projects.index');
}
````

---

### FASE 7: Cache y Optimización

**Tarea 7.1:** Implementar cache en NarrativaGenerator
````php
// En app/Services/NarrativaGenerator.php

use Illuminate\Support\Facades\Cache;

protected function llamarOllama(string $prompt, array $options = []): string
{
    $cacheKey = 'narrativa_' . hash('sha256', $prompt);
    $ttl = now()->addDays(30);
    
    return Cache::remember($cacheKey, $ttl, function () use ($prompt, $options) {
        $response = Http::timeout($this->timeout)
            ->retry(3, 100) // 3 intentos, 100ms entre intentos
            ->post("{$this->ollamaUrl}/api/generate", [
                'model' => $this->model,
                'prompt' => $prompt,
                'stream' => false,
                'options' => array_merge([
                    'temperature' => config('services.ollama.temperature'),
                    'top_p' => 0.9,
                    'num_predict' => config('services.ollama.max_tokens'),
                ], $options)
            ]);
        
        if (!$response->successful()) {
            throw new \Exception(
                "Error en Ollama API: " . $response->body()
            );
        }
        
        $result = $response->json();
        return $this->limpiarRespuestaIA($result['response'] ?? '');
    });
}

public function clearCache(): void
{
    // Limpiar cache de narrativas
    Cache::flush(); // O más específico con tags si usas Redis
}
````

**Tarea 7.2:** Crear comando Artisan para regeneración masiva
````php
// Crear: app/Console/Commands/RegenerarNarrativas.php

namespace App\Console\Commands;

use App\Models\Project;
use App\Services\NarrativaGenerator;
use Illuminate\Console\Command;

class RegenerarNarrativas extends Command
{
    protected $signature = 'narrativas:regenerar 
                            {project_id : ID del proyecto} 
                            {--force : Sobrescribir narrativas aprobadas}
                            {--desde= : Fecha inicio YYYY-MM-DD}
                            {--hasta= : Fecha fin YYYY-MM-DD}';
    
    protected $description = 'Regenera narrativas de actividades usando IA';
    
    public function handle(NarrativaGenerator $generator): int
    {
        $proyecto = Project::findOrFail($this->argument('project_id'));
        
        $query = $proyecto->actividades();
        
        // Filtros opcionales
        if ($this->option('desde')) {
            $query->where('fecha', '>=', $this->option('desde'));
        }
        
        if ($this->option('hasta')) {
            $query->where('fecha', '<=', $this->option('hasta'));
        }
        
        // Si no es force, solo las no aprobadas
        if (!$this->option('force')) {
            $query->where(function ($q) {
                $q->whereNull('narrativa_generada')
                  ->orWhere('narrativa_aprobada', false);
            });
        }
        
        $actividades = $query->get();
        
        if ($actividades->isEmpty()) {
            $this->info('No hay actividades para regenerar.');
            return self::SUCCESS;
        }
        
        $this->info("Se regenerarán {$actividades->count()} actividades.");
        
        $bar = $this->output->createProgressBar($actividades->count());
        $bar->start();
        
        foreach ($actividades as $actividad) {
            try {
                $narrativa = $generator->generarNarrativaActividad($actividad);
                
                $actividad->update([
                    'narrativa_generada' => $narrativa,
                    'narrativa_regenerada_at' => now(),
                    'narrativa_aprobada' => false,
                ]);
                
                $bar->advance();
                
            } catch (\Exception $e) {
                $this->error("\nError en actividad {$actividad->id}: " . $e->getMessage());
            }
        }
        
        $bar->finish();
        $this->newLine(2);
        $this->info('Regeneración completada.');
        
        return self::SUCCESS;
    }
}
````

---

### FASE 8: Testing Básico

**Tarea 8.1:** Crear tests de integración
````php
// Crear: tests/Feature/NarrativaGeneratorTest.php

namespace Tests\Feature;

use Tests\TestCase;
use App\Services\NarrativaGenerator;
use App\Models\Actividad;
use Illuminate\Foundation\Testing\RefreshDatabase;

class NarrativaGeneratorTest extends TestCase
{
    use RefreshDatabase;
    
    protected NarrativaGenerator $generator;
    
    protected function setUp(): void
    {
        parent::setUp();
        $this->generator = new NarrativaGenerator();
    }
    
    /** @test */
    public function puede_generar_narrativa_basica()
    {
        // Crear actividad de prueba
        $actividad = Actividad::factory()->create([
            'titulo' => 'Reunión de prueba',
            'descripcion' => 'Se realizó una reunión de coordinación',
            'participantes_count' => 10,
        ]);
        
        $narrativa = $this->generator->generarNarrativaActividad($actividad);
        
        $this->assertNotEmpty($narrativa);
        $this->assertStringContainsString('se llevó a cabo', strtolower($narrativa));
        $this->assertStringContainsString('participaron', strtolower($narrativa));
    }
    
    /** @test */
    public function cachea_narrativas_generadas()
    {
        $actividad = Actividad::factory()->create();
        
        // Primera llamada
        $narrativa1 = $this->generator->generarNarrativaActividad($actividad);
        
        // Segunda llamada (debería usar cache)
        $narrativa2 = $this->generator->generarNarrativaActividad($actividad);
        
        $this->assertEquals($narrativa1, $narrativa2);
    }
}

// Crear: tests/Feature/InformeGenerationTest.php
// Tests para el flujo completo de generación
````

---

### FASE 9: Panel de Administración en Filament

**Tarea 9.1:** Agregar acciones a recurso de Actividades
````php
// Actualizar: app/Filament/Resources/ActividadResource.php

public static function table(Table $table): Table
{
    return $table
        ->columns([
            Tables\Columns\TextColumn::make('fecha')
                ->date('d/m/Y')
                ->sortable(),
            Tables\Columns\TextColumn::make('titulo')
                ->searchable()
                ->limit(50),
            Tables\Columns\IconColumn::make('narrativa_aprobada')
                ->boolean()
                ->label('Aprobada')
                ->alignCenter(),
            Tables\Columns\TextColumn::make('narrativa_generada')
                ->label('Narrativa')
                ->limit(50)
                ->placeholder('Sin generar')
                ->tooltip(fn ($record) => $record->narrativa_generada),
        ])
        ->actions([
            Tables\Actions\Action::make('generar_narrativa')
                ->label('Generar')
                ->icon('heroicon-o-sparkles')
                ->color('success')
                ->visible(fn ($record) => !$record->narrativa_generada)
                ->requiresConfirmation()
                ->action(function ($record) {
                    $generator = app(NarrativaGenerator::class);
                    $narrativa = $generator->generarNarrativaActividad($record);
                    
                    $record->update([
                        'narrativa_generada' => $narrativa,
                        'narrativa_regenerada_at' => now(),
                    ]);
                    
                    Notification::make()
                        ->title('Narrativa generada')
                        ->success()
                        ->send();
                })
                ->modalHeading('Generar narrativa con IA')
                ->modalDescription('Se generará una narrativa en estilo formal institucional.'),
            
            Tables\Actions\Action::make('ver_narrativa')
                ->label('Ver')
                ->icon('heroicon-o-eye')
                ->visible(fn ($record) => $record->narrativa_generada)
                ->modalContent(fn ($record) => view('filament.modals.narrativa-preview', [
                    'actividad' => $record
                ]))
                ->modalSubmitAction(false)
                ->modalCancelActionLabel('Cerrar'),
            
            Tables\Actions\Action::make('regenerar_narrativa')
                ->label('Regenerar')
                ->icon('heroicon-o-arrow-path')
                ->color('warning')
                ->visible(fn ($record) => $record->narrativa_generada)
                ->requiresConfirmation()
                ->modalHeading('¿Regenerar narrativa?')
                ->modalDescription('Se eliminará la narrativa actual y se generará una nueva.')
                ->action(function ($record) {
                    $record->regenerarNarrativa();
                    
                    $generator = app(NarrativaGenerator::class);
                    $narrativa = $generator->generarNarrativaActividad($record);
                    
                    $record->update([
                        'narrativa_generada' => $narrativa,
                        'narrativa_regenerada_at' => now(),
                        'narrativa_aprobada' => false,
                    ]);
                    
                    Notification::make()
                        ->title('Narrativa regenerada')
                        ->success()
                        ->send();
                }),
            
            Tables\Actions\Action::make('aprobar_narrativa')
                ->label('Aprobar')
                ->icon('heroicon-o-check-circle')
                ->color('success')
                ->visible(fn ($record) => $record->narrativa_generada && !$record->narrativa_aprobada)
                ->requiresConfirmation()
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
            Tables\Actions\BulkAction::make('generar_narrativas')
                ->label('Generar narrativas')
                ->icon('heroicon-o-sparkles')
                ->requiresConfirmation()
                ->action(function ($records) {
                    $generator = app(NarrativaGenerator::class);
                    $count = 0;
                    
                    foreach ($records as $record) {
                        if (!$record->narrativa_generada) {
                            $narrativa = $generator->generarNarrativaActividad($record);
                            $record->update([
                                'narrativa_generada' => $narrativa,
                                'narrativa_regenerada_at' => now(),
                            ]);
                            $count++;
                        }
                    }
                    
                    Notification::make()
                        ->title("{$count} narrativas generadas")
                        ->success()
                        ->send();
                }),
        ]);
}
````

**Tarea 9.2:** Crear vista de preview de narrativa
````php
// Crear: resources/views/filament/modals/narrativa-preview.blade.php

<div class="space-y-4">
    <div class="bg-gray-50 dark:bg-gray-800 p-4 rounded-lg">
        <h3 class="font-semibold text-lg mb-2">
            {{ $actividad->fecha->format('d \d\e F \d\e Y') }} — {{ $actividad->titulo }}
        </h3>
        
        @if($actividad->ubicacion)
        <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
            📍 {{ $actividad->ubicacion }}
        </p>
        @endif
        
        <div class="prose dark:prose-invert max-w-none text-justify leading-relaxed">
            {!! nl2br(e($actividad->narrativa_generada)) !!}
        </div>
    </div>
    
    <div class="flex items-center justify-between p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
        <div class="flex items-center space-x-2">
            @if($actividad->narrativa_aprobada)
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
        
        @if($actividad->narrativa_regenerada_at)
        <span class="text-xs text-gray-500">
            Generada: {{ $actividad->narrativa_regenerada_at->diffForHumans() }}
        </span>
        @endif
    </div>
</div>
````

---

### FASE 10: Variables de Entorno y Configuración

**Tarea 10.1:** Actualizar .env y .env.example
````bash
# Agregar al final de .env y .env.example:

# ============================================
# OLLAMA CONFIGURATION
# ============================================
OLLAMA_URL=http://localhost:11434
OLLAMA_MODEL=llama3.1
OLLAMA_TIMEOUT=120
OLLAMA_TEMPERATURE=0.3
OLLAMA_MAX_TOKENS=1500
````

**Tarea 10.2:** Documentar en README.md
````markdown
## Generación de Informes con IA

Este sistema utiliza Ollama para generar narrativas institucionales automáticamente.

### Prerequisitos

1. **Instalar Ollama:**
```bash
   # macOS/Linux
   curl -fsSL https://ollama.com/install.sh | sh
   
   # O descarga desde https://ollama.com/download
```

2. **Descargar modelo de lenguaje:**
```bash
   ollama pull llama3.1
```

3. **Iniciar servicio Ollama:**
```bash
   ollama serve
```

### Configuración

1. Copiar `.env.example` a `.env`
2. Configurar variables de Ollama:
````
   OLLAMA_URL=http://localhost:11434
   OLLAMA_MODEL=llama3.1

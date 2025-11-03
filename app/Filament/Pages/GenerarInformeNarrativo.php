<?php

namespace App\Filament\Pages;

use App\Models\Project;
use App\Models\ActivityCalendar;
use App\Models\ActivityNarrative;
use App\Services\NarrativaGenerator;
use Barryvdh\DomPDF\Facade\Pdf;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Notifications\Notification;
use Filament\Pages\Page;
use Illuminate\Support\Facades\DB;

class GenerarInformeNarrativo extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon = 'heroicon-o-document-chart-bar';

    protected static string $view = 'filament.pages.generar-informe-narrativo';

    protected static ?string $navigationLabel = 'Generar Informe Narrativo';

    protected static ?string $title = 'Generar Informe Narrativo';

    protected static ?string $navigationGroup = 'Informes y Reportes';

    protected static ?int $navigationSort = 2;

    public ?array $data = [];

    public function mount(): void
    {
        $this->form->fill([
            'incluir_introduccion' => true,
            'incluir_logros' => false,
            'incluir_lecciones' => false,
            'usar_cache_narrativas' => true,
            'formato_salida' => 'pdf',
        ]);
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Proyecto a reportar')
                    ->description('Selecciona el proyecto del cual deseas generar el informe narrativo')
                    ->schema([
                        Forms\Components\Select::make('project_id')
                            ->label('Proyecto')
                            ->options(Project::pluck('name', 'id'))
                            ->searchable()
                            ->required()
                            ->reactive()
                            ->afterStateUpdated(fn ($state, callable $set) => $this->updateProjectData($state, $set))
                            ->helperText('Selecciona el proyecto principal'),
                    ]),

                Forms\Components\Section::make('Periodo del Informe')
                    ->description('Define el rango de fechas para los eventos que se incluirán')
                    ->schema([
                        Forms\Components\DatePicker::make('fecha_inicio')
                            ->label('Fecha de inicio')
                            ->required()
                            ->native(false)
                            ->displayFormat('d/m/Y')
                            ->default(now()->startOfMonth())
                            ->maxDate(fn (Forms\Get $get) => $get('fecha_fin')),

                        Forms\Components\DatePicker::make('fecha_fin')
                            ->label('Fecha de fin')
                            ->required()
                            ->native(false)
                            ->displayFormat('d/m/Y')
                            ->default(now())
                            ->minDate(fn (Forms\Get $get) => $get('fecha_inicio')),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Contenido a Incluir')
                    ->description('Filtra qué objetivos y metas incluir en el informe (opcional)')
                    ->schema([
                        Forms\Components\Select::make('objetivos_ids')
                            ->label('Objetivos Específicos')
                            ->multiple()
                            ->options(function (Forms\Get $get) {
                                $projectId = $get('project_id');
                                if (!$projectId) {
                                    return [];
                                }
                                return Project::find($projectId)
                                    ?->specificObjectives()
                                    ->pluck('description', 'id')
                                    ->toArray() ?? [];
                            })
                            ->placeholder('Todos los objetivos')
                            ->helperText('Dejar vacío para incluir todos')
                            ->visible(fn (Forms\Get $get) => (bool) $get('project_id')),

                        Forms\Components\Select::make('metas_ids')
                            ->label('Metas')
                            ->multiple()
                            ->options(function (Forms\Get $get) {
                                $projectId = $get('project_id');
                                if (!$projectId) {
                                    return [];
                                }
                                return Project::find($projectId)
                                    ?->goals()
                                    ->pluck('description', 'id')
                                    ->toArray() ?? [];
                            })
                            ->placeholder('Todas las metas')
                            ->helperText('Dejar vacío para incluir todas')
                            ->visible(fn (Forms\Get $get) => (bool) $get('project_id')),
                    ])
                    ->columns(2)
                    ->collapsed(),

                Forms\Components\Section::make('Opciones de Generación')
                    ->schema([
                        Forms\Components\Toggle::make('incluir_introduccion')
                            ->label('Incluir introducción del proyecto')
                            ->default(true)
                            ->inline(false)
                            ->helperText('Párrafo introductorio con contexto del proyecto'),

                        Forms\Components\Toggle::make('incluir_logros')
                            ->label('Incluir sección de logros significativos')
                            ->default(true)
                            ->inline(false)
                            ->helperText('Resumen de logros clave del periodo (eventos con mayor participación)'),

                        Forms\Components\Toggle::make('incluir_lecciones')
                            ->label('Incluir sección de lecciones aprendidas')
                            ->default(true)
                            ->inline(false)
                            ->helperText('Análisis de participación y colaboración del periodo'),

                        Forms\Components\Toggle::make('usar_cache_narrativas')
                            ->label('Usar narrativas ya generadas (cache)')
                            ->default(true)
                            ->helperText('Desactivar para regenerar todas las narrativas con IA')
                            ->inline(false),

                        Forms\Components\Toggle::make('solo_aprobadas')
                            ->label('Solo incluir narrativas aprobadas')
                            ->default(false)
                            ->helperText('Si está activado, solo se incluirán eventos con narrativa aprobada')
                            ->inline(false),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Formato de Salida')
                    ->schema([
                        Forms\Components\Select::make('formato_salida')
                            ->label('Formato del informe')
                            ->options([
                                'pdf' => 'PDF (Solo lectura)',
                                'docx' => 'DOCX (Editable en Word)',
                                'html' => 'HTML (Vista previa)',
                            ])
                            ->required()
                            ->default('docx')
                            ->native(false)
                            ->helperText('DOCX permite editar el informe en Microsoft Word o LibreOffice'),
                    ]),
            ])
            ->statePath('data');
    }

    protected function updateProjectData($projectId, callable $set): void
    {
        if (!$projectId) {
            return;
        }

        $project = Project::find($projectId);
        if ($project) {
            $set('fecha_inicio', $project->start_date);
            $set('fecha_fin', $project->end_date ?? now());
        }
    }

    public function generar()
    {
        $data = $this->form->getState();

        // Validar que se haya seleccionado un proyecto
        if (!$data['project_id']) {
            Notification::make()
                ->title('Error')
                ->body('Debes seleccionar un proyecto')
                ->danger()
                ->send();
            return;
        }

        try {
            // 1. Obtener datos del proyecto filtrados
            $datos = $this->obtenerDatosProyecto($data);

            // Verificar que hay eventos
            if ($datos['eventos']->isEmpty()) {
                Notification::make()
                    ->title('No hay eventos')
                    ->body('No se encontraron eventos en el periodo seleccionado')
                    ->warning()
                    ->send();
                return;
            }

            // 2. Procesar narrativas (generar las que falten)
            $this->procesarNarrativas($datos, $data['usar_cache_narrativas']);

            // 3. Renderizar informe
            $html = $this->renderizarInforme($datos, $data);

            // 4. Guardar en sesión para descarga
            session([
                'informe_narrativo_html' => $html,
                'informe_narrativo_formato' => $data['formato_salida'],
                'informe_narrativo_proyecto_id' => $datos['proyecto']->id,
                'informe_narrativo_proyecto_nombre' => $datos['proyecto']->name,
            ]);

            \Log::info('GenerarInformeNarrativo: Datos guardados en sesión', [
                'proyecto_id' => $datos['proyecto']->id,
                'formato' => $data['formato_salida'],
                'html_length' => strlen($html)
            ]);

            Notification::make()
                ->title('Informe generado exitosamente')
                ->body('El informe se descargará automáticamente')
                ->success()
                ->send();

            // 5. Disparar evento para descarga
            \Log::info('GenerarInformeNarrativo: Disparando evento descargar-informe');
            $this->dispatch('descargar-informe');

        } catch (\Exception $e) {
            Notification::make()
                ->title('Error al generar informe')
                ->body($e->getMessage())
                ->danger()
                ->persistent()
                ->send();

            \Log::error('Error generando informe', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
        }
    }

    protected function obtenerLogros(array $datos): array
    {
        // Obtener los 5 eventos con mayor impacto (más participantes y con narrativa aprobada)
        $logrosDestacados = $datos['eventos']
            ->filter(function($evento) {
                return $evento->narrativa &&
                       $evento->narrativa->narrativa_generada &&
                       $evento->narrativa->participantes_count > 0;
            })
            ->sortByDesc(function($evento) {
                return $evento->narrativa->participantes_count;
            })
            ->take(5)
            ->values();

        return $logrosDestacados->toArray();
    }

    protected function obtenerLecciones(array $datos): array
    {
        $lecciones = [];

        // 1. Analizar participación promedio
        $eventosConParticipantes = $datos['eventos']->filter(function($evento) {
            return $evento->narrativa && $evento->narrativa->participantes_count > 0;
        });

        if ($eventosConParticipantes->count() > 0) {
            $promedioParticipantes = round($eventosConParticipantes->avg(function($evento) {
                return $evento->narrativa->participantes_count;
            }), 1);

            $lecciones[] = "Se mantuvo una participación promedio de {$promedioParticipantes} personas por actividad, lo que refleja el nivel de convocatoria e interés comunitario.";
        }

        // 2. Analizar diversidad de organizaciones participantes
        $organizaciones = $datos['eventos']
            ->filter(function($evento) {
                return $evento->narrativa && $evento->narrativa->organizaciones_participantes;
            })
            ->pluck('narrativa.organizaciones_participantes')
            ->flatMap(function($orgs) {
                return array_map('trim', explode(',', $orgs));
            })
            ->unique()
            ->count();

        if ($organizaciones > 0) {
            $lecciones[] = "La participación de {$organizaciones} organizaciones diferentes demuestra el trabajo colaborativo y la construcción de redes intersectoriales.";
        }

        // 3. Analizar cobertura territorial
        $ubicaciones = $datos['eventos']
            ->filter(function($evento) {
                return $evento->location || $evento->address_backup;
            })
            ->map(function($evento) {
                return $evento->location ? $evento->location->name : $evento->address_backup;
            })
            ->unique()
            ->count();

        if ($ubicaciones > 0) {
            $lecciones[] = "Las actividades se desarrollaron en {$ubicaciones} ubicaciones diferentes, evidenciando la cobertura territorial del proyecto.";
        }

        // 4. Analizar cumplimiento de narrativas
        $porcentajeNarrativas = $datos['estadisticas']['total_eventos'] > 0
            ? round(($datos['estadisticas']['eventos_con_narrativa'] / $datos['estadisticas']['total_eventos']) * 100, 1)
            : 0;

        if ($porcentajeNarrativas > 80) {
            $lecciones[] = "Se alcanzó un {$porcentajeNarrativas}% de documentación narrativa, lo que fortalece la sistematización y memoria institucional del proyecto.";
        }

        return $lecciones;
    }

    protected function calcularResultadosAnalisis(array $datos, $periodo): array
    {
        $resultados = [];

        // Iterar sobre los objetivos y sus metas en los datos organizados
        foreach ($datos['eventos_por_objetivo'] as $objetivoId => $objetivoData) {
            $objetivo = $objetivoData['objetivo'];

            foreach ($objetivoData['metas'] as $metaId => $metaData) {
                $meta = $metaData['meta'];
                $eventosRealizados = count($metaData['eventos']);

                // Obtener total de actividades planificadas para esta meta
                $actividadesPlanificadas = $meta->activities()->count();

                // Calcular cobertura (eventos realizados en el periodo vs actividades totales de la meta)
                $cobertura = $actividadesPlanificadas > 0
                    ? round(($eventosRealizados / $actividadesPlanificadas) * 100, 1)
                    : 0;

                // Calcular total de participantes para esta meta en el periodo
                $totalParticipantes = collect($metaData['eventos'])->sum(function($evento) {
                    return $evento->narrativa?->participantes_count ?? 0;
                });

                $resultados[] = [
                    'objetivo' => "OE" . array_search($objetivoId, array_keys($datos['eventos_por_objetivo'])) + 1,
                    'meta' => $meta->description,
                    'planificadas' => $actividadesPlanificadas,
                    'realizadas' => $eventosRealizados,
                    'cobertura' => $cobertura,
                    'participantes' => $totalParticipantes,
                ];
            }
        }

        return $resultados;
    }

    protected function obtenerDatosProyecto(array $data): array
    {
        $proyecto = Project::with([
            'financiers',
            'coFinancier',
            'specificObjectives',
            'goals'
        ])->findOrFail($data['project_id']);
        $fechaInicio = $data['fecha_inicio'];
        $fechaFin = $data['fecha_fin'];
        $objetivosIds = $data['objetivos_ids'] ?? [];
        $metasIds = $data['metas_ids'] ?? [];
        $soloAprobadas = $data['solo_aprobadas'] ?? false;

        // Obtener eventos del periodo
        $eventosQuery = ActivityCalendar::with([
            'activity.goal',
            'activity.specificObjective',
            'location',
            'beneficiaryRegistries'
        ])
            ->whereHas('activity.goal', function ($q) use ($proyecto) {
                $q->where('project_id', $proyecto->id);
            })
            ->whereBetween('start_date', [$fechaInicio, $fechaFin])
            ->where('cancelled', false);

        // Filtrar por metas si se especificaron
        if (!empty($metasIds)) {
            $eventosQuery->whereHas('activity.goal', function ($q) use ($metasIds) {
                $q->whereIn('id', $metasIds);
            });
        }

        // Filtrar por objetivos si se especificaron
        if (!empty($objetivosIds)) {
            $eventosQuery->whereHas('activity.specificObjective', function ($q) use ($objetivosIds) {
                $q->whereIn('id', $objetivosIds);
            });
        }

        $eventos = $eventosQuery->orderBy('start_date')->get();

        // Filtrar eventos con narrativas
        $eventosFiltrados = collect();
        foreach ($eventos as $evento) {
            $narrativa = ActivityNarrative::where('activity_calendar_id', $evento->id)->first();

            // Si solo queremos aprobadas, verificar
            if ($soloAprobadas && (!$narrativa || !$narrativa->narrativa_aprobada)) {
                continue;
            }

            // Agregar la narrativa al evento para facilitar acceso
            $evento->narrativa = $narrativa;
            $eventosFiltrados->push($evento);
        }

        // Organizar eventos por objetivo → meta
        $eventosPorObjetivo = [];
        foreach ($eventosFiltrados as $evento) {
            // El objetivo específico se obtiene directamente de la actividad
            $objetivo = $evento->activity->specificObjective;
            $meta = $evento->activity->goal;

            if ($objetivo && $meta) {
                $eventosPorObjetivo[$objetivo->id]['objetivo'] = $objetivo;
                $eventosPorObjetivo[$objetivo->id]['metas'][$meta->id]['meta'] = $meta;
                $eventosPorObjetivo[$objetivo->id]['metas'][$meta->id]['eventos'][] = $evento;
            }
        }

        return [
            'proyecto' => $proyecto,
            'eventos' => $eventosFiltrados,
            'eventos_por_objetivo' => $eventosPorObjetivo,
            'periodo' => [
                'inicio' => $fechaInicio,
                'fin' => $fechaFin,
            ],
            'estadisticas' => [
                'total_eventos' => $eventosFiltrados->count(),
                'total_participantes' => $eventosFiltrados->sum(function ($evento) {
                    return $evento->narrativa?->participantes_count ?? 0;
                }),
                'eventos_con_narrativa' => $eventosFiltrados->filter(function ($evento) {
                    return $evento->narrativa && $evento->narrativa->narrativa_generada;
                })->count(),
            ],
        ];
    }

    protected function procesarNarrativas(array &$datos, bool $usarCache): void
    {
        $generator = app(NarrativaGenerator::class);

        foreach ($datos['eventos'] as $evento) {
            // Si no tiene narrativa, crear una vacía
            if (!$evento->narrativa) {
                $evento->narrativa = ActivityNarrative::create([
                    'activity_calendar_id' => $evento->id,
                ]);
            }

            // Si no tiene narrativa generada o no usamos cache, generar
            if (!$usarCache || !$evento->narrativa->narrativa_generada) {
                try {
                    $generator->generarNarrativaEvento($evento, !$usarCache);
                    // Refrescar la narrativa
                    $evento->narrativa->refresh();
                } catch (\Exception $e) {
                    \Log::error("Error generando narrativa para evento {$evento->id}", [
                        'error' => $e->getMessage()
                    ]);
                }
            }
        }
    }

    protected function renderizarInforme(array $datos, array $config): string
    {
        // Obtener logros si está habilitado
        $logros = [];
        if ($config['incluir_logros'] ?? false) {
            $logros = $this->obtenerLogros($datos);
        }

        // Obtener lecciones aprendidas si está habilitado
        $lecciones = [];
        if ($config['incluir_lecciones'] ?? false) {
            $lecciones = $this->obtenerLecciones($datos);
        }

        // Calcular resultados y análisis (siempre incluido)
        $resultados = $this->calcularResultadosAnalisis($datos, $datos['periodo']);

        // Preparar resultados agrupados por objetivo para la tabla mejorada
        $resultados_agrupados = $this->prepararResultadosAgrupados($datos);

        // Preparar actividades en curso (ejemplo, se puede mejorar con datos reales)
        $resultados_en_curso = $this->prepararActividadesEnCurso($datos);

        // Preparar acciones correctivas (ejemplo)
        $acciones_correctivas = $this->prepararAccionesCorrectivas($datos);

        // Preparar actividades siguientes (ejemplo)
        $actividades_siguientes = $this->prepararActividadesSiguientes($datos);

        return view('reports.informe-narrativo', [
            'proyecto' => $datos['proyecto'],
            'eventos' => $datos['eventos'],
            'eventos_por_objetivo' => $datos['eventos_por_objetivo'],
            'periodo' => $datos['periodo'],
            'estadisticas' => $datos['estadisticas'],
            'config' => $config,
            'logros' => $logros,
            'lecciones' => $lecciones,
            'resultados' => $resultados,
            'resultados_agrupados' => $resultados_agrupados,
            'resultados_en_curso' => $resultados_en_curso,
            'acciones_correctivas' => $acciones_correctivas,
            'actividades_siguientes' => $actividades_siguientes,
        ])->render();
    }

    protected function prepararResultadosAgrupados(array $datos): array
    {
        $agrupados = [];
        $contador_meta = 1;

        foreach ($datos['eventos_por_objetivo'] as $objetivoId => $objetivoData) {
            $objetivo = $objetivoData['objetivo'];
            $objetivo_nombre = "OE" . (array_search($objetivoId, array_keys($datos['eventos_por_objetivo'])) + 1) . ". " . $objetivo->description;

            $metas = [];

            foreach ($objetivoData['metas'] as $metaId => $metaData) {
                $meta = $metaData['meta'];
                $eventosRealizados = count($metaData['eventos']);
                $actividadesPlanificadas = $meta->activities()->count();
                $porcentaje = $actividadesPlanificadas > 0
                    ? round(($eventosRealizados / $actividadesPlanificadas) * 100, 1)
                    : 0;

                $totalParticipantes = collect($metaData['eventos'])->sum(function($evento) {
                    return $evento->narrativa?->participantes_count ?? 0;
                });

                // Generar análisis automático
                $analisis = "Se realizaron {$eventosRealizados} actividades de esta meta durante el periodo reportado";
                if ($totalParticipantes > 0) {
                    $analisis .= " con la participación de {$totalParticipantes} personas";
                }
                $analisis .= ", alcanzando un " . number_format($porcentaje, 1) . "% de cumplimiento respecto a lo planificado.";

                if ($porcentaje < 80 && $eventosRealizados > 0) {
                    $analisis .= " Se implementará un plan de trabajo con seguimiento mensual para alcanzar las metas restantes.";
                }

                $metas[] = [
                    'numero' => $contador_meta++,
                    'descripcion' => $meta->description,
                    'meta_periodo' => $actividadesPlanificadas,
                    'cobertura' => $eventosRealizados,
                    'porcentaje' => $porcentaje,
                    'analisis' => $analisis,
                ];
            }

            if (!empty($metas)) {
                $agrupados[$objetivo_nombre] = $metas;
            }
        }

        return $agrupados;
    }

    protected function prepararActividadesEnCurso(array $datos): array
    {
        // Por ahora retorna array vacío - se puede implementar con datos reales
        // si se tiene un campo de estado "en curso" en las actividades
        return [];
    }

    protected function prepararAccionesCorrectivas(array $datos): array
    {
        // Por ahora retorna array vacío - se puede implementar con datos reales
        // si se registran acciones correctivas en el sistema
        return [];
    }

    protected function prepararActividadesSiguientes(array $datos): array
    {
        // Por ahora retorna array vacío - se puede implementar con datos reales
        // obteniendo actividades programadas para el siguiente periodo
        return [];
    }

    protected function exportar(string $html, string $formato, $proyecto)
    {
        $filename = "informe_narrativo_{$proyecto->id}_" . now()->format('Y-m-d_His');

        return match ($formato) {
            'pdf' => $this->exportarPDF($html, $filename),
            'html' => response($html, 200, [
                'Content-Type' => 'text/html; charset=utf-8',
                'Content-Disposition' => "inline; filename=\"{$filename}.html\"",
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

    public function getEstadisticas(): array
    {
        $projectId = $this->data['project_id'] ?? null;

        if (!$projectId) {
            return [
                'objetivos' => 0,
                'metas' => 0,
                'eventos' => 0,
                'narrativas_generadas' => 0,
                'narrativas_aprobadas' => 0,
            ];
        }

        $proyecto = Project::find($projectId);

        if (!$proyecto) {
            return [
                'objetivos' => 0,
                'metas' => 0,
                'eventos' => 0,
                'narrativas_generadas' => 0,
                'narrativas_aprobadas' => 0,
            ];
        }

        $eventosCount = ActivityCalendar::whereHas('activity.goal', function ($q) use ($proyecto) {
            $q->where('project_id', $proyecto->id);
        })->count();

        $narrativasGeneradas = ActivityNarrative::whereHas('activityCalendar.activity.goal', function ($q) use ($proyecto) {
            $q->where('project_id', $proyecto->id);
        })->whereNotNull('narrativa_generada')->count();

        $narrativasAprobadas = ActivityNarrative::whereHas('activityCalendar.activity.goal', function ($q) use ($proyecto) {
            $q->where('project_id', $proyecto->id);
        })->where('narrativa_aprobada', true)->count();

        return [
            'objetivos' => $proyecto->specificObjectives->count(),
            'metas' => $proyecto->goals->count(),
            'eventos' => $eventosCount,
            'narrativas_generadas' => $narrativasGeneradas,
            'narrativas_aprobadas' => $narrativasAprobadas,
        ];
    }
}

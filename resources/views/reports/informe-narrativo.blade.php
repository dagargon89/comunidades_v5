<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informe Narrativo - {{ $proyecto->name }}</title>
    <style>
        /* Reset y base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'DejaVu Sans', Arial, sans-serif;
            font-size: 11pt;
            line-height: 1.6;
            color: #333;
            padding: 0;
            margin: 0;
        }

        /* Encabezado principal */
        .header {
            background-color: #f8f9fa;
            padding: 20px;
            border-bottom: 3px solid #0066cc;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #0066cc;
            font-size: 20pt;
            margin-bottom: 10px;
            text-align: center;
        }

        .header .project-name {
            font-size: 16pt;
            color: #333;
            text-align: center;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .header .periodo {
            text-align: center;
            color: #666;
            font-size: 10pt;
            margin-top: 8px;
        }

        /* Información del proyecto */
        .project-info {
            background-color: #f0f4f8;
            padding: 15px;
            margin-bottom: 25px;
            border-left: 4px solid #0066cc;
        }

        .project-info h3 {
            color: #0066cc;
            font-size: 12pt;
            margin-bottom: 10px;
        }

        .project-info p {
            margin: 5px 0;
            font-size: 10pt;
            line-height: 1.5;
        }

        .project-info strong {
            color: #333;
        }

        /* Estadísticas */
        .estadisticas {
            display: table;
            width: 100%;
            margin-bottom: 25px;
            border-collapse: collapse;
        }

        .estadisticas .stat-item {
            display: table-cell;
            text-align: center;
            padding: 12px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
        }

        .estadisticas .stat-value {
            font-size: 18pt;
            font-weight: bold;
            color: #0066cc;
            display: block;
        }

        .estadisticas .stat-label {
            font-size: 9pt;
            color: #666;
            display: block;
            margin-top: 5px;
        }

        /* Introducción */
        .introduccion {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-left: 4px solid #28a745;
        }

        .introduccion h2 {
            color: #28a745;
            font-size: 14pt;
            margin-bottom: 15px;
        }

        .introduccion p {
            text-align: justify;
            line-height: 1.8;
            margin-bottom: 12px;
        }

        /* Objetivo específico */
        .objetivo {
            margin-bottom: 35px;
            page-break-inside: avoid;
        }

        .objetivo-header {
            background-color: #0066cc;
            color: white;
            padding: 12px 15px;
            margin-bottom: 20px;
            font-size: 13pt;
            font-weight: 600;
        }

        /* Meta */
        .meta {
            margin-bottom: 25px;
            margin-left: 15px;
        }

        .meta-header {
            background-color: #e7f3ff;
            color: #0066cc;
            padding: 10px 12px;
            margin-bottom: 15px;
            font-size: 11pt;
            font-weight: 600;
            border-left: 4px solid #0066cc;
        }

        /* Evento */
        .evento {
            margin-bottom: 20px;
            margin-left: 30px;
            page-break-inside: avoid;
        }

        .evento-header {
            color: #333;
            font-size: 11pt;
            font-weight: 600;
            margin-bottom: 8px;
            padding-bottom: 5px;
            border-bottom: 2px solid #dee2e6;
        }

        .evento-fecha {
            color: #0066cc;
            font-weight: bold;
        }

        .evento-ubicacion {
            color: #666;
            font-size: 9pt;
            margin-top: 3px;
            font-style: italic;
        }

        .evento-narrativa {
            text-align: justify;
            line-height: 1.8;
            margin-top: 12px;
            margin-bottom: 15px;
            padding: 15px;
            background-color: #fafafa;
            border-left: 3px solid #dee2e6;
        }

        .evento-narrativa p {
            margin-bottom: 12px;
        }

        .evento-info {
            font-size: 9pt;
            color: #666;
            margin-top: 10px;
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 3px;
        }

        .evento-info strong {
            color: #333;
        }

        /* Sin narrativa */
        .sin-narrativa {
            color: #dc3545;
            font-style: italic;
            padding: 10px;
            background-color: #fff3cd;
            border-left: 3px solid #ffc107;
        }

        /* Sección vacía */
        .seccion-vacia {
            color: #6c757d;
            font-style: italic;
            text-align: center;
            padding: 20px;
            background-color: #f8f9fa;
        }

        /* Saltos de página */
        .page-break {
            page-break-after: always;
        }

        /* Footer */
        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            height: 30px;
            text-align: center;
            font-size: 8pt;
            color: #666;
            border-top: 1px solid #dee2e6;
            padding-top: 8px;
            background-color: white;
        }

        /* Contadores */
        .counter {
            counter-reset: objetivo;
        }

        .objetivo-header::before {
            counter-increment: objetivo;
            content: "Objetivo " counter(objetivo) ": ";
        }

        /* Tablas */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
        }

        th {
            background-color: #0066cc;
            color: white;
            font-weight: 600;
        }

        /* Utilidades */
        .text-center {
            text-align: center;
        }

        .text-justify {
            text-align: justify;
        }

        .mb-2 {
            margin-bottom: 10px;
        }

        .mb-3 {
            margin-bottom: 15px;
        }

        .mt-3 {
            margin-top: 15px;
        }

        /* Estilos específicos para DomPDF */
        @page {
            margin: 20mm 15mm;
        }
    </style>
</head>
<body>
    {{-- Encabezado del informe --}}
    <div class="header">
        <h1>Informe Narrativo de Actividades</h1>
        <div class="project-name">{{ $proyecto->name }}</div>
        <div class="periodo">
            Periodo: {{ \Carbon\Carbon::parse($periodo['inicio'])->format('d/m/Y') }}
            al
            {{ \Carbon\Carbon::parse($periodo['fin'])->format('d/m/Y') }}
        </div>
    </div>

    {{-- ÍNDICE --}}
    <div style="margin-bottom: 40px; page-break-after: always;">
        <h2 style="color: #0066cc; font-size: 16pt; margin-bottom: 20px; text-align: center; text-transform: uppercase;">
            REPORTE NARRATIVO DEL PROYECTO CON ID. {{ $proyecto->id }}
        </h2>
        <div style="margin-top: 30px; font-size: 10pt; line-height: 2.2;">
            <div style="margin-bottom: 8px;">
                <strong>Ficha técnica del proyecto</strong>
                <span style="float: right;">2</span>
            </div>
            <div style="margin-bottom: 8px;">
                <strong>Informe narrativo de actividades por objetivos específicos en el periodo
                {{ \Carbon\Carbon::parse($periodo['inicio'])->translatedFormat('F') }} -
                {{ \Carbon\Carbon::parse($periodo['fin'])->translatedFormat('F Y') }}</strong>
                <span style="float: right;">{{ 3 + count($proyecto->specificObjectives ?? []) }}</span>
            </div>
            @foreach($proyecto->specificObjectives ?? [] as $objetivo)
            <div style="margin-left: 20px; margin-bottom: 6px; font-size: 9pt;">
                Objetivo Específico {{ $loop->iteration }} - {{ \Illuminate\Support\Str::limit($objetivo->description, 60) }}
            </div>
            @endforeach
            @if(count($resultados_en_curso ?? []) > 0)
            <div style="margin-bottom: 8px; margin-top: 12px;">
                <strong>Informe narrativo de actividades en curso por objetivos específicos</strong>
            </div>
            @endif
            <div style="margin-bottom: 8px; margin-top: 12px;">
                <strong>Resultado y análisis de las metas proyectadas para el periodo</strong>
            </div>
            @if($config['incluir_momentos_clave'] ?? false)
            <div style="margin-bottom: 8px;">
                <strong>Fotografías de momentos clave</strong>
            </div>
            @endif
            @if(($config['incluir_logros'] ?? false) && count($logros ?? []) > 0)
            <div style="margin-bottom: 8px;">
                <strong>Logros significativos / acontecimientos o eventos clave</strong>
            </div>
            @endif
            @if(($config['incluir_lecciones'] ?? false) && count($lecciones ?? []) > 0)
            <div style="margin-bottom: 8px;">
                <strong>Lecciones aprendidas</strong>
            </div>
            @endif
            @if(count($acciones_correctivas ?? []) > 0)
            <div style="margin-bottom: 8px;">
                <strong>Acciones correctivas realizadas por Objetivo específico</strong>
            </div>
            @endif
            @if(count($actividades_siguientes ?? []) > 0)
            <div style="margin-bottom: 8px;">
                <strong>Actividades programadas para el siguiente periodo
                {{ \Carbon\Carbon::parse($periodo['fin'])->addDay()->translatedFormat('F') }} -
                {{ \Carbon\Carbon::parse($periodo['fin'])->addMonths(3)->translatedFormat('F Y') }}</strong>
            </div>
            @endif
        </div>
    </div>

    {{-- Ficha Técnica del Proyecto --}}
    <div style="margin-bottom: 30px; page-break-inside: avoid;">
        <h2 style="color: #0066cc; font-size: 14pt; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 3px solid #0066cc;">
            Ficha Técnica del Proyecto
        </h2>
        <table style="width: 100%; border-collapse: collapse; font-size: 10pt; background-color: #f8f9fa;">
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; width: 30%; font-weight: 600; background-color: #e7f3ff;">
                    Periodo de cobertura:
                </td>
                <td style="padding: 10px;">
                    {{ \Carbon\Carbon::parse($periodo['inicio'])->format('d/m/Y') }}
                    al
                    {{ \Carbon\Carbon::parse($periodo['fin'])->format('d/m/Y') }}
                </td>
            </tr>
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff;">
                    ID del Proyecto:
                </td>
                <td style="padding: 10px;">
                    {{ $proyecto->id }}
                </td>
            </tr>
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff;">
                    Nombre del Proyecto:
                </td>
                <td style="padding: 10px; font-weight: 600;">
                    {{ $proyecto->name }}
                </td>
            </tr>
            @if($proyecto->general_objective)
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff; vertical-align: top;">
                    Objetivo General:
                </td>
                <td style="padding: 10px; text-align: justify; line-height: 1.6;">
                    {{ $proyecto->general_objective }}
                </td>
            </tr>
            @endif
            @if($proyecto->specificObjectives->count() > 0)
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff; vertical-align: top;">
                    Objetivos Específicos:
                </td>
                <td style="padding: 10px;">
                    <table style="width: 100%; font-size: 9pt;">
                        @foreach($proyecto->specificObjectives as $objetivo)
                        <tr>
                            <td style="padding: 6px 0; vertical-align: top; text-align: justify; line-height: 1.5;">
                                <strong style="color: #0066cc;">OE{{ $loop->iteration }}:</strong>
                                {{ $objetivo->description }}
                            </td>
                        </tr>
                        @endforeach
                    </table>
                </td>
            </tr>
            @endif
            @if($proyecto->goals->count() > 0)
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff; vertical-align: top;">
                    Metas Programadas:
                </td>
                <td style="padding: 10px;">
                    <ol style="margin: 0 0 0 20px; padding: 0; font-size: 9pt; line-height: 1.5;">
                        @foreach($proyecto->goals as $meta)
                        <li style="margin-bottom: 6px; text-align: justify;">
                            {{ $meta->description }}
                        </li>
                        @endforeach
                    </ol>
                </td>
            </tr>
            @endif
            @if($proyecto->total_cost)
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff;">
                    Presupuesto del Proyecto:
                </td>
                <td style="padding: 10px; font-weight: 600; color: #0066cc;">
                    ${{ number_format($proyecto->total_cost, 2) }} MXN
                </td>
            </tr>
            @endif
            @if($proyecto->financiers)
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff;">
                    Financiador Principal:
                </td>
                <td style="padding: 10px;">
                    {{ $proyecto->financiers->name }}
                </td>
            </tr>
            @endif
            @if($proyecto->coFinancier)
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff;">
                    Cofinanciador:
                </td>
                <td style="padding: 10px;">
                    {{ $proyecto->coFinancier->name }}
                </td>
            </tr>
            @endif
            @if($proyecto->start_date)
            <tr style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 10px; font-weight: 600; background-color: #e7f3ff;">
                    Periodo de Ejecución del Proyecto:
                </td>
                <td style="padding: 10px;">
                    {{ $proyecto->start_date->format('d/m/Y') }}
                    @if($proyecto->end_date)
                        al {{ $proyecto->end_date->format('d/m/Y') }}
                    @endif
                </td>
            </tr>
            @endif
        </table>
    </div>

    {{-- Estadísticas del periodo --}}
    <div class="estadisticas">
        <div class="stat-item">
            <span class="stat-value">{{ $estadisticas['total_eventos'] }}</span>
            <span class="stat-label">Eventos realizados</span>
        </div>
        <div class="stat-item">
            <span class="stat-value">{{ $estadisticas['total_participantes'] }}</span>
            <span class="stat-label">Participantes totales</span>
        </div>
        <div class="stat-item">
            <span class="stat-value">{{ $estadisticas['eventos_con_narrativa'] }}</span>
            <span class="stat-label">Narrativas generadas</span>
        </div>
    </div>

    {{-- Introducción (opcional) --}}
    @if($config['incluir_introduccion'] ?? false)
    <div class="introduccion">
        <h2>Introducción</h2>
        <p>
            El presente informe narrativo documenta las actividades realizadas en el marco del proyecto
            <strong>{{ $proyecto->name }}</strong> durante el periodo comprendido entre el
            {{ \Carbon\Carbon::parse($periodo['inicio'])->format('d \d\e F \d\e Y') }} y el
            {{ \Carbon\Carbon::parse($periodo['fin'])->format('d \d\e F \d\e Y') }}.
        </p>
        <p>
            Durante este periodo se llevaron a cabo <strong>{{ $estadisticas['total_eventos'] }} actividades</strong>
            con la participación de <strong>{{ $estadisticas['total_participantes'] }} personas</strong>,
            en el marco de los objetivos específicos y metas establecidas en el proyecto.
        </p>
        <p>
            Las narrativas presentadas a continuación han sido generadas siguiendo un estilo institucional formal,
            documentando el contexto, desarrollo y resultados de cada actividad realizada.
        </p>
    </div>
    @endif

    {{-- Actividades en Curso --}}
    @if(count($resultados_en_curso ?? []) > 0)
    <div style="margin-bottom: 40px; page-break-inside: avoid;">
        <h2 style="color: #0066cc; font-size: 14pt; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #0066cc;">
            Informe Narrativo de Actividades en Curso por Objetivos Específicos
        </h2>
        <p style="font-size: 10pt; margin-bottom: 20px; text-align: justify; line-height: 1.8;">
            Las siguientes actividades se encuentran actualmente en proceso de ejecución y se espera su conclusión
            en los próximos periodos de reporte:
        </p>

        @foreach($resultados_en_curso as $objetivo => $metas)
            <div style="background-color: #5a6268; color: white; padding: 10px 15px; margin-bottom: 15px; margin-top: 25px; font-size: 12pt; font-weight: 600;">
                {{ $objetivo }}
            </div>

            <table style="width: 100%; border-collapse: collapse; margin-bottom: 25px; font-size: 9pt;">
                <thead>
                    <tr style="background-color: #e7f3ff;">
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 35%; font-weight: 600; color: #0066cc;">
                            Descripción de la Meta
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 25%; font-weight: 600; color: #0066cc;">
                            Indicadores
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 40%; font-weight: 600; color: #0066cc;">
                            Avances y Análisis
                        </th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($metas as $meta)
                    <tr style="border-bottom: 1px solid #dee2e6;">
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: justify; line-height: 1.6;">
                            {{ $meta['descripcion'] }}
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top;">
                            <div style="margin-bottom: 6px;">
                                • <strong>Meta del periodo:</strong> {{ $meta['meta_periodo'] }}
                            </div>
                            <div style="margin-bottom: 6px;">
                                • <strong>Cobertura:</strong> {{ $meta['cobertura'] }}
                            </div>
                            <div style="font-weight: 600;
                                @if($meta['porcentaje'] >= 80)
                                    color: #28a745;
                                @elseif($meta['porcentaje'] >= 50)
                                    color: #ffc107;
                                @else
                                    color: #dc3545;
                                @endif
                            ">
                                • <strong>% de cobertura:</strong> {{ number_format($meta['porcentaje'], 1) }}%
                            </div>
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: justify; line-height: 1.6;">
                            {{ $meta['analisis'] }}
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        @endforeach
    </div>
    @endif

    {{-- Logros Significativos del Periodo --}}
    @if(($config['incluir_logros'] ?? false) && count($logros) > 0)
    <div class="introduccion" style="border-left-color: #ffc107; page-break-inside: avoid;">
        <h2 style="color: #ffc107;">Logros Significativos del Periodo</h2>
        <p style="margin-bottom: 15px;">
            Durante el periodo reportado se destacaron las siguientes actividades por su alto impacto
            y participación comunitaria:
        </p>
        <ul style="margin-left: 20px; line-height: 2;">
            @foreach($logros as $evento)
            <li style="margin-bottom: 12px;">
                <strong>{{ \Carbon\Carbon::parse($evento['start_date'])->format('d/m/Y') }}</strong> —
                <strong>{{ $evento['activity']['name'] }}</strong>
                @if($evento['location'])
                    en {{ $evento['location']['name'] }}
                @elseif($evento['address_backup'])
                    en {{ $evento['address_backup'] }}
                @endif
                @if($evento['narrativa']['participantes_count'])
                    con la participación de <strong>{{ $evento['narrativa']['participantes_count'] }} personas</strong>
                @endif
                @if($evento['narrativa']['organizaciones_participantes'])
                    de {{ $evento['narrativa']['organizaciones_participantes'] }}
                @endif
            </li>
            @endforeach
        </ul>
    </div>
    @endif

    {{-- Lecciones Aprendidas --}}
    @if(($config['incluir_lecciones'] ?? false) && count($lecciones) > 0)
    <div class="introduccion" style="border-left-color: #17a2b8; page-break-inside: avoid;">
        <h2 style="color: #17a2b8;">Lecciones Aprendidas y Análisis del Periodo</h2>
        <p style="margin-bottom: 15px;">
            El análisis de las actividades realizadas durante el periodo permite identificar los siguientes aprendizajes:
        </p>
        <ul style="margin-left: 20px; line-height: 2;">
            @foreach($lecciones as $leccion)
            <li style="margin-bottom: 12px; text-align: justify;">
                {{ $leccion }}
            </li>
            @endforeach
        </ul>
    </div>
    @endif

    {{-- Resultados y Análisis de las Metas Proyectadas --}}
    @if(count($resultados ?? []) > 0)
    <div style="margin-bottom: 40px; page-break-inside: avoid;">
        <h2 style="color: #0066cc; font-size: 14pt; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #0066cc;">
            Resultado y Análisis de las Metas Proyectadas para el Periodo
        </h2>

        @foreach($resultados_agrupados ?? [] as $objetivo => $metas)
            <div style="background-color: #5a6268; color: white; padding: 10px 15px; margin-bottom: 15px; margin-top: 25px; font-size: 12pt; font-weight: 600;">
                {{ $objetivo }}
            </div>

            <table style="width: 100%; border-collapse: collapse; margin-bottom: 25px; font-size: 9pt;">
                <thead>
                    <tr style="background-color: #e7f3ff;">
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 35%; font-weight: 600; color: #0066cc;">
                            Descripción de la Meta
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 25%; font-weight: 600; color: #0066cc;">
                            Indicadores
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 40%; font-weight: 600; color: #0066cc;">
                            Análisis de Resultados
                        </th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($metas as $meta)
                    <tr style="border-bottom: 1px solid #dee2e6;">
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: justify; line-height: 1.6;">
                            <strong>{{ $meta['numero'] }}.</strong> {{ $meta['descripcion'] }}
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top;">
                            <div style="margin-bottom: 6px;">
                                • <strong>Meta del periodo:</strong> {{ $meta['meta_periodo'] }}
                            </div>
                            <div style="margin-bottom: 6px;">
                                • <strong>Cobertura:</strong> {{ $meta['cobertura'] }}
                            </div>
                            <div style="font-weight: 600;
                                @if($meta['porcentaje'] >= 100)
                                    color: #28a745;
                                @elseif($meta['porcentaje'] >= 80)
                                    color: #28a745;
                                @elseif($meta['porcentaje'] >= 50)
                                    color: #ffc107;
                                @else
                                    color: #dc3545;
                                @endif
                            ">
                                • <strong>% de cobertura:</strong> {{ number_format($meta['porcentaje'], 1) }}%
                            </div>
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: justify; line-height: 1.6;">
                            <div style="margin-bottom: 8px;">
                                @if($meta['porcentaje'] >= 100)
                                    <strong style="color: #28a745;">Meta superada ({{ $meta['cobertura'] }}/{{ $meta['meta_periodo'] }}).</strong>
                                @elseif($meta['porcentaje'] >= 80)
                                    <strong style="color: #28a745;">Meta cumplida ({{ $meta['cobertura'] }}/{{ $meta['meta_periodo'] }}).</strong>
                                @elseif($meta['porcentaje'] >= 50)
                                    <strong style="color: #ffc107;">Meta parcialmente cumplida ({{ $meta['cobertura'] }}/{{ $meta['meta_periodo'] }}).</strong>
                                @else
                                    <strong style="color: #dc3545;">Meta de actividades no cumplida ({{ $meta['cobertura'] }}/{{ $meta['meta_periodo'] }}).</strong>
                                @endif
                            </div>
                            {{ $meta['analisis'] ?? 'Se realizaron ' . $meta['cobertura'] . ' actividades de esta meta durante el periodo reportado, alcanzando un ' . number_format($meta['porcentaje'], 1) . '% de cumplimiento respecto a lo planificado.' }}
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        @endforeach

        <p style="font-size: 9pt; color: #666; font-style: italic; margin-top: 15px; padding: 10px; background-color: #f8f9fa; border-left: 3px solid #0066cc;">
            <strong>Nota:</strong> La cobertura se calcula comparando las actividades realizadas en el periodo con el total de actividades planificadas para cada meta según la programación del proyecto.
        </p>
    </div>
    @endif

    {{-- Contenido organizado por Objetivo → Meta → Eventos --}}
    <div class="counter">
        @forelse($eventos_por_objetivo as $objetivoId => $objetivoData)
            <div class="objetivo">
                {{-- Encabezado del objetivo --}}
                <div class="objetivo-header">
                    {{ $objetivoData['objetivo']->description }}
                </div>

                {{-- Metas del objetivo --}}
                @foreach($objetivoData['metas'] as $metaId => $metaData)
                    <div class="meta">
                        {{-- Encabezado de la meta --}}
                        <div class="meta-header">
                            Meta: {{ $metaData['meta']->description }}
                        </div>

                        {{-- Eventos de la meta --}}
                        @forelse($metaData['eventos'] as $evento)
                            <div class="evento">
                                {{-- Formato: Fecha — Título (Ubicación): --}}
                                <p style="margin-bottom: 12px; line-height: 1.6;">
                                    <strong style="color: #0066cc;">
                                        {{ $evento->start_date->format('d \d\e F \d\e Y') }}
                                    </strong>
                                    —
                                    <strong>{{ $evento->activity->name }}</strong>
                                    @if($evento->location)
                                        ({{ $evento->location->name }})
                                    @elseif($evento->address_backup)
                                        ({{ $evento->address_backup }})
                                    @endif
                                    :

                                {{-- Narrativa del evento --}}
                                @if($evento->narrativa && $evento->narrativa->narrativa_generada)
                                    @php
                                        // Dividir la narrativa en párrafos si contiene saltos de línea
                                        $parrafos = explode("\n\n", $evento->narrativa->narrativa_generada);
                                        if (count($parrafos) === 1) {
                                            // Si no hay dobles saltos, dividir por saltos simples
                                            $parrafos = explode("\n", $evento->narrativa->narrativa_generada);
                                        }
                                    @endphp

                                    @foreach($parrafos as $parrafo)
                                        @if(trim($parrafo))
                                        <span style="display: block; text-align: justify; margin-bottom: 12px; line-height: 1.8;">
                                            {{ trim($parrafo) }}
                                        </span>
                                        @endif
                                    @endforeach
                                </p>

                                @else
                                    <span style="display: block; color: #dc3545; font-style: italic; margin: 10px 0;">
                                        No se ha generado narrativa para este evento.
                                    </span>
                                </p>
                                @endif
                            </div>
                        @empty
                            <div class="seccion-vacia">
                                No hay eventos registrados para esta meta en el periodo seleccionado
                            </div>
                        @endforelse
                    </div>
                @endforeach
            </div>
        @empty
            <div class="seccion-vacia">
                <p><strong>No se encontraron eventos en el periodo seleccionado</strong></p>
                <p>Verifica los filtros aplicados o el rango de fechas.</p>
            </div>
        @endforelse
    </div>

    {{-- Fotografías de momentos clave --}}
    @if($config['incluir_momentos_clave'] ?? false)
    <div style="margin-top: 40px; margin-bottom: 30px; page-break-inside: avoid;">
        <h2 style="color: #0066cc; font-size: 14pt; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 3px solid #0066cc;">
            Fotografías de Momentos Clave
        </h2>
        <p style="text-align: justify; line-height: 1.8; margin-bottom: 15px; font-size: 10pt;">
            A continuación se presentan algunos de los momentos más representativos del periodo reportado,
            que evidencian el impacto y la participación comunitaria en las actividades realizadas.
        </p>
        <p style="font-size: 9pt; color: #666; font-style: italic; text-align: center; padding: 20px;">
            [Las fotografías documentales se incorporan de manera independiente según los registros fotográficos del proyecto]
        </p>
    </div>
    @endif

    {{-- Acciones Correctivas por Objetivo Específico --}}
    @if(count($acciones_correctivas ?? []) > 0)
    <div style="margin-bottom: 40px; page-break-inside: avoid;">
        <h2 style="color: #0066cc; font-size: 14pt; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #0066cc;">
            Acciones Correctivas Realizadas por Objetivo Específico
        </h2>
        <p style="font-size: 10pt; margin-bottom: 20px; text-align: justify; line-height: 1.8;">
            Durante el periodo se identificaron situaciones que requirieron acciones correctivas para asegurar
            el cumplimiento de los objetivos y metas del proyecto. A continuación se detallan las medidas tomadas:
        </p>

        @foreach($acciones_correctivas as $objetivo => $acciones)
            <div style="background-color: #5a6268; color: white; padding: 10px 15px; margin-bottom: 15px; margin-top: 25px; font-size: 12pt; font-weight: 600;">
                {{ $objetivo }}
            </div>

            <table style="width: 100%; border-collapse: collapse; margin-bottom: 25px; font-size: 9pt;">
                <thead>
                    <tr style="background-color: #e7f3ff;">
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 40%; font-weight: 600; color: #0066cc;">
                            Situación Identificada
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 60%; font-weight: 600; color: #0066cc;">
                            Acción Correctiva Implementada
                        </th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($acciones as $accion)
                    <tr style="border-bottom: 1px solid #dee2e6;">
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: justify; line-height: 1.6;">
                            {{ $accion['situacion'] }}
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: justify; line-height: 1.6;">
                            {{ $accion['accion'] }}
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        @endforeach
    </div>
    @endif

    {{-- Actividades Programadas para el Siguiente Periodo --}}
    @if(count($actividades_siguientes ?? []) > 0)
    <div style="margin-bottom: 40px; page-break-inside: avoid;">
        <h2 style="color: #0066cc; font-size: 14pt; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #0066cc;">
            Actividades Programadas para el Siguiente Periodo
            {{ \Carbon\Carbon::parse($periodo['fin'])->addDay()->translatedFormat('F') }} -
            {{ \Carbon\Carbon::parse($periodo['fin'])->addMonths(3)->translatedFormat('F Y') }}
        </h2>
        <p style="font-size: 10pt; margin-bottom: 20px; text-align: justify; line-height: 1.8;">
            Con base en la planificación del proyecto y los resultados del periodo actual, se han programado
            las siguientes actividades para el próximo periodo de reporte:
        </p>

        @foreach($actividades_siguientes as $objetivo => $actividades)
            <div style="background-color: #5a6268; color: white; padding: 10px 15px; margin-bottom: 15px; margin-top: 25px; font-size: 12pt; font-weight: 600;">
                {{ $objetivo }}
            </div>

            <table style="width: 100%; border-collapse: collapse; margin-bottom: 25px; font-size: 9pt;">
                <thead>
                    <tr style="background-color: #e7f3ff;">
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 8%; font-weight: 600; color: #0066cc;">
                            #
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 52%; font-weight: 600; color: #0066cc;">
                            Actividad Programada
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 20%; font-weight: 600; color: #0066cc;">
                            Fecha Estimada
                        </th>
                        <th style="padding: 10px; border: 1px solid #dee2e6; text-align: left; width: 20%; font-weight: 600; color: #0066cc;">
                            Meta Asociada
                        </th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($actividades as $actividad)
                    <tr style="border-bottom: 1px solid #dee2e6;">
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: center; font-weight: 600;">
                            {{ $loop->iteration }}
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: justify; line-height: 1.6;">
                            {{ $actividad['nombre'] }}
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: center;">
                            {{ $actividad['fecha'] ?? 'Por definir' }}
                        </td>
                        <td style="padding: 12px; border: 1px solid #dee2e6; vertical-align: top; text-align: center;">
                            {{ $actividad['meta'] ?? '-' }}
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        @endforeach
    </div>
    @endif

    {{-- Espacio para firma --}}
    <div style="margin-top: 60px; margin-bottom: 40px; page-break-inside: avoid;">
        <div style="border-top: 2px solid #dee2e6; padding-top: 40px;">
            <p style="text-align: center; margin-bottom: 80px;">
                <strong style="font-size: 11pt;">
                    Firma del Representante Legal o Responsable del Proyecto
                </strong>
            </p>
            <div style="width: 60%; margin: 0 auto; text-align: center;">
                <div style="border-top: 2px solid #333; padding-top: 10px; margin-bottom: 5px;">

                </div>
                <p style="margin: 0; font-size: 10pt; font-weight: 600;">
                    @if($proyecto->followup_officer)
                        {{ $proyecto->followup_officer }}
                    @else
                        [Nombre del Representante Legal]
                    @endif
                </p>
                <p style="margin: 5px 0 0 0; font-size: 9pt; color: #666;">
                    Responsable del Proyecto
                </p>
            </div>
        </div>
    </div>

    {{-- Pie de página --}}
    <div class="footer">
        Informe generado el {{ now()->format('d/m/Y H:i') }} |
        {{ $proyecto->name }} |
        Página <span class="pagenum"></span>
    </div>

    {{-- Script para numeración de páginas (DomPDF) --}}
    <script type="text/php">
        if (isset($pdf)) {
            $text = "Página {PAGE_NUM} de {PAGE_COUNT}";
            $size = 8;
            $font = $fontMetrics->getFont("DejaVu Sans");
            $width = $fontMetrics->get_text_width($text, $font, $size) / 2;
            $x = ($pdf->get_width() - $width) / 2;
            $y = $pdf->get_height() - 30;
            $pdf->page_text($x, $y, $text, $font, $size);
        }
    </script>
</body>
</html>

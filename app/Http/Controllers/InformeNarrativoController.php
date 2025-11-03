<?php

namespace App\Http\Controllers;

use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\IOFactory;
use PhpOffice\PhpWord\Shared\Html;

class InformeNarrativoController extends Controller
{
    public function descargar(Request $request)
    {
        try {
            \Log::info('InformeNarrativoController: Iniciando descarga de informe');

            $html = session('informe_narrativo_html');
            $formato = session('informe_narrativo_formato', 'pdf');
            $proyectoId = session('informe_narrativo_proyecto_id');
            $proyectoNombre = session('informe_narrativo_proyecto_nombre', 'Proyecto');

            \Log::info('InformeNarrativoController: Sesión recuperada', [
                'tiene_html' => !empty($html),
                'formato' => $formato,
                'proyecto_id' => $proyectoId
            ]);

            if (!$html) {
                \Log::error('InformeNarrativoController: No se encontró HTML en sesión');
                abort(404, 'No se encontró el informe en sesión. Por favor, genera el informe nuevamente.');
            }

            $filename = "informe_narrativo_{$proyectoId}_" . now()->format('Y-m-d_His');

            \Log::info('InformeNarrativoController: Generando archivo', [
                'filename' => $filename,
                'formato' => $formato
            ]);

            if ($formato === 'pdf') {
                $pdf = Pdf::loadHTML($html)
                    ->setPaper('letter', 'portrait')
                    ->setOption('isHtml5ParserEnabled', true)
                    ->setOption('isRemoteEnabled', true)
                    ->setOption('enable-local-file-access', true);

                \Log::info('InformeNarrativoController: PDF generado, enviando respuesta');

                // Limpiar sesión DESPUÉS de generar el PDF
                session()->forget([
                    'informe_narrativo_html',
                    'informe_narrativo_formato',
                    'informe_narrativo_proyecto_id',
                    'informe_narrativo_proyecto_nombre',
                ]);

                return response()->streamDownload(function () use ($pdf) {
                    echo $pdf->output();
                }, "{$filename}.pdf", [
                    'Content-Type' => 'application/pdf',
                ]);
            } elseif ($formato === 'docx') {
                \Log::info('InformeNarrativoController: Generando DOCX');

                // Crear documento Word
                $phpWord = new PhpWord();

                // Configurar el documento
                $phpWord->getSettings()->setThemeFontLang(new \PhpOffice\PhpWord\Style\Language(\PhpOffice\PhpWord\Style\Language::ES_ES));

                // Agregar sección con márgenes
                $section = $phpWord->addSection([
                    'marginLeft' => 1134,    // 2cm en twips
                    'marginRight' => 1134,
                    'marginTop' => 1134,
                    'marginBottom' => 1134,
                ]);

                // Extraer solo el contenido del body (PHPWord no puede procesar documentos HTML completos)
                $dom = new \DOMDocument();
                @$dom->loadHTML('<?xml encoding="UTF-8">' . $html);
                $bodyNodes = $dom->getElementsByTagName('body');

                if ($bodyNodes->length > 0) {
                    $bodyContent = '';
                    foreach ($bodyNodes->item(0)->childNodes as $child) {
                        $bodyContent .= $dom->saveHTML($child);
                    }
                    $htmlContent = $bodyContent;
                } else {
                    // Si no hay body, usar el HTML tal cual
                    $htmlContent = $html;
                }

                \Log::info('InformeNarrativoController: HTML procesado', [
                    'html_original_length' => strlen($html),
                    'html_procesado_length' => strlen($htmlContent)
                ]);

                // Convertir HTML a Word
                Html::addHtml($section, $htmlContent, false, false);

                \Log::info('InformeNarrativoController: DOCX creado, guardando archivo');

                // Limpiar sesión
                session()->forget([
                    'informe_narrativo_html',
                    'informe_narrativo_formato',
                    'informe_narrativo_proyecto_id',
                    'informe_narrativo_proyecto_nombre',
                ]);

                // Generar archivo temporal
                $tempFile = tempnam(sys_get_temp_dir(), 'informe_') . '.docx';
                $objWriter = IOFactory::createWriter($phpWord, 'Word2007');
                $objWriter->save($tempFile);

                \Log::info('InformeNarrativoController: DOCX guardado, enviando respuesta');

                return response()->download($tempFile, "{$filename}.docx", [
                    'Content-Type' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                ])->deleteFileAfterSend(true);
            } else {
                \Log::info('InformeNarrativoController: HTML generado, enviando respuesta');

                // Limpiar sesión
                session()->forget([
                    'informe_narrativo_html',
                    'informe_narrativo_formato',
                    'informe_narrativo_proyecto_id',
                    'informe_narrativo_proyecto_nombre',
                ]);

                return response($html, 200, [
                    'Content-Type' => 'text/html; charset=utf-8',
                    'Content-Disposition' => "attachment; filename=\"{$filename}.html\"",
                ]);
            }
        } catch (\Exception $e) {
            \Log::error('InformeNarrativoController: Error al descargar', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            abort(500, 'Error al descargar el informe: ' . $e->getMessage());
        }
    }
}

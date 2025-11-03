-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 03, 2025 at 05:14 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `planeacion`
--

-- --------------------------------------------------------

--
-- Table structure for table `action_lines`
--

CREATE TABLE `action_lines` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `program_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `action_lines`
--

INSERT INTO `action_lines` (`id`, `name`, `program_id`, `created_at`, `updated_at`) VALUES
(1, 'Capacitar en herramientas y estrategias artísticas para el desarrollo integral infantil en la educación inicial.', 1, NULL, NULL),
(2, 'Desarrollar programas de formación artística básica en guitarra, violín, fotografía, teatro y danza.', 2, NULL, NULL),
(3, 'Impartir seminarios y talleres formativos sobre participación ciudadana y liderazgo.', 3, NULL, NULL),
(4, 'Capacitar en liderazgo orientado al trabajo colaborativo.', 4, NULL, NULL),
(5, 'Capacitar en gestión de equipos efectivos.', 4, NULL, NULL),
(6, 'Desarrollar habilidades de comunicación y confianza grupal.', 4, NULL, NULL),
(7, 'Capacitar en resolución creativa y constructiva de conflictos.', 4, NULL, NULL),
(8, 'Capacitar en formación especializada a facilitadores.', 4, NULL, NULL),
(9, 'Promover el desarrollo personal, social y vocacional en jóvenes', 5, NULL, NULL),
(10, 'Fomentar actividades deportivas y recreativas para el aprendizaje colaborativo.', 5, NULL, NULL),
(11, 'Brindar atención a la salud mental y desarrollar acciones  para el bienestar emocional de los jóvenes y las comunidades.', 5, NULL, NULL),
(12, 'Implementar programas de orientación vocacional y fortalecer alianzas con instituciones para ampliar oportunidades educativas y laborales.', 5, NULL, NULL),
(13, 'Implementar programas de formación técnica y digital especializada.', 6, NULL, NULL),
(14, 'Fomentar habilidades para profesiones creativas y servicios especializados.', 6, NULL, NULL),
(15, 'Desarrollar formación digital y tecnológica avanzada.', 6, NULL, NULL),
(16, 'Fortalecer la vinculación intersectorial para ampliar oportunidades educativas y laborales.', 6, NULL, NULL),
(17, 'Sensibilizar y promover la ética en sectores público y privado.', 7, NULL, NULL),
(18, 'Capacitar en mecanismos de integridad.', 7, NULL, NULL),
(19, 'Desarrollar formación especializada para servidores públicos.', 7, NULL, NULL),
(20, 'Capacitar en habilidades críticas para la gestión pública.', 8, NULL, NULL),
(21, 'Fomentar redes colaborativas entre funcionarios públicos.', 8, NULL, NULL),
(22, 'Impulsar la producción artística colaborativa.', 9, NULL, NULL),
(23, 'Fortalecer vínculos sostenibles entre artistas y comunidades.', 9, NULL, NULL),
(24, 'Capacitar en habilidades financieras y empresariales.', 10, NULL, NULL),
(25, 'Acompañar y validar proyectos emprendedores.', 10, NULL, NULL),
(26, 'Fortalecer el ecosistema emprendedor.', 10, NULL, NULL),
(27, 'Facilitar el acceso a oportunidades laborales.', 11, NULL, NULL),
(28, 'Capacitar en habilidades laborales y derechos.', 11, NULL, NULL),
(29, 'Fortalecer redes y promover la vinculación intersectorial.', 11, NULL, NULL),
(30, 'Monitorear experiencias laborales.', 11, NULL, NULL),
(31, 'Elaborar y formalizar una agenda medioambiental institucional basada en el diagnóstico de problemáticas ambientales en la ciudad.', 12, NULL, NULL),
(32, 'Implementar ecotecnias comunitarias y proyectos de reforestación con especies nativas en espacios públicos.', 12, NULL, NULL),
(33, 'Establecer alianzas con OSC y sectores privados para financiamiento y ejecución de proyectos ambientales.', 12, NULL, NULL),
(34, 'Construir y diseñar la Agenda Social 2030.', 13, NULL, NULL),
(35, 'Monitorear y evaluar la Agenda Social 2030.', 13, NULL, NULL),
(36, 'Fortalecer capacidades para la incidencia pública.', 14, NULL, NULL),
(37, 'Generar y presentar propuestas e iniciativas colectivas.', 14, NULL, NULL),
(38, 'Sistematizar avances y resultados de las iniciativas para evaluar su impacto.', 14, NULL, NULL),
(39, 'Monitorear y dar seguimiento a acciones gubernamentales.', 14, NULL, NULL),
(40, 'Diseñar e implementar planes de bienestar personalizados para fortalecer el desarrollo integral del personal de las OSC.', 15, NULL, NULL),
(41, 'Desarrollar y ejecutar talleres y cursos de formación para fortalecer competencias estratégicas y operativas.', 15, NULL, NULL),
(42, 'Generar y difundir materiales educativos y recursos de aprendizaje para el fortalecimiento continuo del personal de las OSC.', 15, NULL, NULL),
(43, 'Fomentar redes de intercambio y colaboración entre el personal de diferentes OSC para fortalecer capacidades colectivas y promover sinergias.', 15, NULL, NULL),
(44, 'Fortalecer las capacidades de las OSC en gestión de proyectos y empresas sociales mediante formación y desarrollo de herramientas para la viabilidad económica y social.', 16, NULL, NULL),
(45, 'Desarrollar y consolidar empresas sociales a través de la implementación de versiones iniciales, su fortalecimiento y continuidad.', 16, NULL, NULL),
(46, 'Integrar empresas sociales en estrategias de financiamiento de las OSC, promoviendo su autosostenibilidad y su impacto en el sector social.', 16, NULL, NULL),
(47, 'Generar espacios de diálogo comunitario.', 17, NULL, NULL),
(48, 'Formalizar y fortalecer grupos vecinales.', 17, NULL, NULL),
(49, 'Cocrear planes de activación comunitaria.', 17, NULL, NULL),
(50, 'Desarrollar y distribuir materiales informativos y metodológicos.', 17, NULL, NULL),
(51, 'Crear y fortalecer comités ciudadanos para la vigilancia y gestión del entorno urbano.', 18, NULL, NULL),
(52, 'Implementar acciones comunitarias de mejora urbana, incorporando reforestación, gestión de residuos y ecotecnias para la rehabilitación de espacios públicos.', 18, NULL, NULL),
(53, 'Implementar iniciativas de urbanismo táctico que promuevan la participación activa y el uso sostenible de los espacios públicos.', 18, NULL, NULL),
(54, 'Formar en herramientas de incidencia para la toma de decisiones.', 19, NULL, NULL),
(55, 'Diseñar y acompañar agendas ciudadanas.', 19, NULL, NULL),
(56, 'Articular esfuerzos intersectoriales para la incidencia.', 19, NULL, NULL),
(57, 'Fortalecer capacidades para el voluntariado.', 20, NULL, NULL),
(58, 'Desarrollar herramientas de organización y seguimiento.', 20, NULL, NULL),
(59, 'Articular sectores para generar impacto comunitario.', 20, NULL, NULL),
(60, 'Activar espacios públicos con programación cultural.', 21, NULL, NULL),
(61, 'Fomentar el talento local y la economía creativa.', 21, NULL, NULL),
(62, 'Promover la colaboración entre talentos locales.', 21, NULL, NULL),
(63, 'Monitorear y analizar procesos gubernamentales.', 22, NULL, NULL),
(64, 'Acompañar en procesos de cabildeo.', 22, NULL, NULL),
(65, 'Elaborar informes ciudadanos.', 22, NULL, NULL),
(66, 'Monitorear y analizar contrataciones públicas.', 23, NULL, NULL),
(67, 'Calcular el riesgo de corrupción.', 23, NULL, NULL),
(68, 'Estimar el costo de la corrupción administrativa.', 23, NULL, NULL),
(69, 'Generar y difundir informes sobre corrupción.', 23, NULL, NULL),
(70, 'Brindar asesoría legal sobre mecanismos de participación ciudadana, derechos humanos y urbanos, y demandas de amparo.', 24, NULL, NULL),
(71, 'Analizar aspectos jurídicos y formar en derechos ciudadanos y urbanos.', 24, NULL, NULL),
(72, 'Capacitar en participación ciudadana y derecho a la ciudad.', 24, NULL, NULL),
(73, 'Distribuir materiales educativos para empoderar a la ciudadanía en el ejercicio de sus derechos.', 24, NULL, NULL),
(74, 'Aplicar encuestas de percepción ciudadana.', 25, NULL, NULL),
(75, 'Generar datos e indicadores clave.', 25, NULL, NULL),
(76, 'Analizar y dar seguimiento a la normatividad urbana y ambiental.', 25, NULL, NULL),
(77, 'Elaborar informes estratégicos.', 25, NULL, NULL),
(78, 'Promover el diálogo multisectorial.', 25, NULL, NULL),
(79, 'Desarrollar estrategias de comunicación digital y territorial.', 26, NULL, NULL),
(80, 'Producir campañas temáticas de incidencia de la opinión pública.', 26, NULL, NULL),
(81, 'Elaborar materiales gráficos, interactivos y audiovisuales.', 26, NULL, NULL),
(82, 'Capacitar a las organizaciones de la sociedad civil (OSC) en estrategias de comunicación y difusión de sus iniciativas.', 26, NULL, NULL),
(83, 'Difundir las iniciativas de las osc.', 26, NULL, NULL),
(84, 'Generar contenido informativo sobre problemáticas territoriales.', 27, NULL, NULL),
(85, 'Visibilizar actores clave y organizaciones de la sociedad civil.', 27, NULL, NULL),
(86, 'Analizar y monitorear procesos gubernamentales.', 27, NULL, NULL),
(87, 'Difundir casos exitosos de participación ciudadana.', 27, NULL, NULL),
(88, 'Diseñar e implementar planes de bienestar personalizados para fortalecer el desarrollo integral del personal de las OSC.', 28, NULL, NULL),
(89, 'Desarrollar y ejecutar talleres y cursos de formación para fortalecer competencias estratégicas y operativas.', 28, NULL, NULL),
(90, 'Generar y difundir materiales educativos y recursos de aprendizaje para el fortalecimiento continuo del personal del GPJ', 28, NULL, NULL),
(91, 'Fomentar redes de intercambio y colaboración entre el personal del GPJ para fortalecer capacidades colectivas y promover sinergias.', 28, NULL, NULL),
(92, 'Capacitar continuamente al personal del GPJ', 28, NULL, NULL),
(93, 'Diseñar, implementar y dar seguimiento a proyectos estratégicos.', 29, NULL, NULL),
(94, 'Implementar un sistema de monitoreo para el seguimiento de proyectos.', 29, NULL, NULL),
(95, 'Establecer alianzas multisectoriales para la sostenibilidad de los proyectos.', 29, NULL, NULL),
(96, 'Unificar y optimizar la gestión documental del GPJ', 30, NULL, NULL),
(97, 'Automatizar procesos operativos y administrativos', 30, NULL, NULL),
(98, 'Fortalecer y diversificar las fuentes de financiamiento mediante la consolidación de relaciones con donantes actuales y la captación de nuevos aliados estratégicos.', 31, NULL, NULL),
(99, 'Diseñar e implementar estrategias efectivas de captación y fidelización de donantes para garantizar la sostenibilidad financiera.', 31, NULL, NULL),
(100, 'Desarrollar mecanismos innovadores de financiamiento y generación de ingresos que reduzcan la dependencia de donaciones tradicionales y promuevan la autonomía financiera (incubadora de empresas sociales).', 31, NULL, NULL),
(101, 'Implementar estrategias de mantenimiento preventivo y correctivo para garantizar el buen estado y sostenibilidad de los bienes muebles e inmuebles del GPJ.', 32, NULL, NULL),
(102, 'Optimizar y difundir el uso de los espacios disponibles para renta, asegurando su aprovechamiento eficiente.', 32, NULL, NULL),
(103, 'Fortalecer la promoción y visibilidad de los espacios disponibles, mediante la difusión en redes sociales y otros canales de comunicación.', 32, NULL, NULL),
(104, 'Optimizar procesos internos a través de la digitalización y automatización, mejorando la eficiencia operativa y reduciendo la carga administrativa.', 33, NULL, NULL),
(105, 'Implementar metodologías ágiles y herramientas innovadoras para fortalecer la gestión organizacional y la capacidad adaptativa del equipo.', 33, NULL, NULL),
(106, 'Capacitar al equipo en innovación organizacional mediante formación en nuevas tecnologías, metodologías de trabajo y enfoques estratégicos.', 33, NULL, NULL),
(107, 'Desarrollar un sistema de monitoreo y mejora continua para evaluar la eficiencia, efectividad y sostenibilidad de los procesos internos.', 33, NULL, NULL),
(108, 'Diseñar e implementar estrategias de comunicación para fortalecer la identidad y presencia del GPJ.', 34, NULL, NULL),
(109, 'Optimizar y diversificar los canales de difusión para ampliar el alcance y visibilidad de las acciones del GPJ.', 34, NULL, NULL),
(110, 'Desarrollar estrategias de articulación y vinculación con actores clave para fortalecer el posicionamiento institucional.', 34, NULL, NULL),
(111, 'Crear y distribuir herramientas y materiales de comunicación innovadores para mejorar la proyección y difusión de la organización.', 34, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `specific_objective_id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `goals_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `name`, `specific_objective_id`, `description`, `goals_id`, `created_by`, `created_at`, `updated_at`) VALUES
(47, 'Jornadas de limpieza comunitaria y reforestación en espacios públicos y escuelas en el polígono de Riberas del Bravo', 7, 'Realizar jornadas de limpieza comunitaria y reforestación en espacios públicos y escuelas', 47, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(48, 'Jornadas de limpieza comunitaria y reforestación en espacios públicos y escuelas en el polígono de Riberas del Bravo', 7, 'Realizar jornadas de limpieza comunitaria y reforestación en espacios públicos y escuelas en el polígono', 48, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(49, 'Actividades de divulgación de ecotecnias y educación ambiental en las comunidades de Riberas del Bravo y el suroriente de Juárez', 8, 'Realizar actividades de divulgación de ecotecnias y educación ambiental en las comunidades ', 49, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(50, 'Actividades para conocer el arbolado urbano apropiado para la región', 8, 'Realizar actividades para conocer el arbolado urbano apropiado para la región', 50, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(51, 'Actividades para conocer las técnicas de riego eficiente', 8, 'Realizar actividades para conocer las técnicas de riego eficiente\n', 51, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(52, 'Actividades para gestionar apropiadamente los residuos sólidos', 8, 'Desarrollar actividades para  gestionar apropiadamente los residuos sólidos', 52, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(53, ' Actividades para aprovechar los residuos orgánicos en compostaje', 8, ' Desarrollar actividades para aprovechar los residuos orgánicos en compostaje', 53, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(54, 'Talleres de tenencia responsable de animales de compañía', 8, 'Realizar talleres de tenencia responsable de animales de compañía', 54, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(55, 'Talleres de bioplaguicidas caseros', 8, 'Realizar talleres de bioplaguicidas caseros', 55, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(56, 'Huertos urbanos en Riberas del Bravo', 9, 'Poner en funcionamiento huertos urbanos', 56, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(57, ' Talleres de introducción a los huertos agroecológicos', 9, 'Desarrollar talleres de introducción a los huertos agroecológicos', 57, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(58, ' Actividades lúdicas de creatividad para codiseñar espacios comunitarios para huertos urbanos', 9, 'Realizar actividades lúdicas de creatividad para codiseñar espacios comunitarios para huertos urbanos', 58, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(59, ' Sesiones de montaje y construcción comunitaria de huertos urbanos', 9, 'Desarrollar  sesiones de montaje y construcción comunitaria de huertos urbanos', 59, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(60, ' Actividades para generar huertos caseros urbanos', 9, 'Realizar actividades para generar huertos caseros urbanos', 60, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(61, 'Talleres de mantenimiento de huertos urbanos', 9, 'Desarrollar talleres de mantenimiento de huertos urbanos', 61, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(62, 'Talleres de introducción a los huertos agroecológicos', 9, 'Desarrollar talleres de introducción a los huertos agroecológicos', 62, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(63, 'Talleres de identificación de plagas en huertos urbanos y su tratamiento', 9, 'Desarrollar talleres de identificación de plagas en huertos urbanos y su tratamiento', 63, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(64, 'Talleres de rotación y asociación de cultivos en huertos urbanos', 9, 'Desarrollar talleres de rotación y asociación de cultivos en huertos urbanos', 64, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(65, 'Talleres de productos bioculturales comestibles', 9, 'Desarrollar talleres de productos bioculturales comestibles', 65, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(66, 'Actividades comunitarias de intercambio de plantas y productos del huerto', 9, 'Realizar actividades comunitarias de intercambio de plantas y productos del huerto', 66, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(67, 'Actividades de rendimiento y preparación invernal del suelo de huertos urbanos', 9, 'Realizar actividades de rendimiento y preparación invernal del suelo de huertos urbanos', 67, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(68, 'Talleres de cuidados invernales de huertos urbanos y plantas caseras', 9, 'Desarrollar talleres de cuidados invernales de huertos urbanos y plantas caseras', 68, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(69, 'Huertos urbanos en Riberas del Bravo', 9, 'Participación en huertos urbanos en Riberas del Bravo', 69, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(70, 'Taller de Participación Ciudadana Avanzados CS', 13, 'Realizar talleres de Participación Ciudadana Avanzados', 70, 3, '2025-08-01 15:57:20', '2025-08-01 15:57:20'),
(71, 'Seminario de Derecho a la Ciudad CS', 13, 'Realizar seminarios de derecho a la ciudad para comunidades en seguimiento ', 71, 3, '2025-08-01 16:16:44', '2025-08-01 16:16:44'),
(72, 'Seminario de Diseño Participativo CS', 13, 'Realizar seminarios de diseño participativo para comunidades en seguimiento', 72, 3, '2025-08-01 16:19:34', '2025-08-01 16:19:34'),
(73, 'Taller de Participación Ciudadana Básicos CN', 13, 'Realizar talleres de participación ciudadana básicos para comunidades nuevas', 73, 3, '2025-08-01 16:23:00', '2025-08-01 16:23:00'),
(74, ' Seminario de Participación Ciudadana CN', 13, 'Realizar seminarios de participación ciudadana para comunidades nuevas', 74, 3, '2025-08-01 16:28:23', '2025-08-01 16:28:23'),
(75, 'Seminario para NNA CN', 13, 'Realizar seminarios de participación ciudadana para niñas, niños y adolescentes', 75, 3, '2025-08-01 16:42:24', '2025-08-01 18:07:22'),
(76, 'Taller de Participación Ciudadana Básicos (Polígono Las Torres)', 13, 'Realizar talleres de participación ciudadana básicos ', 76, 3, '2025-08-01 16:46:47', '2025-08-01 20:26:36'),
(77, 'Seminario de Participación Ciudadana (Polígono Las Torres)', 13, 'Realizar seminarios de participación ciudadana', 77, 3, '2025-08-01 16:46:47', '2025-08-01 20:26:36'),
(78, 'Seminario para NNA (Polígono Las Torres)', 13, 'Realizar seminarios de participación ciudadana para niñas, niños y adolescentes', 78, 3, '2025-08-01 16:52:03', '2025-08-01 20:26:36'),
(79, 'Conformación de grupo vecinal CS', 14, 'Realizar comunidades vecinales en seguimiento ', 79, 3, '2025-08-01 17:07:29', '2025-08-01 17:07:29'),
(80, 'Diálogo Vecinal CS', 14, 'Realizar diálogos vecinales para comunidades en seguimiento', 80, 3, '2025-08-01 17:09:29', '2025-08-01 17:09:29'),
(81, 'Planes de acción CS', 14, 'Realizar planes de acción', 81, 3, '2025-08-01 17:51:14', '2025-08-01 17:57:28'),
(82, 'Actividad comunitaria CS', 14, 'Realizar actividades comunitarias para comunidades en seguimiento ', 82, 3, '2025-08-01 17:52:52', '2025-08-01 17:52:52'),
(83, 'Asamblea comunitaria CS', 14, 'Realizar asambleas comunitarias para comunidades en seguimiento', 83, 3, '2025-08-01 17:57:28', '2025-08-01 17:57:28'),
(84, 'Gestiones Comunitarias', 14, 'Realizar gestiones comunitarias para comunidades en seguimiento', 84, 3, '2025-08-01 17:57:28', '2025-08-01 17:57:28'),
(85, 'Taller de vigilancia de obra CS', 14, 'Realizar talleres de vigilancia de obra pública para comunidades en seguimiento', 85, 3, '2025-08-01 18:00:50', '2025-08-01 18:00:50'),
(86, 'Conformación de Comités de vigilancia de obras CS', 14, 'Realizar la conformación comités ciudadanos de vigilancia de obra para comunidades en seguimiento', 86, 3, '2025-08-01 18:00:50', '2025-08-01 18:00:50'),
(87, 'Recorrido Exploratorio CS', 14, 'Realizar recorridos exploratorios para comunidades en seguimiento', 87, 3, '2025-08-01 18:04:45', '2025-08-01 18:04:45'),
(88, 'Proyectos Comunitarios CS', 14, 'Realizar proyectos comunitarios propuestos por la comunidad en espacios de participación ciudadana ', 88, 3, '2025-08-01 18:04:45', '2025-08-01 18:04:45'),
(89, 'Conformación de grupo vecinal CN', 14, 'Realizar la conformación comunidades vecinales nuevas', 89, 3, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(90, 'Diálogo Vecinal CN', 14, 'Realizar diálogos vecinales para comunidades nuevas', 90, 3, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(91, 'Planes de acción CN', 14, 'Realizar planes de acción comunitarios básicos para comunidades nuevas derivados de los diálogos vecinales', 91, 3, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(92, ' Actividad comunitaria CN', 14, 'Realizar actividades comunitarias para comunidades nuevas', 92, 3, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(93, 'Gestiones Comunitarias CN', 14, 'Realizar gestiones comunitarias para comunidades nuevas', 93, 3, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(94, 'Proyectos Ciudadanos CN', 14, 'Realizar proyectos ciudadanos para el presupuesto participativo', 94, 3, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(95, 'Conformación de Comités de vigilancia de obras CN', 14, 'Realizar la conformación de comités ciudadanos de vigilancia de obra para comunidades nuevas', 95, 3, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(96, 'Conformación de grupo vecinal (Polígono Las Torres)', 14, 'Realizar la conformación de comunidades vecinales nuevas', 96, 3, '2025-08-01 19:19:57', '2025-08-01 19:19:57'),
(97, 'Planes de Acción', 14, 'Realizar planes de acción comunitarios derivados de los diálogos vecinales', 97, 4, '2025-08-01 19:33:24', '2025-08-01 19:33:24'),
(98, 'Actividad comunitaria (Polígono Las Torres)', 14, 'Realizar actividades comunitarias ', 98, 4, '2025-08-01 19:33:24', '2025-08-01 19:33:24'),
(99, 'Gestiones comunitarias (Polígono Las Torres)', 14, 'Realizar gestiones comunitarias ', 99, 4, '2025-08-01 19:33:24', '2025-08-01 19:36:17'),
(100, 'Proyectos Ciudadanos (Polígono Las Torres)', 14, 'Realizar proyectos ciudadanos para el presupuesto participativo', 100, 4, '2025-08-01 19:36:17', '2025-08-01 19:40:04'),
(101, 'Conformación de Comités de vigilancia de obras (Polígono Las Torres)', 14, 'Realizar la conformación de comités de vigilancia de obras', 101, 4, '2025-08-01 19:40:04', '2025-08-01 19:40:04'),
(102, 'Asesorías Juridicas', 14, 'Realizar sesiones de asesorías jurídicas comunitarias para temas de derecho a la ciudad', 102, 4, '2025-08-01 19:40:04', '2025-08-01 19:40:04'),
(103, 'Talleres de Normativa de Derecho a la Ciudad', 14, 'Realizar talleres de normativa en derecho a la ciudad durante el año', 103, 4, '2025-08-01 19:41:53', '2025-08-01 19:41:53'),
(104, 'Informe territorial ', 15, 'Realizar Informes Territoriales en los polígonos', 104, 4, '2025-08-01 19:45:59', '2025-08-01 19:45:59'),
(105, 'Investigaciones Periodísticas ', 15, 'Realizar investigaciones periodísticas sobre temas relacionados con problemáticas comunitarias y participación ciudadana', 105, 4, '2025-08-01 19:45:59', '2025-08-01 19:45:59'),
(106, 'Contenidos Periodísticos', 15, 'Realizar la publicación de 600 contenidos periodísticos sobre temas relacionados con problemáticas comunitarias participación ciudadana', 106, 4, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(107, 'Análisis sobre cumplimiento de leyes, reglamentos y normas en materia anticorrupción por parte del Municipio de Juárez', 15, 'Realizar análisis sobre cumplimiento de leyes, reglamentos y normas en materia anticorrupción por parte del Municipio de Juárez', 107, 4, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(108, 'Seguimiento de Comisiones de Regidores', 15, 'Realizar el el seguimiento del actuar de los tomadores de decisiones a través del monitoreo de sesiones de=de comisiones clave de regidores', 108, 4, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(109, 'Seguimiento a Sesiones de Cabildo ', 15, 'Dar seguimiento a las 24 sesiones de cabildo', 109, 4, '2025-08-01 19:59:52', '2025-08-01 19:59:52'),
(110, 'Seguimiento al Cumplimento del PMD', 15, 'Dar seguimiento al cumplimiento de los PMD', 110, 4, '2025-08-01 19:59:52', '2025-08-01 19:59:52'),
(111, ' Presentación de información clave de la ciudad', 16, 'Realizar presentaciones de información clave de la ciudad a través de informes', 111, 4, '2025-08-01 20:05:05', '2025-08-01 20:05:05'),
(121, 'Contenidos informativos para el sitio web', 17, 'Generación de contenidos informativos para el sitio web:  contenidos sobre mecanismos de participación ciudadana y toma de decisiones, incluyendo boletines, reportajes y notas publicados en el sitio web', 121, 4, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(122, 'Contenidos Digitales en Redes Sociales', 17, 'Realizar la publicación de contenidos digitales en redes sociales utilizando formatos como contenidos visuales, videos, contenidos interactivos, contenidos educativos y contenidos promocionales', 122, 4, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(123, 'Concientización Comunitaria y Planificación estratégica', 17, 'Implementar  un plan de comunicación que incluye objetivos, análisis de público met, mensajes clave, selección de canales, cronograma, estrategias específicas, asignación de recursos y métricas de evaluación, para fomentar la participación ciudadana e involucramiento comunitario', 123, 4, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(124, 'Diseño de materiales impresos informativos para informes territoriales', 17, 'Diseños informativos se generan para impresión en materiales rígidos y  diseños informativos para impresión de lonas, destinados a fortalecer la difusión visual de los informes territoriales ', 124, 4, '2025-08-01 20:20:43', '2025-08-01 20:20:43');

-- --------------------------------------------------------

--
-- Table structure for table `activity_calendars`
--

CREATE TABLE `activity_calendars` (
  `id` bigint UNSIGNED NOT NULL,
  `activity_id` bigint UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_hour` time DEFAULT NULL,
  `end_hour` time DEFAULT NULL,
  `address_backup` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_modified` timestamp NULL DEFAULT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `change_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `assigned_person` bigint UNSIGNED DEFAULT NULL,
  `location_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_calendars`
--

INSERT INTO `activity_calendars` (`id`, `activity_id`, `start_date`, `end_date`, `start_hour`, `end_hour`, `address_backup`, `last_modified`, `cancelled`, `change_reason`, `created_by`, `assigned_person`, `location_id`, `created_at`, `updated_at`) VALUES
(1, 47, '2025-02-21', '2025-02-21', '17:00:00', '18:00:00', NULL, NULL, 1, 'No se realizó actividad', 4, 5, 5, '2025-07-25 15:24:22', '2025-07-25 21:47:02'),
(2, 56, '2025-02-21', '2025-02-21', '18:00:00', '19:00:00', NULL, NULL, 1, 'No se realizó actividad', 4, 5, 5, '2025-07-25 15:34:09', '2025-07-25 21:47:41'),
(3, 47, '2025-03-11', '2025-03-11', '10:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 15:40:39', '2025-07-25 21:48:26'),
(4, 47, '2025-03-11', '2025-03-11', '11:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 15:43:33', '2025-07-25 21:48:53'),
(5, 47, '2025-03-13', '2025-03-13', '10:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 15:45:19', '2025-07-25 21:49:23'),
(6, 47, '2025-03-13', '2025-03-13', '11:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 5, 1, '2025-07-25 15:49:11', '2025-07-25 21:50:12'),
(7, 56, '2025-03-18', '2025-03-18', '10:00:00', '11:00:00', NULL, NULL, 1, 'Se reagendó', 4, 5, 2, '2025-07-25 15:52:48', '2025-07-25 23:03:57'),
(8, 56, '2025-03-18', '2025-03-18', '11:00:00', '12:00:00', NULL, NULL, 1, 'Se reagendó', 4, 5, 6, '2025-07-25 15:54:46', '2025-07-25 23:04:45'),
(9, 56, '2025-03-20', '2025-03-20', '10:00:00', '11:00:00', NULL, NULL, 1, 'Se reagendó por cuestiones climáticas ', 4, 5, 3, '2025-07-25 15:57:07', '2025-07-25 23:06:01'),
(10, 56, '2025-03-20', '2025-03-20', '11:00:00', '12:00:00', NULL, NULL, 1, 'Se reagendó por cuestiones climáticas', 4, 5, 1, '2025-07-25 15:58:44', '2025-07-25 23:06:23'),
(11, 56, '2025-04-01', '2025-04-01', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 16:13:22', '2025-07-25 21:55:09'),
(12, 56, '2025-04-05', '2025-04-05', '10:00:00', '11:00:00', NULL, NULL, 1, 'No se realizó', 4, 5, 3, '2025-07-25 16:14:50', '2025-07-25 23:02:41'),
(13, 56, '2025-04-03', '2025-04-03', '10:00:00', '11:00:00', NULL, NULL, 1, 'No se realizó', 4, 5, 5, '2025-07-25 16:16:47', '2025-07-25 23:00:47'),
(14, 47, '2025-04-05', '2025-04-05', '11:00:00', '12:00:00', NULL, NULL, 1, 'No se realizó', 4, 5, 3, '2025-07-25 16:18:31', '2025-07-25 23:02:12'),
(15, 47, '2025-04-03', '2025-04-03', '10:00:00', '11:00:00', NULL, NULL, 1, 'No se realizó', 4, 5, 5, '2025-07-25 16:19:50', '2025-07-25 23:01:18'),
(16, 64, '2025-08-27', '2025-08-27', '19:30:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 4, '2025-07-25 16:20:37', '2025-07-25 22:10:38'),
(17, 61, '2025-05-01', '2025-05-01', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 5, 1, '2025-07-25 16:22:30', '2025-07-25 22:11:50'),
(18, 64, '2025-08-25', '2025-08-25', '18:30:00', '19:30:00', NULL, NULL, 0, NULL, 3, 5, 7, '2025-07-25 16:23:04', '2025-07-25 22:12:35'),
(19, 61, '2025-05-14', '2025-05-14', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 16:24:15', '2025-07-25 22:14:46'),
(20, 64, '2025-08-26', '2025-08-26', '19:30:00', '20:30:00', NULL, NULL, 0, NULL, 3, 5, 1, '2025-07-25 16:24:39', '2025-07-25 22:15:46'),
(21, 61, '2025-05-21', '2025-05-21', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 16:25:48', '2025-07-25 22:17:11'),
(22, 49, '2025-06-18', '2025-06-18', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 16:28:08', '2025-07-25 22:17:46'),
(23, 49, '2025-06-25', '2025-06-25', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 16:29:58', '2025-07-25 22:18:19'),
(24, 64, '2025-08-25', '2025-08-25', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 8, '2025-07-25 16:31:17', '2025-07-25 22:19:17'),
(25, 56, '2025-06-16', '2025-06-16', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 4, '2025-07-25 16:32:06', '2025-07-25 22:58:48'),
(26, 50, '2025-06-23', '2025-06-23', '18:00:00', '08:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 16:33:53', '2025-07-25 22:36:33'),
(27, 50, '2025-06-17', '2025-06-17', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 16:35:38', '2025-07-25 22:37:37'),
(28, 62, '2025-06-03', '2025-06-03', '18:00:00', '20:00:00', NULL, NULL, 1, NULL, 4, 5, 2, '2025-07-25 16:40:09', '2025-08-06 18:29:59'),
(29, 57, '2025-06-10', '2025-06-10', '18:00:00', '20:00:00', NULL, NULL, 1, 'Se reagendó. Se cambio la fecha al 11/06/25, por cuestiones climáticas', 4, 5, 3, '2025-07-25 16:41:48', '2025-07-29 18:17:46'),
(30, 64, '2025-08-26', '2025-08-28', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 16:42:08', '2025-07-25 22:39:38'),
(31, 57, '2025-06-24', '2025-06-24', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 4, '2025-07-25 16:45:34', '2025-07-25 22:44:34'),
(32, 51, '2025-06-07', '2025-06-07', '09:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 16:48:38', '2025-07-25 22:57:12'),
(33, 64, '2025-08-27', '2025-08-27', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 17:13:46', '2025-07-25 22:38:53'),
(34, 64, '2025-08-20', '2025-08-20', '19:30:00', '20:30:00', NULL, NULL, 0, NULL, 3, 5, 4, '2025-07-25 17:16:21', '2025-07-25 22:42:08'),
(35, 51, '2025-06-14', '2025-06-14', '09:00:00', '11:00:00', NULL, NULL, 1, 'No se realizó. Por cuestiones climáticas no se pudo realizar la actividad', 4, 5, 3, '2025-07-25 17:27:29', '2025-07-29 18:20:22'),
(36, 64, '2025-08-18', '2025-08-18', '18:30:00', '19:30:00', NULL, NULL, 0, NULL, 3, 5, 7, '2025-07-25 17:27:29', '2025-07-25 22:43:50'),
(37, 51, '2025-06-21', '2025-06-21', '09:00:00', '11:00:00', NULL, NULL, 1, 'No se realizó', 4, 5, 1, '2025-07-25 17:28:59', '2025-07-29 18:35:06'),
(38, 56, '2025-06-05', '2025-06-05', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:31:12', '2025-07-25 22:56:06'),
(39, 56, '2025-06-12', '2025-06-12', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:32:31', '2025-07-25 22:56:45'),
(40, 56, '2025-06-19', '2025-06-19', '15:00:00', '17:00:00', NULL, NULL, 1, 'No se realizó. Actividades no desarrolladas por vacaciones de los estudiantes', 4, 5, 5, '2025-07-25 17:33:27', '2025-07-29 18:21:23'),
(41, 56, '2025-06-26', '2025-06-26', '15:00:00', '17:00:00', NULL, NULL, 1, 'No se realizó. Actividades no desarrolladas por vacaciones de los estudiantes', 4, 5, 5, '2025-07-25 17:34:46', '2025-07-29 18:35:52'),
(42, 56, '2025-06-06', '2025-06-06', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:35:46', '2025-07-25 22:56:25'),
(43, 56, '2025-06-13', '2025-06-13', '15:00:00', '17:00:00', NULL, NULL, 1, 'Se reagendó por falta de disponibilidad de la escuela', 4, 5, 5, '2025-07-25 17:37:44', '2025-07-29 18:18:50'),
(44, 56, '2025-06-20', '2025-06-20', '15:00:00', '17:00:00', NULL, NULL, 1, 'No se realizó. Actividades no desarrolladas por vacaciones de los estudiantes', 4, 5, 5, '2025-07-25 17:38:36', '2025-07-29 18:34:18'),
(45, 56, '2025-06-27', '2025-06-27', '15:00:00', '17:00:00', NULL, NULL, 1, 'No se realizó', 4, 5, 5, '2025-07-25 17:39:32', '2025-07-29 18:37:24'),
(46, 64, '2025-08-19', '2025-08-19', '19:30:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 1, '2025-07-25 17:39:45', '2025-07-25 22:43:02'),
(47, 56, '2025-06-09', '2025-06-09', '17:00:00', '19:00:00', NULL, NULL, 1, NULL, 4, 5, 7, '2025-07-25 17:42:31', '2025-08-06 18:31:26'),
(48, 50, '2025-06-16', '2025-06-16', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 7, '2025-07-25 17:44:10', '2025-07-25 22:57:45'),
(49, 64, '2025-08-18', '2025-07-18', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 8, '2025-07-25 17:45:20', '2025-07-25 22:43:31'),
(50, 56, '2025-06-30', '2025-06-30', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 5, 7, '2025-07-25 17:45:33', '2025-07-25 22:45:38'),
(51, 64, '2025-08-19', '2025-08-19', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 17:46:46', '2025-07-25 22:42:38'),
(52, 47, '2025-06-30', '2025-06-30', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 8, '2025-07-25 17:48:40', '2025-07-25 22:46:01'),
(53, 64, '2025-08-20', '2025-08-20', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 17:48:53', '2025-07-25 22:41:32'),
(54, 51, '2025-07-01', '2025-07-01', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 17:50:00', '2025-07-25 22:46:25'),
(55, 52, '2025-08-13', '2025-08-13', '19:30:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 4, '2025-07-25 17:50:54', '2025-07-25 22:45:15'),
(56, 51, '2025-07-02', '2025-07-02', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 17:51:06', '2025-07-25 22:46:50'),
(57, 52, '2025-08-11', '2025-08-11', '18:30:00', '19:30:00', NULL, NULL, 0, NULL, 3, 5, 7, '2025-07-25 17:52:46', '2025-07-25 22:50:02'),
(58, 52, '2025-08-12', '2025-08-12', '19:30:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 1, '2025-07-25 17:56:23', '2025-07-25 22:46:09'),
(59, 51, '2025-07-09', '2025-07-09', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 17:58:35', '2025-07-25 22:48:05'),
(60, 52, '2025-08-11', '2025-08-11', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 8, '2025-07-25 18:00:05', '2025-07-25 22:47:29'),
(61, 51, '2025-07-08', '2025-07-08', '18:00:00', '20:00:00', NULL, NULL, 1, 'No se realizó', 4, 5, 2, '2025-07-25 18:00:30', '2025-07-29 18:38:13'),
(62, 52, '2025-08-12', '2025-08-12', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 18:01:25', '2025-07-25 22:45:41'),
(63, 49, '2025-07-16', '2025-07-16', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 18:01:28', '2025-07-25 22:48:47'),
(64, 49, '2025-07-15', '2025-07-15', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 18:02:33', '2025-07-25 22:48:32'),
(65, 52, '2025-08-13', '2025-08-13', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 18:03:32', '2025-07-25 22:44:43'),
(66, 49, '2025-07-21', '2025-07-21', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 5, 7, '2025-07-25 18:03:35', '2025-07-25 22:49:11'),
(67, 49, '2025-07-21', '2025-07-21', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 8, '2025-07-25 18:07:00', '2025-07-25 22:53:16'),
(68, 49, '2025-07-28', '2025-07-28', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 7, '2025-07-25 18:08:28', '2025-07-25 22:54:15'),
(69, 49, '2025-07-28', '2025-07-28', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 8, '2025-07-25 18:09:57', '2025-07-25 22:54:41'),
(70, 49, '2025-07-22', '2025-07-22', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 18:10:59', '2025-07-25 22:53:39'),
(71, 49, '2025-07-23', '2025-07-23', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 18:12:15', '2025-07-25 22:53:57'),
(72, 49, '2025-07-29', '2025-07-29', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 18:13:23', '2025-07-25 22:55:17'),
(73, 49, '2025-07-30', '2025-07-30', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 18:14:27', '2025-07-25 22:55:33'),
(74, 49, '2025-08-06', '2025-08-06', '19:30:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 4, '2025-07-25 18:15:27', '2025-07-25 22:53:13'),
(75, 49, '2025-08-04', '2025-07-04', '18:30:00', '19:30:00', NULL, NULL, 0, NULL, 3, 5, 7, '2025-07-25 18:17:23', '2025-07-25 22:54:53'),
(76, 49, '2025-08-05', '2025-08-05', '19:00:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 1, '2025-07-25 18:20:01', '2025-07-25 22:54:16'),
(77, 49, '2025-08-04', '2025-08-04', '19:30:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 8, '2025-07-25 18:21:12', '2025-07-25 22:54:35'),
(78, 49, '2025-08-05', '2025-07-05', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 18:22:26', '2025-07-25 22:53:42'),
(79, 49, '2025-08-06', '2025-08-06', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 18:23:49', '2025-07-25 22:51:43'),
(80, 56, '2025-03-18', '2025-03-18', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-28 22:14:16', '2025-07-28 22:14:16'),
(81, 56, '2025-03-18', '2025-03-18', '19:00:00', '08:00:00', NULL, NULL, 0, NULL, 3, 5, 6, '2025-07-28 22:16:13', '2025-07-28 22:16:13'),
(83, 82, '2025-08-16', '2025-08-16', '10:00:00', '12:00:00', NULL, NULL, 1, 'Se reagendo ', 10, 10, 10, '2025-08-01 21:25:59', '2025-08-12 16:13:32'),
(84, 72, '2025-08-16', '2025-08-16', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 9, 11, '2025-08-06 19:31:29', '2025-08-06 19:31:29'),
(85, 79, '2025-08-18', '2025-08-18', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 12, '2025-08-06 19:42:09', '2025-08-06 19:42:09'),
(86, 80, '2025-08-25', '2025-08-25', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 9, 12, '2025-08-06 21:57:21', '2025-08-06 21:57:21'),
(87, 82, '2025-08-14', '2025-08-14', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 9, 12, '2025-08-06 21:59:25', '2025-08-06 21:59:25'),
(88, 89, '2025-08-07', '2025-08-07', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 9, 19, '2025-08-06 22:46:18', '2025-08-12 16:43:17'),
(89, 90, '2025-08-21', '2025-08-21', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 9, 19, '2025-08-07 15:09:00', '2025-08-12 16:40:31'),
(90, 92, '2025-08-28', '2025-08-28', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 9, 19, '2025-08-07 15:12:50', '2025-08-12 16:28:37'),
(91, 72, '2025-08-05', '2025-08-19', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 20, '2025-08-07 15:35:55', '2025-08-07 15:35:55'),
(92, 79, '2025-08-01', '2025-08-01', '15:00:00', '16:00:00', NULL, NULL, 0, NULL, 4, 10, 21, '2025-08-07 15:54:22', '2025-08-07 15:54:22'),
(93, 80, '2025-08-01', '2025-08-01', '16:00:00', '18:00:00', NULL, NULL, 0, NULL, 4, 10, 21, '2025-08-07 15:58:12', '2025-08-07 15:58:12'),
(94, 89, '2025-08-22', '2025-08-22', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 10, 22, '2025-08-07 16:06:42', '2025-08-07 16:06:42'),
(95, 90, '2025-08-22', '2025-08-22', '19:00:00', '21:00:00', NULL, NULL, 0, NULL, 4, 10, 22, '2025-08-07 16:21:13', '2025-08-12 16:11:26'),
(96, 92, '2025-08-29', '2025-08-29', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 22, '2025-08-07 16:22:23', '2025-08-12 16:10:33'),
(97, 82, '2025-08-15', '2025-08-15', '17:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 10, 21, '2025-08-07 16:25:20', '2025-08-07 16:25:20'),
(98, 82, '2025-08-07', '2025-08-07', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 24, '2025-08-07 17:00:31', '2025-08-07 17:00:31'),
(99, 82, '2025-08-16', '2025-08-16', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 25, '2025-08-07 17:04:22', '2025-08-07 17:04:22'),
(100, 90, '2025-08-16', '2025-08-16', '12:00:00', '14:00:00', NULL, NULL, 0, NULL, 4, 10, 26, '2025-08-07 17:09:06', '2025-08-12 16:11:54'),
(101, 92, '2025-08-26', '2025-08-26', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 20, '2025-08-07 17:25:25', '2025-08-07 17:25:25'),
(103, 70, '2025-07-17', '2025-07-17', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 9, 12, '2025-08-07 18:40:20', '2025-08-07 18:40:20'),
(104, 82, '2025-07-22', '2025-07-22', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 27, '2025-08-07 18:54:13', '2025-08-07 18:54:13'),
(105, 80, '2025-07-09', '2025-07-09', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 9, 19, '2025-08-07 19:08:24', '2025-08-07 19:08:24'),
(106, 79, '2025-08-15', '2025-08-15', '10:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 9, 11, '2025-08-07 19:18:57', '2025-08-07 19:18:57'),
(107, 82, '2025-08-20', '2025-08-20', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 12, '2025-08-07 19:20:27', '2025-08-07 19:20:27'),
(108, 85, '2025-08-15', '2025-08-15', '11:00:00', '22:00:00', NULL, NULL, 0, NULL, 4, 9, 11, '2025-08-07 19:22:18', '2025-08-07 19:22:18'),
(109, 89, '2025-08-30', '2025-08-30', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 28, '2025-08-07 19:37:26', '2025-08-07 19:37:26'),
(110, 70, '2025-07-04', '2025-07-04', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 29, '2025-08-07 21:23:33', '2025-08-07 21:23:33'),
(111, 70, '2025-07-08', '2025-07-08', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 20, '2025-08-07 21:26:24', '2025-08-07 21:26:24'),
(112, 82, '2025-07-01', '2025-07-01', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 24, '2025-08-07 21:31:21', '2025-08-07 21:31:21'),
(113, 80, '2025-07-05', '2025-07-05', '09:00:00', '10:30:00', NULL, NULL, 0, NULL, 4, 10, 25, '2025-08-07 21:34:08', '2025-08-07 21:34:08'),
(114, 82, '2025-07-05', '2025-07-05', '10:30:00', '12:30:00', NULL, NULL, 0, NULL, 4, 10, 25, '2025-08-07 21:40:34', '2025-08-12 16:15:38'),
(115, 82, '2025-07-12', '2025-07-12', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 25, '2025-08-07 21:43:51', '2025-08-07 21:43:51'),
(116, 79, '2025-06-03', '2025-06-03', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 30, '2025-08-07 22:16:32', '2025-08-07 22:16:32'),
(117, 80, '2025-06-17', '2025-06-17', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 30, '2025-08-07 22:20:46', '2025-08-07 22:25:42'),
(118, 82, '2025-06-08', '2025-06-08', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 31, '2025-08-07 22:30:12', '2025-08-07 22:30:12'),
(119, 85, '2025-06-24', '2025-06-24', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 30, '2025-08-07 22:33:35', '2025-08-07 22:33:35'),
(120, 95, '2025-06-06', '2025-06-06', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 24, '2025-08-07 22:35:13', '2025-08-07 22:35:13'),
(121, 90, '2025-06-13', '2025-06-13', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 24, '2025-08-07 22:36:26', '2025-08-07 22:36:26'),
(122, 92, '2025-06-10', '2025-06-10', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 20, '2025-08-07 22:38:09', '2025-08-07 22:38:09'),
(123, 79, '2025-06-19', '2025-06-19', '17:00:00', '18:00:00', NULL, NULL, 0, NULL, 4, 9, 32, '2025-08-07 22:53:01', '2025-08-07 22:53:01'),
(124, 80, '2025-06-24', '2025-06-24', '17:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 33, '2025-08-11 16:31:50', '2025-08-11 16:31:50'),
(125, 85, '2025-06-26', '2025-06-26', '17:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 33, '2025-08-11 17:36:13', '2025-08-11 17:36:13'),
(126, 89, '2025-06-10', '2025-06-10', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 9, 34, '2025-08-11 17:51:56', '2025-08-11 17:51:56'),
(127, 90, '2025-06-17', '2025-06-17', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 9, 34, '2025-08-11 18:08:02', '2025-08-11 18:08:02'),
(128, 92, '2025-06-03', '2025-06-03', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 9, 33, '2025-08-11 18:16:42', '2025-08-11 18:16:42'),
(129, 70, '2025-05-02', '2025-05-02', '17:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 11, '2025-08-11 18:33:24', '2025-08-11 18:33:24'),
(130, 73, '2025-05-13', '2025-05-13', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 9, 35, '2025-08-11 20:24:49', '2025-08-11 20:24:49'),
(131, 71, '2025-05-20', '2025-05-20', '17:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 9, 12, '2025-08-11 20:57:07', '2025-08-11 20:57:07'),
(132, 90, '2025-04-15', '2025-04-15', '11:00:00', '13:00:00', NULL, NULL, 0, NULL, 4, 9, 34, '2025-08-11 21:34:06', '2025-08-11 21:34:06'),
(133, 89, '2025-04-08', '2025-04-08', '11:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 9, 35, '2025-08-11 21:41:19', '2025-08-11 21:41:19'),
(134, 74, '2025-05-06', '2025-05-20', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 20, '2025-08-12 15:50:16', '2025-08-12 15:50:16'),
(135, 73, '2025-05-23', '2025-05-23', '11:00:00', '13:00:00', NULL, NULL, 0, NULL, 4, 10, 29, '2025-08-12 16:51:29', '2025-08-12 16:51:29'),
(136, 70, '2025-05-04', '2025-05-04', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 31, '2025-08-12 16:53:12', '2025-08-12 16:53:12'),
(137, 75, '2025-04-04', '2025-04-08', '11:00:00', '12:30:00', NULL, NULL, 0, NULL, 4, 10, 36, '2025-08-12 16:58:53', '2025-08-12 16:58:53'),
(138, 90, '2025-04-18', '2025-04-18', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 29, '2025-08-12 17:15:40', '2025-08-12 17:15:40'),
(139, 89, '2025-04-11', '2025-04-11', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 29, '2025-08-12 17:29:38', '2025-08-12 17:29:38'),
(140, 92, '2025-04-19', '2025-04-19', '13:00:00', '16:00:00', NULL, NULL, 0, NULL, 4, 10, 9, '2025-08-12 17:34:55', '2025-08-12 17:34:55'),
(141, 73, '2025-03-09', '2025-03-09', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 31, '2025-08-12 17:37:34', '2025-08-12 17:37:34'),
(142, 82, '2025-03-12', '2025-03-12', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 10, 37, '2025-08-12 17:42:46', '2025-08-12 17:42:46'),
(143, 71, '2025-03-07', '2025-03-21', '09:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 10, 29, '2025-08-12 17:50:04', '2025-08-12 17:50:04'),
(144, 70, '2025-03-22', '2025-03-22', '12:30:00', '14:30:00', NULL, NULL, 0, NULL, 4, 10, 26, '2025-08-12 18:09:17', '2025-08-12 18:09:17'),
(145, 92, '2025-02-19', '2025-02-19', '17:00:00', '18:30:00', NULL, NULL, 0, NULL, 4, 10, 31, '2025-08-12 18:12:03', '2025-08-12 18:12:03'),
(146, 90, '2025-02-23', '2025-02-23', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 31, '2025-08-12 18:13:38', '2025-08-12 18:13:38'),
(147, 89, '2025-02-16', '2025-02-16', '10:00:00', '13:00:00', NULL, NULL, 0, NULL, 4, 10, 31, '2025-08-12 18:15:04', '2025-08-12 18:15:04'),
(148, 82, '2025-02-23', '2025-02-23', '12:30:00', '15:00:00', NULL, NULL, 0, NULL, 4, 10, 39, '2025-08-12 18:19:34', '2025-08-12 18:19:34'),
(149, 80, '2025-02-22', '2025-02-22', '13:00:00', '15:00:00', NULL, NULL, 0, NULL, 4, 10, 26, '2025-08-12 18:25:12', '2025-08-12 18:25:12'),
(150, 79, '2025-02-22', '2025-02-22', '11:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 10, 26, '2025-08-12 18:26:57', '2025-08-12 18:26:57'),
(151, 92, '2025-04-12', '2025-04-12', '10:00:00', '12:00:00', NULL, NULL, 0, NULL, 4, 9, 34, '2025-08-12 18:32:12', '2025-08-12 18:32:12'),
(152, 70, '2025-09-08', '2025-09-30', '10:00:00', '11:00:00', NULL, NULL, 0, NULL, 1, 1, 2, '2025-09-08 22:09:29', '2025-09-08 22:09:29');

-- --------------------------------------------------------

--
-- Table structure for table `activity_files`
--

CREATE TABLE `activity_files` (
  `id` bigint UNSIGNED NOT NULL,
  `month` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `upload_date` timestamp NULL DEFAULT NULL,
  `activity_calendar_id` bigint UNSIGNED DEFAULT NULL,
  `activity_log_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `planned_metrics_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `activity_calendar_id` bigint UNSIGNED DEFAULT NULL,
  `beneficiary_registry_id` bigint UNSIGNED DEFAULT NULL,
  `activity_id` bigint UNSIGNED DEFAULT NULL,
  `population_value` int NOT NULL DEFAULT '0',
  `product_value` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `planned_metrics_id`, `created_by`, `created_at`, `updated_at`, `activity_calendar_id`, `beneficiary_registry_id`, `activity_id`, `population_value`, `product_value`) VALUES
(1, 13, 1, '2025-08-01 21:41:20', '2025-08-01 21:41:20', NULL, NULL, NULL, 0, NULL);

--
-- Triggers `activity_logs`
--
DELIMITER $$
CREATE TRIGGER `update_planned_metrics_after_delete` AFTER DELETE ON `activity_logs` FOR EACH ROW BEGIN
                IF OLD.activity_id IS NOT NULL THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(OLD.activity_id),
                        product_real_value = calculate_product_real_value(OLD.activity_id)
                    WHERE pm.id = OLD.activity_id;
                END IF;
            END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_planned_metrics_after_insert` AFTER INSERT ON `activity_logs` FOR EACH ROW BEGIN
                IF NEW.activity_id IS NOT NULL THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(NEW.activity_id),
                        product_real_value = calculate_product_real_value(NEW.activity_id)
                    WHERE pm.id = NEW.activity_id;
                END IF;
            END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_planned_metrics_after_update` AFTER UPDATE ON `activity_logs` FOR EACH ROW BEGIN
                -- Actualizar para el nuevo activity_id
                IF NEW.activity_id IS NOT NULL THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(NEW.activity_id),
                        product_real_value = calculate_product_real_value(NEW.activity_id)
                    WHERE pm.id = NEW.activity_id;
                END IF;

                -- Actualizar para el activity_id anterior si era diferente
                IF OLD.activity_id IS NOT NULL AND OLD.activity_id != NEW.activity_id THEN
                    UPDATE planned_metrics pm
                    SET
                        population_real_value = calculate_population_real_value(OLD.activity_id),
                        product_real_value = calculate_product_real_value(OLD.activity_id)
                    WHERE pm.id = OLD.activity_id;
                END IF;
            END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_population_value_on_insert` BEFORE INSERT ON `activity_logs` FOR EACH ROW BEGIN
                IF NEW.activity_calendar_id IS NOT NULL THEN
                    SET NEW.population_value = calculate_population_value(NEW.activity_calendar_id);
                END IF;
            END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_population_value_on_update` BEFORE UPDATE ON `activity_logs` FOR EACH ROW BEGIN
                IF NEW.activity_calendar_id != OLD.activity_calendar_id
                   OR (NEW.activity_calendar_id IS NOT NULL AND OLD.activity_calendar_id IS NULL) THEN
                    SET NEW.population_value = calculate_population_value(NEW.activity_calendar_id);
                END IF;
            END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `axes`
--

CREATE TABLE `axes` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `axes`
--

INSERT INTO `axes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Formación y fortalecimiento de agentes', '2025-07-18 17:40:28', '2025-07-18 17:40:28'),
(2, 'Desarrollo del sector social', '2025-07-18 17:40:36', '2025-07-18 17:40:36'),
(3, 'Participación ciudadana', '2025-07-18 17:40:50', '2025-07-18 17:40:50'),
(4, 'Generación y divulgación de conocimiento', '2025-07-18 17:41:03', '2025-07-18 17:41:03'),
(5, 'Fortalecimiento institucional, sostenibilidad e innovación', '2025-07-18 17:41:09', '2025-07-18 17:41:09');

-- --------------------------------------------------------

--
-- Table structure for table `beneficiaries`
--

CREATE TABLE `beneficiaries` (
  `id` bigint UNSIGNED NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_names` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('M','F','Male','Female') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `neighborhood` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_backup` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `beneficiaries`
--

INSERT INTO `beneficiaries` (`id`, `last_name`, `mother_last_name`, `first_names`, `birth_year`, `gender`, `phone`, `street`, `ext_number`, `neighborhood`, `address_backup`, `identifier`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 'Mascarro', 'Soto', 'Javier', '1996', 'M', '6562251304', 'Rivera de Manzanillo', '332', 'Riberas del Bravo', NULL, 'MSJX1996MAOA', 3, '2025-07-28 21:26:27', '2025-07-28 21:26:27'),
(3, 'Santana', 'Romero', 'Elvira', '1960', 'M', '6567748325', 'Rivera de Manzanillo', '327', 'Riberas del Bravo', NULL, 'SREX1960MAOL', 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(4, 'Rivero', 'Ruelas', 'José Armando', NULL, 'M', '6562160989', 'Rivera de Ixtapa', '335', 'Riberas del Bravo', NULL, 'RRJAMIUO', 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(5, 'Camargo ', 'Reyes ', 'Guadalupe', '1969', 'F', '6563479627', 'Rivera de Ixtapa', '316', 'Riberas del Bravo', NULL, 'CRGX1969FAEU', 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(6, 'Camargo', 'Reyes', 'Raquel', '1973', 'F', '6561035181', 'Rivera de Ixtapa', '316', 'Riveras del Bravo', NULL, 'CRRX1973FAEA', 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(7, 'García', 'Marcelo', 'Rony', '1999', 'M', '6563552541', 'Rivera de Urique', '2035', 'Riberas del Bravo', NULL, 'GMRX1999MAAO', 3, '2025-07-28 21:39:55', '2025-07-28 21:39:55'),
(8, 'Bretado', 'Flores', 'José', '1976', 'M', '6561765394', 'Rivera Peñasco', '2371', 'Riberas del Bravo', NULL, 'BFJX1976MRLO', 3, '2025-07-28 21:45:51', '2025-07-28 21:55:10'),
(9, 'Yepez', 'Gracía', 'Hilario', '1972', 'M', '6563197048', 'Rivera Peñasco', '2358', 'Riberas del Bravo', NULL, 'YGHX1972MERI', 3, '2025-07-28 21:45:51', '2025-07-28 21:54:05'),
(10, 'Vazquez', 'Tellez', 'Manuel', '2014', 'M', '656779556', 'Rivera Peñasco', NULL, 'Riberas del Bravo', NULL, 'VTMX2014MAEA', 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(11, 'Suarez', 'Tellez', 'Benito', '1970', 'M', NULL, 'Rivera Peñasco', '4079', 'Riberas del Bravo', NULL, 'STBX1970MUEE', 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(12, 'Medina', 'Lorenzo ', 'Delfino', '1999', 'M', '6564996567', 'Rivera Peñasco', '2345', 'Riberas del Bravo', NULL, 'MLDX1999MEOE', 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(13, 'Martinez', 'Francisco', 'José Luis', '1970', 'M', '656792259', 'Rivera Peñasco', '5223', 'Riberas del Bravo', NULL, 'MFJL1970MARO', 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(14, 'Luna', 'Castro', 'Guadalupe', '1947', 'M', '6565911711', 'Rivera Peñasco', NULL, 'Riberas del Bravo', NULL, 'LCGX1947MUAU', 3, '2025-07-28 22:03:40', '2025-07-28 22:03:40'),
(15, 'Bretado', 'Hernandez', 'Cruz', '1995', 'M', '6567715096', 'Rivera Peñasco', '2371', 'Riberas del Bravo', NULL, 'BHCX1995MRER', 3, '2025-07-28 22:48:02', '2025-07-28 22:48:02'),
(16, 'Bretado', 'Hernandez', 'José', '1976', 'M', '6561765343', 'Rivera Peñasco', '2371', 'Riberas del Bravo', NULL, 'BHJX1976MREO', 3, '2025-07-28 22:48:02', '2025-07-28 22:48:02'),
(17, 'Meraz', 'Suarez', 'Jesus', '1991', 'M', '6564737815', 'Rivera Peñasco', '2346', 'Riberas del Bravo', NULL, 'MSJX1991MEUE', 3, '2025-07-28 22:48:02', '2025-07-28 22:48:02'),
(18, 'Valero', 'Galvan', 'Juan', '1975', 'M', '6567952318', 'de Colima', '2366', 'Riberas del Bravo', NULL, 'VGJX1975MAAU', 3, '2025-07-28 22:48:03', '2025-07-28 22:48:03'),
(19, 'Hernandez', 'Rosario', 'Jenny', '2001', 'F', '6567109075', 'Rivera de Chetumal', '431', 'Riberas del Bravo', NULL, 'HRJX2001FEOE', 3, '2025-07-28 22:48:03', '2025-07-28 22:48:03'),
(20, 'Poxtan', 'Tecan', 'Herendida', '1995', 'F', '6561203589', 'Rivera de Urique', '2238', 'Riberas del Bravo', NULL, 'PTHX1995FOEE', 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(21, NULL, 'Salas', 'Josefina', '1961', 'F', NULL, 'Rivera de Urique', '2242', 'Riberas del Bravo', NULL, 'SJX1961FXAO', 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(22, 'Lozoya', 'Rodriguez', 'Jhoana', '1993', 'F', '8712300446', 'Rivera de Urique', '2240', 'Riberas del Bravo', NULL, 'LRJX1993FOOH', 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(23, 'Villanueva', 'Lozoya', 'Iker Janik', '2015', 'M', NULL, 'Rivera de Urique', '2240', 'Riberas del Bravo', NULL, 'VLIJ2015MIOK', 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(24, 'Villanueva', 'Lozoya', 'Mateo', '2014', 'M', NULL, 'Rivera de Urique', '2240', 'Riberas del Bravo', NULL, 'VLMX2014MIOA', 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(25, 'Aguilar', 'Rodriguez', 'Guadalupe', '1971', 'F', '6563013163', 'Rivera de Urique', '2260', 'Riberas del Bravo', NULL, 'ARGX1971FGOU', 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(26, 'Dueñes', 'Mena', 'José Luis', '1974', 'M', '6567915278', 'Rivera de Urique', '2226', 'Riberas del Bravo', NULL, 'DMJL1974MUEO', 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(27, 'Reyes', 'Favela', 'Patricia', '1978', 'F', '6567971068', 'Rivera de Urique', '2226', 'Riberas del Bravo', NULL, 'RFPX1978FEAA', 3, '2025-07-28 23:01:53', '2025-07-28 23:01:53'),
(28, 'Ens', 'Sheraida', 'Isac', '1954', 'M', NULL, 'Rivera de Urique', '2244', 'Riberas del Bravo', NULL, 'ESIX1954MNHS', 3, '2025-07-28 23:04:28', '2025-07-28 23:04:28'),
(29, 'Esquivel', 'Alvarado', 'Danna Paola', '2006', 'F', NULL, 'Riveras del Rosario', '421', 'Riberas del Bravo', NULL, 'EADP2006FSLA', 3, '2025-07-29 19:11:18', '2025-07-29 19:11:18'),
(30, 'Esquivel', 'Alvarado', 'Danna Paola', '2006', 'M', NULL, 'Ribera de Rosarito', '421', 'Riberas del Bravo', NULL, 'EADP2006MSLA', 4, '2025-07-30 15:52:26', '2025-07-30 15:52:26'),
(31, 'Diaz ', 'Ramirez', 'Natalia Harel ', '2008', 'F', NULL, 'Riberas de Otero', '421', 'Riberas del Bravo', NULL, 'DRNH2008FIAA', 4, '2025-07-30 16:07:04', '2025-07-30 16:07:04'),
(32, 'Barrera ', 'Villalpando', 'Kevin Alonso', '2008', 'M', NULL, 'Rivera de Palomo', '1845', 'Riberas del Bravo', NULL, 'BVKA2008MAIE', 4, '2025-07-30 16:08:45', '2025-07-30 16:08:45'),
(33, 'Camacho ', 'De la Cruz ', 'Carlos Enrique', '2008', 'M', NULL, 'Riberas del Nilo', NULL, 'Riberas del Bravo', NULL, 'CDCE2008MAEA', 4, '2025-07-30 16:12:16', '2025-07-30 16:12:16'),
(34, 'Hernandez', 'Pedroza', 'Luis Enrique', '2009', 'M', NULL, 'Ribera de las Perlas ', NULL, 'Riberas del Bravo', NULL, 'HPLE2009MEEU', 4, '2025-07-30 16:17:42', '2025-07-30 16:17:42'),
(35, 'Aguirre', 'Hernandez ', 'Yolanda ', '2005', 'F', NULL, 'Ribera del Aguila ', '248', 'Riberas del Bravo', NULL, 'AHY2005FGEO', 4, '2025-07-30 16:19:13', '2025-07-30 16:19:13'),
(36, 'Hernandez ', 'Montañez', 'Naomi Ale', '2007', 'F', NULL, 'Riberas del Rio', '927', NULL, NULL, 'HMNA2007FEOA', 4, '2025-07-30 16:21:05', '2025-07-30 16:21:05'),
(37, 'Catana', 'Peralta ', 'Melanie', '2008', 'F', NULL, 'Riberas de Rosarito', '437', 'Riberas del Bravo', NULL, 'CPMX2008FAEE', 4, '2025-07-30 16:54:52', '2025-07-30 16:56:42'),
(38, 'Morales', 'Celis', 'Armando', '2008', 'M', NULL, 'Ribera de las Palmas ', '353', 'Riberas del Bravo', NULL, 'MCAX2008MOER', 4, '2025-07-30 16:56:17', '2025-07-30 16:56:17'),
(39, 'Rocha', 'Candelario', 'Jazmin', '2007', 'F', NULL, 'Riberas de la Pradera', '2703', 'Riberas del Bravo', NULL, 'RCJX2007FOAA', 4, '2025-07-30 16:58:39', '2025-07-30 16:58:39'),
(40, 'Cruz ', 'Hernandez', 'Estrella', '2007', 'F', NULL, 'Riberas de Arenal', '1909', 'Riberas del Bravo', NULL, 'CHEX2007FRES', 4, '2025-07-30 17:05:01', '2025-07-30 17:05:01'),
(41, 'Zuñiga ', 'Jimenez ', 'Antonio', '2008', 'M', NULL, 'Ribera de Urique', '2032', 'Riberas del Bravo', NULL, 'ZJAX2008MUIN', 4, '2025-07-30 17:06:28', '2025-07-30 17:06:28'),
(42, 'Serafino', 'Prieto', 'Jose', '2008', 'M', NULL, 'Riberas del Galeon', '607', 'Riberas del Bravo', NULL, 'SPJX2008MERO', 4, '2025-07-30 17:08:06', '2025-07-30 17:08:06'),
(43, 'Altamirano ', 'Torres', 'Jesus Fernando', '2008', 'M', NULL, NULL, '502', 'Parajes del Sur', NULL, 'ATJF2008MLOE', 4, '2025-07-30 17:13:55', '2025-07-30 17:13:55'),
(44, 'Palacios ', 'Tugie', 'Luis David', '2008', 'M', NULL, 'Riberas de Cunon', '412', 'Riberas del Bravo', NULL, 'PTLD2008MAUU', 4, '2025-07-30 17:22:40', '2025-07-30 17:22:40'),
(45, 'Calderon ', 'Sanchez', 'Brian', '2008', 'M', NULL, NULL, NULL, 'Riberas del Bravo', NULL, 'CSBX2008MAAR', 4, '2025-07-30 17:24:20', '2025-07-30 17:24:20'),
(46, 'Niño', 'Valles', 'Mario Alberto', '2008', 'M', NULL, NULL, NULL, 'Riberas del Bravo', NULL, 'NVMA2008MIAA', 4, '2025-07-30 17:25:09', '2025-07-30 17:25:09'),
(47, 'Medina', 'Macias', 'Jose Manuel', '2000', 'M', NULL, NULL, NULL, 'Riberas del Bravo', NULL, 'MMJM2000MEAO', 4, '2025-07-30 17:26:42', '2025-07-30 17:26:42'),
(48, 'Herrera ', 'Zamora', 'Gabriela', '2008', 'F', NULL, 'Ribera del Vergel', '412', 'Riberas del Bravo', NULL, 'HZGX2008FEAA', 4, '2025-07-30 17:27:52', '2025-07-30 17:27:52'),
(49, NULL, 'Varelas', 'Ma Elia', '1960', 'F', '6566345157', 'Riberas del Portal', '655', 'Riveras del Bravo ', NULL, 'VME1960FXAA', 4, '2025-07-30 17:39:28', '2025-07-30 18:33:48'),
(50, 'Gonzalez ', 'Carrera', 'Guadalupe', '1979', 'F', '6565281011', 'Ribera de Ixtapa', NULL, 'Riberas del Bravo ', NULL, 'GCGX1979FOAU', 4, '2025-07-30 17:39:28', '2025-07-30 18:34:02'),
(51, 'Montes ', 'Ortiz', 'Beatriz ', '1979', 'F', '6563133218', 'Ribera de Peñasco', '2351', 'Riberas del Bravo', NULL, 'MOB1979FORE', 4, '2025-07-30 17:49:39', '2025-07-30 17:49:39'),
(52, 'Aguayo', 'Muñoz', 'Alma Isabel', '1995', 'F', '6566576801', 'Riberas del Mezquite', '2610', 'Riberas del Bravo ', NULL, 'AMAI1995FGUL', 4, '2025-07-30 17:49:39', '2025-07-30 18:34:28'),
(53, 'Aguilar', 'Salazar', 'Cosmelia', '1975', 'F', NULL, 'Riberas de Galeon', '260837', 'Riberas del Bravo ', NULL, 'ASCX1975FGAO', 4, '2025-07-30 17:49:39', '2025-07-30 18:34:39'),
(54, 'Rosales', 'Nava', 'Monica', '2000', 'F', '6563720817', 'Riberas del Carizo', '26114', 'Riberas del Bravo ', NULL, 'RNMX2000FOAO', 4, '2025-07-30 17:52:20', '2025-07-30 18:34:51'),
(55, 'Alvarez', 'Aquino', 'Adriana', '1991', 'F', '6562851860', 'Ribera de Urique', '2050', 'Riberas del Bravo ', NULL, 'AAAX1991FLQD', 4, '2025-07-30 18:05:33', '2025-07-30 18:35:02'),
(56, 'Marquez ', 'Ortiz', 'Carlos', '1971', 'M', '6568646853', 'Siglo XX', '2016', 'Riberas del Bravo ', NULL, 'MOCX1971MARA', 4, '2025-07-30 18:05:33', '2025-07-30 18:35:13'),
(57, 'Holguin ', 'Perez', 'Jesus', '1984', 'M', '6565211010', 'Ribera de Ixtapa ', '344', 'Riberas del Bravo ', NULL, 'HPJX1984MOEE', 4, '2025-07-30 18:09:19', '2025-07-30 18:35:43'),
(58, 'Hidalgo ', 'Cano', 'Maria del Rosario', '1980', 'F', '6564501805', 'Ribera del Carrizo', '2611-6', 'Riberas del Bravo ', NULL, 'HCMD1980FIAA', 4, '2025-07-30 18:25:30', '2025-07-30 18:36:17'),
(59, 'Martinez', 'Armas', 'Guadalupe', '1999', 'F', '9221119792', 'Ribera de Mezquite ', '2610-15', 'Riberas del Bravo ', NULL, 'MAGX1999FARU', 4, '2025-07-30 18:25:30', '2025-07-30 18:25:30'),
(60, 'Venancio', 'Martinez ', 'Yetziel', NULL, 'F', '9221119792', 'Ribera del Mezquite', NULL, 'Riberas del Bravo', NULL, 'VMYXFEAE', 4, '2025-07-30 18:33:16', '2025-07-30 18:33:16'),
(61, 'Belmonte', 'Almeida ', 'Rocio', '1967', 'F', '6562039212', 'Rincon del Rio Conchos', '2007', 'Rincones del Rio', NULL, 'BARX1967FELO', 4, '2025-07-30 18:50:49', '2025-07-30 18:50:49'),
(62, 'Martinez', 'Davila', 'Corina', '1962', 'F', '6561778170', 'Rincon del Rio Conchos', '2009', 'Rincones del Rio', NULL, 'MDCX1962FAAO', 4, '2025-07-30 18:50:49', '2025-07-30 18:50:49'),
(63, 'Valencia ', 'Ortiz', 'Maria', '1985', 'F', '6571929451', 'Rincon de Rio Verde', '228', 'Rincones del Rio', NULL, 'VOMX1985FARA', 4, '2025-07-30 18:55:20', '2025-07-30 18:55:20'),
(64, 'Holguin', 'Gonzalez', 'Ethan', '2008', 'M', NULL, 'Ribera de Peñasco', NULL, 'Riberas del Bravo', NULL, 'HGEX2008MOOT', 4, '2025-07-30 19:02:19', '2025-07-30 19:02:19'),
(65, 'Holguin', 'Gonzalez', 'Jesus', '2009', 'M', '6147545161', 'Ribera de Peñasco', '344', 'Riberas del Bravo', NULL, 'HGJX2009MOOE', 4, '2025-07-30 19:02:19', '2025-07-30 19:02:19'),
(66, 'Parra', 'Perez', 'Abel', '1962', 'M', '656181086', 'Ribera de Vallarta', '358', 'Riberas del Bravo', NULL, 'PPAX1962MAEB', 4, '2025-07-30 19:02:19', '2025-07-30 19:02:19'),
(67, 'Rivero', 'Ruelas', 'José Armando', '2006', 'M', '6562160989', 'Rivera de Ixtapa', '335', 'Riberas del Bravo', NULL, 'RRJA2006MIUO', 4, '2025-07-30 19:06:43', '2025-07-30 19:06:43'),
(68, NULL, 'Vazquez', 'Maria Soledad', NULL, 'F', '6562229775', 'Rio Conchos ', '2003', 'Riberas del Bravo', NULL, 'VMSFXAA', 4, '2025-07-30 19:06:43', '2025-07-30 19:06:43'),
(69, 'Avendaño', 'Vazquez', 'Martha', '1992', 'F', '6568501367', 'Ribera de Galeon', '260838', 'Riberas del Bravo', NULL, 'AVMX1992FVAA', 4, '2025-07-30 20:44:55', '2025-07-30 20:44:55'),
(70, 'Giner ', 'Meraz', 'Sandra', '1981', 'F', '6566677566', 'Ribera de Carrizo', NULL, 'Riberas del Bravo', NULL, 'GMSX1981FIEA', 4, '2025-07-30 20:47:18', '2025-07-30 20:47:18'),
(71, 'Arceo', 'Tadeo', 'Juan', '1994', 'M', '6563537811', 'Ribera de Mezquite', '2610', 'Riberas del Bravo', NULL, 'ATJX1994MRAU', 4, '2025-07-30 20:54:55', '2025-07-30 20:54:55'),
(72, 'Parra', 'Parra', 'Lucia', '1976', 'F', '6568201782', 'Ribera del Carrizo', '26112', 'Riberas del Bravo', NULL, 'PPLX1976FAAU', 4, '2025-07-30 20:56:53', '2025-07-30 20:57:12'),
(73, 'Vazquez', 'Muñoz', 'Gabriel Ismael', '1999', 'M', '656829782', 'Ribera del Carrizo', NULL, 'Riberas del Bravo', NULL, 'VMGI1999MAUA', 4, '2025-07-30 21:02:24', '2025-07-30 21:02:24'),
(74, 'Acosta ', 'Magaña ', 'Brenda Ivon', '1999', 'F', '6567666191', 'Ribera del Carrizo', NULL, 'Riberas del Bravo', NULL, 'AMBI1999FCAR', 4, '2025-07-30 21:02:24', '2025-07-30 21:02:24'),
(75, 'Venancio', 'Martinez ', 'Yetziel', '2013', 'F', '9221119792', 'Ribera del Mezquite', NULL, 'Riberas del Bravo', NULL, 'VMYX2013FEAE', 4, '2025-07-30 21:12:03', '2025-07-30 21:12:03'),
(76, 'Joaquin', 'Vazquez', 'Alejandra', '2012', 'F', '6563096592', 'Rincon del Rio conchos', '2003', 'Riberas del Bravo', NULL, 'JVAX2012FOAL', 4, '2025-07-30 21:15:41', '2025-07-30 21:15:57'),
(77, 'Nataren', 'Martinez', 'Rene', '1986', 'M', '6568426926', 'Manzanillo', '337', 'Riberas del Bravo', NULL, 'NMRX1986MAAE', 4, '2025-07-30 21:24:32', '2025-07-30 21:24:32'),
(78, 'Mendoza', 'Rosalina', 'Juan', '1974', 'M', '6567611680', 'Ribera de Manzanillo', '331', 'Riberas del Bravo', NULL, 'MRJX1974MEOU', 4, '2025-07-30 21:24:32', '2025-07-30 21:24:32'),
(79, 'Moreno', 'Catañeda', 'Maria del Carmen ', '1966', 'F', '6563768076', 'Riberas de Parral', '2178', 'Riberas del Bravo', NULL, 'MCMD1966FOAA', 4, '2025-07-30 21:45:24', '2025-07-30 21:45:24'),
(80, 'Velazquez', 'Martinez', 'Maria Micaela', '1977', 'F', '6561122195', 'Ribera de Peñasco', '358', 'Riberas del Bravo', NULL, 'VMMM1977FEAA', 4, '2025-07-30 21:45:24', '2025-07-30 21:45:24'),
(81, 'Gonzalez', 'Patrana', 'Luis Alejandro', '1995', 'M', NULL, NULL, NULL, 'Riberas del Bravo', NULL, 'GPLA1995MOAU', 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(82, 'Castro', 'Vidaña', 'Edgar Alejandro', '2003', 'M', NULL, 'Riberas de Zampoala', '311', 'Riberas del Bravo', NULL, 'CVEA2003MAID', 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(83, 'Flores ', 'Esquivel', 'Esperanza', '1996', 'F', NULL, 'Riberas del Carmen ', '326-7', 'Riberas del Bravo', NULL, 'FEEX1996FLSS', 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(84, 'Ramirez', 'Bernal', 'Ivonne', '1984', 'F', '6566700620', 'Riberas de Plata', '2169', 'Riberas del Bravo', NULL, 'RBIX1984FAEV', 4, '2025-07-31 15:57:57', '2025-07-31 15:57:57'),
(85, 'Valles ', 'Estrada', 'Gloria ', '1978', 'F', '6562494767', 'Ribera de Ixtapa', '2169', 'Riberas del Bravo', NULL, 'VEG1978FASL', 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(86, 'Castañeda', 'Valles', 'Jesus Miguel', '2001', 'F', '6564300075', 'Ribera de Ixtapa', '356', 'Riberas del Bravo', NULL, 'CVJM2001FAAE', 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(87, 'Ramirez', 'Catañeda', 'Juantonio', '1978', 'M', '6564539600', 'Ribera de Ixtapa', '356', 'Riberas del Bravo', NULL, 'RCJX1978MAAU', 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(88, 'Gomez', 'Santiz', 'Elena', '1983', 'F', '6563501637', 'Ribera de Manzanillo', '337', 'Riberas del Bravo', NULL, 'GSEX1983FOAL', 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(89, 'Vazquez', 'Mendoza', 'Gloria', '1982', 'F', '6567688062', 'Rincon del Rio ', '1955', 'Riberas del Bravo', NULL, 'VMGX1982FAEL', 4, '2025-07-31 16:23:00', '2025-07-31 16:23:00'),
(90, 'Ramos', 'Ramos', 'Jesus', '1976', 'M', '6568582020', 'Ribera de Ixtapa', '333', 'Riberas del Bravo', NULL, 'RRJX1976MAAE', 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(91, 'Lozano', 'Soto', 'Ctalina', '1952', 'F', '6563088843', 'Ribera de Vallarta', '351', 'Riberas del Bravo', NULL, 'LSCX1952FOOT', 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(92, 'Vazquez ', 'Reyes', 'Maria Soledad', '1975', 'F', '6562229795', 'Rincon del Rio', '2003', 'Riberas del Bravo', NULL, 'VRMS1975FAEA', 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(93, 'Garcia', 'Islas', 'Leonor', '1994', 'F', '6566621309', 'Ribera de Ixtapa', '329', 'Riberas del Bravo', NULL, 'GILX1994FASE', 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(94, 'Silva', 'Mireles', 'Jose', NULL, 'M', '6563588225', 'Ribera de Ixtapa', '352', 'Riberas del Bravo', NULL, 'SMJXMIIO', 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(95, 'Medina', 'Hernandez', 'Angelica', NULL, 'F', '6561319489', 'Ribera de Ixtapa', '442', 'Riberas del Bravo', NULL, 'MHAXFEEN', 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(96, 'Segovia', 'Romero', 'Martha', NULL, 'F', '6566093402', 'Ribera de Ixtapa', '442', 'Riberas del Bravo', NULL, 'SRMXFEOA', 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(97, 'Medina', 'Hernandez', 'Dulce Milema', NULL, 'F', '6561522976', 'Ribera de Ixtapa', '442', 'Riberas del Bravo', NULL, 'MHDMFEEU', 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(98, 'Luna', 'Gallegos', 'Delfino', '1953', 'M', NULL, 'Ribera de la Hoya', NULL, 'Riberas del Bravo', NULL, 'LGDX1953MUAE', 4, '2025-08-01 16:05:06', '2025-08-01 16:05:06'),
(99, 'Peña', 'Vazquez', 'Fabiola', '1995', 'F', NULL, NULL, NULL, NULL, NULL, 'PVFX1995FEAA', 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(100, 'Vazquez', 'Reyes', 'Soledad', '1975', 'F', '6562229775', 'Rio Conchos', '2003', 'Riberas del Bravo', NULL, 'VRSX1975FAEO', 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(101, 'Joaquin', 'Vazquez', 'Diana', '2013', 'F', '6563096597', 'Rio Conchos', '2003', 'Riberas del Bravo', NULL, 'JVDX2013FOAI', 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(102, 'Saucedo', 'Ibarra', 'Misael', '2009', 'M', '6563083881', 'Ribera de Peñasco', '2373', 'Riberas del Bravo', NULL, 'SIMX2009MABI', 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(103, 'Garcia', 'Bretado', 'Ian Jaciel ', '2012', 'M', '6567500327', NULL, NULL, 'Riberas del Bravo', NULL, 'GBIJ2012MARA', 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(104, 'Saldaña', 'Almaguer', 'Axel Antonio', '2014', 'M', NULL, 'Ribera de Peñasco', '429', 'Riberas del Bravo', NULL, 'SAAA2014MALX', 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(105, NULL, 'Hidalgo', 'Dulce', '1998', 'F', '6561764752', 'Riberas de la Silla', '2611-7', 'Riberas del Bravo', NULL, 'HDX1998FXIU', 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(106, 'Rosales ', 'Nava', 'Lucero Monica', '2000', 'F', '6563720827', 'Ribera del Carrizo', '2611-4', 'Riberas del Bravo', NULL, 'RNLM2000FOAU', 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(107, 'Martinez', 'Armes', 'Guadalupe', NULL, 'F', '6561180863', 'Ribera del Mezquite', '2610-5', 'Riberas del Bravo', NULL, 'MAGXFARU', 4, '2025-08-01 17:43:24', '2025-08-01 17:43:24'),
(108, 'Zapata', 'Patraca', 'Angela Guadalupe', '2006', 'F', '6567631797', 'Riberas del Lago', '410', 'Riberas del Bravo', NULL, 'ZPAG2006FAAN', 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(109, 'Martinez', 'Ruiz', 'Saul', '1967', 'M', '6566570905', 'Del Valle 1', 'SN', 'Hacienda Torres Universidad', NULL, 'MRSX1967MAUA', 10, '2025-08-01 21:30:36', '2025-08-01 21:30:36'),
(110, 'Victoriano', 'Maya', 'Wendy Nayeli', '2000', 'F', NULL, NULL, NULL, NULL, NULL, 'VMWN2000FIAE', 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(111, 'Morales', 'Esparza', 'Josue', '1987', 'M', '6567804275', 'Rio Conchos', '2007', 'Riberas del Bravo', NULL, 'MEJX1987MOSO', 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(112, 'Cabrales', 'Gamboa', 'Perla Armida', NULL, 'F', '6563179434', 'Rincon rio verde', '232', 'Riberas del Bravo', NULL, 'CGPAFAAE', 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(113, 'Torres', 'Esquivel', 'Esperanza', '1964', 'F', NULL, 'Rincon del Rio', NULL, 'Riberas del Bravo', NULL, 'TEEX1964FOSS', 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(114, 'Cortinas', 'Padilla', 'Maria', '1975', 'F', '6562626268', 'Ribera de Ixtapa', '333', 'Riberas del Bravo', NULL, 'CPMX1975FOAA', 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(115, 'Alvarado', 'Dominguez', 'Ivonne Giselee', '2001', 'F', NULL, 'Ribera de Zempoala', '2000', 'Riberas del Bravo', NULL, 'ADIG2001FLOV', 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(116, 'Hernandez', 'Vazquez', 'Lidia', '1964', 'F', '6564903351', 'Ribera de Zempoala', NULL, 'Riberas del Bravo', NULL, 'HVLX1964FEAI', 4, '2025-08-01 23:01:47', '2025-08-01 23:01:47'),
(117, 'Navarrete', 'Pioquido', 'Julian', '1986', 'M', '6561364220', 'Ribera', '2218', 'Riberas del Bravo', NULL, 'NPJX1986MAIU', 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(118, 'Dueñas', 'Mena', 'Jose Luis', '1984', 'M', '6567973278', 'Ribera de Urique', '2226', 'Riberas del Bravo', NULL, 'DMJL1984MUEO', 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(119, 'Vazquez', 'Xala', 'Javier', '1984', 'M', '6564305373', 'Ribera de Urique', '2208', 'Riberas del Bravo', NULL, 'VXJX1984MAAA', 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(120, 'Santos', 'Oordoñez', 'Martin', '1977', 'M', '6563291508', 'Ribera de Urique', '2212', 'Riberas del Bravo', NULL, 'SOMX1977MAOA', 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(121, 'Ortiz', 'Juarez', 'Virginia', '1978', 'F', NULL, 'Ribera de Boycona', '443', 'Riberas del Bravo', NULL, 'OJVX1978FRUI', 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(122, 'Bretado', 'Hernandez', 'Musio', '1960', 'M', '6563466775', 'Privada Praderas', '1219', 'Riberas del Bravo', NULL, 'BHMX1960MREU', 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(123, 'Mendez', 'Mendez', 'Magdalena', '1977', 'F', '6563137311', 'Ribera de Peñasco', NULL, 'Riberas del Bravo', NULL, 'MMMX1977FEEA', 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(124, 'Ramales ', 'Pioquinto', 'Evelia', '1980', 'F', '6565847540', 'Ribera de la Plata', '2167', 'Riberas del Bravo', NULL, 'RPEX1980FAIV', 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(125, 'Felix', 'Feria', 'Jose Trinidad', '1973', 'M', NULL, 'Ribera de Peñasco', '2351', 'Riberas del Bravo', NULL, 'FFJT1973MEEO', 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(126, 'Olivas', 'Garcia', 'Norma', '1973', 'F', NULL, 'Ribera de Peñasco', NULL, 'Riberas del Bravo', NULL, 'OGNX1973FLAO', 4, '2025-08-05 22:17:26', '2025-08-05 22:17:26'),
(127, 'Ramon', 'Vazquez', 'Cirila', '1961', 'F', NULL, 'Ribera de Urique', '222', 'Riberas del Bravo', NULL, 'RVCX1961FAAI', 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(128, 'Villanueva', 'Gonzalez', 'Mauro', '1992', 'M', '6563487551', 'Ribera de Urique', '2240', 'Riberas del Bravo', NULL, 'VGMX1992MIOA', 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(129, 'Lara', 'Salas', 'Alexa', '2007', 'F', NULL, 'Ribera de Urique', '2007', 'Riberas del Bravo', NULL, 'LSAX2007FAAL', 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(130, 'Montoya', 'Carrera', 'Raul', '1960', 'M', '8715253650', 'Ribera de Hoya', NULL, 'Riberas del Bravo', NULL, 'MCRX1960MOAA', 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(131, 'Saldaña ', NULL, 'Jeronimo', '1986', 'M', NULL, 'Ribera de Peñasco', '2356', 'Riberas del Bravo', NULL, 'SJX1986MAXE', 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(132, 'Velez', 'Jaramillo', 'Sofia', '2013', 'F', NULL, 'Riberas del Carmen', NULL, 'Riberas del Bravo', NULL, 'VJSX2013FEAO', 4, '2025-08-06 16:09:38', '2025-08-06 16:09:38'),
(133, 'Vazquez', 'Espinosa', 'Carolina', '2013', 'F', NULL, 'Rincon de Rio Conchos', NULL, 'Riberas del Bravo', NULL, 'VECX2013FASA', 4, '2025-08-06 16:28:58', '2025-08-06 16:28:58'),
(134, 'Argueyo', 'Osorio', 'Victor', '2016', 'M', NULL, 'Abulon', '2212', 'Riberas del Bravo', NULL, 'AOVX2016MRSI', 4, '2025-08-06 16:28:58', '2025-08-06 16:28:58'),
(135, 'Viramontes', 'Huerta', 'Jesus', '2009', 'M', '4671023875', 'Ribera de Tabares', NULL, 'Riberas del Bravo', NULL, 'VHJX2009MIUE', 4, '2025-08-06 16:28:58', '2025-08-06 16:28:58'),
(136, 'Floriano', 'Ramirez', 'Carmelo', '1982', 'M', '6565294126', 'Rincon del Rio ', '1955', 'Riberas del Bravo', NULL, 'FRCX1982MLAA', 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(137, 'De Jesus', 'Garcia', 'Adolfo', '1965', 'M', '6565512908', 'Ribera de plata', '2165', 'Riberas del Bravo', NULL, 'DGAX1965MEAD', 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(138, 'Flores ', 'Mata', 'Rosalinda', '2009', 'F', NULL, NULL, NULL, NULL, NULL, 'FMRX2009FLAO', 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(139, 'Gutierrez', 'Avila', 'Marisol', '1987', 'F', '6564271611', 'Ribera de Peñasco', '2375', 'Riberas del Bravo', NULL, 'GAMX1987FUVA', 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(140, 'Vazquez ', 'Lerma', 'Manuel', '1991', 'M', '6181465158', 'Ribera de Peñasco', NULL, 'Riberas del  Bravo', NULL, 'VLMX1991MAEA', 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(141, 'Bretado', 'Hernandez', 'Geronimo', '1963', 'M', '6563395296', 'Ribera de Peñasco', '2371', 'Riberas del Bravo', NULL, 'BHGX1963MREE', 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(142, 'Bretado', 'Flores', 'Yaresly', '2001', 'F', '6562643323', 'Ribera de Peñasco', '2371', 'Riberas del Bravo', NULL, 'BFYX2001FRLA', 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(143, 'Bretado', 'Guzman', 'Abraham', '2016', 'M', NULL, 'Ribera de Peñasco ', '2371', 'Riberas del Bravo', NULL, 'BGAX2016MRUB', 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(144, 'Bretado', 'Guerrero', 'Rosa Elia', '1987', 'F', NULL, 'Ribera de Peñasco ', '2356', 'Riberas del Bravo', NULL, 'BGRE1987FRUO', 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(145, 'Argullo ', 'Saucedo', 'Victor', '1999', 'M', '6563637517', 'Abulon', '2212', 'Riberas del Bravo', NULL, 'ASVX1999MRAI', 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(146, 'Jaramillo', 'Flores', 'Carolina', '1994', 'F', '4931486214', 'Riberas del Carmen', '326', 'Riberas del Bravo', NULL, 'JFCX1994FALA', 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(147, 'Peña', 'Perez', 'Belem', '1988', 'F', NULL, 'Ribera de Ensenada', '448', 'Riberas del Bravo', NULL, 'PPBX1988FEEE', 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(148, 'Ramales', 'Pioquinto', 'Evelia', NULL, 'F', '6741061342', 'Ribera de Plata', '2167', 'Riberas del Bravo', NULL, 'RPEXFAIV', 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(149, 'Portugal', 'Ramales', 'Guadalupe', '2006', 'F', '6565897540', 'Ribera de Plata', '2167', 'Riberas del Bravo', NULL, 'PRGX2006FOAU', 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(150, 'Ordoñez', NULL, 'Miguel Julian', '1977', 'M', '6572199941', 'Ribera de Ixtapa', '450', 'Riberas del Bravo', NULL, 'OMJ1977MRXI', 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(151, 'Ramirez', 'Madeo', 'Clara', '2012', 'F', '6566516516', 'Ribera de Peñasco', NULL, 'Riberas del Bravo', NULL, 'RMCX2012FAAL', 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(152, 'Mena', 'Lerma', 'Alma', '1993', 'F', '6183709201', 'Ribera de Peñasco', NULL, 'Riberas del Bravo', NULL, 'MLAX1993FEEL', 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(153, 'Berdin', 'Lerma', 'Bernardina', '1974', 'F', '6561046243', 'Ribera de Peñasco', NULL, 'Riberas del Bravo', NULL, 'BLBX1974FEEE', 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(154, 'Vazquez', 'Telles', 'Tania', '2009', 'F', '6567779569', 'Ribera de Peñasco', NULL, 'Riberas del Bravo', NULL, 'VTTX2009FAEA', 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(155, 'Armijo', 'Hernandez', 'Hugo Tomas', '1992', 'M', '6565334350', 'Ribera de Peñasco', '427', 'Riberas del Bravo', NULL, 'AHHT1992MREU', 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(156, 'Barrera', NULL, 'Socorro', '1967', 'F', '6563066128', 'Ribera de Vallarta', '353', 'Riberas del Bravo', NULL, 'BSX1967FAXO', 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(157, 'Lozano', 'Soto', 'Catalina', '1952', 'F', '6563088843', 'Ribera de Vallarta', '351', 'Riberas del Bravo', NULL, 'LSCX1952FOOA', 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(158, 'Cruz', 'Lopez', 'Esther', '1959', 'F', '6567735462', NULL, NULL, 'Riberas del Bravo', NULL, 'CLEX1959FROS', 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(159, 'Martinez', 'Reyez', 'Edmali', '1988', 'F', '9532302300', 'Rincon del Rio', NULL, 'Riberas del Bravo', NULL, 'MREX1988FAED', 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(160, 'Gonzalez', 'Gonzalez', 'Minerva', '1957', 'F', '6562005473', 'Ribera de Chetumal', '2232', 'Riberas del Bravo', NULL, 'GGMX1957FOOI', 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(161, 'Nava', 'Monivez', 'Aide', '1949', 'F', '6441067299', 'Ribera de Chetumal', NULL, 'Riberas del Bravo', NULL, 'NMAX1949FAOI', 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(162, 'Salazar', 'Garcia', 'Graciela', '1969', 'F', '6561568511', 'Ribera de chetumal ', '323', 'Riberas del Bravo', NULL, 'SGGX1969FAAR', 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(163, 'Hernandez', 'Lau', 'Joselyn', '2001', 'F', '6561865380', 'Ribera de Parral', '2162', 'Riberas del Bravo', NULL, 'HLJX2001FEAO', 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(164, 'Lau', 'Pastrana', 'Esther', '1963', 'F', '6563997753', 'Ribera del Parral', '2162', 'Riberas del Bravo', NULL, 'LPEX1963FAAS', 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(165, 'Morena', 'Ortiz', 'Alba', '1962', 'F', '92319818', 'Ribera de Ensenada', NULL, 'Riberas del Bravo', NULL, 'MOAX1962FORL', 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(166, 'Montes', 'Ortiz', 'Hilda', '1980', 'F', '6567555275', 'Ribera de Ixtapa', NULL, 'Riberas del Bravo', NULL, 'MOHX1980FORI', 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(167, 'Sanchez ', 'De la Cruz', 'Carmelino', '1953', 'M', '6562029660', 'Ribera de Ixtapa', NULL, 'Riberas del Bravo', NULL, 'SDCX1953MAEA', 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(168, 'Villela', 'Nuñez', 'Victor', '1948', 'M', NULL, 'Ribera de Ixtapa', '247', 'Riberas del Bravo', NULL, 'VNVX1948MIUI', 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36');

-- --------------------------------------------------------

--
-- Table structure for table `beneficiary_registries`
--

CREATE TABLE `beneficiary_registries` (
  `id` bigint UNSIGNED NOT NULL,
  `activity_calendar_id` bigint UNSIGNED NOT NULL,
  `beneficiaries_id` bigint UNSIGNED NOT NULL,
  `data_collectors_id` bigint UNSIGNED NOT NULL,
  `signature` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `beneficiary_registries`
--

INSERT INTO `beneficiary_registries` (`id`, `activity_calendar_id`, `beneficiaries_id`, `data_collectors_id`, `signature`, `created_by`, `created_at`, `updated_at`) VALUES
(2, 3, 2, 3, NULL, 3, '2025-07-28 21:26:27', '2025-07-28 21:26:27'),
(4, 3, 3, 3, NULL, 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(5, 3, 4, 3, NULL, 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(6, 3, 5, 3, NULL, 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(7, 3, 6, 3, NULL, 3, '2025-07-28 21:38:44', '2025-07-28 21:38:44'),
(8, 3, 7, 3, NULL, 3, '2025-07-28 21:39:55', '2025-07-28 21:39:55'),
(9, 5, 8, 3, NULL, 3, '2025-07-28 21:45:51', '2025-07-28 21:45:51'),
(10, 5, 9, 3, NULL, 3, '2025-07-28 21:45:51', '2025-07-28 21:45:51'),
(11, 5, 10, 3, NULL, 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(12, 5, 11, 3, NULL, 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(13, 5, 12, 3, NULL, 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(14, 5, 13, 3, NULL, 3, '2025-07-28 22:01:13', '2025-07-28 22:01:13'),
(15, 5, 14, 3, NULL, 3, '2025-07-28 22:03:40', '2025-07-28 22:03:40'),
(16, 80, 9, 3, NULL, 3, '2025-07-28 22:18:50', '2025-07-28 22:18:50'),
(17, 80, 8, 3, NULL, 3, '2025-07-28 22:19:40', '2025-07-28 22:19:40'),
(18, 80, 10, 3, NULL, 3, '2025-07-28 22:20:13', '2025-07-28 22:20:13'),
(19, 80, 14, 3, NULL, 3, '2025-07-28 22:20:47', '2025-07-28 22:20:47'),
(20, 80, 12, 3, NULL, 3, '2025-07-28 22:21:12', '2025-07-28 22:21:12'),
(21, 80, 13, 3, NULL, 3, '2025-07-28 22:21:40', '2025-07-28 22:21:40'),
(22, 80, 11, 3, NULL, 3, '2025-07-28 22:22:08', '2025-07-28 22:22:08'),
(23, 81, 15, 3, NULL, 3, '2025-07-28 22:48:02', '2025-07-28 22:48:02'),
(24, 81, 16, 3, NULL, 3, '2025-07-28 22:48:02', '2025-07-28 22:48:02'),
(25, 81, 17, 3, NULL, 3, '2025-07-28 22:48:03', '2025-07-28 22:48:03'),
(26, 81, 10, 3, NULL, 3, '2025-07-28 22:48:03', '2025-07-28 22:48:03'),
(27, 81, 18, 3, NULL, 3, '2025-07-28 22:48:03', '2025-07-28 22:48:03'),
(28, 81, 19, 3, NULL, 3, '2025-07-28 22:48:03', '2025-07-28 22:48:03'),
(29, 6, 20, 3, NULL, 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(30, 6, 21, 3, NULL, 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(31, 6, 22, 3, NULL, 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(32, 6, 23, 3, NULL, 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(33, 6, 24, 3, NULL, 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(34, 6, 25, 3, NULL, 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(35, 6, 26, 3, NULL, 3, '2025-07-28 22:57:31', '2025-07-28 22:57:31'),
(36, 6, 27, 3, NULL, 3, '2025-07-28 23:01:53', '2025-07-28 23:01:53'),
(37, 6, 28, 3, NULL, 3, '2025-07-28 23:04:28', '2025-07-28 23:04:28'),
(38, 38, 29, 3, NULL, 3, '2025-07-29 19:11:18', '2025-07-29 19:11:18'),
(40, 38, 31, 4, NULL, 4, '2025-07-30 16:07:04', '2025-07-30 16:07:04'),
(41, 38, 32, 4, NULL, 4, '2025-07-30 16:08:45', '2025-07-30 16:08:45'),
(42, 38, 33, 4, NULL, 4, '2025-07-30 16:12:16', '2025-07-30 16:12:16'),
(43, 38, 34, 4, NULL, 4, '2025-07-30 16:17:42', '2025-07-30 16:17:42'),
(44, 38, 35, 4, NULL, 4, '2025-07-30 16:19:13', '2025-07-30 16:19:13'),
(45, 38, 36, 4, NULL, 4, '2025-07-30 16:21:05', '2025-07-30 16:21:05'),
(46, 38, 37, 4, NULL, 4, '2025-07-30 16:54:52', '2025-07-30 16:54:52'),
(47, 38, 38, 4, NULL, 4, '2025-07-30 16:56:17', '2025-07-30 16:56:17'),
(48, 38, 39, 4, NULL, 4, '2025-07-30 16:58:39', '2025-07-30 16:58:39'),
(49, 38, 40, 4, NULL, 4, '2025-07-30 17:05:01', '2025-07-30 17:05:01'),
(50, 38, 41, 4, NULL, 4, '2025-07-30 17:06:28', '2025-07-30 17:06:28'),
(51, 38, 42, 4, NULL, 4, '2025-07-30 17:08:06', '2025-07-30 17:08:06'),
(52, 38, 43, 4, NULL, 4, '2025-07-30 17:13:55', '2025-07-30 17:13:55'),
(53, 38, 44, 4, NULL, 4, '2025-07-30 17:22:40', '2025-07-30 17:22:40'),
(54, 38, 45, 4, NULL, 4, '2025-07-30 17:24:20', '2025-07-30 17:24:20'),
(55, 38, 46, 4, NULL, 4, '2025-07-30 17:25:09', '2025-07-30 17:25:09'),
(56, 38, 47, 4, NULL, 4, '2025-07-30 17:26:42', '2025-07-30 17:26:42'),
(57, 38, 48, 4, NULL, 4, '2025-07-30 17:27:52', '2025-07-30 17:27:52'),
(58, 52, 49, 4, NULL, 4, '2025-07-30 17:39:28', '2025-07-30 17:39:28'),
(59, 52, 50, 4, NULL, 4, '2025-07-30 17:39:28', '2025-07-30 17:39:28'),
(60, 52, 51, 4, NULL, 4, '2025-07-30 17:49:39', '2025-07-30 17:49:39'),
(61, 52, 52, 4, NULL, 4, '2025-07-30 17:49:39', '2025-07-30 17:49:39'),
(62, 52, 53, 4, NULL, 4, '2025-07-30 17:49:39', '2025-07-30 17:49:39'),
(63, 52, 54, 4, NULL, 4, '2025-07-30 17:52:20', '2025-07-30 17:52:20'),
(64, 52, 55, 4, NULL, 4, '2025-07-30 18:05:33', '2025-07-30 18:05:33'),
(65, 52, 56, 4, NULL, 4, '2025-07-30 18:05:33', '2025-07-30 18:05:33'),
(66, 52, 57, 4, NULL, 4, '2025-07-30 18:09:19', '2025-07-30 18:09:19'),
(67, 52, 8, 4, NULL, 4, '2025-07-30 18:09:19', '2025-07-30 18:09:19'),
(68, 52, 58, 4, NULL, 4, '2025-07-30 18:25:30', '2025-07-30 18:25:30'),
(69, 52, 59, 4, NULL, 4, '2025-07-30 18:25:30', '2025-07-30 18:25:30'),
(70, 52, 60, 4, NULL, 4, '2025-07-30 18:33:16', '2025-07-30 18:33:16'),
(71, 52, 61, 4, NULL, 4, '2025-07-30 18:50:49', '2025-07-30 18:50:49'),
(72, 52, 62, 4, NULL, 4, '2025-07-30 18:50:49', '2025-07-30 18:50:49'),
(73, 52, 63, 4, NULL, 4, '2025-07-30 18:55:20', '2025-07-30 18:55:20'),
(74, 52, 64, 4, NULL, 4, '2025-07-30 19:02:19', '2025-07-30 19:02:19'),
(75, 52, 65, 4, NULL, 4, '2025-07-30 19:02:19', '2025-07-30 19:02:19'),
(76, 52, 66, 4, NULL, 4, '2025-07-30 19:02:19', '2025-07-30 19:02:19'),
(77, 52, 67, 4, NULL, 4, '2025-07-30 19:06:43', '2025-07-30 19:06:43'),
(78, 52, 68, 4, NULL, 4, '2025-07-30 19:06:43', '2025-07-30 19:06:43'),
(79, 50, 56, 4, NULL, 4, '2025-07-30 20:44:55', '2025-07-30 20:44:55'),
(80, 50, 54, 4, NULL, 4, '2025-07-30 20:44:55', '2025-07-30 20:44:55'),
(81, 50, 69, 4, NULL, 4, '2025-07-30 20:44:55', '2025-07-30 20:44:55'),
(82, 50, 58, 4, NULL, 4, '2025-07-30 20:47:18', '2025-07-30 20:47:18'),
(83, 50, 70, 4, NULL, 4, '2025-07-30 20:47:18', '2025-07-30 20:47:18'),
(84, 50, 52, 4, NULL, 4, '2025-07-30 20:54:55', '2025-07-30 20:54:55'),
(85, 50, 71, 4, NULL, 4, '2025-07-30 20:54:55', '2025-07-30 20:54:55'),
(86, 50, 53, 4, NULL, 4, '2025-07-30 20:56:53', '2025-07-30 20:56:53'),
(87, 50, 72, 4, NULL, 4, '2025-07-30 20:56:53', '2025-07-30 20:56:53'),
(88, 50, 73, 4, NULL, 4, '2025-07-30 21:02:24', '2025-07-30 21:02:24'),
(89, 50, 74, 4, NULL, 4, '2025-07-30 21:02:24', '2025-07-30 21:02:24'),
(90, 50, 59, 4, NULL, 4, '2025-07-30 21:12:03', '2025-07-30 21:12:03'),
(91, 50, 75, 4, NULL, 4, '2025-07-30 21:12:03', '2025-07-30 21:12:03'),
(92, 23, 76, 4, NULL, 4, '2025-07-30 21:15:41', '2025-07-30 21:15:41'),
(93, 23, 77, 4, NULL, 4, '2025-07-30 21:24:32', '2025-07-30 21:24:32'),
(94, 23, 51, 4, NULL, 4, '2025-07-30 21:24:32', '2025-07-30 21:24:32'),
(95, 23, 78, 4, NULL, 4, '2025-07-30 21:24:32', '2025-07-30 21:24:32'),
(96, 23, 79, 4, NULL, 4, '2025-07-30 21:45:24', '2025-07-30 21:45:24'),
(97, 23, 50, 4, NULL, 4, '2025-07-30 21:45:24', '2025-07-30 21:45:24'),
(98, 23, 8, 4, NULL, 4, '2025-07-30 21:45:24', '2025-07-30 21:45:24'),
(99, 23, 80, 4, NULL, 4, '2025-07-30 21:45:24', '2025-07-30 21:45:24'),
(100, 23, 66, 4, NULL, 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(101, 23, 81, 4, NULL, 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(102, 23, 82, 4, NULL, 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(103, 23, 57, 4, NULL, 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(104, 23, 83, 4, NULL, 4, '2025-07-30 21:51:17', '2025-07-30 21:51:17'),
(105, 23, 5, 4, NULL, 4, '2025-07-31 15:57:57', '2025-07-31 15:57:57'),
(106, 23, 6, 4, NULL, 4, '2025-07-31 15:57:57', '2025-07-31 15:57:57'),
(107, 23, 84, 4, NULL, 4, '2025-07-31 15:57:57', '2025-07-31 15:57:57'),
(108, 23, 85, 4, NULL, 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(109, 23, 86, 4, NULL, 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(110, 23, 87, 4, NULL, 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(111, 23, 88, 4, NULL, 4, '2025-07-31 16:19:47', '2025-07-31 16:19:47'),
(112, 23, 3, 4, NULL, 4, '2025-07-31 16:23:00', '2025-07-31 16:23:00'),
(113, 23, 89, 4, NULL, 4, '2025-07-31 16:23:01', '2025-07-31 16:23:01'),
(114, 23, 90, 4, NULL, 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(115, 23, 91, 4, NULL, 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(116, 23, 92, 4, NULL, 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(117, 23, 93, 4, NULL, 4, '2025-07-31 16:31:35', '2025-07-31 16:31:35'),
(118, 23, 94, 4, NULL, 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(119, 23, 95, 4, NULL, 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(120, 23, 96, 4, NULL, 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(121, 23, 97, 4, NULL, 4, '2025-07-31 16:41:56', '2025-07-31 16:41:56'),
(122, 31, 51, 4, NULL, 4, '2025-08-01 16:05:06', '2025-08-01 16:05:06'),
(123, 31, 8, 4, NULL, 4, '2025-08-01 16:05:06', '2025-08-01 16:05:06'),
(124, 31, 98, 4, NULL, 4, '2025-08-01 16:05:06', '2025-08-01 16:05:06'),
(125, 31, 14, 4, NULL, 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(126, 31, 11, 4, NULL, 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(127, 31, 50, 4, NULL, 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(128, 31, 99, 4, NULL, 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(129, 31, 100, 4, NULL, 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(130, 31, 101, 4, NULL, 4, '2025-08-01 16:11:56', '2025-08-01 16:11:56'),
(131, 31, 102, 4, NULL, 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(132, 31, 103, 4, NULL, 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(133, 31, 104, 4, NULL, 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(134, 31, 64, 4, NULL, 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(135, 31, 65, 4, NULL, 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(136, 31, 4, 4, NULL, 4, '2025-08-01 17:03:38', '2025-08-01 17:03:38'),
(137, 31, 57, 4, NULL, 4, '2025-08-01 17:12:55', '2025-08-01 17:12:55'),
(138, 25, 69, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(139, 25, 105, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(140, 25, 106, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(141, 25, 72, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(142, 25, 53, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(143, 25, 52, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(144, 25, 71, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(145, 25, 56, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(146, 25, 58, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(147, 25, 55, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(148, 25, 60, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(149, 25, 66, 4, NULL, 4, '2025-08-01 17:38:42', '2025-08-01 17:38:42'),
(150, 25, 107, 4, NULL, 4, '2025-08-01 17:43:24', '2025-08-01 17:43:24'),
(151, 39, 108, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(152, 39, 41, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(153, 39, 35, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(154, 39, 40, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(155, 39, 36, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(156, 39, 42, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(157, 39, 33, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(158, 39, 37, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(159, 39, 43, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(160, 39, 47, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(161, 39, 31, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(162, 39, 32, 4, NULL, 4, '2025-08-01 18:18:03', '2025-08-01 18:18:03'),
(163, 39, 38, 4, NULL, 4, '2025-08-01 18:41:44', '2025-08-01 18:41:44'),
(165, 48, 8, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(166, 48, 65, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(167, 48, 67, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(168, 48, 50, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(169, 48, 68, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(170, 48, 99, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(171, 48, 101, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(172, 48, 110, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(173, 48, 61, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(174, 48, 111, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(175, 48, 63, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(176, 48, 62, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(177, 48, 112, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(178, 48, 92, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(179, 48, 113, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(180, 48, 88, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(181, 48, 78, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(182, 48, 3, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(183, 48, 4, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(184, 48, 57, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(185, 48, 114, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(186, 48, 85, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(187, 48, 115, 4, NULL, 4, '2025-08-01 22:59:44', '2025-08-01 22:59:44'),
(188, 48, 116, 4, NULL, 4, '2025-08-01 23:01:47', '2025-08-01 23:01:47'),
(189, 32, 117, 4, NULL, 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(190, 32, 28, 4, NULL, 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(191, 32, 118, 4, NULL, 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(192, 32, 119, 4, NULL, 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(193, 32, 120, 4, NULL, 4, '2025-08-05 21:23:28', '2025-08-05 21:23:28'),
(194, 4, 121, 4, NULL, 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(195, 4, 15, 4, NULL, 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(196, 4, 122, 4, NULL, 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(197, 4, 123, 4, NULL, 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(198, 4, 9, 4, NULL, 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(199, 4, 8, 4, NULL, 4, '2025-08-05 21:45:00', '2025-08-05 21:45:00'),
(200, 11, 51, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(201, 11, 8, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(202, 11, 14, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(203, 11, 101, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(204, 11, 92, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(205, 11, 99, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(206, 11, 50, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(207, 11, 124, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(208, 11, 11, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(209, 11, 65, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(210, 11, 57, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(211, 11, 4, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(212, 11, 64, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(213, 11, 125, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(214, 11, 13, 4, NULL, 4, '2025-08-05 22:14:46', '2025-08-05 22:14:46'),
(215, 11, 126, 4, NULL, 4, '2025-08-05 22:17:26', '2025-08-05 22:17:26'),
(216, 17, 21, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(217, 17, 27, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(218, 17, 26, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(219, 17, 127, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(220, 17, 28, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(221, 17, 23, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(222, 17, 24, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(223, 17, 128, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(224, 17, 129, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(225, 17, 130, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(226, 17, 98, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(227, 17, 11, 4, NULL, 4, '2025-08-05 22:44:05', '2025-08-05 22:44:05'),
(228, 17, 131, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(229, 17, 13, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(230, 17, 17, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(231, 17, 99, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(232, 17, 92, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(233, 17, 101, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(234, 17, 51, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(235, 17, 14, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(236, 17, 57, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(237, 17, 50, 4, NULL, 4, '2025-08-06 16:06:07', '2025-08-06 16:06:07'),
(238, 17, 132, 4, NULL, 4, '2025-08-06 16:09:38', '2025-08-06 16:09:38'),
(239, 17, 133, 4, NULL, 4, '2025-08-06 16:28:58', '2025-08-06 16:28:58'),
(240, 17, 134, 4, NULL, 4, '2025-08-06 16:28:58', '2025-08-06 16:28:58'),
(241, 17, 135, 4, NULL, 4, '2025-08-06 16:28:58', '2025-08-06 16:28:58'),
(242, 17, 136, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(243, 17, 67, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(244, 17, 64, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(245, 17, 137, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(246, 17, 65, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(247, 17, 138, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(248, 17, 66, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(249, 17, 15, 4, NULL, 4, '2025-08-06 16:36:08', '2025-08-06 16:36:08'),
(250, 17, 139, 4, NULL, 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(251, 17, 8, 4, NULL, 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(252, 17, 140, 4, NULL, 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(253, 17, 141, 4, NULL, 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(254, 17, 142, 4, NULL, 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(255, 17, 143, 4, NULL, 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(256, 17, 144, 4, NULL, 4, '2025-08-06 16:48:32', '2025-08-06 16:48:32'),
(257, 17, 145, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(258, 17, 116, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(259, 17, 3, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(260, 17, 93, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(261, 17, 6, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(262, 17, 113, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(263, 17, 5, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(264, 17, 146, 4, NULL, 4, '2025-08-06 17:13:46', '2025-08-06 17:13:46'),
(265, 17, 147, 4, NULL, 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(266, 17, 148, 4, NULL, 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(267, 17, 149, 4, NULL, 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(268, 17, 150, 4, NULL, 4, '2025-08-06 17:22:59', '2025-08-06 17:22:59'),
(269, 21, 151, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(270, 21, 8, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(271, 21, 116, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(272, 21, 152, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(273, 21, 153, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(274, 21, 154, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(275, 21, 155, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(276, 21, 156, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(277, 21, 157, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(278, 21, 66, 4, NULL, 4, '2025-08-06 17:51:39', '2025-08-06 17:51:39'),
(279, 19, 158, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(280, 19, 88, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(281, 19, 77, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(282, 19, 78, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(283, 19, 137, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(284, 19, 159, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(285, 19, 160, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(286, 19, 161, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(287, 19, 162, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(288, 19, 163, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(289, 19, 8, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(290, 19, 3, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(291, 19, 116, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(292, 19, 99, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(293, 19, 92, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(294, 19, 79, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(295, 19, 164, 4, NULL, 4, '2025-08-06 18:09:25', '2025-08-06 18:09:25'),
(296, 19, 66, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(297, 19, 165, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(298, 19, 80, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(299, 19, 51, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(300, 19, 166, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(301, 19, 84, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(302, 19, 167, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(303, 19, 50, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(304, 19, 57, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(305, 19, 168, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36'),
(306, 19, 113, 4, NULL, 4, '2025-08-06 18:17:36', '2025-08-06 18:17:36');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('planeacion-estrategica-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3', 'i:1;', 1762187036),
('planeacion-estrategica-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer', 'i:1762187036;', 1762187036),
('planeacion-estrategica-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:340:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:17:\"view_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:21:\"view_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:19:\"create_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:19:\"update_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:20:\"restore_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:24:\"restore_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:22:\"replicate_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:20:\"reorder_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:19:\"delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:23:\"delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:25:\"force_delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:29:\"force_delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:13:\"view_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:17:\"view_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:15:\"create_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:15:\"update_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:16:\"restore_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:20:\"restore_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:18:\"replicate_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:16:\"reorder_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:15:\"delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:19:\"delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:21:\"force_delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:25:\"force_delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:23:\"view_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:27:\"view_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:25:\"create_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:25:\"update_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:26:\"restore_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:30:\"restore_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:28:\"replicate_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:26:\"reorder_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:25:\"delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:29:\"delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:31:\"force_delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:35:\"force_delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:19:\"view_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:23:\"view_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:21:\"create_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:21:\"update_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:22:\"restore_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:26:\"restore_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:24:\"replicate_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:22:\"reorder_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:21:\"delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:25:\"delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:27:\"force_delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:31:\"force_delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:18:\"view_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:22:\"view_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:20:\"create_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:20:\"update_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:21:\"restore_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:25:\"restore_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:23:\"replicate_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:21:\"reorder_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:20:\"delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:24:\"delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:26:\"force_delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:30:\"force_delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:8:\"view_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:12:\"view_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:10:\"create_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:10:\"update_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:11:\"restore_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:15:\"restore_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:13:\"replicate_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:11:\"reorder_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:10:\"delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:14:\"delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:16:\"force_delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:20:\"force_delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:16:\"view_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:73;a:4:{s:1:\"a\";i:74;s:1:\"b\";s:20:\"view_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:74;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:18:\"create_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:75;a:4:{s:1:\"a\";i:76;s:1:\"b\";s:18:\"update_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:76;a:4:{s:1:\"a\";i:77;s:1:\"b\";s:19:\"restore_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:4:{s:1:\"a\";i:78;s:1:\"b\";s:23:\"restore_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:4:{s:1:\"a\";i:79;s:1:\"b\";s:21:\"replicate_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:4:{s:1:\"a\";i:80;s:1:\"b\";s:19:\"reorder_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:4:{s:1:\"a\";i:81;s:1:\"b\";s:18:\"delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:4:{s:1:\"a\";i:82;s:1:\"b\";s:22:\"delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:4:{s:1:\"a\";i:83;s:1:\"b\";s:24:\"force_delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:4:{s:1:\"a\";i:84;s:1:\"b\";s:28:\"force_delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:26:\"view_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:4:{s:1:\"a\";i:86;s:1:\"b\";s:30:\"view_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:4:{s:1:\"a\";i:87;s:1:\"b\";s:28:\"create_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:4:{s:1:\"a\";i:88;s:1:\"b\";s:28:\"update_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:4:{s:1:\"a\";i:89;s:1:\"b\";s:29:\"restore_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:33:\"restore_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:4:{s:1:\"a\";i:91;s:1:\"b\";s:31:\"replicate_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:4:{s:1:\"a\";i:92;s:1:\"b\";s:29:\"reorder_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:4:{s:1:\"a\";i:93;s:1:\"b\";s:28:\"delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:4:{s:1:\"a\";i:94;s:1:\"b\";s:32:\"delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:4:{s:1:\"a\";i:95;s:1:\"b\";s:34:\"force_delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:4:{s:1:\"a\";i:96;s:1:\"b\";s:38:\"force_delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:4:{s:1:\"a\";i:97;s:1:\"b\";s:14:\"view_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:97;a:4:{s:1:\"a\";i:98;s:1:\"b\";s:18:\"view_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:98;a:4:{s:1:\"a\";i:99;s:1:\"b\";s:16:\"create_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:99;a:4:{s:1:\"a\";i:100;s:1:\"b\";s:16:\"update_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:100;a:4:{s:1:\"a\";i:101;s:1:\"b\";s:17:\"restore_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:101;a:4:{s:1:\"a\";i:102;s:1:\"b\";s:21:\"restore_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:102;a:4:{s:1:\"a\";i:103;s:1:\"b\";s:19:\"replicate_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:103;a:4:{s:1:\"a\";i:104;s:1:\"b\";s:17:\"reorder_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:104;a:4:{s:1:\"a\";i:105;s:1:\"b\";s:16:\"delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:105;a:4:{s:1:\"a\";i:106;s:1:\"b\";s:20:\"delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:106;a:4:{s:1:\"a\";i:107;s:1:\"b\";s:22:\"force_delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:107;a:4:{s:1:\"a\";i:108;s:1:\"b\";s:26:\"force_delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:108;a:4:{s:1:\"a\";i:109;s:1:\"b\";s:14:\"view_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:109;a:4:{s:1:\"a\";i:110;s:1:\"b\";s:18:\"view_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:110;a:4:{s:1:\"a\";i:111;s:1:\"b\";s:16:\"create_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:111;a:4:{s:1:\"a\";i:112;s:1:\"b\";s:16:\"update_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:112;a:4:{s:1:\"a\";i:113;s:1:\"b\";s:17:\"restore_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:113;a:4:{s:1:\"a\";i:114;s:1:\"b\";s:21:\"restore_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:114;a:4:{s:1:\"a\";i:115;s:1:\"b\";s:19:\"replicate_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:115;a:4:{s:1:\"a\";i:116;s:1:\"b\";s:17:\"reorder_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:116;a:4:{s:1:\"a\";i:117;s:1:\"b\";s:16:\"delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:117;a:4:{s:1:\"a\";i:118;s:1:\"b\";s:20:\"delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:118;a:4:{s:1:\"a\";i:119;s:1:\"b\";s:22:\"force_delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:119;a:4:{s:1:\"a\";i:120;s:1:\"b\";s:26:\"force_delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:120;a:4:{s:1:\"a\";i:121;s:1:\"b\";s:9:\"view_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:121;a:4:{s:1:\"a\";i:122;s:1:\"b\";s:13:\"view_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:122;a:4:{s:1:\"a\";i:123;s:1:\"b\";s:11:\"create_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:123;a:4:{s:1:\"a\";i:124;s:1:\"b\";s:11:\"update_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:124;a:4:{s:1:\"a\";i:125;s:1:\"b\";s:12:\"restore_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:125;a:4:{s:1:\"a\";i:126;s:1:\"b\";s:16:\"restore_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:126;a:4:{s:1:\"a\";i:127;s:1:\"b\";s:14:\"replicate_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:127;a:4:{s:1:\"a\";i:128;s:1:\"b\";s:12:\"reorder_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:128;a:4:{s:1:\"a\";i:129;s:1:\"b\";s:11:\"delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:129;a:4:{s:1:\"a\";i:130;s:1:\"b\";s:15:\"delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:130;a:4:{s:1:\"a\";i:131;s:1:\"b\";s:17:\"force_delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:131;a:4:{s:1:\"a\";i:132;s:1:\"b\";s:21:\"force_delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:132;a:4:{s:1:\"a\";i:133;s:1:\"b\";s:8:\"view_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:133;a:4:{s:1:\"a\";i:134;s:1:\"b\";s:12:\"view_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:134;a:4:{s:1:\"a\";i:135;s:1:\"b\";s:10:\"create_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:135;a:4:{s:1:\"a\";i:136;s:1:\"b\";s:10:\"update_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:136;a:4:{s:1:\"a\";i:137;s:1:\"b\";s:11:\"restore_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:137;a:4:{s:1:\"a\";i:138;s:1:\"b\";s:15:\"restore_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:138;a:4:{s:1:\"a\";i:139;s:1:\"b\";s:13:\"replicate_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:139;a:4:{s:1:\"a\";i:140;s:1:\"b\";s:11:\"reorder_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:140;a:4:{s:1:\"a\";i:141;s:1:\"b\";s:10:\"delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:141;a:4:{s:1:\"a\";i:142;s:1:\"b\";s:14:\"delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:142;a:4:{s:1:\"a\";i:143;s:1:\"b\";s:16:\"force_delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:143;a:4:{s:1:\"a\";i:144;s:1:\"b\";s:20:\"force_delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:144;a:4:{s:1:\"a\";i:145;s:1:\"b\";s:13:\"view_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:145;a:4:{s:1:\"a\";i:146;s:1:\"b\";s:17:\"view_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:146;a:4:{s:1:\"a\";i:147;s:1:\"b\";s:15:\"create_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:147;a:4:{s:1:\"a\";i:148;s:1:\"b\";s:15:\"update_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:148;a:4:{s:1:\"a\";i:149;s:1:\"b\";s:16:\"restore_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:149;a:4:{s:1:\"a\";i:150;s:1:\"b\";s:20:\"restore_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:150;a:4:{s:1:\"a\";i:151;s:1:\"b\";s:18:\"replicate_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:151;a:4:{s:1:\"a\";i:152;s:1:\"b\";s:16:\"reorder_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:152;a:4:{s:1:\"a\";i:153;s:1:\"b\";s:15:\"delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:153;a:4:{s:1:\"a\";i:154;s:1:\"b\";s:19:\"delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:154;a:4:{s:1:\"a\";i:155;s:1:\"b\";s:21:\"force_delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:155;a:4:{s:1:\"a\";i:156;s:1:\"b\";s:25:\"force_delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:156;a:4:{s:1:\"a\";i:157;s:1:\"b\";s:17:\"view_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:157;a:4:{s:1:\"a\";i:158;s:1:\"b\";s:21:\"view_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:158;a:4:{s:1:\"a\";i:159;s:1:\"b\";s:19:\"create_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:159;a:4:{s:1:\"a\";i:160;s:1:\"b\";s:19:\"update_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:160;a:4:{s:1:\"a\";i:161;s:1:\"b\";s:20:\"restore_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:161;a:4:{s:1:\"a\";i:162;s:1:\"b\";s:24:\"restore_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:162;a:4:{s:1:\"a\";i:163;s:1:\"b\";s:22:\"replicate_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:163;a:4:{s:1:\"a\";i:164;s:1:\"b\";s:20:\"reorder_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:164;a:4:{s:1:\"a\";i:165;s:1:\"b\";s:19:\"delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:165;a:4:{s:1:\"a\";i:166;s:1:\"b\";s:23:\"delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:166;a:4:{s:1:\"a\";i:167;s:1:\"b\";s:25:\"force_delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:167;a:4:{s:1:\"a\";i:168;s:1:\"b\";s:29:\"force_delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:168;a:4:{s:1:\"a\";i:169;s:1:\"b\";s:20:\"view_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:169;a:4:{s:1:\"a\";i:170;s:1:\"b\";s:24:\"view_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:170;a:4:{s:1:\"a\";i:171;s:1:\"b\";s:22:\"create_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:171;a:4:{s:1:\"a\";i:172;s:1:\"b\";s:22:\"update_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:172;a:4:{s:1:\"a\";i:173;s:1:\"b\";s:23:\"restore_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:173;a:4:{s:1:\"a\";i:174;s:1:\"b\";s:27:\"restore_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:174;a:4:{s:1:\"a\";i:175;s:1:\"b\";s:25:\"replicate_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:175;a:4:{s:1:\"a\";i:176;s:1:\"b\";s:23:\"reorder_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:176;a:4:{s:1:\"a\";i:177;s:1:\"b\";s:22:\"delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:177;a:4:{s:1:\"a\";i:178;s:1:\"b\";s:26:\"delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:178;a:4:{s:1:\"a\";i:179;s:1:\"b\";s:28:\"force_delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:179;a:4:{s:1:\"a\";i:180;s:1:\"b\";s:32:\"force_delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:180;a:4:{s:1:\"a\";i:181;s:1:\"b\";s:12:\"view_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:181;a:4:{s:1:\"a\";i:182;s:1:\"b\";s:16:\"view_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:182;a:4:{s:1:\"a\";i:183;s:1:\"b\";s:14:\"create_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:183;a:4:{s:1:\"a\";i:184;s:1:\"b\";s:14:\"update_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:184;a:4:{s:1:\"a\";i:185;s:1:\"b\";s:15:\"restore_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:185;a:4:{s:1:\"a\";i:186;s:1:\"b\";s:19:\"restore_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:186;a:4:{s:1:\"a\";i:187;s:1:\"b\";s:17:\"replicate_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:187;a:4:{s:1:\"a\";i:188;s:1:\"b\";s:15:\"reorder_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:188;a:4:{s:1:\"a\";i:189;s:1:\"b\";s:14:\"delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:189;a:4:{s:1:\"a\";i:190;s:1:\"b\";s:18:\"delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:190;a:4:{s:1:\"a\";i:191;s:1:\"b\";s:20:\"force_delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:191;a:4:{s:1:\"a\";i:192;s:1:\"b\";s:24:\"force_delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:192;a:4:{s:1:\"a\";i:193;s:1:\"b\";s:12:\"view_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:193;a:4:{s:1:\"a\";i:194;s:1:\"b\";s:16:\"view_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:194;a:4:{s:1:\"a\";i:195;s:1:\"b\";s:14:\"create_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:195;a:4:{s:1:\"a\";i:196;s:1:\"b\";s:14:\"update_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:196;a:4:{s:1:\"a\";i:197;s:1:\"b\";s:15:\"restore_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:197;a:4:{s:1:\"a\";i:198;s:1:\"b\";s:19:\"restore_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:198;a:4:{s:1:\"a\";i:199;s:1:\"b\";s:17:\"replicate_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:199;a:4:{s:1:\"a\";i:200;s:1:\"b\";s:15:\"reorder_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:200;a:4:{s:1:\"a\";i:201;s:1:\"b\";s:14:\"delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:201;a:4:{s:1:\"a\";i:202;s:1:\"b\";s:18:\"delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:202;a:4:{s:1:\"a\";i:203;s:1:\"b\";s:20:\"force_delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:203;a:4:{s:1:\"a\";i:204;s:1:\"b\";s:24:\"force_delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:204;a:4:{s:1:\"a\";i:205;s:1:\"b\";s:23:\"view_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:205;a:4:{s:1:\"a\";i:206;s:1:\"b\";s:27:\"view_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:206;a:4:{s:1:\"a\";i:207;s:1:\"b\";s:25:\"create_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:207;a:4:{s:1:\"a\";i:208;s:1:\"b\";s:25:\"update_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:208;a:4:{s:1:\"a\";i:209;s:1:\"b\";s:26:\"restore_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:209;a:4:{s:1:\"a\";i:210;s:1:\"b\";s:30:\"restore_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:210;a:4:{s:1:\"a\";i:211;s:1:\"b\";s:28:\"replicate_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:211;a:4:{s:1:\"a\";i:212;s:1:\"b\";s:26:\"reorder_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:212;a:4:{s:1:\"a\";i:213;s:1:\"b\";s:25:\"delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:213;a:4:{s:1:\"a\";i:214;s:1:\"b\";s:29:\"delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:214;a:4:{s:1:\"a\";i:215;s:1:\"b\";s:31:\"force_delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:215;a:4:{s:1:\"a\";i:216;s:1:\"b\";s:35:\"force_delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:216;a:4:{s:1:\"a\";i:217;s:1:\"b\";s:12:\"view_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:217;a:4:{s:1:\"a\";i:218;s:1:\"b\";s:16:\"view_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:218;a:4:{s:1:\"a\";i:219;s:1:\"b\";s:14:\"create_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:219;a:4:{s:1:\"a\";i:220;s:1:\"b\";s:14:\"update_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:220;a:4:{s:1:\"a\";i:221;s:1:\"b\";s:15:\"restore_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:221;a:4:{s:1:\"a\";i:222;s:1:\"b\";s:19:\"restore_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:222;a:4:{s:1:\"a\";i:223;s:1:\"b\";s:17:\"replicate_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:223;a:4:{s:1:\"a\";i:224;s:1:\"b\";s:15:\"reorder_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:224;a:4:{s:1:\"a\";i:225;s:1:\"b\";s:14:\"delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:225;a:4:{s:1:\"a\";i:226;s:1:\"b\";s:18:\"delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:226;a:4:{s:1:\"a\";i:227;s:1:\"b\";s:20:\"force_delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:227;a:4:{s:1:\"a\";i:228;s:1:\"b\";s:24:\"force_delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:228;a:4:{s:1:\"a\";i:229;s:1:\"b\";s:26:\"view_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:229;a:4:{s:1:\"a\";i:230;s:1:\"b\";s:30:\"view_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:230;a:4:{s:1:\"a\";i:231;s:1:\"b\";s:28:\"create_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:231;a:4:{s:1:\"a\";i:232;s:1:\"b\";s:28:\"update_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:232;a:4:{s:1:\"a\";i:233;s:1:\"b\";s:29:\"restore_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:233;a:4:{s:1:\"a\";i:234;s:1:\"b\";s:33:\"restore_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:234;a:4:{s:1:\"a\";i:235;s:1:\"b\";s:31:\"replicate_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:235;a:4:{s:1:\"a\";i:236;s:1:\"b\";s:29:\"reorder_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:236;a:4:{s:1:\"a\";i:237;s:1:\"b\";s:28:\"delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:237;a:4:{s:1:\"a\";i:238;s:1:\"b\";s:32:\"delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:238;a:4:{s:1:\"a\";i:239;s:1:\"b\";s:34:\"force_delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:239;a:4:{s:1:\"a\";i:240;s:1:\"b\";s:38:\"force_delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:240;a:4:{s:1:\"a\";i:241;s:1:\"b\";s:20:\"view_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:241;a:4:{s:1:\"a\";i:242;s:1:\"b\";s:24:\"view_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:242;a:4:{s:1:\"a\";i:243;s:1:\"b\";s:22:\"create_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:243;a:4:{s:1:\"a\";i:244;s:1:\"b\";s:22:\"update_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:244;a:4:{s:1:\"a\";i:245;s:1:\"b\";s:23:\"restore_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:245;a:4:{s:1:\"a\";i:246;s:1:\"b\";s:27:\"restore_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:246;a:4:{s:1:\"a\";i:247;s:1:\"b\";s:25:\"replicate_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:247;a:4:{s:1:\"a\";i:248;s:1:\"b\";s:23:\"reorder_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:248;a:4:{s:1:\"a\";i:249;s:1:\"b\";s:22:\"delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:249;a:4:{s:1:\"a\";i:250;s:1:\"b\";s:26:\"delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:250;a:4:{s:1:\"a\";i:251;s:1:\"b\";s:28:\"force_delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:251;a:4:{s:1:\"a\";i:252;s:1:\"b\";s:32:\"force_delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:252;a:4:{s:1:\"a\";i:253;s:1:\"b\";s:9:\"view_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:253;a:4:{s:1:\"a\";i:254;s:1:\"b\";s:13:\"view_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:254;a:4:{s:1:\"a\";i:255;s:1:\"b\";s:11:\"create_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:255;a:4:{s:1:\"a\";i:256;s:1:\"b\";s:11:\"update_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:256;a:4:{s:1:\"a\";i:257;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:257;a:4:{s:1:\"a\";i:258;s:1:\"b\";s:15:\"delete_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:258;a:4:{s:1:\"a\";i:259;s:1:\"b\";s:24:\"view_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:259;a:4:{s:1:\"a\";i:260;s:1:\"b\";s:28:\"view_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:260;a:4:{s:1:\"a\";i:261;s:1:\"b\";s:26:\"create_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:261;a:4:{s:1:\"a\";i:262;s:1:\"b\";s:26:\"update_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:262;a:4:{s:1:\"a\";i:263;s:1:\"b\";s:27:\"restore_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:263;a:4:{s:1:\"a\";i:264;s:1:\"b\";s:31:\"restore_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:264;a:4:{s:1:\"a\";i:265;s:1:\"b\";s:29:\"replicate_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:265;a:4:{s:1:\"a\";i:266;s:1:\"b\";s:27:\"reorder_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:266;a:4:{s:1:\"a\";i:267;s:1:\"b\";s:26:\"delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:267;a:4:{s:1:\"a\";i:268;s:1:\"b\";s:30:\"delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:268;a:4:{s:1:\"a\";i:269;s:1:\"b\";s:32:\"force_delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:269;a:4:{s:1:\"a\";i:270;s:1:\"b\";s:36:\"force_delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:270;a:4:{s:1:\"a\";i:271;s:1:\"b\";s:9:\"view_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:271;a:4:{s:1:\"a\";i:272;s:1:\"b\";s:13:\"view_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:272;a:4:{s:1:\"a\";i:273;s:1:\"b\";s:11:\"create_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:273;a:4:{s:1:\"a\";i:274;s:1:\"b\";s:11:\"update_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:274;a:4:{s:1:\"a\";i:275;s:1:\"b\";s:12:\"restore_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:275;a:4:{s:1:\"a\";i:276;s:1:\"b\";s:16:\"restore_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:276;a:4:{s:1:\"a\";i:277;s:1:\"b\";s:14:\"replicate_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:277;a:4:{s:1:\"a\";i:278;s:1:\"b\";s:12:\"reorder_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:278;a:4:{s:1:\"a\";i:279;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:279;a:4:{s:1:\"a\";i:280;s:1:\"b\";s:15:\"delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:280;a:4:{s:1:\"a\";i:281;s:1:\"b\";s:17:\"force_delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:281;a:4:{s:1:\"a\";i:282;s:1:\"b\";s:21:\"force_delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:282;a:4:{s:1:\"a\";i:283;s:1:\"b\";s:24:\"page_ActivityFileManager\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:283;a:4:{s:1:\"a\";i:284;s:1:\"b\";s:28:\"page_BeneficiaryRegistryView\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:284;a:3:{s:1:\"a\";i:285;s:1:\"b\";s:25:\"page_ProjectCreationGuide\";s:1:\"c\";s:3:\"web\";}i:285;a:4:{s:1:\"a\";i:286;s:1:\"b\";s:22:\"page_ProjectManagement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:286;a:4:{s:1:\"a\";i:287;s:1:\"b\";s:18:\"page_ProjectWizard\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:287;a:4:{s:1:\"a\";i:288;s:1:\"b\";s:28:\"page_DataPublicationApproval\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:288;a:4:{s:1:\"a\";i:289;s:1:\"b\";s:22:\"view_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:289;a:4:{s:1:\"a\";i:290;s:1:\"b\";s:26:\"view_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:290;a:4:{s:1:\"a\";i:291;s:1:\"b\";s:24:\"create_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:291;a:4:{s:1:\"a\";i:292;s:1:\"b\";s:24:\"update_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:292;a:4:{s:1:\"a\";i:293;s:1:\"b\";s:25:\"restore_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:293;a:4:{s:1:\"a\";i:294;s:1:\"b\";s:29:\"restore_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:294;a:4:{s:1:\"a\";i:295;s:1:\"b\";s:27:\"replicate_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:295;a:4:{s:1:\"a\";i:296;s:1:\"b\";s:25:\"reorder_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:296;a:4:{s:1:\"a\";i:297;s:1:\"b\";s:24:\"delete_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:297;a:4:{s:1:\"a\";i:298;s:1:\"b\";s:28:\"delete_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:298;a:4:{s:1:\"a\";i:299;s:1:\"b\";s:30:\"force_delete_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:299;a:4:{s:1:\"a\";i:300;s:1:\"b\";s:34:\"force_delete_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:300;a:4:{s:1:\"a\";i:301;s:1:\"b\";s:24:\"view_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:301;a:4:{s:1:\"a\";i:302;s:1:\"b\";s:28:\"view_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:302;a:4:{s:1:\"a\";i:303;s:1:\"b\";s:26:\"create_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:303;a:4:{s:1:\"a\";i:304;s:1:\"b\";s:26:\"update_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:304;a:4:{s:1:\"a\";i:305;s:1:\"b\";s:27:\"restore_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:305;a:4:{s:1:\"a\";i:306;s:1:\"b\";s:31:\"restore_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:306;a:4:{s:1:\"a\";i:307;s:1:\"b\";s:29:\"replicate_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:307;a:4:{s:1:\"a\";i:308;s:1:\"b\";s:27:\"reorder_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:308;a:4:{s:1:\"a\";i:309;s:1:\"b\";s:26:\"delete_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:309;a:4:{s:1:\"a\";i:310;s:1:\"b\";s:30:\"delete_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:310;a:4:{s:1:\"a\";i:311;s:1:\"b\";s:32:\"force_delete_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:311;a:4:{s:1:\"a\";i:312;s:1:\"b\";s:36:\"force_delete_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:312;a:4:{s:1:\"a\";i:313;s:1:\"b\";s:22:\"view_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:313;a:4:{s:1:\"a\";i:314;s:1:\"b\";s:26:\"view_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:314;a:4:{s:1:\"a\";i:315;s:1:\"b\";s:24:\"create_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:315;a:4:{s:1:\"a\";i:316;s:1:\"b\";s:24:\"update_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:316;a:4:{s:1:\"a\";i:317;s:1:\"b\";s:25:\"restore_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:317;a:4:{s:1:\"a\";i:318;s:1:\"b\";s:29:\"restore_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:318;a:4:{s:1:\"a\";i:319;s:1:\"b\";s:27:\"replicate_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:319;a:4:{s:1:\"a\";i:320;s:1:\"b\";s:25:\"reorder_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:320;a:4:{s:1:\"a\";i:321;s:1:\"b\";s:24:\"delete_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:321;a:4:{s:1:\"a\";i:322;s:1:\"b\";s:28:\"delete_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:322;a:4:{s:1:\"a\";i:323;s:1:\"b\";s:30:\"force_delete_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:323;a:4:{s:1:\"a\";i:324;s:1:\"b\";s:34:\"force_delete_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:324;a:4:{s:1:\"a\";i:325;s:1:\"b\";s:23:\"view_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:325;a:4:{s:1:\"a\";i:326;s:1:\"b\";s:27:\"view_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:326;a:4:{s:1:\"a\";i:327;s:1:\"b\";s:25:\"create_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:327;a:4:{s:1:\"a\";i:328;s:1:\"b\";s:25:\"update_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:328;a:4:{s:1:\"a\";i:329;s:1:\"b\";s:26:\"restore_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:329;a:4:{s:1:\"a\";i:330;s:1:\"b\";s:30:\"restore_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:330;a:4:{s:1:\"a\";i:331;s:1:\"b\";s:28:\"replicate_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:331;a:4:{s:1:\"a\";i:332;s:1:\"b\";s:26:\"reorder_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:332;a:4:{s:1:\"a\";i:333;s:1:\"b\";s:25:\"delete_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:333;a:4:{s:1:\"a\";i:334;s:1:\"b\";s:29:\"delete_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:334;a:4:{s:1:\"a\";i:335;s:1:\"b\";s:31:\"force_delete_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:335;a:4:{s:1:\"a\";i:336;s:1:\"b\";s:35:\"force_delete_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:336;a:4:{s:1:\"a\";i:337;s:1:\"b\";s:25:\"page_ActivityCalendarView\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:337;a:4:{s:1:\"a\";i:338;s:1:\"b\";s:21:\"page_ProjectGanttView\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:338;a:4:{s:1:\"a\";i:339;s:1:\"b\";s:28:\"widget_ActivityCalendarCount\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:339;a:4:{s:1:\"a\";i:340;s:1:\"b\";s:19:\"widget_ProjectCount\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:2:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:10:\"capturista\";s:1:\"c\";s:3:\"web\";}}}', 1762273382);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `components`
--

CREATE TABLE `components` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_lines_id` bigint UNSIGNED NOT NULL,
  `action_lines_program_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `components`
--

INSERT INTO `components` (`id`, `name`, `action_lines_id`, `action_lines_program_id`, `created_at`, `updated_at`) VALUES
(1, 'C1. Talleres de capacitación en herramientas y estrategias artísticas para el desarrollo integral infantil realizados.', 1, 0, NULL, NULL),
(2, 'C2. Proyectos piloto artístico-educativos diseñados e implementados en aulas de educación inicial.', 1, 0, NULL, NULL),
(3, 'C1. Programas de formación artística básica desarrollados.', 2, 0, NULL, NULL),
(4, 'C1. Seminarios de liderazgo y participación ciudadana realizados.', 3, 0, NULL, NULL),
(5, 'C2. Talleres de participación ciudadana para mujeres adolescentes realizados.', 3, 0, NULL, NULL),
(6, 'C3. Recorridos temáticos exploratorios para el reconocimiento del entorno urbano realizados.', 3, 0, NULL, NULL),
(7, 'C1. Talleres de habilidades de liderazgo orientados al trabajo colaborativo realizados.', 4, 0, NULL, NULL),
(8, 'C2. Capacitación en gestión de equipos efectivos mediante metodologías de prevención impartida.', 5, 0, NULL, NULL),
(9, 'C3. Talleres sobre comunicación y confianza grupal realizados.', 6, 0, NULL, NULL),
(10, 'C4. Capacitación en resolución creativa y constructiva de conflictos impartida.', 7, 0, NULL, NULL),
(11, 'C5. Formación especializada para facilitadores realizada.', 8, 0, NULL, NULL),
(12, 'C1. Talleres de habilidades para la vida, inteligencia emocional, creatividad y pensamiento crítico realizados.', 9, 0, NULL, NULL),
(13, 'C2. Actividades deportivas y recreativas implementadas para el aprendizaje colaborativo.', 10, 0, NULL, NULL),
(14, 'C3. Atención a la salud mental y acciones de sensibilización realizadas', 11, 0, NULL, NULL),
(15, 'C4. Programas de orientación vocacional realizados y alianzas establecidas con instituciones.', 12, 0, NULL, NULL),
(16, 'C1. Programas de formación técnica y digital especializada implementados.', 13, 0, NULL, NULL),
(17, 'C2. Capacitaciones en profesiones creativas y servicios especializados realizadas.', 14, 0, NULL, NULL),
(18, 'C3. Programas de formación digital y tecnología avanzada implementados.', 15, 0, NULL, NULL),
(19, 'C4. Vinculación intersectorial con instituciones educativas y empresas establecida.', 16, 0, NULL, NULL),
(20, 'C1. Seminarios y foros sobre ética e integridad realizados.', 17, 0, NULL, NULL),
(21, 'C2. Talleres de implementación de mecanismos de integridad impartidos.', 18, 0, NULL, NULL),
(22, 'C3. Programa Pro-Ética para Servidores Públicos implementado en instituciones gubernamentales.', 19, 0, NULL, NULL),
(23, 'C1. Capacitación en habilidades críticas para la gestión pública.', 20, 0, NULL, NULL),
(24, 'C2. Encuentros interinstitucionales organizados para fomentar redes colaborativas.', 21, 0, NULL, NULL),
(25, 'C1. Producción artística colaborativa que refleja la identidad local.', 22, 0, NULL, NULL),
(26, 'C2. Vínculos sostenibles entre artistas y comunidades fomentados.', 23, 0, NULL, NULL),
(27, 'C1. Capacidades de emprendedores locales fortalecidas en gestión empresarial y finanzas.', 24, 0, NULL, NULL),
(28, 'C2. Proyectos de emprendimiento viables desarrollados y validados.', 25, 0, NULL, NULL),
(29, 'C3. Redes de colaboración y espacios de visibilización para emprendedores fomentados', 26, 0, NULL, NULL),
(30, 'C1. Acceso a oportunidades laborales facilitado para buscadores de empleo.', 27, 0, NULL, NULL),
(31, 'C2. Habilidades laborales y conocimiento de derechos desarrollados en los participantes.', 28, 0, NULL, NULL),
(32, 'C3. Redes de colaboración intersectorial entre empresas y buscadores de empleo fortalecidas.', 29, 0, NULL, NULL),
(33, 'C4. Experiencia práctica a través de prácticas profesionales facilitada para los participantes.', 30, 0, NULL, NULL),
(34, 'C1. Agenda medioambiental institucional desarrollada y aplicada.', 31, 0, NULL, NULL),
(35, 'C2. Comunidades capacitadas en gestión ambiental (ecotecnicas aplicadas en espacios comunitarios)', 32, 0, NULL, NULL),
(36, 'C3. Redes de colaboración activadas con otras organizaciones y sectores.', 33, 0, NULL, NULL),
(37, 'C1. Agenda Social 2030 diseñada y validada como marco de referencia para el tercer sector.', 34, 0, NULL, NULL),
(38, 'C2. Mecanismos de monitoreo y evaluación de la Agenda Social 2030 implementados para el seguimiento de su impacto y efectividad.', 35, 0, NULL, NULL),
(39, 'C1. Capacidades fortalecidas para la incidencia pública, promoviendo la participación activa en la toma de decisiones.', 36, 0, NULL, NULL),
(40, 'C2. Propuestas e iniciativas colectivas desarrolladas y presentadas ante actores clave.', 37, 0, NULL, NULL),
(41, 'C3. Avances y resultados de iniciativas sistematizados y documentados.', 38, 0, NULL, NULL),
(42, 'C4. Mecanismos de monitoreo y seguimiento de acciones gubernamentales implementados.', 39, 0, NULL, NULL),
(43, 'C1. Planes de bienestar personalizados diseñados e implementados.', 40, 0, NULL, NULL),
(44, 'C2. Talleres y cursos de formación desarrollados y ejecutados.', 41, 0, NULL, NULL),
(45, 'C3. Materiales educativos y recursos de aprendizaje creados y distribuidos.', 42, 0, NULL, NULL),
(46, 'C4. Redes de intercambio y colaboración entre el personal de OSC activadas y fortalecidas.', 43, 0, NULL, NULL),
(47, 'C1. Capacidades de las OSC en gestión de proyectos y empresas sociales fortalecidas mediante formación y desarrollo de herramientas para la viabilidad económica y social.', 44, 0, NULL, NULL),
(48, 'C2. Empresas sociales desarrolladas y consolidadas a través de la implementación de versiones iniciales, su fortalecimiento y continuidad.', 45, 0, NULL, NULL),
(49, 'C3. Empresas sociales integradas en estrategias de financiamiento de las OSC, promoviendo su autosostenibilidad y su impacto en el sector social.', 46, 0, NULL, NULL),
(50, 'C1. Espacios de diálogo y deliberación comunitaria establecidos.', 47, 0, NULL, NULL),
(51, 'C2. Grupos vecinales formalizados y fortalecidos para la representación y gestión comunitaria.', 48, 0, NULL, NULL),
(52, 'C3. Planes de activación comunitaria validados y comprobados.', 49, 0, NULL, NULL),
(53, 'C4. Materiales informativos y metodológicos desarrollados y distribuidos.', 50, 0, NULL, NULL),
(54, 'C1. Comités ciudadanos para la vigilancia y gestión del entorno urbano creados y fortalecidos.', 51, 0, NULL, NULL),
(55, 'C2. Acciones comunitarias de mejora urbana implementadas, incluyendo reforestación, gestión de residuos y ecotecnias para el mejoramiento de espacios públicos.', 52, 0, NULL, NULL),
(56, 'C3. Iniciativas de urbanismo táctico implementadas en espacios subutilizados.', 53, 0, NULL, NULL),
(57, 'C1. Herramientas de incidencia desarrolladas y apropiadas por los ciudadanos.', 54, 0, NULL, NULL),
(58, 'C2. Agendas de incidencia ciudadana diseñadas e implementadas, con participación ciudadana.', 55, 0, NULL, NULL),
(59, 'C3.1. Mesas de trabajo sectoriales organizadas con la participación de actores ciudadanos, públicos y privados.', 56, 0, NULL, NULL),
(60, 'C3.2.  Redes de colaboración intersectorial establecidas para la implementación de proyectos de incidencia ciudadana.', 56, 0, NULL, NULL),
(61, 'C3. 3.  Propuestas ciudadanas presentadas y seguidas ante grupos de interés, para influir en la toma de decisiones (gobernanza).', 56, 0, NULL, NULL),
(62, 'C1. Capacidades para el voluntariado fortalecidas mediante talleres y programas de formación.', 57, 0, NULL, NULL),
(63, 'C2.1 Herramientas de organización, gestión y seguimiento del voluntariado implementadas, incluyendo el Banco de Tiempo y manuales de gestión.', 58, 0, NULL, NULL),
(64, 'C2.2. Sistema de gestión de voluntariado implementado, para gestionar las actividades voluntarias.', 58, 0, NULL, NULL),
(65, 'C3. Redes de voluntariado corporativo establecidas, para articular empresas y comunidades.', 59, 0, NULL, NULL),
(66, 'C1. Espacios públicos con programación cultural.', 60, 0, NULL, NULL),
(67, 'C2. Talento local y economía creativa fomentados.', 61, 0, NULL, NULL),
(68, 'C3. Colaboración entre talentos locales promovida.', 62, 0, NULL, NULL),
(69, 'C1. Procesos gubernamentales monitoreados y analizados.', 63, 0, NULL, NULL),
(70, 'C2. Estrategias de cabildeo generadas y presentadas.', 64, 0, NULL, NULL),
(71, 'C3. Informes ciudadanos elaborados y difundidos.', 65, 0, NULL, NULL),
(72, 'C1. Procesos de contratación pública monitoreados y analizados.', 66, 0, NULL, NULL),
(73, 'C2. Riesgos de corrupción identificados en los procesos de contratación pública.', 67, 0, NULL, NULL),
(74, 'C3. Costo de la corrupción administrativa estimado.', 68, 0, NULL, NULL),
(75, 'C4. Informes de corrupción elaborados y difundidos.', 69, 0, NULL, NULL),
(76, 'C1. Asesorías legales brindadas sobre mecanismos de participación ciudadana, Derechos Humanos y Urbanos, y demandas de amparo.', 70, 0, NULL, NULL),
(77, 'C2. Análisis técnicos realizados sobre normatividad urbana y derechos ciudadanos.', 71, 0, NULL, NULL),
(78, 'C3. Talleres educativos impartidos a la ciudadanía en el ejercicio de sus derechos.', 72, 0, NULL, NULL),
(79, 'C4. Materiales educativos generados para la ciudadanía en el ejercicio de sus derechos generados.', 73, 0, NULL, NULL),
(80, 'C1. Informes de percepción ciudadana realizados.', 74, 0, NULL, NULL),
(81, 'C2. Panel de indicadores clave actualizado.', 75, 0, NULL, NULL),
(82, 'C3. Análisis y seguimiento de la normatividad urbana y ambiental elaborados.', 76, 0, NULL, NULL),
(83, 'C4.1.  Informes específicos sobre áreas clave de interés público publicados.', 77, 0, NULL, NULL),
(84, 'C4.2.  Informes temáticos y territoriales publicados.', 77, 0, NULL, NULL),
(85, 'C4.3. Informe binacional publicado.', 77, 0, NULL, NULL),
(86, 'C5. Seminarios y eventos multisectoriales organizados para presentar hallazgos y fomentar el diálogo.', 78, 0, NULL, NULL),
(87, 'C1. Estrategias de comunicación digital y territorial desplegadas.', 79, 0, NULL, NULL),
(88, 'C2. Campañas de incidencia en la opinión públicas implementadas.', 80, 0, NULL, NULL),
(89, 'C3. Producciones, gráficas, interactivas y audiovisuales y diseño editorial desarrolladas.', 81, 0, NULL, NULL),
(90, 'C4. Capacitaciones en estrategias de comunicación realizadas.', 82, 0, NULL, NULL),
(91, 'C5. Iniciativas de las osc difundidas.', 83, 0, NULL, NULL),
(92, 'C1. Contenidos informativos elaborados sobre actividades estratégicas y problemáticas territoriales.', 84, 0, NULL, NULL),
(93, 'C2. Actores clave y Organizaciones de la Sociedad Civil (OSC) visibilizados y fortalecidos.', 85, 0, NULL, NULL),
(94, 'C3. Análisis e investigaciones realizadas sobre procesos de contratación pública y casos de corrupción.', 86, 0, NULL, NULL),
(95, 'C4. Experiencias exitosas de participación ciudadana y comunitaria documentadas y difundidas.', 87, 0, NULL, NULL),
(96, 'C1. Planes de bienestar personalizados diseñados e implementados.', 88, 0, NULL, NULL),
(97, 'C2. Talleres y cursos de formación desarrollados y ejecutados.', 89, 0, NULL, NULL),
(98, 'C3. Materiales educativos y recursos de aprendizaje creados y distribuidos.', 90, 0, NULL, NULL),
(99, 'C4. Redes de intercambio y colaboración entre el personal de OSC activadas y fortalecidas.', 91, 0, NULL, NULL),
(100, 'C5. Capacidades del personal del GPJ fortalecidas mediante procesos de formación continua y desarrollo profesional.', 92, 0, NULL, NULL),
(101, 'C1. Proyectos estratégicos diseñados e implementados basados en diagnósticos locales.', 93, 0, NULL, NULL),
(102, 'C2. Sistema de monitoreo implementado para el seguimiento de los proyectos.', 94, 0, NULL, NULL),
(103, 'C3. Alianzas multisectoriales establecidas para la sostenibilidad de los proyectos.', 95, 0, NULL, NULL),
(104, 'C1. Gestión documental del GPJ unificada y optimizada para mejorar la organización y acceso a la información.', 96, 0, NULL, NULL),
(105, 'C2. Procesos operativos y administrativos automatizados para aumentar la eficiencia y reducir la carga operativa.', 97, 0, NULL, NULL),
(106, 'C1. Estrategias de fidelización y fortalecimiento de la relación con donantes y aliados estratégicos implementadas.', 98, 0, NULL, NULL),
(107, 'C2. Estrategias de captación y crecimiento de la base de donantes desarrolladas e implementadas para fortalecer la sostenibilidad financiera.', 99, 0, NULL, NULL),
(108, 'C3. Mecanismos innovadores de financiamiento y generación de ingresos diseñados y operando para diversificar las fuentes de sostenibilidad económica (incubadora de empresas sociales)', 100, 0, NULL, NULL),
(109, 'C1. Estrategias de mantenimiento preventivo y correctivo implementadas para garantizar la sostenibilidad y buen estado de los bienes muebles e inmuebles del GPJ.', 101, 0, NULL, NULL),
(110, 'C2. Espacios disponibles para renta optimizados y gestionados eficientemente para maximizar su aprovechamiento y funcionalidad.', 102, 0, NULL, NULL),
(111, 'C3. Estrategias de difusión y promoción de los espacios disponibles implementadas en redes sociales y otros canales de comunicación.', 103, 0, NULL, NULL),
(112, 'C1. Estrategias de digitalización y automatización implementadas para optimizar los procesos internos y mejorar la eficiencia operativa.', 104, 0, NULL, NULL),
(113, 'C2. Metodologías ágiles y herramientas innovadoras adoptadas y aplicadas para fortalecer la gestión organizacional y la capacidad adaptativa del equipo.', 105, 0, NULL, NULL),
(114, 'C3. Capacidades del equipo fortalecidas mediante formación en innovación organizacional, nuevas tecnologías y metodologías de trabajo.', 106, 0, NULL, NULL),
(115, 'C4. Sistema de monitoreo y mejora continua diseñado e implementado para evaluar la eficiencia, efectividad y sostenibilidad de los procesos internos.', 107, 0, NULL, NULL),
(116, 'C1. Estrategias de comunicación diseñadas e implementadas para fortalecer la identidad y presencia del GPJ.', 108, 0, NULL, NULL),
(117, 'C2. Canales de difusión optimizados y operando para ampliar el alcance y visibilidad de las acciones del GPJ.', 109, 0, NULL, NULL),
(118, 'C3. Estrategias de articulación y vinculación con actores clave desarrolladas e implementadas para fortalecer el posicionamiento institucional.', 110, 0, NULL, NULL),
(119, 'C4. Herramientas y materiales de comunicación innovadores creados y distribuidos para mejorar la proyección y difusión de la organización.', 111, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `data_publications`
--

CREATE TABLE `data_publications` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `published_by` bigint UNSIGNED NOT NULL,
  `publication_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `metrics_count` int NOT NULL DEFAULT '0',
  `projects_count` int NOT NULL DEFAULT '0',
  `activities_count` int NOT NULL DEFAULT '0',
  `period_from` date DEFAULT NULL,
  `period_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `financiers`
--

CREATE TABLE `financiers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financiers`
--

INSERT INTO `financiers` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Fundación del Empresariado Chihuahuense (FECHAC) ', '2025-07-21 19:27:06', '2025-07-21 19:27:06'),
(2, 'Fundación Comunitaria de la Frontera Norte A.C.', '2025-07-21 20:35:49', '2025-07-21 20:35:49'),
(3, 'Plan Estratégico de Juárez A.C.', '2025-07-30 15:28:43', '2025-07-30 15:28:43');

-- --------------------------------------------------------

--
-- Table structure for table `goals`
--

CREATE TABLE `goals` (
  `id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `number` int DEFAULT NULL,
  `components_id` bigint UNSIGNED NOT NULL,
  `components_action_lines_id` bigint UNSIGNED NOT NULL,
  `components_action_lines_program_id` bigint UNSIGNED NOT NULL,
  `organizations_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `goals`
--

INSERT INTO `goals` (`id`, `project_id`, `description`, `number`, `components_id`, `components_action_lines_id`, `components_action_lines_program_id`, `organizations_id`, `created_at`, `updated_at`) VALUES
(47, 1, '1.1 Realizar 4 jornadas de limpieza comunitaria y reforestación en espacios públicos y escuelas en el polígono de Riberas del Bravo durante el primer año del proyecto entre noviembre/2024 y mayo/2025.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(48, 1, '1.2 Que al menos 80 personas participen en las jornadas de limpieza comunitaria y reforestación en espacios públicos y escuelas en el polígono de Riberas del Bravo durante el primer año del proyecto entre noviembre/2024 y mayo/2025.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(49, 1, '2.1 Llevar a cabo 11 actividades de divulgación de ecotecnias y educación ambiental en las comunidades de Riberas del Bravo y el suroriente de Juárez entre junio y noviembre de 2025, para mejorar su entorno urbano y fortalecer la cohesión social.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(50, 1, '2.1 Involucrar a al menos 58 personas en actividades para conocer el arbolado urbano apropiado para la región en 06/2025.', NULL, 56, 53, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(51, 1, '2.2 Involucrar a al menos 58 personas en actividades para conocer las técnicas de riego eficiente en 07/2025.\n', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(52, 1, '2.3 Involucrar a al menos 58 personas en actividades para gestionar apropiadamente los residuos sólidos en 08/2025.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(53, 1, '2.4 Involucrar a al menos 58 personas en actividades para aprovechar los residuos orgánicos en compostaje en 09/2025.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(54, 1, '2.5 Involucrar a al menos 58 personas en talleres de tenencia responsable de animales de compañía en 10/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(55, 1, '2.6 Involucrar a al menos 60 personas en talleres de bioplaguicidas caseros en 11/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(56, 1, '3.1 Establecer y poner en funcionamiento dos huertos urbanos en Riberas del Bravo durante 2025, a través de talleres de huertos urbanos y actividades de rendimiento de huertos.', NULL, 56, 53, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(57, 1, '3.1.1 Llevar a cabo 3 actividades de introducción a los huertos urbanos en Riberas del Bravo entre 01/2025 y 02/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(58, 1, '3.1.2 Llevar a cabo 2 actividades lúdicas de creatividad para codiseñar dos espacios comunitarios para huertos urbanos en Riberas del Bravo en 02/2025.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(59, 1, '3.1.3 Llevar a cabo 6 sesiones de montaje y construcción comunitaria de dos huertos urbanos en Riberas del Bravo en 03/2025.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(60, 1, '3.1.4 Llevar a cabo 3 actividades para generar huertos caseros urbanos en Riberas del Bravo en 04/2025.', NULL, 55, 52, 18, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(61, 1, '3.1.5 Impartir 3 talleres de mantenimiento de huertos urbanos en Riberas del Bravo en 05/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(62, 1, '3.1.6 Llevar a cabo 3 talleres de introducción a los huertos agroecológicos como espacios que fomentan la corresponsabilidad y la vinculación comunitaria en Riberas del Bravo en 06/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(63, 1, '3.1.7 Llevar a cabo 3 talleres de identificación de plagas en huertos urbanos y su tratamiento, en Riberas del Bravo en 07/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(64, 1, '3.1.8 Llevar a cabo 3 talleres de rotación y asociación de cultivos en huertos urbanos, en Riberas del Bravo en 08/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(65, 1, '3.1.9 Llevar a cabo 4 talleres de productos bioculturales comestibles en Riberas del Bravo en 09/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(66, 1, '3.1.10 Llevar a cabo 3 actividades comunitarias de intercambio de plantas y productos del huerto en Riberas del Bravo en 10/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(67, 1, '3.1.11 Llevar a cabo 3 actividades de rendimiento y preparación invernal del suelo de huertos urbanos, en Riberas del Bravo en 11/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(68, 1, '3.1.12 Llevar a cabo 2 talleres de cuidados invernales de huertos urbanos y plantas caseras en Riberas del Bravo en 12/2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(69, 1, '3.2 Lograr la participación de al menos 220 personas en actividades relacionadas con los huertos urbanos entre enero y diciembre de 2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(70, 3, '1.1. 30 talleres de participación ciudadana avanzados para comunidades en seguimiento con al menos 7 personas cada uno a diciembre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 15:57:20', '2025-08-01 15:57:20'),
(71, 3, '1.2. 6 seminarios de derecho a la ciudad para comunidades en seguimiento con al menos 7 personas cada uno a octubre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:16:44', '2025-08-01 16:16:44'),
(72, 3, '1.3. 6 seminarios de diseño participativo para comunidades en seguimiento con al menos 7 personas cada uno a diciembre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:19:34', '2025-08-01 16:19:34'),
(73, 3, '1.4. 30 talleres de participación ciudadana básicos para comunidades nuevas con al menos 7 personas cada uno a diciembre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:23:00', '2025-08-01 16:23:00'),
(74, 3, '1.5. 6 seminarios de participación ciudadana para comunidades en seguimiento con al menos 10 personas cada uno a diciembre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:28:23', '2025-08-01 16:28:23'),
(75, 3, '1.6. 12 seminarios de participación ciudadana para niñas, niños y adolescentes con al menos 30 personas cada uno a octubre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:42:24', '2025-08-01 16:42:24'),
(76, 3, '1.7. 10 talleres de participación ciudadana básicos con al menos 7 personas cada uno a diciembre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:46:47', '2025-08-01 16:46:47'),
(77, 3, '1.8. 2 seminarios de participación ciudadana con al menos 10 personas cada uno a diciembre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:46:47', '2025-08-01 16:49:54'),
(78, 3, '1.9. 2 seminarios de participación ciudadana para niñas, niños y adolescentes con al menos 30 personas cada uno a octubre del 2025', NULL, 4, 3, 3, 5, '2025-08-01 16:52:03', '2025-08-01 16:52:03'),
(79, 3, '2.1. 36 comunidades vecinales en seguimiento con al menos 5 personas cada una a diciembre del 2025', NULL, 51, 48, 17, 5, '2025-08-01 17:07:29', '2025-08-01 17:09:29'),
(80, 3, '2.2. 36 diálogos vecinales para comunidades en seguimiento con al menos 7 personas cada uno a diciembre del 2025', NULL, 50, 47, 17, 5, '2025-08-01 17:09:29', '2025-08-01 17:09:29'),
(81, 3, '2.3. 36 planes de acción avanzados para comunidades en seguimiento derivados de los diálogos vecinales a diciembre del 2025', NULL, 52, 49, 17, 5, '2025-08-01 17:51:14', '2025-08-01 17:51:14'),
(82, 3, '2.4. 36 actividades comunitarias para comunidades en seguimiento con al menos 10 personas cada una a diciembre del 2025', NULL, 51, 48, 17, 5, '2025-08-01 17:52:52', '2025-08-01 17:52:52'),
(83, 3, '2.5. 6 asambleas comunitarias para comunidades en seguimiento con al menos 30 personas cada una a octubre del 2025', NULL, 50, 47, 17, 5, '2025-08-01 17:57:28', '2025-08-01 17:57:28'),
(84, 3, ' 2.6. 60 gestiones comunitarias para comunidades en seguimiento a diciembre del 2025', NULL, 56, 53, 18, 5, '2025-08-01 17:57:28', '2025-08-01 17:57:28'),
(85, 3, '2.7. 6 talleres de vigilancia de obra pública para comunidades en seguimiento con al menos 7 personas cada uno a octubre del 2025', NULL, 54, 51, 18, 5, '2025-08-01 18:00:50', '2025-08-01 18:00:50'),
(86, 3, '2.8. 6 comités ciudadanos de vigilancia de obra para comunidades en seguimiento con al menos 7 personas cada uno a octubre del 2025', NULL, 54, 51, 18, 5, '2025-08-01 18:00:50', '2025-08-01 18:00:50'),
(87, 3, '2.9. 6 recorridos exploratorios para comunidades en seguimiento con al menos 7 personas cada uno a octubre del 2025', NULL, 6, 3, 3, 5, '2025-08-01 18:04:45', '2025-08-01 18:04:45'),
(88, 3, '2.10. 6 proyectos comunitarios propuestos por la comunidad en espacios de participación ciudadana a diciembre del 2025', NULL, 52, 49, 17, 5, '2025-08-01 18:04:45', '2025-08-01 18:04:45'),
(89, 3, '2.11. 36 comunidades vecinales nuevas conformadas por al menos 5 personas cada una a diciembre del 2025', NULL, 51, 48, 17, 5, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(90, 3, '2.12. 36 diálogos vecinales para comunidades nuevas con al menos 7 personas cada uno a diciembre del 2025', NULL, 50, 47, 17, 5, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(91, 3, '2.13. 36 planes de acción comunitarios básicos para comunidades nuevas derivados de los diálogos vecinales a diciembre del 2025', NULL, 52, 49, 17, 5, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(92, 3, '2.14. 36 actividades comunitarias para comunidades nuevas con al menos 10 personas cada una a diciembre del 2025', NULL, 51, 48, 17, 5, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(93, 3, '2.15. 60 gestiones comunitarias para comunidades nuevas a diciembre del 25', NULL, 56, 53, 18, 5, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(94, 3, '2.16. 28 proyectos ciudadanos para el presupuesto participativo a diciembre del 2025', NULL, 52, 49, 17, 5, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(95, 3, '2.17. 6 comités ciudadanos de vigilancia de obra para comunidades nuevas con al menos 7 personas cada uno a octubre del 2025\n', NULL, 54, 51, 18, 5, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(96, 3, '2.18. 12 comunidades vecinales nuevas conformadas por al menos 5 personas cada una a diciembre del 2025', NULL, 51, 48, 17, 5, '2025-08-01 19:19:57', '2025-08-01 19:19:57'),
(97, 3, '2.20. 12 planes de acción comunitarios derivados de los diálogos vecinales a diciembre del 2025', NULL, 52, 49, 17, 5, '2025-08-01 19:33:24', '2025-08-01 19:33:24'),
(98, 3, '2.21. 12 actividades comunitarias con al menos 10 personas cada una  a diciembre del 2025', NULL, 51, 48, 17, 5, '2025-08-01 19:33:24', '2025-08-01 19:33:24'),
(99, 3, '2.22. 20 gestiones comunitarias a diciembre del 2025', NULL, 56, 53, 18, 5, '2025-08-01 19:33:24', '2025-08-01 19:36:17'),
(100, 3, '2.23. 4 proyectos ciudadanos para el presupuesto participativo a diciembre del 2025', NULL, 52, 49, 17, 5, '2025-08-01 19:36:17', '2025-08-01 19:36:17'),
(101, 3, '2.24. 2 comités ciudadanos de vigilancia de obra con al menos 7 personas cada uno a octubre del 2025 ', NULL, 54, 51, 18, 5, '2025-08-01 19:40:04', '2025-08-01 19:40:04'),
(102, 3, '2.25. 60 personas participan en las 6 sesiones de asesorías jurídicas comunitarias para temas de derecho a la ciudad durante el año', NULL, 76, 70, 24, 5, '2025-08-01 19:40:04', '2025-08-01 19:40:04'),
(103, 3, '2.26. 40 personas participan en los 4 Talleres de normativa en derecho a la ciudad durante el año', NULL, 4, 3, 3, 5, '2025-08-01 19:41:53', '2025-08-01 19:41:53'),
(104, 3, '3.1 200 personas asisten a los Informes Territoriales en los polígonos (9 meses, 2  informes) a septiembre de 2025.', NULL, 84, 77, 25, 3, '2025-08-01 19:45:59', '2025-08-01 19:45:59'),
(105, 3, '3.2 Publicación de 24 investigaciones periodísticas sobre temas relacionados con problemáticas comunitarias y participación ciudadana (24 investigaciones publicadas, 12 meses)', NULL, 92, 84, 27, 9, '2025-08-01 19:45:59', '2025-08-01 19:54:17'),
(106, 3, '3.3 Publicación de 600 contenidos periodísticos sobre temas relacionados con problemáticas comunitarias participación ciudadana (600 notas publicadas, 12 meses).', NULL, 92, 84, 27, 9, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(107, 3, '3.4 Realizar 4 análisis sobre cumplimiento de leyes, reglamentos y normas en materia anticorrupción por parte del Municipio de Juárez, a través de herramientas de transparencia, manejo archivístico y vigilancia (4 análisis trimestrales, 12 meses). ', NULL, 77, 71, 24, 3, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(108, 3, '3.5 Llevar a cabo el seguimiento del actuar de los tomadores de decisiones a través del monitoreo de  sesiones de 9  de comisiones clave de regidores (4 seguimientos trimestrales, 12 meses).', NULL, 69, 63, 22, 3, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(109, 3, '3.6  Las 24 sesiones de cabildo (2 por mes durante 12 meses).', NULL, 69, 63, 22, 3, '2025-08-01 19:59:52', '2025-08-01 19:59:52'),
(110, 3, '3.7 Realizar el cumplimiento al PMD a través de 4 seguimientos (1 seguimiento trimestral) de sus indicadores.', NULL, 69, 63, 22, 3, '2025-08-01 19:59:52', '2025-08-01 19:59:52'),
(111, 3, '4.1 600 personas asisten a los eventos para la presentación de información clave de la ciudad, resultada del seguimiento de la AJ2030 y AEJ (8 Informes, 12 meses).', NULL, 83, 77, 25, 3, '2025-08-01 20:05:05', '2025-08-01 20:05:05'),
(121, 3, '5.1 Generación de contenidos informativos para el sitio web: 120 contenidos sobre mecanismos de participación ciudadana y toma de decisiones se generan y publican en el sitio web de Plan Estratégico, incluyendo boletines, reportajes y notas durante un periodo de 12 meses, a diciembre de 2025.', NULL, 89, 81, 26, 3, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(122, 3, '5.2. Publicación de contenidos digitales en redes sociales: 96 contenidos se publican en redes sociales durante un periodo de 12 meses, a diciembre de 2025, utilizando formatos como contenidos visuales, videos, contenidos interactivos, contenidos educativos y contenidos promocionales.', NULL, 89, 81, 26, 3, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(123, 3, '5.3. Concientización comunitaria y planificación estratégica: Se diseña e implementa un plan de comunicación que incluye objetivos, análisis de público met, mensajes clave, selección de canales, cronograma, estrategias específicas, asignación de recursos y métricas de evaluación, para fomentar la participación ciudadana e involucramiento comunitario que se aplicará durante 12 meses, a diciembre de 2025.', NULL, 87, 79, 26, 3, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(124, 3, '5.4. Diseño de materiales impresos informativos para informes territoriales: 24 diseños informativos se generan para impresión en materiales rígidos y 8 diseños informativos para impresión de lonas, destinados a fortalecer la difusión visual de los informes territoriales durante un periodo de 12 meses, a diciembre de 2025.', NULL, 91, 83, 26, 3, '2025-08-01 20:20:43', '2025-08-01 20:20:43');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kpis`
--

CREATE TABLE `kpis` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `initial_value` decimal(10,2) DEFAULT NULL,
  `final_value` decimal(10,2) DEFAULT NULL,
  `projects_id` bigint UNSIGNED NOT NULL,
  `is_percentage` tinyint(1) DEFAULT NULL,
  `org_area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `neighborhood` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `int_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_place_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `polygons_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `category`, `street`, `neighborhood`, `ext_number`, `int_number`, `google_place_id`, `polygons_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Parque C. Rivera de Urique', 'Parque público', 'C. Rivera de Urique  y C. Rivera del Cozumel', 'Riberas del Bravo', NULL, NULL, 'Ek5SaXZlcmEgZGUgVXJpcXVlLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iLiosChQKEglPhNEqWGjnhhHIO0pzzjeDxxIUChIJ0UCA7fdo54YRnEyYikVxXHk Rivera de Urique, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 20:55:18', '2025-07-24 21:38:21'),
(2, ' Parque C. Rivera de Peñasco y Rivera de Ixtapa', 'Parque público', 'C. Rivera de Peñasco y Rivera de Ixtapa', 'Riberas del Bravo', NULL, NULL, 'EmZDLiBSaXZlcmEgUGXDsWFzY28gJiBDLiBSaXZlcmEgZGUgSXh0YXBhLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEgk3Ryk6V2jnhhEWukjBZTpCIhIUChIJN0cpOldo54YRFrpIwWU6QiIaFAoSCSEBILL4aOeGEYOlVRGB6W9xGhQKEgkZAbDfWWjnhhHvyA1csT8y1yIKDUV42BIVxnqiwA C. Rivera Peñasco & C. Rivera de Ixtapa, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:17:46', '2025-07-24 22:00:08'),
(3, ' Parque C. Rivera Peñasco y del Florido', 'Parque público', 'C. Rivera Peñasco y C. del Florido', 'Riberas del Bravo', NULL, NULL, 'EmFDLiBSaXZlcmEgUGXDsWFzY28gJiBDLiBkZWwgRmxvcmlkbywgUGFyY2VsYXMgRWppZG8gSmVzw7pzIENhcnJhbnphLCAzMjU5NCBKdcOhcmV6LCBDaGloLiwgTWV4aWNvImYiZAoUChIJPx-ny_ho54YRRGIVsr4zPVkSFAoSCT8fp8v4aOeGEURiFbK-Mz1ZGhQKEgkhASCy-GjnhhGDpVURgelvcRoUChIJq17Kwvho54YRM01ayC4VFRciCg3RkdcSFVoSo8A C. Rivera Peñasco & C. del Florido, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:23:48', '2025-07-24 21:59:28'),
(4, ' Parque C. Rivera Peñasco y Rivera de Altamira', 'Parque público', ' C. Rivera Peñasco y Rivera de Altamira S/N', 'Riberas del Bravo', NULL, NULL, 'EmhDYWxsZSBSaXZlcmEgUGXDsWFzY28gJiBSaXZlcmEgZGUgQWx0YW1pcmEsIFBhcmNlbGFzIEVqaWRvIEplc8O6cyBDYXJyYW56YSwgMzI1OTQgSnXDoXJleiwgQ2hpaC4sIE1leGljbyJmImQKFAoSCTfavhtXaOeGEcHUrUVFOR8OEhQKEgk32r4bV2jnhhHB1K1FRTkfDhoUChIJIQEgsvho54YRg6VVEYHpb3EaFAoSCVVeLg1XaOeGEVTtuSBptYspIgoNQlPYEhV0j6LA Calle Rivera Peñasco & Rivera de Altamira, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:28:35', '2025-07-24 21:39:29'),
(5, 'Telebachillerato 8688 Víctor Hugo Rascón Banda', 'Escuela pública', 'C. Rivera de Agua Blanca y Ribera de la Bahía', 'Riberas del Bravo', NULL, NULL, 'ChIJmfjAJktp54YRmDZOgFd48Ek Rivera de Agua Blanca y Ribera de la Bahia Col, Rivera del Bravo, Riberas de bravo etapa I, 32594 Juárez, Chih., México', 1, 3, '2025-07-24 21:35:45', '2025-07-24 21:35:45'),
(6, 'Parque C. Rivera Batopilas y del Florido', 'Parque público', 'C. Rivera Batopilas y del Florido', 'Riberas del Bravo', NULL, NULL, 'EmVSaXZlcmEgZGUgQmF0b3BpbGFzICYgQ2FsbGUgZGVsIEZsb3JpZG8sIFBhcmNlbGFzIEVqaWRvIEplc8O6cyBDYXJyYW56YSwgMzI1OTQgSnXDoXJleiwgQ2hpaC4sIE1leGljbyJmImQKFAoSCX_qasP4aOeGEeJ-rAmCjDuPEhQKEgl_6mrD-GjnhhHifqwJgow7jxoUChIJU_us6vho54YRLoW3DlANepQaFAoSCateysL4aOeGETNNWsguFRUXIgoNHYHXEhUt7qLA Rivera de Batopilas & Calle del Florido, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:43:07', '2025-07-24 21:59:52'),
(7, 'Parque C. Rivera de Mezquite y Rivera de Galeon', 'Parque público', 'C. Rivera de Mezquite y Rivera de Galeon', 'Riberas del Bravo', NULL, NULL, 'EmNSaXZlcmEgZGUgTWV6cXVpdGUgJiBSaXZlcmEgZGUgR2FsZW9uLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEglXoHcV-2jnhhGF64Y9XWijpRIUChIJV6B3Ffto54YRheuGPV1oo6UaFAoSCTlCAUf7aOeGEULSsAELNtX9GhQKEgnp0vwi-2jnhhEpAjanth4pgSIKDVdT1hIVKNqiwA Rivera de Mezquite & Rivera de Galeon, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:58:45', '2025-07-24 21:58:45'),
(8, 'Parque C. Rincon de Río Conchos y Rincon de Río Verde', 'Parque público', 'C. Rincon de Río Conchos y Rincon de Río Verde', 'Riberas del Bravo', NULL, NULL, 'EoMBQy4gUmluY29uIGRlIFLDrW8gQ29uY2hvcyAmIEMuIFJpbmNvbiBkZWwgUmlvIFZlcmRlLCBSaW5jw7NuIGRlbCBSw61vLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEgnFwRbMUWjnhhHwLW_VJ8u_mRIUChIJxcEWzFFo54YR8C1v1SfLv5kaFAoSCSld1NJRaOeGEWcLjmgER8CoGhQKEgll2hbMUWjnhhEgfNrq1mj8QSIKDR5T2RIVIreiwA C. Rincon de Río Conchos & C. Rincon del Rio Verde, Rincón del Río, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 22:16:13', '2025-07-24 22:16:13'),
(9, 'Parque del Valle', 'Parque público', 'Av. Universidad Tecnológica', 'Hacienda de la Torres Universidad', 'S/N', NULL, 'ChIJ9cukO1Zm54YR-Lku-3Nw_6Q Av. Universidad Tecnológica s/n, Hacienda de las Torres Universidad, 32576 Juárez, Chih., México', 5, 4, '2025-08-01 20:42:52', '2025-08-11 16:17:44'),
(10, 'Parque Ilusion', 'Parque público', 'Praderas del Sol ', 'Mezquital', 'SN', NULL, 'ChIJZ6xpeu1m54YRbBsfP_QBLGU Praderas del Sol s/n, Praderas del Sur, 32575 Juárez, Chih., México', 5, 10, '2025-08-01 21:25:42', '2025-08-11 16:17:59'),
(11, 'Parque Puerto Anzio', 'Parque público', 'Puerto Anzio', 'Tierra Nueva', NULL, NULL, NULL, 6, 4, '2025-08-06 19:31:26', '2025-08-06 19:31:26'),
(12, 'Parque Prados del recuerdo', 'Parque público', 'prados del recuerdo', 'Urbivilla del Prado 1', 'S/N', NULL, 'EkhQcmFkb3MgZGVsIFJlY3VlcmRvICYgUHJhZG9zIGRlIExhcyBGbG9yZXMsIDMyNTc1IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEgmVN-fN92XnhhEzwEjwpBvr2xIUChIJlTfnzfdl54YRM8BI8KQb69saFAoSCfnryM33ZeeGETucEO9n0SCNGhQKEgnTY7oOWG_nhhG1Knyy-hJauCIKDaIkzhIVGbOcwA Prados del Recuerdo & Prados de Las Flores, 32575 Juárez, Chih., México', 6, 4, '2025-08-06 19:42:02', '2025-08-06 19:42:02'),
(19, 'Parque Granados', 'Parque público', 'Portal del Membrillo', 'Portal del Roble 2', 'S/D', 'S/D', 'ChIJyW_BqeJp54YR6-L6QC5nS2o', 6, 4, '2025-08-06 22:46:08', '2025-08-06 22:46:08'),
(20, 'Centro Comunitario Municipio Libre', 'Centro Comunitario', 'Efrain Gonzalez Luna', 'Municipio Libre', 'S/D', NULL, ' ChIJmfKvnFRm54YRe1K3kHeaoKk', 5, 4, '2025-08-07 15:35:49', '2025-08-07 15:35:49'),
(21, 'Domicilio Particular Calle Verbena ', 'Domicilio Particular', 'Verbena', 'El Mezquital', '1665', NULL, 'Ei9WZXJiZW5hIDE2NTctMTY2OSwgMzI1NzYgSnXDoXJleiwgQ2hpaC4sIE1leGljbyIgGh4KFgoUChIJi_E0nvpm54YRRtFcxBKulPMSBDE2Njk Verbena 1657-1669, 32576 Juárez, Chih., México', 5, 4, '2025-08-07 15:54:20', '2025-08-11 16:16:52'),
(22, 'Domicilio particular calle Mezquite Verde', 'Domicilio Particular', 'Mezquite verde', 'El Mezquital', '2975', 'S/D', 'EjFNZXpxdWl0ZSBWZXJkZSAyOTc1LCAzMjU3NiBKdcOhcmV6LCBDaGloLiwgTWV4aWNvIjESLwoUChIJ85UftvNm54YRPWcodWSSD_0QnxcqFAoSCXVxelTxZueGEZpaZ0CoOjBc Mezquite Verde 2975, 32576 Juárez, Chih., México', 5, 4, '2025-08-07 16:06:40', '2025-08-07 16:06:40'),
(24, 'Parque Condominio del Valle 3', 'Parque Publico ', 'Condominio del Valle 3', 'Universidad', 'S/D', 'S/D', 'El5DYWxsZSBBdmVuaWRhIFVuaXZlcnNpZGFkIFRlY25vbG9naWNhICYgQ29uZG9taW5pbyBkZWwgVmFsbGUgSUlJLCAzMjU3NiBKdcOhcmV6LCBDaGloLiwgTWV4aWNvImYiZAoUChIJ92NUJVZm54YRncnNQ4UiR1YSFAoSCfdjVCVWZueGEZ3JzUOFIkdWGhQKEgmFDlklVmbnhhFfbLKLD6H7HxoUChIJ21iULVZm54YR_OwUpr6sJ9giCg1c69QSFTO_lcA Calle Avenida Universidad Tecnologica & Condominio del Valle III, 32576 Juárez, Chih., México', 5, 4, '2025-08-07 17:00:28', '2025-08-07 17:00:28'),
(25, 'Parque Publico Condominio del Valle 1', 'Parque Publico', 'Condominio del Valle 1', 'El Mezquital', 'S/D', 'S/D', 'ElxDYWxsZSBBdmVuaWRhIFVuaXZlcnNpZGFkIFRlY25vbG9naWNhICYgQ29uZG9taW5pbyBkZWwgVmFsbGUgSSwgMzI1NzYgSnXDoXJleiwgQ2hpaC4sIE1leGljbyJmImQKFAoSCRVB2zlWZueGEdLvCiDJa3mLEhQKEgkVQds5VmbnhhHS7wogyWt5ixoUChIJhQ5ZJVZm54YRX2yyiw-h-x8aFAoSCadrNDxWZueGEVxcZe8w2vvQIgoNwO7UEhU505XA', 5, 4, '2025-08-07 17:04:19', '2025-08-07 17:04:19'),
(26, 'Parque Palmillo', 'Parque publico', 'Palmillo', 'El Mezquital', 'S/D', 'S/D', 'EjdNZXpxdWl0ZSBWZXJkZSAmIFBhbG1pbGxvLCAzMjU3NiBKdcOhcmV6LCBDaGloLiwgTWV4aWNvImYiZAoUChIJgWft_vZm54YRmlIiRuIpyMYSFAoSCYFn7f72ZueGEZpSIkbiKcjGGhQKEgl1cXpU8WbnhhGaWmdAqDowXBoUChIJezIdA_dm54YRZ69mrACwjEciCg2M29MSFX4nlcA Mezquite Verde & Palmillo, 32576 Juárez, Chih., México', 5, 4, '2025-08-07 17:08:55', '2025-08-07 17:08:55'),
(27, 'Parque  Francisco Villa y Benito Juárez', 'Parque Publico', ' Francisco Villa ', 'Zaragoza', 'S/D', 'S/D', 'EkhGcmFuY2lzY28gVmlsbGEgJiBCZW5pdG8gSnXDoXJleiwgWmFyYWdvemEsIDMyNTkwIEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEglJRFxA-mfnhhGaHrEQG9_QyRIUChIJSURcQPpn54YRmh6xEBvf0MkaFAoSCfnKl4XvZ-eGETss4ZZR1oQ5GhQKEgkXhz2KimfnhhFZlwEY4AdqOCIKDZqB3BIVJEibwA', 6, 4, '2025-08-07 18:54:11', '2025-08-07 18:54:11'),
(28, 'Parque Dunas de Bilbao Norte y Dunas de Bilbao Sur', 'Parque público', 'Dunas de Bilbao Norte', 'Parajes del Oriente', 'S/D', 'S/D', 'EklEdW5hcyBkZSBCaWxiYW8gU3VyICYgRHVuYXMgZGUgQmlsYmFvIE5vcnRlLCAzMjU3NSBKdcOhcmV6LCBDaGloLiwgTWV4aWNvImYiZAoUChIJ3fhRSSZm54YRu-Z1HMrTkyESFAoSCd34UUkmZueGEbvmdRzK05MhGhQKEglL3cJvJmbnhhGqCahCtwgywBoUChIJJR88yCdm54YRioQMRLMTov8iCg0J_dQSFSpRnMA', 6, 4, '2025-08-07 19:37:23', '2025-08-11 16:18:23'),
(29, 'Gimnasio Municipal Raul Palma Cano (El Mezquital)', 'Centro Comunitario', 'Romerillo', 'El Mezquital', 'S/D', 'S/D', 'ChIJsRC2mD9n54YRKENXg2xuGFQ', 5, 4, '2025-08-07 21:23:30', '2025-08-07 21:23:30'),
(30, 'Parque Hacienda del Real', 'Parque público', 'Hacienda del Real', 'Universidad', 'S/D', 'S/D', ' ChIJe3FYlPtm54YRiShreuMESO4', 5, 4, '2025-08-07 22:16:31', '2025-08-11 16:18:33'),
(31, 'Parque Gamera', 'Parque público', 'Hacienda la Gamera', 'Las Haciendas', 'S/D', 'S/D', 'ChIJc-SeUwBn54YRxcABa_OjPL0', 5, 4, '2025-08-07 22:30:11', '2025-08-11 16:18:46'),
(32, 'Parque Portal del membrillo y Puerto Vallarta', 'Parque público', 'Portal del Membrillo', 'Tierra Nueva', 'S/D', 'S/D', 'ChIJg5qUGQlp54YRpAXe6OKTq-c', 6, 4, '2025-08-07 22:52:59', '2025-08-11 16:19:00'),
(33, 'Parque Puerto Anzio y Puerto Ebano', 'Parque público', 'Puerto Anzio', 'Tierra Nueva ', 'S/D', 'S/D', ' ChIJVWn4Xghp54YROUpgbMsUEB8', 6, 4, '2025-08-11 16:31:47', '2025-08-11 16:31:47'),
(34, 'Calle Ejido Guadalupe ', 'Vía pública', 'Ejido Guadalupe', 'Paplote', 'S/D', 'S/D', 'EkhFamlkbyBHdWFkYWx1cGUgJiBDYWxsZSBFamlkbyBTYW4gQWd1c3TDrW4sIDMyNTk5IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEgnZzfm1CmjnhhHa5ZAFvvSiyBIUChIJ2c35tQpo54YR2uWQBb70osgaFAoSCf9LBrh0aOeGEfYZBroBMPe2GhQKEgk_m4z3CmjnhhFBVdOZuuc9BiIKDZ122hIVRw6dwA Ejido Guadalupe & Calle Ejido San Agustín, 32599 Juárez, Chih., México', 6, 4, '2025-08-11 17:51:54', '2025-08-11 17:51:54'),
(35, 'Parque Puerto Tarento y Puerto Dunquerque', 'Parque público', 'Puerto Tarento', 'Tierra Nueva', 'S/D', 'S/D', 'Ei1QdWVydG8gR3VlcnJlcm8sIDMyNTk5IEp1w6FyZXosIENoaWguLCBNZXhpY28iLiosChQKEgkfs4qUhWjnhhEVTTqlxm7NRxIUChIJnTILPcte54YRdHmcVABhGQs ', 6, 4, '2025-08-11 20:24:46', '2025-08-11 20:24:46'),
(36, 'Escuela Primaria Federal Maria Edmee Alvarez', 'Escuela pública', 'Efrain Gonzalez Luna', 'Universidad', 'S/D', 'S/D', 'ChIJxXEJxlZm54YRIrCtDVRN6jk', 5, 4, '2025-08-12 16:58:51', '2025-08-12 16:58:51'),
(37, 'Parque Valsequilla Lado Oeste ', 'Parque público', 'Valsequilla', 'Las Haciendas', 'S/D', 'S/D', 'ChIJY0Z4QQBn54YRberhoXM4bG8', 5, 4, '2025-08-12 17:42:44', '2025-08-12 17:42:44'),
(39, 'Parque Bustillos', 'Parque público', 'Hacienda de Bustillos', 'Las Haciendas ', 'S/D', 'S/D', 'ChIJAdCBGZtn54YRScQSCPS-8g0', 5, 4, '2025-08-12 18:19:31', '2025-08-12 18:19:31');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_07_16_210907_create_organizations_table', 1),
(5, '2025_07_16_210908_add_fields_to_users_table', 1),
(6, '2025_07_16_215251_create_axes_table', 1),
(7, '2025_07_16_215252_create_programs_table', 1),
(8, '2025_07_16_215253_create_action_lines_table', 1),
(9, '2025_07_16_215255_create_components_table', 1),
(10, '2025_07_16_215256_create_financiers_table', 1),
(11, '2025_07_16_215257_create_projects_table', 1),
(12, '2025_07_16_215258_create_kpis_table', 1),
(13, '2025_07_16_215259_create_program_indicators_table', 1),
(14, '2025_07_16_215300_create_specific_objectives_table', 1),
(15, '2025_07_16_215301_create_goals_table', 1),
(16, '2025_07_16_215302_create_activities_table', 1),
(17, '2025_07_16_215303_create_polygons_table', 1),
(18, '2025_07_16_215304_create_locations_table', 1),
(19, '2025_07_16_215305_create_activity_calendars_table', 1),
(20, '2025_07_16_215306_create_beneficiaries_table', 1),
(21, '2025_07_16_215307_create_beneficiary_registries_table', 1),
(22, '2025_07_16_215308_create_planned_metrics_table', 1),
(23, '2025_07_16_215309_create_activity_logs_table', 1),
(24, '2025_07_16_215310_create_project_reports_table', 1),
(25, '2025_07_16_215311_create_project_disbursements_table', 1),
(26, '2025_07_16_215312_create_activity_files_table', 1),
(27, '2025_07_17_020936_remove_belongs_to_from_programs_table', 1),
(28, '2025_07_17_023202_remove_belongs_to_from_action_lines_table', 1),
(29, '2025_07_17_023755_remove_belongs_to_from_components_table', 1),
(30, '2025_07_17_024029_remove_belongs_to_from_program_indicators_table', 1),
(31, '2025_07_17_024446_remove_belongs_to_from_goals_table', 1),
(32, '2025_07_17_025619_remove_belongs_to_from_projects_table', 1),
(33, '2025_07_17_031121_remove_belongs_to_from_kpis_table', 1),
(34, '2025_07_17_032039_remove_belongs_to_from_specific_objectives_table', 1),
(35, '2025_07_17_032352_remove_belongs_to_from_activities_table', 1),
(36, '2025_07_17_033218_remove_belongs_to_from_planned_metrics_table', 1),
(37, '2025_07_17_150803_make_activity_progress_log_id_nullable_in_planned_metrics_table', 1),
(38, '2025_07_17_153115_remove_belongs_to_from_locations_table', 1),
(39, '2025_07_17_160512_remove_belongsto_from_activity_calendars_table', 1),
(40, '2025_07_17_164522_remove_signature_from_beneficiaries_table', 1),
(41, '2025_07_17_171444_add_signature_to_beneficiaries_table', 1),
(42, '2025_07_17_172043_remove_belongsto_from_beneficiaries_table', 1),
(43, '2025_07_17_172120_remove_belongsto_from_beneficiary_registries_table', 1),
(44, '2025_07_17_173117_remove_belongsto_from_activity_logs_table', 1),
(45, '2025_07_17_173131_remove_belongsto_from_activity_files_table', 1),
(46, '2025_07_17_175856_add_name_to_activities_table', 1),
(47, '2025_07_17_210051_add_identifier_to_beneficiaries_table', 1),
(48, '2025_07_17_224315_add_activity_calendar_id_to_activity_files_table', 1),
(49, '2025_07_21_152134_create_permission_tables', 2),
(50, '2025_07_21_171725_create_data_publications_table', 3),
(51, '2025_07_21_171732_create_published_projects_table', 3),
(52, '2025_07_21_171738_create_published_activities_table', 3),
(53, '2025_07_21_171746_create_published_metrics_table', 3),
(54, '2025_07_21_172027_add_publish_fields_to_users_table', 3),
(55, '2025_07_21_180000_remove_belongsto_from_project_disbursements_table', 3),
(56, '2025_07_21_180100_remove_belongsto_from_project_reports_table', 3),
(57, '2024_07_22_000001_create_project_goal_table', 4),
(58, '2025_07_23_182939_update_activity_calendars_table', 5),
(59, '2025_07_23_182943_remove_activity_progress_log_id_from_tables', 5),
(60, '2025_07_23_200000_add_project_id_to_goals', 5),
(61, '2025_07_22_175947_alter_longtext_fields_in_projects_table', 6),
(62, '2025_07_28_200513_add_address_fields_to_beneficiaries_table', 6),
(63, '2025_08_04_184429_add_foreign_key_constraints_to_database', 7),
(64, '2025_08_05_152905_add_project_id_to_published_activities_table', 8),
(65, '2025_08_05_214739_create_vista_progreso_proyectos_view', 9),
(66, '2025_08_05_214740_create_padron_beneficiarios_view', 10),
(67, '2025_01_21_001000_add_fk_columns_to_activity_logs', 11),
(68, '2025_01_21_002000_add_value_columns_to_activity_logs', 12),
(69, '2025_01_21_003000_add_foreign_keys_to_activity_logs', 13),
(70, '2025_01_21_004000_create_activity_calculation_functions', 14),
(71, '2025_01_21_005000_update_existing_activity_records', 15),
(72, '2025_01_21_006000_create_activity_triggers', 16),
(73, '2025_10_27_151819_add_soft_deletes_to_users_table', 17),
(74, '2025_10_27_163900_add_soft_deletes_to_projects_table', 18);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 1),
(3, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(1, 'App\\Models\\User', 3),
(1, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 11),
(1, 'App\\Models\\User', 12);

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Juárez Limpio A.C', '2025-07-24 18:42:33', '2025-07-24 18:42:33'),
(2, 'Asamblea de Organizaciones', '2025-07-24 18:42:41', '2025-07-24 18:42:41'),
(3, 'Plan Estratégico de Juárez A.C', '2025-07-24 18:43:34', '2025-07-24 18:43:34'),
(5, 'Red de Vecinos', '2025-07-24 18:44:07', '2025-07-24 18:49:15'),
(6, 'Arte en el Parque A.C', '2025-07-24 18:44:39', '2025-07-24 18:44:39'),
(7, 'Centro Humano de Liderazgo A.C.', '2025-07-24 18:45:23', '2025-07-24 18:45:23'),
(9, 'YoCiudadano', '2025-07-24 18:46:07', '2025-07-24 18:46:07'),
(10, 'Fundación Comunitaria de la Frontera Norte, A.C.', '2025-07-30 15:36:15', '2025-07-30 15:36:15');

-- --------------------------------------------------------

--
-- Stand-in structure for view `padron_beneficiarios`
-- (See below for the actual view)
--
CREATE TABLE `padron_beneficiarios` (
`Nombres` varchar(100)
,`Apellido_paterno` varchar(100)
,`Apellido_materno` varchar(100)
,`nacimiento` varchar(4)
,`genero` enum('M','F','Male','Female')
,`telefono` varchar(20)
,`calle` varchar(255)
,`colonia` varchar(255)
,`nombre_actividad` varchar(255)
,`nombre_proyecto` varchar(500)
,`Evento_Fecha_Inicio` date
,`financiadora` bigint unsigned
);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'view_action::line', 'web', '2025-07-21 16:37:11', '2025-07-21 16:37:11'),
(2, 'view_any_action::line', 'web', '2025-07-21 16:37:11', '2025-07-21 16:37:11'),
(3, 'create_action::line', 'web', '2025-07-21 16:37:12', '2025-07-21 16:37:12'),
(4, 'update_action::line', 'web', '2025-07-21 16:37:12', '2025-07-21 16:37:12'),
(5, 'restore_action::line', 'web', '2025-07-21 16:37:13', '2025-07-21 16:37:13'),
(6, 'restore_any_action::line', 'web', '2025-07-21 16:37:14', '2025-07-21 16:37:14'),
(7, 'replicate_action::line', 'web', '2025-07-21 16:37:14', '2025-07-21 16:37:14'),
(8, 'reorder_action::line', 'web', '2025-07-21 16:37:15', '2025-07-21 16:37:15'),
(9, 'delete_action::line', 'web', '2025-07-21 16:37:16', '2025-07-21 16:37:16'),
(10, 'delete_any_action::line', 'web', '2025-07-21 16:37:16', '2025-07-21 16:37:16'),
(11, 'force_delete_action::line', 'web', '2025-07-21 16:37:17', '2025-07-21 16:37:17'),
(12, 'force_delete_any_action::line', 'web', '2025-07-21 16:37:18', '2025-07-21 16:37:18'),
(13, 'view_activity', 'web', '2025-07-21 16:37:19', '2025-07-21 16:37:19'),
(14, 'view_any_activity', 'web', '2025-07-21 16:37:19', '2025-07-21 16:37:19'),
(15, 'create_activity', 'web', '2025-07-21 16:37:20', '2025-07-21 16:37:20'),
(16, 'update_activity', 'web', '2025-07-21 16:37:20', '2025-07-21 16:37:20'),
(17, 'restore_activity', 'web', '2025-07-21 16:37:21', '2025-07-21 16:37:21'),
(18, 'restore_any_activity', 'web', '2025-07-21 16:37:22', '2025-07-21 16:37:22'),
(19, 'replicate_activity', 'web', '2025-07-21 16:37:22', '2025-07-21 16:37:22'),
(20, 'reorder_activity', 'web', '2025-07-21 16:37:22', '2025-07-21 16:37:22'),
(21, 'delete_activity', 'web', '2025-07-21 16:37:23', '2025-07-21 16:37:23'),
(22, 'delete_any_activity', 'web', '2025-07-21 16:37:23', '2025-07-21 16:37:23'),
(23, 'force_delete_activity', 'web', '2025-07-21 16:37:23', '2025-07-21 16:37:23'),
(24, 'force_delete_any_activity', 'web', '2025-07-21 16:37:24', '2025-07-21 16:37:24'),
(25, 'view_activity::calendar', 'web', '2025-07-21 16:37:25', '2025-07-21 16:37:25'),
(26, 'view_any_activity::calendar', 'web', '2025-07-21 16:37:26', '2025-07-21 16:37:26'),
(27, 'create_activity::calendar', 'web', '2025-07-21 16:37:26', '2025-07-21 16:37:26'),
(28, 'update_activity::calendar', 'web', '2025-07-21 16:37:27', '2025-07-21 16:37:27'),
(29, 'restore_activity::calendar', 'web', '2025-07-21 16:37:27', '2025-07-21 16:37:27'),
(30, 'restore_any_activity::calendar', 'web', '2025-07-21 16:37:27', '2025-07-21 16:37:27'),
(31, 'replicate_activity::calendar', 'web', '2025-07-21 16:37:28', '2025-07-21 16:37:28'),
(32, 'reorder_activity::calendar', 'web', '2025-07-21 16:37:28', '2025-07-21 16:37:28'),
(33, 'delete_activity::calendar', 'web', '2025-07-21 16:37:28', '2025-07-21 16:37:28'),
(34, 'delete_any_activity::calendar', 'web', '2025-07-21 16:37:29', '2025-07-21 16:37:29'),
(35, 'force_delete_activity::calendar', 'web', '2025-07-21 16:37:29', '2025-07-21 16:37:29'),
(36, 'force_delete_any_activity::calendar', 'web', '2025-07-21 16:37:30', '2025-07-21 16:37:30'),
(37, 'view_activity::file', 'web', '2025-07-21 16:37:31', '2025-07-21 16:37:31'),
(38, 'view_any_activity::file', 'web', '2025-07-21 16:37:32', '2025-07-21 16:37:32'),
(39, 'create_activity::file', 'web', '2025-07-21 16:37:32', '2025-07-21 16:37:32'),
(40, 'update_activity::file', 'web', '2025-07-21 16:37:32', '2025-07-21 16:37:32'),
(41, 'restore_activity::file', 'web', '2025-07-21 16:37:33', '2025-07-21 16:37:33'),
(42, 'restore_any_activity::file', 'web', '2025-07-21 16:37:33', '2025-07-21 16:37:33'),
(43, 'replicate_activity::file', 'web', '2025-07-21 16:37:33', '2025-07-21 16:37:33'),
(44, 'reorder_activity::file', 'web', '2025-07-21 16:37:34', '2025-07-21 16:37:34'),
(45, 'delete_activity::file', 'web', '2025-07-21 16:37:34', '2025-07-21 16:37:34'),
(46, 'delete_any_activity::file', 'web', '2025-07-21 16:37:34', '2025-07-21 16:37:34'),
(47, 'force_delete_activity::file', 'web', '2025-07-21 16:37:35', '2025-07-21 16:37:35'),
(48, 'force_delete_any_activity::file', 'web', '2025-07-21 16:37:35', '2025-07-21 16:37:35'),
(49, 'view_activity::log', 'web', '2025-07-21 16:37:36', '2025-07-21 16:37:36'),
(50, 'view_any_activity::log', 'web', '2025-07-21 16:37:36', '2025-07-21 16:37:36'),
(51, 'create_activity::log', 'web', '2025-07-21 16:37:36', '2025-07-21 16:37:36'),
(52, 'update_activity::log', 'web', '2025-07-21 16:37:37', '2025-07-21 16:37:37'),
(53, 'restore_activity::log', 'web', '2025-07-21 16:37:37', '2025-07-21 16:37:37'),
(54, 'restore_any_activity::log', 'web', '2025-07-21 16:37:37', '2025-07-21 16:37:37'),
(55, 'replicate_activity::log', 'web', '2025-07-21 16:37:38', '2025-07-21 16:37:38'),
(56, 'reorder_activity::log', 'web', '2025-07-21 16:37:38', '2025-07-21 16:37:38'),
(57, 'delete_activity::log', 'web', '2025-07-21 16:37:39', '2025-07-21 16:37:39'),
(58, 'delete_any_activity::log', 'web', '2025-07-21 16:37:39', '2025-07-21 16:37:39'),
(59, 'force_delete_activity::log', 'web', '2025-07-21 16:37:40', '2025-07-21 16:37:40'),
(60, 'force_delete_any_activity::log', 'web', '2025-07-21 16:37:40', '2025-07-21 16:37:40'),
(61, 'view_axe', 'web', '2025-07-21 16:37:41', '2025-07-21 16:37:41'),
(62, 'view_any_axe', 'web', '2025-07-21 16:37:42', '2025-07-21 16:37:42'),
(63, 'create_axe', 'web', '2025-07-21 16:37:42', '2025-07-21 16:37:42'),
(64, 'update_axe', 'web', '2025-07-21 16:37:43', '2025-07-21 16:37:43'),
(65, 'restore_axe', 'web', '2025-07-21 16:37:43', '2025-07-21 16:37:43'),
(66, 'restore_any_axe', 'web', '2025-07-21 16:37:44', '2025-07-21 16:37:44'),
(67, 'replicate_axe', 'web', '2025-07-21 16:37:44', '2025-07-21 16:37:44'),
(68, 'reorder_axe', 'web', '2025-07-21 16:37:45', '2025-07-21 16:37:45'),
(69, 'delete_axe', 'web', '2025-07-21 16:37:45', '2025-07-21 16:37:45'),
(70, 'delete_any_axe', 'web', '2025-07-21 16:37:46', '2025-07-21 16:37:46'),
(71, 'force_delete_axe', 'web', '2025-07-21 16:37:46', '2025-07-21 16:37:46'),
(72, 'force_delete_any_axe', 'web', '2025-07-21 16:37:47', '2025-07-21 16:37:47'),
(73, 'view_beneficiary', 'web', '2025-07-21 16:37:48', '2025-07-21 16:37:48'),
(74, 'view_any_beneficiary', 'web', '2025-07-21 16:37:48', '2025-07-21 16:37:48'),
(75, 'create_beneficiary', 'web', '2025-07-21 16:37:49', '2025-07-21 16:37:49'),
(76, 'update_beneficiary', 'web', '2025-07-21 16:37:49', '2025-07-21 16:37:49'),
(77, 'restore_beneficiary', 'web', '2025-07-21 16:37:49', '2025-07-21 16:37:49'),
(78, 'restore_any_beneficiary', 'web', '2025-07-21 16:37:50', '2025-07-21 16:37:50'),
(79, 'replicate_beneficiary', 'web', '2025-07-21 16:37:50', '2025-07-21 16:37:50'),
(80, 'reorder_beneficiary', 'web', '2025-07-21 16:37:50', '2025-07-21 16:37:50'),
(81, 'delete_beneficiary', 'web', '2025-07-21 16:37:51', '2025-07-21 16:37:51'),
(82, 'delete_any_beneficiary', 'web', '2025-07-21 16:37:51', '2025-07-21 16:37:51'),
(83, 'force_delete_beneficiary', 'web', '2025-07-21 16:37:51', '2025-07-21 16:37:51'),
(84, 'force_delete_any_beneficiary', 'web', '2025-07-21 16:37:52', '2025-07-21 16:37:52'),
(85, 'view_beneficiary::registry', 'web', '2025-07-21 16:37:53', '2025-07-21 16:37:53'),
(86, 'view_any_beneficiary::registry', 'web', '2025-07-21 16:37:53', '2025-07-21 16:37:53'),
(87, 'create_beneficiary::registry', 'web', '2025-07-21 16:37:53', '2025-07-21 16:37:53'),
(88, 'update_beneficiary::registry', 'web', '2025-07-21 16:37:53', '2025-07-21 16:37:53'),
(89, 'restore_beneficiary::registry', 'web', '2025-07-21 16:37:54', '2025-07-21 16:37:54'),
(90, 'restore_any_beneficiary::registry', 'web', '2025-07-21 16:37:54', '2025-07-21 16:37:54'),
(91, 'replicate_beneficiary::registry', 'web', '2025-07-21 16:37:55', '2025-07-21 16:37:55'),
(92, 'reorder_beneficiary::registry', 'web', '2025-07-21 16:37:55', '2025-07-21 16:37:55'),
(93, 'delete_beneficiary::registry', 'web', '2025-07-21 16:37:55', '2025-07-21 16:37:55'),
(94, 'delete_any_beneficiary::registry', 'web', '2025-07-21 16:37:56', '2025-07-21 16:37:56'),
(95, 'force_delete_beneficiary::registry', 'web', '2025-07-21 16:37:56', '2025-07-21 16:37:56'),
(96, 'force_delete_any_beneficiary::registry', 'web', '2025-07-21 16:37:56', '2025-07-21 16:37:56'),
(97, 'view_component', 'web', '2025-07-21 16:37:57', '2025-07-21 16:37:57'),
(98, 'view_any_component', 'web', '2025-07-21 16:37:58', '2025-07-21 16:37:58'),
(99, 'create_component', 'web', '2025-07-21 16:37:58', '2025-07-21 16:37:58'),
(100, 'update_component', 'web', '2025-07-21 16:37:58', '2025-07-21 16:37:58'),
(101, 'restore_component', 'web', '2025-07-21 16:37:58', '2025-07-21 16:37:58'),
(102, 'restore_any_component', 'web', '2025-07-21 16:37:59', '2025-07-21 16:37:59'),
(103, 'replicate_component', 'web', '2025-07-21 16:37:59', '2025-07-21 16:37:59'),
(104, 'reorder_component', 'web', '2025-07-21 16:38:00', '2025-07-21 16:38:00'),
(105, 'delete_component', 'web', '2025-07-21 16:38:00', '2025-07-21 16:38:00'),
(106, 'delete_any_component', 'web', '2025-07-21 16:38:00', '2025-07-21 16:38:00'),
(107, 'force_delete_component', 'web', '2025-07-21 16:38:01', '2025-07-21 16:38:01'),
(108, 'force_delete_any_component', 'web', '2025-07-21 16:38:01', '2025-07-21 16:38:01'),
(109, 'view_financier', 'web', '2025-07-21 16:38:02', '2025-07-21 16:38:02'),
(110, 'view_any_financier', 'web', '2025-07-21 16:38:02', '2025-07-21 16:38:02'),
(111, 'create_financier', 'web', '2025-07-21 16:38:02', '2025-07-21 16:38:02'),
(112, 'update_financier', 'web', '2025-07-21 16:38:03', '2025-07-21 16:38:03'),
(113, 'restore_financier', 'web', '2025-07-21 16:38:03', '2025-07-21 16:38:03'),
(114, 'restore_any_financier', 'web', '2025-07-21 16:38:03', '2025-07-21 16:38:03'),
(115, 'replicate_financier', 'web', '2025-07-21 16:38:03', '2025-07-21 16:38:03'),
(116, 'reorder_financier', 'web', '2025-07-21 16:38:04', '2025-07-21 16:38:04'),
(117, 'delete_financier', 'web', '2025-07-21 16:38:04', '2025-07-21 16:38:04'),
(118, 'delete_any_financier', 'web', '2025-07-21 16:38:04', '2025-07-21 16:38:04'),
(119, 'force_delete_financier', 'web', '2025-07-21 16:38:05', '2025-07-21 16:38:05'),
(120, 'force_delete_any_financier', 'web', '2025-07-21 16:38:05', '2025-07-21 16:38:05'),
(121, 'view_goal', 'web', '2025-07-21 16:38:06', '2025-07-21 16:38:06'),
(122, 'view_any_goal', 'web', '2025-07-21 16:38:06', '2025-07-21 16:38:06'),
(123, 'create_goal', 'web', '2025-07-21 16:38:06', '2025-07-21 16:38:06'),
(124, 'update_goal', 'web', '2025-07-21 16:38:07', '2025-07-21 16:38:07'),
(125, 'restore_goal', 'web', '2025-07-21 16:38:07', '2025-07-21 16:38:07'),
(126, 'restore_any_goal', 'web', '2025-07-21 16:38:07', '2025-07-21 16:38:07'),
(127, 'replicate_goal', 'web', '2025-07-21 16:38:08', '2025-07-21 16:38:08'),
(128, 'reorder_goal', 'web', '2025-07-21 16:38:08', '2025-07-21 16:38:08'),
(129, 'delete_goal', 'web', '2025-07-21 16:38:08', '2025-07-21 16:38:08'),
(130, 'delete_any_goal', 'web', '2025-07-21 16:38:09', '2025-07-21 16:38:09'),
(131, 'force_delete_goal', 'web', '2025-07-21 16:38:09', '2025-07-21 16:38:09'),
(132, 'force_delete_any_goal', 'web', '2025-07-21 16:38:09', '2025-07-21 16:38:09'),
(133, 'view_kpi', 'web', '2025-07-21 16:38:10', '2025-07-21 16:38:10'),
(134, 'view_any_kpi', 'web', '2025-07-21 16:38:10', '2025-07-21 16:38:10'),
(135, 'create_kpi', 'web', '2025-07-21 16:38:11', '2025-07-21 16:38:11'),
(136, 'update_kpi', 'web', '2025-07-21 16:38:11', '2025-07-21 16:38:11'),
(137, 'restore_kpi', 'web', '2025-07-21 16:38:11', '2025-07-21 16:38:11'),
(138, 'restore_any_kpi', 'web', '2025-07-21 16:38:12', '2025-07-21 16:38:12'),
(139, 'replicate_kpi', 'web', '2025-07-21 16:38:12', '2025-07-21 16:38:12'),
(140, 'reorder_kpi', 'web', '2025-07-21 16:38:12', '2025-07-21 16:38:12'),
(141, 'delete_kpi', 'web', '2025-07-21 16:38:13', '2025-07-21 16:38:13'),
(142, 'delete_any_kpi', 'web', '2025-07-21 16:38:13', '2025-07-21 16:38:13'),
(143, 'force_delete_kpi', 'web', '2025-07-21 16:38:13', '2025-07-21 16:38:13'),
(144, 'force_delete_any_kpi', 'web', '2025-07-21 16:38:14', '2025-07-21 16:38:14'),
(145, 'view_location', 'web', '2025-07-21 16:38:14', '2025-07-21 16:38:14'),
(146, 'view_any_location', 'web', '2025-07-21 16:38:15', '2025-07-21 16:38:15'),
(147, 'create_location', 'web', '2025-07-21 16:38:15', '2025-07-21 16:38:15'),
(148, 'update_location', 'web', '2025-07-21 16:38:15', '2025-07-21 16:38:15'),
(149, 'restore_location', 'web', '2025-07-21 16:38:16', '2025-07-21 16:38:16'),
(150, 'restore_any_location', 'web', '2025-07-21 16:38:16', '2025-07-21 16:38:16'),
(151, 'replicate_location', 'web', '2025-07-21 16:38:16', '2025-07-21 16:38:16'),
(152, 'reorder_location', 'web', '2025-07-21 16:38:16', '2025-07-21 16:38:16'),
(153, 'delete_location', 'web', '2025-07-21 16:38:17', '2025-07-21 16:38:17'),
(154, 'delete_any_location', 'web', '2025-07-21 16:38:17', '2025-07-21 16:38:17'),
(155, 'force_delete_location', 'web', '2025-07-21 16:38:17', '2025-07-21 16:38:17'),
(156, 'force_delete_any_location', 'web', '2025-07-21 16:38:18', '2025-07-21 16:38:18'),
(157, 'view_organization', 'web', '2025-07-21 16:38:18', '2025-07-21 16:38:18'),
(158, 'view_any_organization', 'web', '2025-07-21 16:38:19', '2025-07-21 16:38:19'),
(159, 'create_organization', 'web', '2025-07-21 16:38:19', '2025-07-21 16:38:19'),
(160, 'update_organization', 'web', '2025-07-21 16:38:19', '2025-07-21 16:38:19'),
(161, 'restore_organization', 'web', '2025-07-21 16:38:20', '2025-07-21 16:38:20'),
(162, 'restore_any_organization', 'web', '2025-07-21 16:38:20', '2025-07-21 16:38:20'),
(163, 'replicate_organization', 'web', '2025-07-21 16:38:20', '2025-07-21 16:38:20'),
(164, 'reorder_organization', 'web', '2025-07-21 16:38:21', '2025-07-21 16:38:21'),
(165, 'delete_organization', 'web', '2025-07-21 16:38:21', '2025-07-21 16:38:21'),
(166, 'delete_any_organization', 'web', '2025-07-21 16:38:21', '2025-07-21 16:38:21'),
(167, 'force_delete_organization', 'web', '2025-07-21 16:38:22', '2025-07-21 16:38:22'),
(168, 'force_delete_any_organization', 'web', '2025-07-21 16:38:22', '2025-07-21 16:38:22'),
(169, 'view_planned::metric', 'web', '2025-07-21 16:38:23', '2025-07-21 16:38:23'),
(170, 'view_any_planned::metric', 'web', '2025-07-21 16:38:23', '2025-07-21 16:38:23'),
(171, 'create_planned::metric', 'web', '2025-07-21 16:38:23', '2025-07-21 16:38:23'),
(172, 'update_planned::metric', 'web', '2025-07-21 16:38:23', '2025-07-21 16:38:23'),
(173, 'restore_planned::metric', 'web', '2025-07-21 16:38:24', '2025-07-21 16:38:24'),
(174, 'restore_any_planned::metric', 'web', '2025-07-21 16:38:24', '2025-07-21 16:38:24'),
(175, 'replicate_planned::metric', 'web', '2025-07-21 16:38:24', '2025-07-21 16:38:24'),
(176, 'reorder_planned::metric', 'web', '2025-07-21 16:38:25', '2025-07-21 16:38:25'),
(177, 'delete_planned::metric', 'web', '2025-07-21 16:38:25', '2025-07-21 16:38:25'),
(178, 'delete_any_planned::metric', 'web', '2025-07-21 16:38:25', '2025-07-21 16:38:25'),
(179, 'force_delete_planned::metric', 'web', '2025-07-21 16:38:26', '2025-07-21 16:38:26'),
(180, 'force_delete_any_planned::metric', 'web', '2025-07-21 16:38:26', '2025-07-21 16:38:26'),
(181, 'view_polygon', 'web', '2025-07-21 16:38:27', '2025-07-21 16:38:27'),
(182, 'view_any_polygon', 'web', '2025-07-21 16:38:27', '2025-07-21 16:38:27'),
(183, 'create_polygon', 'web', '2025-07-21 16:38:27', '2025-07-21 16:38:27'),
(184, 'update_polygon', 'web', '2025-07-21 16:38:28', '2025-07-21 16:38:28'),
(185, 'restore_polygon', 'web', '2025-07-21 16:38:28', '2025-07-21 16:38:28'),
(186, 'restore_any_polygon', 'web', '2025-07-21 16:38:28', '2025-07-21 16:38:28'),
(187, 'replicate_polygon', 'web', '2025-07-21 16:38:29', '2025-07-21 16:38:29'),
(188, 'reorder_polygon', 'web', '2025-07-21 16:38:29', '2025-07-21 16:38:29'),
(189, 'delete_polygon', 'web', '2025-07-21 16:38:29', '2025-07-21 16:38:29'),
(190, 'delete_any_polygon', 'web', '2025-07-21 16:38:29', '2025-07-21 16:38:29'),
(191, 'force_delete_polygon', 'web', '2025-07-21 16:38:30', '2025-07-21 16:38:30'),
(192, 'force_delete_any_polygon', 'web', '2025-07-21 16:38:30', '2025-07-21 16:38:30'),
(193, 'view_program', 'web', '2025-07-21 16:38:31', '2025-07-21 16:38:31'),
(194, 'view_any_program', 'web', '2025-07-21 16:38:31', '2025-07-21 16:38:31'),
(195, 'create_program', 'web', '2025-07-21 16:38:31', '2025-07-21 16:38:31'),
(196, 'update_program', 'web', '2025-07-21 16:38:32', '2025-07-21 16:38:32'),
(197, 'restore_program', 'web', '2025-07-21 16:38:32', '2025-07-21 16:38:32'),
(198, 'restore_any_program', 'web', '2025-07-21 16:38:32', '2025-07-21 16:38:32'),
(199, 'replicate_program', 'web', '2025-07-21 16:38:33', '2025-07-21 16:38:33'),
(200, 'reorder_program', 'web', '2025-07-21 16:38:33', '2025-07-21 16:38:33'),
(201, 'delete_program', 'web', '2025-07-21 16:38:33', '2025-07-21 16:38:33'),
(202, 'delete_any_program', 'web', '2025-07-21 16:38:34', '2025-07-21 16:38:34'),
(203, 'force_delete_program', 'web', '2025-07-21 16:38:34', '2025-07-21 16:38:34'),
(204, 'force_delete_any_program', 'web', '2025-07-21 16:38:34', '2025-07-21 16:38:34'),
(205, 'view_program::indicator', 'web', '2025-07-21 16:38:35', '2025-07-21 16:38:35'),
(206, 'view_any_program::indicator', 'web', '2025-07-21 16:38:36', '2025-07-21 16:38:36'),
(207, 'create_program::indicator', 'web', '2025-07-21 16:38:36', '2025-07-21 16:38:36'),
(208, 'update_program::indicator', 'web', '2025-07-21 16:38:36', '2025-07-21 16:38:36'),
(209, 'restore_program::indicator', 'web', '2025-07-21 16:38:37', '2025-07-21 16:38:37'),
(210, 'restore_any_program::indicator', 'web', '2025-07-21 16:38:37', '2025-07-21 16:38:37'),
(211, 'replicate_program::indicator', 'web', '2025-07-21 16:38:37', '2025-07-21 16:38:37'),
(212, 'reorder_program::indicator', 'web', '2025-07-21 16:38:38', '2025-07-21 16:38:38'),
(213, 'delete_program::indicator', 'web', '2025-07-21 16:38:38', '2025-07-21 16:38:38'),
(214, 'delete_any_program::indicator', 'web', '2025-07-21 16:38:38', '2025-07-21 16:38:38'),
(215, 'force_delete_program::indicator', 'web', '2025-07-21 16:38:39', '2025-07-21 16:38:39'),
(216, 'force_delete_any_program::indicator', 'web', '2025-07-21 16:38:39', '2025-07-21 16:38:39'),
(217, 'view_project', 'web', '2025-07-21 16:38:40', '2025-07-21 16:38:40'),
(218, 'view_any_project', 'web', '2025-07-21 16:38:40', '2025-07-21 16:38:40'),
(219, 'create_project', 'web', '2025-07-21 16:38:40', '2025-07-21 16:38:40'),
(220, 'update_project', 'web', '2025-07-21 16:38:41', '2025-07-21 16:38:41'),
(221, 'restore_project', 'web', '2025-07-21 16:38:41', '2025-07-21 16:38:41'),
(222, 'restore_any_project', 'web', '2025-07-21 16:38:41', '2025-07-21 16:38:41'),
(223, 'replicate_project', 'web', '2025-07-21 16:38:42', '2025-07-21 16:38:42'),
(224, 'reorder_project', 'web', '2025-07-21 16:38:42', '2025-07-21 16:38:42'),
(225, 'delete_project', 'web', '2025-07-21 16:38:42', '2025-07-21 16:38:42'),
(226, 'delete_any_project', 'web', '2025-07-21 16:38:43', '2025-07-21 16:38:43'),
(227, 'force_delete_project', 'web', '2025-07-21 16:38:43', '2025-07-21 16:38:43'),
(228, 'force_delete_any_project', 'web', '2025-07-21 16:38:43', '2025-07-21 16:38:43'),
(229, 'view_project::disbursement', 'web', '2025-07-21 16:38:44', '2025-07-21 16:38:44'),
(230, 'view_any_project::disbursement', 'web', '2025-07-21 16:38:44', '2025-07-21 16:38:44'),
(231, 'create_project::disbursement', 'web', '2025-07-21 16:38:45', '2025-07-21 16:38:45'),
(232, 'update_project::disbursement', 'web', '2025-07-21 16:38:45', '2025-07-21 16:38:45'),
(233, 'restore_project::disbursement', 'web', '2025-07-21 16:38:45', '2025-07-21 16:38:45'),
(234, 'restore_any_project::disbursement', 'web', '2025-07-21 16:38:45', '2025-07-21 16:38:45'),
(235, 'replicate_project::disbursement', 'web', '2025-07-21 16:38:46', '2025-07-21 16:38:46'),
(236, 'reorder_project::disbursement', 'web', '2025-07-21 16:38:46', '2025-07-21 16:38:46'),
(237, 'delete_project::disbursement', 'web', '2025-07-21 16:38:46', '2025-07-21 16:38:46'),
(238, 'delete_any_project::disbursement', 'web', '2025-07-21 16:38:47', '2025-07-21 16:38:47'),
(239, 'force_delete_project::disbursement', 'web', '2025-07-21 16:38:47', '2025-07-21 16:38:47'),
(240, 'force_delete_any_project::disbursement', 'web', '2025-07-21 16:38:47', '2025-07-21 16:38:47'),
(241, 'view_project::report', 'web', '2025-07-21 16:38:48', '2025-07-21 16:38:48'),
(242, 'view_any_project::report', 'web', '2025-07-21 16:38:48', '2025-07-21 16:38:48'),
(243, 'create_project::report', 'web', '2025-07-21 16:38:49', '2025-07-21 16:38:49'),
(244, 'update_project::report', 'web', '2025-07-21 16:38:49', '2025-07-21 16:38:49'),
(245, 'restore_project::report', 'web', '2025-07-21 16:38:49', '2025-07-21 16:38:49'),
(246, 'restore_any_project::report', 'web', '2025-07-21 16:38:50', '2025-07-21 16:38:50'),
(247, 'replicate_project::report', 'web', '2025-07-21 16:38:50', '2025-07-21 16:38:50'),
(248, 'reorder_project::report', 'web', '2025-07-21 16:38:50', '2025-07-21 16:38:50'),
(249, 'delete_project::report', 'web', '2025-07-21 16:38:51', '2025-07-21 16:38:51'),
(250, 'delete_any_project::report', 'web', '2025-07-21 16:38:51', '2025-07-21 16:38:51'),
(251, 'force_delete_project::report', 'web', '2025-07-21 16:38:51', '2025-07-21 16:38:51'),
(252, 'force_delete_any_project::report', 'web', '2025-07-21 16:38:52', '2025-07-21 16:38:52'),
(253, 'view_role', 'web', '2025-07-21 16:38:52', '2025-07-21 16:38:52'),
(254, 'view_any_role', 'web', '2025-07-21 16:38:53', '2025-07-21 16:38:53'),
(255, 'create_role', 'web', '2025-07-21 16:38:53', '2025-07-21 16:38:53'),
(256, 'update_role', 'web', '2025-07-21 16:38:53', '2025-07-21 16:38:53'),
(257, 'delete_role', 'web', '2025-07-21 16:38:54', '2025-07-21 16:38:54'),
(258, 'delete_any_role', 'web', '2025-07-21 16:38:54', '2025-07-21 16:38:54'),
(259, 'view_specific::objective', 'web', '2025-07-21 16:38:55', '2025-07-21 16:38:55'),
(260, 'view_any_specific::objective', 'web', '2025-07-21 16:38:55', '2025-07-21 16:38:55'),
(261, 'create_specific::objective', 'web', '2025-07-21 16:38:55', '2025-07-21 16:38:55'),
(262, 'update_specific::objective', 'web', '2025-07-21 16:38:56', '2025-07-21 16:38:56'),
(263, 'restore_specific::objective', 'web', '2025-07-21 16:38:56', '2025-07-21 16:38:56'),
(264, 'restore_any_specific::objective', 'web', '2025-07-21 16:38:56', '2025-07-21 16:38:56'),
(265, 'replicate_specific::objective', 'web', '2025-07-21 16:38:56', '2025-07-21 16:38:56'),
(266, 'reorder_specific::objective', 'web', '2025-07-21 16:38:57', '2025-07-21 16:38:57'),
(267, 'delete_specific::objective', 'web', '2025-07-21 16:38:57', '2025-07-21 16:38:57'),
(268, 'delete_any_specific::objective', 'web', '2025-07-21 16:38:57', '2025-07-21 16:38:57'),
(269, 'force_delete_specific::objective', 'web', '2025-07-21 16:38:58', '2025-07-21 16:38:58'),
(270, 'force_delete_any_specific::objective', 'web', '2025-07-21 16:38:58', '2025-07-21 16:38:58'),
(271, 'view_user', 'web', '2025-07-21 16:38:59', '2025-07-21 16:38:59'),
(272, 'view_any_user', 'web', '2025-07-21 16:38:59', '2025-07-21 16:38:59'),
(273, 'create_user', 'web', '2025-07-21 16:38:59', '2025-07-21 16:38:59'),
(274, 'update_user', 'web', '2025-07-21 16:39:00', '2025-07-21 16:39:00'),
(275, 'restore_user', 'web', '2025-07-21 16:39:00', '2025-07-21 16:39:00'),
(276, 'restore_any_user', 'web', '2025-07-21 16:39:00', '2025-07-21 16:39:00'),
(277, 'replicate_user', 'web', '2025-07-21 16:39:01', '2025-07-21 16:39:01'),
(278, 'reorder_user', 'web', '2025-07-21 16:39:01', '2025-07-21 16:39:01'),
(279, 'delete_user', 'web', '2025-07-21 16:39:01', '2025-07-21 16:39:01'),
(280, 'delete_any_user', 'web', '2025-07-21 16:39:02', '2025-07-21 16:39:02'),
(281, 'force_delete_user', 'web', '2025-07-21 16:39:02', '2025-07-21 16:39:02'),
(282, 'force_delete_any_user', 'web', '2025-07-21 16:39:02', '2025-07-21 16:39:02'),
(283, 'page_ActivityFileManager', 'web', '2025-07-21 16:39:03', '2025-07-21 16:39:03'),
(284, 'page_BeneficiaryRegistryView', 'web', '2025-07-21 16:39:04', '2025-07-21 16:39:04'),
(285, 'page_ProjectCreationGuide', 'web', '2025-07-21 16:39:05', '2025-07-21 16:39:05'),
(286, 'page_ProjectManagement', 'web', '2025-07-23 03:06:25', '2025-07-23 03:06:25'),
(287, 'page_ProjectWizard', 'web', '2025-07-23 03:06:25', '2025-07-23 03:06:25'),
(288, 'page_DataPublicationApproval', 'web', '2025-07-23 03:06:25', '2025-07-23 03:06:25'),
(289, 'view_data::publication', 'web', '2025-07-28 14:55:37', '2025-07-28 14:55:37'),
(290, 'view_any_data::publication', 'web', '2025-07-28 14:55:38', '2025-07-28 14:55:38'),
(291, 'create_data::publication', 'web', '2025-07-28 14:55:38', '2025-07-28 14:55:38'),
(292, 'update_data::publication', 'web', '2025-07-28 14:55:38', '2025-07-28 14:55:38'),
(293, 'restore_data::publication', 'web', '2025-07-28 14:55:39', '2025-07-28 14:55:39'),
(294, 'restore_any_data::publication', 'web', '2025-07-28 14:55:39', '2025-07-28 14:55:39'),
(295, 'replicate_data::publication', 'web', '2025-07-28 14:55:39', '2025-07-28 14:55:39'),
(296, 'reorder_data::publication', 'web', '2025-07-28 14:55:40', '2025-07-28 14:55:40'),
(297, 'delete_data::publication', 'web', '2025-07-28 14:55:40', '2025-07-28 14:55:40'),
(298, 'delete_any_data::publication', 'web', '2025-07-28 14:55:40', '2025-07-28 14:55:40'),
(299, 'force_delete_data::publication', 'web', '2025-07-28 14:55:41', '2025-07-28 14:55:41'),
(300, 'force_delete_any_data::publication', 'web', '2025-07-28 14:55:41', '2025-07-28 14:55:41'),
(301, 'view_published::activity', 'web', '2025-07-28 14:56:03', '2025-07-28 14:56:03'),
(302, 'view_any_published::activity', 'web', '2025-07-28 14:56:03', '2025-07-28 14:56:03'),
(303, 'create_published::activity', 'web', '2025-07-28 14:56:03', '2025-07-28 14:56:03'),
(304, 'update_published::activity', 'web', '2025-07-28 14:56:04', '2025-07-28 14:56:04'),
(305, 'restore_published::activity', 'web', '2025-07-28 14:56:04', '2025-07-28 14:56:04'),
(306, 'restore_any_published::activity', 'web', '2025-07-28 14:56:04', '2025-07-28 14:56:04'),
(307, 'replicate_published::activity', 'web', '2025-07-28 14:56:05', '2025-07-28 14:56:05'),
(308, 'reorder_published::activity', 'web', '2025-07-28 14:56:05', '2025-07-28 14:56:05'),
(309, 'delete_published::activity', 'web', '2025-07-28 14:56:05', '2025-07-28 14:56:05'),
(310, 'delete_any_published::activity', 'web', '2025-07-28 14:56:06', '2025-07-28 14:56:06'),
(311, 'force_delete_published::activity', 'web', '2025-07-28 14:56:06', '2025-07-28 14:56:06'),
(312, 'force_delete_any_published::activity', 'web', '2025-07-28 14:56:06', '2025-07-28 14:56:06'),
(313, 'view_published::metric', 'web', '2025-07-28 14:56:07', '2025-07-28 14:56:07'),
(314, 'view_any_published::metric', 'web', '2025-07-28 14:56:07', '2025-07-28 14:56:07'),
(315, 'create_published::metric', 'web', '2025-07-28 14:56:08', '2025-07-28 14:56:08'),
(316, 'update_published::metric', 'web', '2025-07-28 14:56:08', '2025-07-28 14:56:08'),
(317, 'restore_published::metric', 'web', '2025-07-28 14:56:08', '2025-07-28 14:56:08'),
(318, 'restore_any_published::metric', 'web', '2025-07-28 14:56:09', '2025-07-28 14:56:09'),
(319, 'replicate_published::metric', 'web', '2025-07-28 14:56:09', '2025-07-28 14:56:09'),
(320, 'reorder_published::metric', 'web', '2025-07-28 14:56:09', '2025-07-28 14:56:09'),
(321, 'delete_published::metric', 'web', '2025-07-28 14:56:10', '2025-07-28 14:56:10'),
(322, 'delete_any_published::metric', 'web', '2025-07-28 14:56:10', '2025-07-28 14:56:10'),
(323, 'force_delete_published::metric', 'web', '2025-07-28 14:56:10', '2025-07-28 14:56:10'),
(324, 'force_delete_any_published::metric', 'web', '2025-07-28 14:56:11', '2025-07-28 14:56:11'),
(325, 'view_published::project', 'web', '2025-07-28 14:56:11', '2025-07-28 14:56:11'),
(326, 'view_any_published::project', 'web', '2025-07-28 14:56:12', '2025-07-28 14:56:12'),
(327, 'create_published::project', 'web', '2025-07-28 14:56:12', '2025-07-28 14:56:12'),
(328, 'update_published::project', 'web', '2025-07-28 14:56:12', '2025-07-28 14:56:12'),
(329, 'restore_published::project', 'web', '2025-07-28 14:56:13', '2025-07-28 14:56:13'),
(330, 'restore_any_published::project', 'web', '2025-07-28 14:56:13', '2025-07-28 14:56:13'),
(331, 'replicate_published::project', 'web', '2025-07-28 14:56:13', '2025-07-28 14:56:13'),
(332, 'reorder_published::project', 'web', '2025-07-28 14:56:14', '2025-07-28 14:56:14'),
(333, 'delete_published::project', 'web', '2025-07-28 14:56:14', '2025-07-28 14:56:14'),
(334, 'delete_any_published::project', 'web', '2025-07-28 14:56:14', '2025-07-28 14:56:14'),
(335, 'force_delete_published::project', 'web', '2025-07-28 14:56:15', '2025-07-28 14:56:15'),
(336, 'force_delete_any_published::project', 'web', '2025-07-28 14:56:15', '2025-07-28 14:56:15'),
(337, 'page_ActivityCalendarView', 'web', '2025-07-28 14:56:21', '2025-07-28 14:56:21'),
(338, 'page_ProjectGanttView', 'web', '2025-07-28 14:56:25', '2025-07-28 14:56:25'),
(339, 'widget_ActivityCalendarCount', 'web', '2025-07-28 14:56:30', '2025-07-28 14:56:30'),
(340, 'widget_ProjectCount', 'web', '2025-07-28 14:56:31', '2025-07-28 14:56:31');

-- --------------------------------------------------------

--
-- Table structure for table `planned_metrics`
--

CREATE TABLE `planned_metrics` (
  `id` bigint UNSIGNED NOT NULL,
  `activity_id` bigint UNSIGNED NOT NULL,
  `unit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `population_target_value` decimal(10,2) DEFAULT NULL,
  `population_real_value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `product_target_value` decimal(10,2) DEFAULT NULL,
  `product_real_value` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `planned_metrics`
--

INSERT INTO `planned_metrics` (`id`, `activity_id`, `unit`, `year`, `month`, `population_target_value`, `population_real_value`, `product_target_value`, `product_real_value`, `created_at`, `updated_at`) VALUES
(1, 70, NULL, NULL, NULL, 210.00, 0.00, 7.00, 0.00, '2025-08-01 15:57:20', '2025-08-01 15:57:20'),
(2, 71, NULL, NULL, NULL, 42.00, 0.00, 6.00, 0.00, '2025-08-01 16:16:44', '2025-08-01 16:16:44'),
(3, 72, NULL, NULL, NULL, 42.00, 0.00, 6.00, 0.00, '2025-08-01 16:19:34', '2025-08-01 16:19:34'),
(4, 73, NULL, NULL, NULL, 210.00, 0.00, 30.00, 0.00, '2025-08-01 16:23:00', '2025-08-01 16:23:00'),
(5, 74, NULL, NULL, NULL, 60.00, 0.00, 6.00, 0.00, '2025-08-01 16:28:23', '2025-08-01 16:28:23'),
(6, 75, NULL, NULL, NULL, 360.00, 0.00, 12.00, 0.00, '2025-08-01 16:42:24', '2025-08-01 16:42:24'),
(7, 76, NULL, NULL, NULL, 70.00, 0.00, 10.00, 0.00, '2025-08-01 16:46:47', '2025-08-01 16:46:47'),
(8, 77, NULL, NULL, NULL, 20.00, 0.00, 2.00, 0.00, '2025-08-01 16:46:47', '2025-08-01 16:46:47'),
(9, 78, NULL, NULL, NULL, 60.00, 0.00, 2.00, 0.00, '2025-08-01 16:52:03', '2025-08-01 16:52:03'),
(10, 79, NULL, NULL, NULL, 180.00, 0.00, 36.00, 0.00, '2025-08-01 17:07:29', '2025-08-01 17:07:29'),
(11, 80, NULL, NULL, NULL, 252.00, 0.00, 36.00, 0.00, '2025-08-01 17:09:29', '2025-08-01 17:09:29'),
(12, 81, NULL, NULL, NULL, 0.00, 0.00, 36.00, 0.00, '2025-08-01 17:51:14', '2025-08-01 17:51:14'),
(13, 82, NULL, NULL, NULL, 360.00, 0.00, 36.00, 0.00, '2025-08-01 17:52:52', '2025-08-01 17:52:52'),
(14, 83, NULL, NULL, NULL, 0.00, 0.00, 6.00, 0.00, '2025-08-01 17:57:28', '2025-08-01 17:57:28'),
(15, 84, NULL, NULL, NULL, 0.00, 0.00, 60.00, 0.00, '2025-08-01 17:57:28', '2025-08-01 17:57:28'),
(16, 85, NULL, NULL, NULL, 42.00, 0.00, 6.00, 0.00, '2025-08-01 18:00:50', '2025-08-01 18:00:50'),
(17, 86, NULL, NULL, NULL, 42.00, 0.00, 6.00, 0.00, '2025-08-01 18:00:50', '2025-08-01 18:00:50'),
(18, 87, NULL, NULL, NULL, 42.00, 0.00, 6.00, 0.00, '2025-08-01 18:04:45', '2025-08-01 18:04:45'),
(19, 88, NULL, NULL, NULL, 0.00, 0.00, 6.00, 0.00, '2025-08-01 18:04:45', '2025-08-01 18:04:45'),
(20, 89, NULL, NULL, NULL, 180.00, 0.00, 36.00, 0.00, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(21, 90, NULL, NULL, NULL, 252.00, 0.00, 36.00, 0.00, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(22, 91, NULL, NULL, NULL, 0.00, 0.00, 36.00, 0.00, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(23, 92, NULL, NULL, NULL, 310.00, 0.00, 36.00, 0.00, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(24, 93, NULL, NULL, NULL, 0.00, 0.00, 60.00, 0.00, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(25, 94, NULL, NULL, NULL, 0.00, 0.00, 28.00, 0.00, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(26, 95, NULL, NULL, NULL, 42.00, 0.00, 6.00, 0.00, '2025-08-01 18:19:30', '2025-08-01 18:19:30'),
(27, 96, NULL, NULL, NULL, 60.00, 0.00, 12.00, 0.00, '2025-08-01 19:19:57', '2025-08-01 19:19:57'),
(28, 97, NULL, NULL, NULL, 0.00, 0.00, 12.00, 0.00, '2025-08-01 19:33:24', '2025-08-01 19:33:24'),
(29, 98, NULL, NULL, NULL, 120.00, 0.00, 12.00, 0.00, '2025-08-01 19:33:24', '2025-08-01 19:33:24'),
(30, 99, NULL, NULL, NULL, 0.00, 0.00, 20.00, 0.00, '2025-08-01 19:33:24', '2025-08-01 19:33:24'),
(31, 100, NULL, NULL, NULL, 0.00, 0.00, 4.00, 0.00, '2025-08-01 19:36:17', '2025-08-01 19:36:17'),
(32, 101, NULL, NULL, NULL, 14.00, 0.00, 2.00, 0.00, '2025-08-01 19:40:04', '2025-08-01 19:40:04'),
(33, 102, NULL, NULL, NULL, 60.00, 0.00, 6.00, 0.00, '2025-08-01 19:40:04', '2025-08-01 19:40:04'),
(34, 103, NULL, NULL, NULL, 40.00, 0.00, 4.00, 0.00, '2025-08-01 19:41:53', '2025-08-01 19:41:53'),
(35, 104, NULL, NULL, NULL, 200.00, 0.00, 2.00, 0.00, '2025-08-01 19:45:59', '2025-08-01 19:45:59'),
(36, 105, NULL, NULL, NULL, 0.00, 0.00, 24.00, 0.00, '2025-08-01 19:45:59', '2025-08-01 19:45:59'),
(37, 106, NULL, NULL, NULL, 0.00, 0.00, 600.00, 0.00, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(38, 107, NULL, NULL, NULL, 0.00, 0.00, 4.00, 0.00, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(39, 108, NULL, NULL, NULL, 0.00, 0.00, 9.00, 0.00, '2025-08-01 19:54:17', '2025-08-01 19:54:17'),
(40, 109, NULL, NULL, NULL, 0.00, 0.00, 24.00, 0.00, '2025-08-01 19:59:52', '2025-08-01 19:59:52'),
(41, 110, NULL, NULL, NULL, 0.00, 0.00, 4.00, 0.00, '2025-08-01 19:59:52', '2025-08-01 19:59:52'),
(42, 111, NULL, NULL, NULL, 600.00, 0.00, 8.00, 0.00, '2025-08-01 20:05:05', '2025-08-01 20:05:05'),
(52, 121, NULL, NULL, NULL, 0.00, 0.00, 120.00, 0.00, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(53, 122, NULL, NULL, NULL, 0.00, 0.00, 96.00, 0.00, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(54, 123, NULL, NULL, NULL, 0.00, 0.00, 1.00, 0.00, '2025-08-01 20:20:43', '2025-08-01 20:20:43'),
(55, 124, NULL, NULL, NULL, 0.00, 0.00, 24.00, 0.00, '2025-08-01 20:20:43', '2025-08-01 20:20:43');

-- --------------------------------------------------------

--
-- Table structure for table `polygons`
--

CREATE TABLE `polygons` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `polygons`
--

INSERT INTO `polygons` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Riberas 1', 'Polígono ubicado entre las calles Siglo XXI, Rivera de Agua Blanca y Rivera del Salado. de las etapas 1 a la 6 ', '2025-07-24 19:21:50', '2025-07-24 19:21:50'),
(2, 'Riberas 2', 'Polígono ubicado entre las calles Rivera del Salado y Las Barrancas. Etapas de la 7 a la 8', '2025-07-24 19:23:51', '2025-07-24 19:23:51'),
(3, 'Comunidades', 'Polígono ubicado al norte entre Blv. Independencia, al poniente  C. Talamas Camandari, al oriente  con la C. Santiago Troncoso y al sur con la C. Paseos de San Isidro', '2025-07-24 19:28:16', '2025-07-24 19:28:16'),
(4, 'Parajes del Sur', 'Polígono ubicado entre C. Refugio de la Libertad, C. Mar del Plata y C. Mar del Sur ', '2025-07-24 19:30:19', '2025-07-24 19:30:19'),
(5, 'El Mezquital', 'Polígono ubicado entre Av. Las Torres, Blv. Independencia, Jesús Valdez y C. Verbena', '2025-07-24 19:31:47', '2025-07-24 19:31:47'),
(6, 'Tierra Nueva ', 'Polígono ubicado entre Blv. Independencia, C. Bahía del Salado, C. Puerto Anzio y Carretera al Porvenir', '2025-07-24 19:35:10', '2025-07-24 19:35:10'),
(7, 'Fuera de los polígonos', 'Esta categoría es utilizada para todas aquellas actividades que se desarrollan fuera de los polígonos de implementación de los proyectos', '2025-07-24 19:36:58', '2025-07-24 19:36:58'),
(8, 'Las Torres', 'Polígono ubicado entre Av. Las Torres. C. Ramón Rayón, C. Valle del Cedro y C. Durango ', '2025-07-24 19:38:09', '2025-07-24 19:38:09'),
(9, 'Tierra Nueva (Parque Gladiolas)', 'Polígono ubicado entre C. Puerto Santo Tomas, C. Bahía de Quino, C. Puro Colón y C. Puerto Palma', '2025-07-24 19:43:28', '2025-07-24 19:43:28'),
(10, 'Comunidades (Parque Frida Kahlo)', 'Polígono ubicado entre C. Refugio de la Libertad, C. Mesa Central, C. 22 de Enero y C. María Teresa Rojas', '2025-07-24 19:45:22', '2025-07-24 19:45:22'),
(11, 'Parajes del Sur (Parque Campo Grande)', 'Polígono ubicado entre C. Mar del Sur, C. Mar del Plata y C. Puerto Argentino', '2025-07-24 19:46:17', '2025-07-24 19:46:17');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `id` bigint UNSIGNED NOT NULL,
  `axes_id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`id`, `axes_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'Formación en arte y desarrollo infantil', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(2, 1, 'Formación artística', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(3, 1, 'Formación ciudadana', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(4, 1, 'Formación de equipos', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(5, 1, 'Formación humana', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(6, 1, 'Formación técnica', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(7, 1, 'Formación ética', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(8, 1, 'Formación de funcionarios de gobierno', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(9, 1, 'Promoción del arte local', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(10, 1, 'Emprendimientos locales', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(11, 1, 'Vinculación laboral', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(12, 1, 'Gestión ambiental institucional y comunitaria', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(13, 2, 'Agenda social', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(14, 2, 'Red para la incidencia pública', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(15, 2, 'Bienestar y desarrollo del personal de las osc', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(16, 2, 'Incubadora de empresas sociales', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(17, 3, 'Organización ciudadana', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(18, 3, 'Activación ciudadana', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(19, 3, 'Incidencia ciudadana', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(20, 3, 'Voluntariado', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(21, 3, 'Espacios públicos culturales', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(22, 3, 'Toma de decisiones', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(23, 4, 'Corrupción', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(24, 4, 'Servicios jurídicos', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(25, 4, 'Indicadores de ciudad', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(26, 4, 'Servicios de comunicación', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(27, 4, 'Periodismo ciudadano', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(28, 5, 'Fortalecimiento institucional', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(29, 5, 'Proyectos estratégicos', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(30, 5, 'Estandarización y automatización de procesos', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(31, 5, 'Gestión financiera y sostenibilidad', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(32, 5, 'Infraestructura y equipamiento', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(33, 5, 'Innovación organizacional', '2025-07-18 18:25:32', '2025-07-18 18:25:32'),
(34, 5, 'Posicionamiento y comunicación estratégica', '2025-07-18 18:25:32', '2025-07-18 18:25:32');

-- --------------------------------------------------------

--
-- Table structure for table `program_indicators`
--

CREATE TABLE `program_indicators` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `initial_value` decimal(10,2) DEFAULT NULL,
  `final_value` decimal(10,2) DEFAULT NULL,
  `program_id` bigint UNSIGNED NOT NULL,
  `program_axes_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `background` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `justification` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `general_objective` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `financiers_id` bigint UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `funded_amount` double DEFAULT NULL,
  `cofunding_amount` double DEFAULT NULL,
  `monthly_disbursement` double DEFAULT NULL,
  `followup_officer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `agreement_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `project_base_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `co_financier_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `background`, `justification`, `general_objective`, `financiers_id`, `start_date`, `end_date`, `total_cost`, `funded_amount`, `cofunding_amount`, `monthly_disbursement`, `followup_officer`, `agreement_file`, `project_base_file`, `co_financier_id`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'La mejora de espacios públicos y la activación socioambiental en el suroriente de Ciudad Juárez, Chihuahua, 2024-2025', 'La población de Riberas del Bravo representa el 3% de la población total de Ciudad Juárez, mayoritariamente es joven, principalmente en una edad de 18 a 24 años en ambos sexos, como se muestra en la Gráfica 1 cuyos datos coinciden con la base de INEGI (2020). Asimismo, en dicha gráfica presenta en el rango de edad de 25 a 39 años en el sexo femenino que son mayoría, mientras que en los demás rangos predomina el sexo masculino, incluso en general se tiene mayor porcentaje de este sexo, con un 50.6%.\nCon respecto a la ocupación de la población, INEGI (2020) exterioriza que el 55% de su población es económicamente activa a diferencia del 52% que existe en Juárez. \nEn Riberas del Bravo, 33% es operador seguido de un 20.7% que se dedican al hogar, un 17.1% son estudiantes, un 16.2% son empleados, Se tiene un porcentaje menor que tienen otro tipo de ocupación como es ser comerciantes, se encuentran jubilados, no tienen alguna ocupación, entre otros (para más detalle de las otras ocupaciones ver documento de gráficas).\nEl 9% de las familias encuestadas algún miembro del hogar tiene alguna discapacidad, referida principalmente de tipo motriz. INEGI indica que el 4.2% de las personas tienen alguna discapacidad y un 11.4% de la población tiene limitación.\nINEGI (2020) señala que en Riberas del Bravo sólo el 4% es analfabeta: donde el 1.4% de la población de 15 años y más es analfabeta, para la ciudad es de una diferencia de 0.1%; es decir es de 1.3%; y el 2.6% de la población de 8 a 14 años no sabe leer y escribir, mismo porcentaje se presenta a nivel municipal. Asimismo, indica que el nivel de escolaridad de Riberas del Bravo es de 9 años, mismo que se tiene en Ciudad Juárez, además es el mismo dato que se reflejan en los resultados de la encuesta, donde el 42.1% tiene como último grado de estudios la secundaria, seguido de un 27.6% que tiene la primaria; es decir, un 69.7% de la población tiene nivel básico, mientras que un 18% preparatoria y solamente el 4.2% tienen alguna profesión.\nUn elemento considerado en la encuesta para conocer la cohesión social de la comunidad se encuentra relacionado con la existencia de una vinculación con diferentes actores: gobierno, organización religiosa y asociación civil. La Gráfica 1 expresa si estos actores han trabajado en algún programa o proyecto en la colonia, en los tres casos el mayor porcentaje se encuentra como respuesta que No, solamente el 22% de los encuestados identificó que el gobierno ha realizado estas acciones, el 4.8% que han sido organizaciones religiosas y un 2% alguna organización de la sociedad civil. \nLa población encuestada reconoció que, por parte del gobierno, las dependencias que han trabajado son del gobierno del Estado, el Municipio, SEDESOL la academia de policía y el Centro comunitario. Para el caso de las organizaciones religiosas reconocieron que han sido cristianas, católicas, y pentecostés, mientras que en el caso de las organizaciones identificaron como los comités de vecinos, Red de mujeres, pueblos indígenas, universidad y un solo caso a la FECHAC.\nDe la población que identificó que han trabajado estos actores en Riberas del Bravo, solamente el 5.4% participó en las acciones realizadas por el gobierno, el 2% lo hizo con las organizaciones religiosas y el 1.8% ha participado en las organizaciones de la sociedad civil. \nOtro elemento considerado en la cohesión social se encuentra en la descripción de la relación con los vecinos. En la Gráfica 2 se indica que en todas las etapas existe buena relación, incluso en las etapas a excepción de la I, existen casos donde la relación es excelente. Por otro lado, existen con un porcentaje inferior de casos que la relación es mala como son en las etapas II, IV, V, VI, y VIII y solamente en la etapa VIII se refleja que la relación es muy mala, con un 0.8%.\nLos parques del fraccionamiento Riberas del Bravo distribuidos en todas las etapas, son espacios que son considerados áreas recreativas. El 31.5% de la población ocupa estas áreas y lo hacen para realizar actividades como caminar, jugar, como forma de distracción para los menores o para realizar algún deporte.\nSobre los comercios de la zona; no existe un supermercado dentro del fraccionamiento, el más cercano se ubica en la avenida Juárez Porvenir, mientras que existen 17 tiendas de auto servicio. INEGI (2020) señala de las unidades económicas que existen en Riberas del Bravo, el 54% corresponden al comercio al por menor, un 22% son de otros servicios y el 10% servicios de alojamiento temporal y de preparación de alimentos y bebidas.\nEn Riberas del Bravo se encuentran como activos de cohesión social dos centros comunitarios: centro comunitario Municipal Riveras del Bravo etapa 8 y el centro comunitario Estatal etapa 3, donde se dan servicios como talleres de habilidades, deportivos, apoyo psicológico, secundaria y preparatoria abierta. En donde se tiene alianzas con organizaciones para realizar estas actividades, las cuales son EMMA, CAPA, SEDEX, MUSPAC, ICHEA y Programa Desafío.', 'Considerando el abandono histórico de que han sido sujetos los espacios públicos de Ciudad Juárez, y su impacto en la conversión de estos, en espacios altamente deteriorados, contaminados que incluso  dificultan la convivencia y niegan el derecho a un ambiente sano y al goce pleno de la ciudad, la intervención de Juárez Limpio A.C. colocará el énfasis de sus acciones en trabajar codo a codo con la comunidad para reconectarse con el ecosistema, identificar los riesgos que se asocian con la contaminación ambiental y poner acciones en marcha para mejorar sus espacios públicos, y regenerar con ello, el sentido de pertenencia y el tejido social. \nLa intervención va de la mano con el Modelo Integral de Desarrollo Social (MIDAS). Juárez Limpio A.C. se unirá a la intervención con los objetivos postulados en posteriores apartados a través de sus programas ambientales A Reforestar Juárez, Pasaporte Ambiental y Educación Ambiental a través de huertos urbanos.\nA Reforestar Juárez es un programa que recurre a la forestación urbana como herramienta para promover la cohesión social. Se comenzará a trabajar con las comunidades ya establecidas previamente en el MIDAS, se levantará una pequeña encuesta relacionada a las prácticas ambientales de las personas asistentes y se llevarán a cabo grupos focales para detectar áreas de oportunidad para forestar o mantener áreas forestadas. Luego, se prepararán los sitios con limpiezas, acolchado, sistemas de riego y talleres técnicos. Se realizarán las forestaciones con especies adaptadas a la zona. Posteriormente se dará seguimiento a los sitios y comunidades forestadas\nEl Pasaporte Ambiental (PA) es un programa que nace de la necesidad de la comunidad juarense de llevar a cabo actividades individuales de cuidado del ambiente. Este consiste en una aplicación móvil donde las personas se podrán inscribir, registrar sus actividades en favor del ambiente y observar las demás que se hacen en otras partes de la ciudad. Esto promoverá la participación ciudadana en temas ambientales. Previo al registro de personas en la aplicación móvil, se promoverán talleres de cuidado del ambiente como reforzamiento del aprendizaje significativo.\nLos huertos urbanos resultan alternativas relevantes para naturar espacios en las grandes urbes y como herramientas de educación ambiental e instrumentos de inclusión social, que inciden en la disminución de los índices delictivos, contribuyen a la soberanía alimentaria, enriquecen la creatividad, reducen la huella ecológica, apoyan las economías locales y generan una consciencia profunda sobre la producción de los alimentos disminuyendo su desperdicio.\nLos huertos comunitarios estimulan la cohesión social, la construcción y fortalecimiento de lazos comunitarios, contribuyen con la proliferación de biodiversidad, la salud de suelo y el aire, la mitigación del cambio climático, e incluso funcionan como actividades terapéutico– relajantes.\nEste proyecto busca contribuir a los objetivos de desarrollo sostenible 3,11 y 13 a través de la disminución de materiales tóxicos al alcance de las personas, contribuyendo a la mejora de los espacios públicos y fortaleciendo la capacidad de adaptación de los riesgos relacionados con el clima. ', 'Promover la participación de la comunidad habitante de Riberas del Bravo en actividades de activación para la solución de problemas ambientales, fortalecer la cohesión social a través de acciones en pro de la activación de los espacios públicos.', 1, '2024-11-04', '2025-12-31', 1297959.21, 864478.64, 433480.57, 0, 'Ana Luisa Sáenz', NULL, NULL, 2, 3, '2025-07-21 20:37:11', '2025-07-24 16:06:03', NULL),
(3, 'Fortalecimiento de las capacidades ciudadanas y los espacios de articulación para la mejora de entornos, comunidades más proactivas y mejor calidad de vida en Juárez 2025', 'Desde 1999, Plan Estratégico de Juárez ha trabajado con un enfoque ciudadano, proponiendo y exigiendo de manera respetuosa pero firme a las autoridades locales. Nuestro objetivo es promover una ciudad más democrática, equitativa y con un gobierno más profesional. Para lograrlo, creemos firmemente en impulsar la participación ciudadana y en encontrar espacios y mecanismos que den estructura a esta participación en la toma de decisiones gubernamentales. Nuestra misión es construir una fuerza ciudadana activa que intervenga en los asuntos públicos, proponiendo y exigiendo mejoras para una mejor calidad de vida, de modo que la ciudadanía tenga una influencia significativa en el gobierno municipal.\n\nDe acuerdo con la Encuesta Nacional de Cultura Cívica (ENCUCI) 2020, el 84.7% de la población mayor de 15 años ha identificado problemas relacionados con infraestructura, seguridad y servicios educativos o de salud en su colonia o localidad. Los problemas más frecuentes, como la falta de alumbrado, agua potable, baches y fugas de agua, afectaron al 71.2% de la población. Asimismo, el 55.8% de los encuestados manifestó estar muy interesado o preocupado por los asuntos del país, y el 54.6% considera la corrupción como uno de los tres principales problemas nacionales, seguido por la pobreza, mencionada por el 53.1%. Además, el 69.2% de la población mayor de 15 años está totalmente de acuerdo con que el gobierno debe contar con la participación activa de la ciudadanía en la toma de decisiones.\n\nA nivel local, según la encuesta \"Así Estamos Juárez\" de 2021, se alcanzó una cifra histórica de participación activa de la población mayor de 18 años en organizaciones de la sociedad civil, con un 50.8%. Sin embargo, esta cifra disminuyó al 31.0% en 2023. Del total de personas que participan activamente, el 54.8% lo hace en organizaciones religiosas, seguido de un 22.6% que participa en OSCs/ONGs o fundaciones, el 16.1% en partidos políticos, y el 9.7% en comités de vecinos, sindicatos o clubes sociales.\n\nEstos datos reflejan una clara necesidad entre los juarenses de colaborar y formar parte de grupos que trabajen activamente por su comunidad. Es crucial llevar a cabo acciones que mantengan, aumenten y expandan la participación ciudadana hacia otros espacios y mecanismos. Durante el primer año del proyecto, se desarrolló una fase de acercamiento y exploración territorial con el fin de identificar elementos en las comunidades que permitieran detectar capacidades de organización comunitaria y acción ciudadana. A través de la Red de Vecinos, se implementaron las fases de organización, formación e incidencia ciudadana, que, de manera articulada con otros componentes del proyecto, consolidaron procesos de participación ciudadana en los tres polígonos seleccionados, para 2024, los esfuerzos se expandieron a 6 polígonos, 5 de los cuales se ubican en el sector suroriente de la ciudad. Estos grupos vecinales ahora están implementando sus Planes de Acción Comunitarios para resolver problemáticas en su entorno, luego de participar en un proceso formativo que incluyó talleres, conversatorios, recorridos exploratorios y seminarios de participación ciudadana. Dicho proceso ha fortalecido sus capacidades individuales y colectivas para gestionar, vigilar, exigir y articularse con diversas instituciones públicas y organizaciones de la sociedad civil.\n\nPara agosto , en el proyecto colaboración con FECHAC, se habían conformado 34 comunidades vecinales solamente en 2024, las cuales se insertaban en los distintos polígonos, enfocándose en la mejora de los espacios comunitarios, el acceso a servicios básicos y la mejora de las relaciones para la participación comunitarias. \n\n**Fuentes:**  \nPlan Estratégico de Juárez, A.C. (2023). *Informe Así Estamos Juárez 2023*. Ciudad Juárez, México: Plan Estratégico de Juárez, A.C.  \nhttps://worldjusticeproject.mx/wp-content/uploads/2022/05/1_WJP_IEDMX_Digital.pdf  \nhttps://www.inegi.org.mx/contenidos/programas/encuci/2020/doc/ENCUCI_2020_Presentacion_Ejecutiva.pdf  \nhttps://asiestamosjuarez.org/wp-content/uploads/2022/03/Informe-AEJ2022.pdf\n', 'Desde el año 2012, PEJ puso en marcha el proyecto “Red de Vecinos”, para promover la participación ciudadana desde un enfoque comunitario. Consideramos que la organización vecinal es una experiencia de sensibilización, colaboración, diálogo y acción que puede impulsar la cohesión social y la solución de problemas comunitarios para la mejora de la calidad de vida. Actualmente, Red de Vecinos de Juárez apoya en la organización de grupos vecinales, la vinculación entre ellos y el acompañamiento a procesos comunitarios de gestión e incidencia a nivel local. Este plan se ha sostenido con la articulación a nivel territorial de estrategias de formación, organización, activación, generación de información y vinculación (ciudadanía, gobierno y sociedad civil) avanzando hacia la formación y consolidación de capital social de base, para, luego de conformar grupos vecinales con las habilidades, conocimientos, herramientas y motivación para que al ser co-responsables con el desarrollo y la mejora de sus comunidades, puedan convertirse en mentores para nuevas comunidades. \n\nEn este sentido, se apuesta por la pedagogía social, en la que la ciudadanía está aprendiendo a participar de manera democrática y respetando la ley, pero por otro, las autoridades locales, quienes también pueden aprender y entender que la ciudadanía es parte clave de la vida pública de la ciudad.  Y si bien por ley se le debe sumar a la toma de decisiones públicas, el que participen de forma organizada y con argumentos técnicos, contribuye a facilitar el trabajo de funcionarios y representantes populares. \n\nSe destaca el área de comunicación, a través de redes sociales y la página web de PEJ, difunde contenido clave sobre el proyecto, beneficiarios y agentes locales, sirviendo como un canal informativo y de debate para los juarenses, esta área refuerza los esfuerzos de Plan Estratégico y sus aliados en la creación de contenido gráfico para eventos, redes sociales y diseño de documentación dirigida a distintos públicos objetivos. \nPor otra parte, para fortalecer los procesos de incidencia el seguimiento a temas estratégicos que garanticen la participación ciudadana efectiva y el seguimiento a temas de relevancia para la comunidad en comisiones de regidores y cabildo, el monitoreo de PEJ ha sido estratégico para proveer de información a la ciudad para activar procesos ciudadanos y comunitarios que busquen discutir, impulsar o detener decisiones o acciones que van en contra de la ciudadanía y la ciudad.  Además, en PEJ se busca amplificar las voces de los ciudadanos, asegurando que sus preocupaciones sean escuchadas y que se promueva la rendición de cuentas en las acciones que afectan a la comunidad.\nEl desarrollo del proyecto no sería posible sin el equipo profesional que conforma el organigrama de PEJ. Este personal tiene roles fundamentales para el éxito del proyecto, al aportar sus conocimientos y experiencia en áreas clave como la organización comunitaria, la formación ciudadana, el análisis de información y la comunicación estratégica. Cada área de trabajo contribuye de manera única al cumplimiento de los objetivos del proyecto. \n\nEn el proyecto activo actualmente, con ID 8142, se pueden destacar como principales logros a junio de 2024, conformar a 45 grupos/comités de vecinos; han participado en procesos de formación 1,159 personas; se han intervenido alrededor de 49 espacios públicos con actividades como limpiezas, murales, desazolve de alcantarillas, bacheo de calles, señalización, entre otros, además de espacios de conformación y convivencia. Así mismo se han construido 45 planes de acción comunitarias y se han llevado a cabo 115 gestiones y vinculaciones para la solución de problemas territoriales. Para esta siguiente fase del proyecto se trabajará con los y las vecinas de las siete zonas/polígonos los cuales participaran de una serie de actividades que van desde la organización y formación, a la gestión y participación ciudadana. Dando continuidad a la metodología de acompañamiento comunitario, cada grupo vecinal tendrá el reto de identificar sus necesidades y definir un plan de acción comunitario que aporte a la mejora de su entorno.\n\nAdicionalemente se integrarán nuevas actividades enfocadas a dar consolidar los procesos participativos como la conformación de Comités de Obra y Seminarios de Participación Ciudadana dirigidos a niñas, niños y adolescentes. En cuanto a la información para la participación, también es importante mencionar al proyecto “Así Estamos Juárez”. AEJ mide desde 2010 la calidad de vida y la percepción de la ciudadanía en múltiples temas a nivel local. Esta información le permite a la sociedad saber en dónde estamos y su hay avances o retrocesos respecto a años anteriores. Para fines del proyecto, se cuenta con información de los siete polígonos seleccionados para conocer de manera más precisa sus particularidades en temas demográficos, percepción ciudadana y estado de los principales temas de relevancia. Información que se convierte en un insumo para que las personas puedan realizar propuestas de solución a los problemas identificados. \n\nA estos esfuerzos se suma el área de Periodismo Ciudadano, en aras del proyecto 2025, cuyo objetivo es generar opinión pública que fortalezca la participación ciudadana. Se enfoca en noticias y reportajes de investigación sobre temas locales en Ciudad Juárez, como actividades gubernamentales, desarrollo urbano y transparencia. Además, el área de Estudios de PEJ da seguimiento a los indicadores de \"Así Estamos Juárez\" y \"Juárez 2030\", fundamentales para describir el estado de la ciudad y guiar intervenciones. La información estadística, focalizada en polígonos de intervención, fortalece los procesos comunitarios y la toma de decisiones.\n\nFinalmente, el área de comunicación de PEJ tiene la importante tarea de generar información digital y física para difundirla a través de diferentes canales, con el fin de aportar a la formación, sensibilización, activación y movilización de la comunidad para lograr los objetivos del proyecto. \n\nLos polígonos en los que se realizará el proyecto son: \n\nPolígonos actuales:\n• Riberas 1 integrado por etapas 1ª las 6 de Riberas del Bravo con una población total de 19,307 habitantes. \n• Riberas 2: integrado por etapas 7 y 8 con una población total de 17,776 habitantes. \n• Tierra Nueva integrado por colonias Águilas de Zaragoza, El Papalote, Patria 1 2 3, Héroes de México, La Perla, Las Montañas, Praderas de Oriente, Tierra Nueva 1 y 2, con una población total de 30,414 habitantes. \n• Hacienda Las Torres Universidad/Mezquital, integrado por fraccionamiento Hacienda Las Torres Universidad, El mezquital y Rincones de Salvárcar con una población total de 17,517 habitantes. \n• Parajes del sur con una población total de 17,419 habitantes. \n• Aztecas que incluye las colonias Aztecas, Constitución, Electricistas, Condominio Maya-sur, Condominio Aztecas, Colonia del Maestro y el Fraccionamiento Independencia Sur con una población de 26,709 habitantes; \n\nPolígonos nuevos:\n• Las Torres con una población de 14,487 a su vez integrado por Fraccionamiento Rincón el sol, Villas de Salvarcar, Versalles -Privada Burdeos, Versalles- Lyon, Misiones de Real , El Campanario 4 Siglos y Pradera de las Torres de acuerdo con datos del censo de población y vivienda del 2020. \n\nCon la incorporación de este nuevo polígono, la población total sería 143, 629 habitantes aproximadamente esto de acuerdo con datos del Censo de Población y Vivienda 2020 de INEGI. \n\nEstos polígonos fueron seleccionados a partir de la características de vulnerabilidad identificadas, favorabilidad de respuesta de la comunidad a procesos comunitarios (procesos previos con PEJ), espacios públicos existentes tanto para realizar actividades como para mejorar su condición y finalmente, otros actores/aliados que puedan sumar a los procesos que se busca impulsar en estas zonas. Además, de la identificación de problemáticas transversales a todo el suroriente de la ciudad derivado de la dispersión y degradación urbana presente. Plan Estratégico de Juárez cuenta con más de 20 años de experiencia promoviendo la participación comunitaria y ciudadana, midiendo la calidad de vida, realizando acciones de contraloría social, periodismo ciudadano y litigio estratégico. Destacando además, que cuenta con un amplio reconocimiento y respaldo de ciudadanía y líderes comunitarios, empresariales, académicos y políticos.\n\nEs importante destacar que tanto el proyecto activo durante 2024 , como el 2025, forman parte de una apuesta integral por el desarrollo de personas, grupos y organizaciones de Juárez. Estos proyectos se inscriben dentro de una estrategia más amplia, progresiva y de largo plazo que ya ha mostrado avances significativos en la ciudad (mencionar resultados de la intervención amplia).\n\nA manera de logros que se buscan consolidar para 2025, en el proyecto activo se destaca una activa participación ciudadana en talleres, seminarios y actividades comunitarias, superando metas en la conformación de comunidades vecinales y realizando gestiones comunitarias efectivas que atienden necesidades locales. Los seminarios para niños, niñas y adolescentes han promovido el empoderamiento desde temprana edad, asegurando la participación futura.\nAdemás, las publicaciones en redes sociales han sensibilizado a la comunidad sobre la importancia de la participación ciudadana, mientras que las Asambleas Comunitarias con candidatos locales han logrado compromisos concretos. Entre los logros tangibles destacan la elaboración de Planes de Desarrollo Territorial en Parajes del Sur y parques, la rehabilitación de espacios como \"El Palomar\" y proyectos de equipamiento para parques mediante el presupuesto participativo. Se han gestionado mejoras en servicios públicos esenciales como alumbrado y pavimentación.\n\nEs importante mencionar que, la estrategia planteada en este proyecto, tiene implícito el trabajo colaborativo con otras organizaciones de la sociedad civil que realizan intervenciones en red como es el caso de “Comunidades Juárez” y que tienen dinámicas operativas en común que fortalece, optimiza y potencia los esfuerzos conjuntos e integrales de PEJ.  El conjunto de organizaciones en territorios vulnerables generan un impacto profundo y sostenible, al abordar problemáticas de manera más holística y eficiente. La colaboración entre ellas permite optimizar recursos, evitar la duplicación de actividades y ofrecer soluciones más integrales, abordando temas como participación ciudadana, arte y cultura, juventud, empleabilidad, liderazgo y derechos humanos.\nAdemás, estas acciones fortalecen el empoderamiento comunitario, fomentan la resiliencia local y aumentan la participación ciudadana en la toma de decisiones. \nEl trabajo coordinado de iniciativas y proyectos financiados por FECHAC, incrementa su capacidad de incidencia política y visibilidad, acelerando cambios estructurales y fortaleciendo redes de apoyo que incrementan la confianza y cohesión social en las comunidades. \nLa cooperación también facilita la innovación social y la creación de mecanismos más eficientes para el monitoreo y evaluación de los resultados, lo que permite ajustar estrategias y maximizar el impacto positivo, a la vez que se reducen riesgos en los territorios más vulnerables. En conjunto, estos esfuerzos contribuyen a construir un entorno más equitativo, resiliente y sostenible para el desarrollo de las comunidades atendidas.', 'Construir una ciudadanía con habilidades para la participación ciudadana y la solución de problemas comunitarios a través del desarrollo de una relación de corresponsabilidad entre gobierno y sociedad en Juárez', 1, '2025-01-14', '2025-12-31', 20323355.51, 13508781.88, 6814573.63, NULL, 'Ana Luisa Saénz', NULL, NULL, 2, 3, '2025-07-30 15:27:37', '2025-07-30 15:27:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `project_disbursements`
--

CREATE TABLE `project_disbursements` (
  `id` bigint UNSIGNED NOT NULL,
  `projects_id` bigint UNSIGNED NOT NULL,
  `amount` double DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_disbursements`
--

INSERT INTO `project_disbursements` (`id`, `projects_id`, `amount`, `disbursement_date`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 307774.99, '2025-05-01', 7, '2025-07-21 21:58:15', '2025-07-30 15:52:34'),
(2, 1, 372794.87, '2025-11-10', 7, '2025-07-21 22:03:36', '2025-07-30 15:52:52'),
(3, 1, 183935.9, '2026-02-09', 7, '2025-07-21 22:04:49', '2025-07-30 15:53:56'),
(4, 3, 8497687.75, '2025-02-03', 8, '2025-07-30 15:32:40', '2025-07-30 21:35:15'),
(5, 3, 1890846.41, '2025-05-16', 8, '2025-07-30 21:45:55', '2025-07-30 21:45:55'),
(6, 3, 3120247.72, '2025-08-15', 8, '2025-07-30 21:48:07', '2025-07-30 21:48:07');

-- --------------------------------------------------------

--
-- Table structure for table `project_reports`
--

CREATE TABLE `project_reports` (
  `id` bigint UNSIGNED NOT NULL,
  `report_date` date DEFAULT NULL,
  `report_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `projects_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `published_activities`
--

CREATE TABLE `published_activities` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_id` bigint UNSIGNED NOT NULL,
  `original_activity_id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `specific_objective_id` bigint UNSIGNED NOT NULL,
  `goals_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `snapshot_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `published_metrics`
--

CREATE TABLE `published_metrics` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_id` bigint UNSIGNED NOT NULL,
  `original_metric_id` bigint UNSIGNED NOT NULL,
  `activity_id` bigint UNSIGNED NOT NULL,
  `unit` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `population_target_value` decimal(10,2) DEFAULT NULL,
  `population_real_value` decimal(10,2) DEFAULT NULL,
  `product_target_value` decimal(10,2) DEFAULT NULL,
  `product_real_value` decimal(10,2) DEFAULT NULL,
  `snapshot_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `published_projects`
--

CREATE TABLE `published_projects` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_id` bigint UNSIGNED NOT NULL,
  `original_project_id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `background` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `justification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `general_objective` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `funded_amount` double DEFAULT NULL,
  `cofunding_amount` double DEFAULT NULL,
  `financiers_id` bigint UNSIGNED NOT NULL,
  `co_financier_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `snapshot_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'web', '2025-07-21 16:21:04', '2025-07-21 16:21:04'),
(2, 'capturista', 'web', '2025-07-28 14:58:28', '2025-07-28 14:58:28'),
(3, 'financiera', 'web', '2025-08-12 18:02:19', '2025-08-12 18:03:55');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 1),
(128, 1),
(129, 1),
(130, 1),
(131, 1),
(132, 1),
(133, 1),
(134, 1),
(135, 1),
(136, 1),
(137, 1),
(138, 1),
(139, 1),
(140, 1),
(141, 1),
(142, 1),
(143, 1),
(144, 1),
(145, 1),
(146, 1),
(147, 1),
(148, 1),
(149, 1),
(150, 1),
(151, 1),
(152, 1),
(153, 1),
(154, 1),
(155, 1),
(156, 1),
(157, 1),
(158, 1),
(159, 1),
(160, 1),
(161, 1),
(162, 1),
(163, 1),
(164, 1),
(165, 1),
(166, 1),
(167, 1),
(168, 1),
(169, 1),
(170, 1),
(171, 1),
(172, 1),
(173, 1),
(174, 1),
(175, 1),
(176, 1),
(177, 1),
(178, 1),
(179, 1),
(180, 1),
(181, 1),
(182, 1),
(183, 1),
(184, 1),
(185, 1),
(186, 1),
(187, 1),
(188, 1),
(189, 1),
(190, 1),
(191, 1),
(192, 1),
(193, 1),
(194, 1),
(195, 1),
(196, 1),
(197, 1),
(198, 1),
(199, 1),
(200, 1),
(201, 1),
(202, 1),
(203, 1),
(204, 1),
(205, 1),
(206, 1),
(207, 1),
(208, 1),
(209, 1),
(210, 1),
(211, 1),
(212, 1),
(213, 1),
(214, 1),
(215, 1),
(216, 1),
(217, 1),
(218, 1),
(219, 1),
(220, 1),
(221, 1),
(222, 1),
(223, 1),
(224, 1),
(225, 1),
(226, 1),
(227, 1),
(228, 1),
(229, 1),
(230, 1),
(231, 1),
(232, 1),
(233, 1),
(234, 1),
(235, 1),
(236, 1),
(237, 1),
(238, 1),
(239, 1),
(240, 1),
(241, 1),
(242, 1),
(243, 1),
(244, 1),
(245, 1),
(246, 1),
(247, 1),
(248, 1),
(249, 1),
(250, 1),
(251, 1),
(252, 1),
(253, 1),
(254, 1),
(255, 1),
(256, 1),
(257, 1),
(258, 1),
(259, 1),
(260, 1),
(261, 1),
(262, 1),
(263, 1),
(264, 1),
(265, 1),
(266, 1),
(267, 1),
(268, 1),
(269, 1),
(270, 1),
(271, 1),
(272, 1),
(273, 1),
(274, 1),
(275, 1),
(276, 1),
(277, 1),
(278, 1),
(279, 1),
(280, 1),
(281, 1),
(282, 1),
(283, 1),
(284, 1),
(286, 1),
(287, 1),
(288, 1),
(289, 1),
(290, 1),
(291, 1),
(292, 1),
(293, 1),
(294, 1),
(295, 1),
(296, 1),
(297, 1),
(298, 1),
(299, 1),
(300, 1),
(301, 1),
(302, 1),
(303, 1),
(304, 1),
(305, 1),
(306, 1),
(307, 1),
(308, 1),
(309, 1),
(310, 1),
(311, 1),
(312, 1),
(313, 1),
(314, 1),
(315, 1),
(316, 1),
(317, 1),
(318, 1),
(319, 1),
(320, 1),
(321, 1),
(322, 1),
(323, 1),
(324, 1),
(325, 1),
(326, 1),
(327, 1),
(328, 1),
(329, 1),
(330, 1),
(331, 1),
(332, 1),
(333, 1),
(334, 1),
(335, 1),
(336, 1),
(337, 1),
(338, 1),
(339, 1),
(340, 1),
(283, 2),
(284, 2),
(337, 2),
(338, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('fvnad3OiE5JzRMae83RUXomFdDMuhIp1QOu4BuZN', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoicGhDYTAxQUJvVkNxVWRqOGxlbTJDQ0tJeWo0OEFUNUhzcUF1ZmhwMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9jb211bmlkYWRlc192NS50ZXN0L2FkbWluL3JlZ2lzdHJvLWJlbmVmaWNpYXJpb3MiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJEtJUjk5bUxQYVI0QVVPS0oyUDRpOWV6WkVsYVdDbGttbmJtdWNWRlNQMkJROXBSaHhjQi5PIjtzOjQwOiI0ODA0MGVmN2YyNTQyYjM5YjliYTlhNzI5ODNiMGQ4OF9maWx0ZXJzIjtOO30=', 1762187380);

-- --------------------------------------------------------

--
-- Table structure for table `specific_objectives`
--

CREATE TABLE `specific_objectives` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `projects_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `specific_objectives`
--

INSERT INTO `specific_objectives` (`id`, `description`, `projects_id`, `created_at`, `updated_at`) VALUES
(7, 'OE1. Lograr que la comunidad habitante de Riberas del Bravo (80: Población femenina-39, Población masculina-41, Población de 0 a 14 años-23, Población de 15 a 29 años-24, Población de 30 a 59 años-31, Población de 60 años y más-2 ) se apropie de espacios públicos (incluyendo escuelas) en el polígono de Riberas del Bravo.', 1, '2025-07-24 16:06:03', '2025-07-24 16:06:03'),
(8, 'OE2.  Impartir actividades que promuevan la educación ambiental como herramienta de cohesión social en las comunidades habitantes de Riberas del Bravo (350: Población femenina-172, Población masculina-178, Población de 0 a 14 años-103, Población de 15 a 29 años-103, Población de 30 a 59 años-134, Población de 60 años y más-10 ) y el suroriente de Juárez.', 1, '2025-07-24 16:06:03', '2025-07-24 16:06:03'),
(9, 'OE3.  Divulgar temas de cuidado de los espacios públicos a la comunidad habitante de Riberas del Bravo (220: Población femenina-78, Población masculina-81, Población de 0 a 14 años-47, Población de 15 a 29 años-47, Población de 30 a 59 años-61, Población de 60 años y más-5), a través de la creación de dos huertos urbanos de la zona', 1, '2025-07-24 16:06:03', '2025-07-24 16:06:03'),
(10, 'OE1. Lograr que la comunidad habitante de Riberas del Bravo (80: Población femenina-39, Población masculina-41, Población de 0 a 14 años-23, Población de 15 a 29 años-24, Población de 30 a 59 años-31, Población de 60 años y más-2 ) se apropie de espacios públicos (incluyendo escuelas) en el polígono de Riberas del Bravo.', 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(11, 'OE2.  Impartir actividades que promuevan la educación ambiental como herramienta de cohesión social en las comunidades habitantes de Riberas del Bravo (350: Población femenina-172, Población masculina-178, Población de 0 a 14 años-103, Población de 15 a 29 años-103, Población de 30 a 59 años-134, Población de 60 años y más-10 ) y el suroriente de Juárez.', 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(12, 'OE3.  Divulgar temas de cuidado de los espacios públicos a la comunidad habitante de Riberas del Bravo (220: Población femenina-78, Población masculina-81, Población de 0 a 14 años-47, Población de 15 a 29 años-47, Población de 30 a 59 años-61, Población de 60 años y más-5), a través de la creación de dos huertos urbanos de la zona', 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(13, 'OE1. Fortalecer las capacidades de la ciudadanía estableciendo procesos formativos que les permitan gestionar la solución de problemas comunitarios', 3, '2025-07-30 15:27:37', '2025-07-30 15:27:37'),
(14, 'OE2. Promover la articulación de la comunidad a través de la conformación de grupos vecinales que les faciliten trabajar en la solución de problemas comunitarios', 3, '2025-07-30 15:27:37', '2025-07-30 15:27:37'),
(15, 'OE3. Generar información estratégica de la ciudad y sus instituciones para mejorar el ejercicio de la participación de la ciudadanía y la toma de decisiones públicas. ', 3, '2025-07-30 15:27:37', '2025-07-30 15:27:37'),
(16, 'OE4. Promover el desarrollo local mediante la difusión de información clave sobre la ciudad, posicionándola como herramienta de planificación estratégica, y fortaleciendo la transparencia mediante la evaluación continua de los procesos de toma de decisiones (procesos de incidencia pública/urbana). ', 3, '2025-07-30 15:27:37', '2025-07-30 15:27:37'),
(17, 'OE5. Asegurar la difusión de las actividades del proyecto para sensibilizar a la comunidad sobre las problemáticas actuales y la importancia de la participación ciudadanía. ', 3, '2025-07-30 15:27:37', '2025-07-30 15:27:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `point_of_contact_id` bigint UNSIGNED DEFAULT NULL,
  `phone` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `org_role` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organizations_id` bigint UNSIGNED DEFAULT NULL,
  `org_area` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `can_publish_data` tinyint(1) NOT NULL DEFAULT '0',
  `last_publication_access` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `point_of_contact_id`, `phone`, `org_role`, `organizations_id`, `org_area`, `can_publish_data`, `last_publication_access`, `deleted_at`) VALUES
(1, 'David García', 'dgarcia@planjuarez.org', NULL, '$2y$12$KIR99mLPaR4AUOKJ2P4i9ezZElaWClkmnbmucVFSP2BQ9pRhxcB.O', 'I5cFsP9VyJsYDRXxz07JYtVT3iksQbNTFTgR98R7UG4IgJGEgeBNIirE4RAC', '2025-07-18 15:42:35', '2025-08-05 15:49:46', NULL, NULL, NULL, 3, NULL, 0, NULL, NULL),
(2, 'Capturista', 'capturista@test.com', NULL, '$2y$12$Va4opuExiUMvvvjU2vgh8OjqmgyUzzyPtNedBys1g5AEI1YcTiUzO', NULL, '2025-07-18 18:49:25', '2025-07-28 14:59:01', NULL, NULL, NULL, 5, NULL, 0, NULL, NULL),
(3, 'Judith Carrillo Carrera', 'jcarrillo@planjuarez.org', NULL, '$2y$12$59lZ6VvrfpB7gOCrfOI5FuZOrfHvYFWuacfDV0ndEUu.qIly960wu', NULL, '2025-07-21 19:22:31', '2025-07-21 19:22:31', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL),
(4, 'Lizeth López Martínez', 'llopez@planjuarez.org', NULL, '$2y$12$2LjLp3NeytBxo0PTUfXnceF8UKCeiP4vYTEW5rGZHDpbf5mWyxfAy', 'LfSAMpHCfGr3TwUI4sNbxlFnzTexwF5BXsKaNFnj3yhWbcWsyCSCXC2wBqO0', '2025-07-25 14:54:14', '2025-07-25 14:56:40', NULL, NULL, 'Ejecutivo (a)', 3, 'Estudios y planeación estratégica ', 0, NULL, NULL),
(5, 'Alejandra Villagrana', 'proyectosambientales@juarezlimpio.org', NULL, '$2y$12$C0BtOjD/wRYdEau.chJuf.3nE8M9Y1uWFlD/XuNIw/X9qauQ3884W', NULL, '2025-07-25 15:24:08', '2025-08-01 21:04:27', NULL, NULL, 'Coordinador (a)', 1, 'Proyectos  Ambientales', 0, NULL, NULL),
(6, 'Lluvia Herrera', 'vinculacion@juarezlimpio.org', NULL, '$2y$12$p6fv.rcTCF5Gc7j4Z1wFxu/FvCoF/yVMRZ7myggWc0rL5PxgE4hcG', NULL, '2025-07-25 15:27:36', '2025-08-01 21:04:03', 5, '6567755145', 'Ejecutivo (a)', 1, 'Atención Comunitaria', 0, NULL, NULL),
(7, ' Bárbara Briones Martínez', 'barbara@fcfn.org', NULL, '$2y$12$c7nwfgOVyCaRDyPiPt5X0OJCQEDM0PwyL.6S4mR2x7i4nWccchGN6', NULL, '2025-07-30 15:51:12', '2025-07-30 15:51:12', NULL, '6563111562', 'Dirección Ejecutiva', 10, 'Sostenibilidad', 0, NULL, NULL),
(8, 'Diego Mesa', 'dmesa@planjuarez.org', NULL, '$2y$12$8EirDthajZH3Mv3Rv.hAQ.Q7LZg4QTeVnKUvs0MLrQG54OzqGaqoi', NULL, '2025-07-30 21:34:20', '2025-07-30 21:34:20', NULL, '6562688665', 'Dirección Ejecutiva', 3, 'Desarrollo Institucional', 0, NULL, NULL),
(9, 'Dario Alvarez', 'dalvarez@planjuarez.org', NULL, '$2y$12$HLX1Zc7Z.4tNpj8GVi69mutuOQx0/JdJbgyJZcycUQZoI.ta7p5NW', NULL, '2025-08-01 20:34:05', '2025-08-01 20:34:05', NULL, '6563203897', 'Operativo (a)', 5, 'Promotoría Comunitaria', 0, NULL, NULL),
(10, 'Lizbeth Trejo', 'ltrejo@planjuarez.org', NULL, '$2y$12$pvilnu1cCIjnuXeT8TDBgO.NbaorAZPHZy6dNvNF6/X1EJ.8vvAX.', NULL, '2025-08-01 20:35:35', '2025-08-11 16:35:27', NULL, '6561483986', 'Operativo (a)', 5, 'Promotoría Comunitaria', 0, NULL, NULL),
(11, 'José Luis Rodriguez Isais', 'lrodriguez@planjuarez.com', NULL, '$2y$12$B29EpcJcDO.3Bbpj9STrPu9f9qjbCEf3qCCyY6W1Jrsu7WdhSyHeC', NULL, '2025-08-01 21:30:09', '2025-08-01 21:31:29', NULL, NULL, NULL, 3, NULL, 0, NULL, NULL),
(12, 'Denisse Ortega', 'dortega@planjuarez.org', NULL, '$2y$12$g6JYfqCYint8uqUV3HGd8.hy.a0EQB0uvKLv1.hS6hdxjbU3Pkfo6', NULL, '2025-08-12 15:59:43', '2025-08-12 16:01:11', 3, NULL, NULL, 3, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_progreso_proyectos`
-- (See below for the actual view)
--
CREATE TABLE `vista_progreso_proyectos` (
`Proyecto` varchar(500)
,`Proyecto_ID` bigint unsigned
,`Proyecto_Fecha_Inicio` date
,`Proyecto_Fecha_Final` date
,`Proyecto_cantidad_financiada` double
,`Financiadora_id` bigint unsigned
,`Encargado_seguimiento` text
,`Proyecto_base` text
,`Actividad` varchar(255)
,`Actividad_id` bigint unsigned
,`Actividad_descripcion` text
,`year_actividad` int
,`mes_actividad` int
,`Poblacion_meta` decimal(10,2)
,`Poblacion_alcanzada` decimal(10,2)
,`Productos_meta` decimal(10,2)
,`Productos_realizados` decimal(10,2)
,`population_progress_percent` decimal(16,2)
,`product_progress_percent` decimal(16,2)
,`Evento_id` bigint unsigned
,`Evento_fecha_inicio` date
,`Evento_fecha_fin` date
,`Evento_estado` varchar(13)
,`Beneficiarios_evento` bigint
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `action_lines`
--
ALTER TABLE `action_lines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_activities_created_by` (`created_by`),
  ADD KEY `fk_activities_goals` (`goals_id`),
  ADD KEY `fk_activities_specific_objectives` (`specific_objective_id`);

--
-- Indexes for table `activity_calendars`
--
ALTER TABLE `activity_calendars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_activity_calendars_activities` (`activity_id`),
  ADD KEY `fk_activity_calendars_assigned_person` (`assigned_person`),
  ADD KEY `fk_activity_calendars_locations` (`location_id`);

--
-- Indexes for table `activity_files`
--
ALTER TABLE `activity_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_files_activity_calendar_id_foreign` (`activity_calendar_id`);

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_activity_logs_calendar` (`activity_calendar_id`),
  ADD KEY `fk_activity_logs_beneficiary` (`beneficiary_registry_id`),
  ADD KEY `fk_activity_logs_activity` (`activity_id`);

--
-- Indexes for table `axes`
--
ALTER TABLE `axes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `beneficiaries_identifier_unique` (`identifier`),
  ADD KEY `fk_beneficiaries_created_by` (`created_by`);

--
-- Indexes for table `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_beneficiary_registries_activity_calendar` (`activity_calendar_id`),
  ADD KEY `fk_beneficiary_registries_beneficiaries` (`beneficiaries_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `components`
--
ALTER TABLE `components`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_publications`
--
ALTER TABLE `data_publications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_publications_date` (`publication_date`),
  ADD KEY `fk_data_publications_published_by` (`published_by`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `financiers`
--
ALTER TABLE `financiers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `goals`
--
ALTER TABLE `goals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `goals_project_id_foreign` (`project_id`),
  ADD KEY `fk_goals_organizations` (`organizations_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kpis`
--
ALTER TABLE `kpis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `locations_name_unique` (`name`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `planned_metrics`
--
ALTER TABLE `planned_metrics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_planned_metrics_activities` (`activity_id`);

--
-- Indexes for table `polygons`
--
ALTER TABLE `polygons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `polygons_name_unique` (`name`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `program_indicators`
--
ALTER TABLE `program_indicators`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_projects_created_by` (`created_by`),
  ADD KEY `fk_projects_financiers` (`financiers_id`),
  ADD KEY `fk_projects_co_financiers` (`co_financier_id`);

--
-- Indexes for table `project_disbursements`
--
ALTER TABLE `project_disbursements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_reports`
--
ALTER TABLE `project_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `published_activities`
--
ALTER TABLE `published_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_activities_specific_objective_id_foreign` (`specific_objective_id`),
  ADD KEY `published_activities_goals_id_foreign` (`goals_id`),
  ADD KEY `published_activities_created_by_foreign` (`created_by`),
  ADD KEY `idx_published_activities_original` (`original_activity_id`),
  ADD KEY `idx_published_activities_project` (`publication_id`,`project_id`);

--
-- Indexes for table `published_metrics`
--
ALTER TABLE `published_metrics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_published_metrics_activity` (`activity_id`),
  ADD KEY `idx_published_metrics_period` (`year`,`month`),
  ADD KEY `idx_published_metrics_original` (`original_metric_id`),
  ADD KEY `fk_published_metrics_publication` (`publication_id`);

--
-- Indexes for table `published_projects`
--
ALTER TABLE `published_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_projects_co_financier_id_foreign` (`co_financier_id`),
  ADD KEY `published_projects_created_by_foreign` (`created_by`),
  ADD KEY `idx_published_projects_original` (`original_project_id`),
  ADD KEY `idx_published_projects_financier` (`financiers_id`),
  ADD KEY `fk_published_projects_publication` (`publication_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `specific_objectives`
--
ALTER TABLE `specific_objectives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_specific_objectives_projects` (`projects_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `fk_users_organizations` (`organizations_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `action_lines`
--
ALTER TABLE `action_lines`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `activity_calendars`
--
ALTER TABLE `activity_calendars`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `activity_files`
--
ALTER TABLE `activity_files`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `axes`
--
ALTER TABLE `axes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;

--
-- AUTO_INCREMENT for table `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=307;

--
-- AUTO_INCREMENT for table `components`
--
ALTER TABLE `components`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `data_publications`
--
ALTER TABLE `data_publications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `financiers`
--
ALTER TABLE `financiers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `goals`
--
ALTER TABLE `goals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kpis`
--
ALTER TABLE `kpis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=341;

--
-- AUTO_INCREMENT for table `planned_metrics`
--
ALTER TABLE `planned_metrics`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `polygons`
--
ALTER TABLE `polygons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `program_indicators`
--
ALTER TABLE `program_indicators`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project_disbursements`
--
ALTER TABLE `project_disbursements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project_reports`
--
ALTER TABLE `project_reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `published_activities`
--
ALTER TABLE `published_activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `published_metrics`
--
ALTER TABLE `published_metrics`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `published_projects`
--
ALTER TABLE `published_projects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `specific_objectives`
--
ALTER TABLE `specific_objectives`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

-- --------------------------------------------------------

--
-- Structure for view `padron_beneficiarios`
--
DROP TABLE IF EXISTS `padron_beneficiarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `padron_beneficiarios`  AS SELECT DISTINCT `b`.`first_names` AS `Nombres`, `b`.`last_name` AS `Apellido_paterno`, `b`.`mother_last_name` AS `Apellido_materno`, `b`.`birth_year` AS `nacimiento`, `b`.`gender` AS `genero`, `b`.`phone` AS `telefono`, `b`.`street` AS `calle`, `b`.`neighborhood` AS `colonia`, `a`.`name` AS `nombre_actividad`, `p`.`name` AS `nombre_proyecto`, `ac`.`start_date` AS `Evento_Fecha_Inicio`, `f`.`id` AS `financiadora` FROM ((((((`beneficiaries` `b` left join `beneficiary_registries` `br` on((`br`.`beneficiaries_id` = `b`.`id`))) left join `activity_calendars` `ac` on((`ac`.`id` = `br`.`activity_calendar_id`))) left join `activities` `a` on((`ac`.`activity_id` = `a`.`id`))) left join `specific_objectives` `so` on((`a`.`specific_objective_id` = `so`.`id`))) left join `projects` `p` on((`so`.`projects_id` = `p`.`id`))) left join `financiers` `f` on((`p`.`financiers_id` = `f`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_progreso_proyectos`
--
DROP TABLE IF EXISTS `vista_progreso_proyectos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_progreso_proyectos`  AS SELECT `p`.`name` AS `Proyecto`, `p`.`id` AS `Proyecto_ID`, `p`.`start_date` AS `Proyecto_Fecha_Inicio`, `p`.`end_date` AS `Proyecto_Fecha_Final`, `p`.`funded_amount` AS `Proyecto_cantidad_financiada`, `p`.`financiers_id` AS `Financiadora_id`, `p`.`followup_officer` AS `Encargado_seguimiento`, `p`.`project_base_file` AS `Proyecto_base`, `a`.`name` AS `Actividad`, `a`.`id` AS `Actividad_id`, `a`.`description` AS `Actividad_descripcion`, `pm`.`year` AS `year_actividad`, `pm`.`month` AS `mes_actividad`, `pm`.`population_target_value` AS `Poblacion_meta`, `pm`.`population_real_value` AS `Poblacion_alcanzada`, `pm`.`product_target_value` AS `Productos_meta`, `pm`.`product_real_value` AS `Productos_realizados`, (case when (`pm`.`population_target_value` > 0) then round(((`pm`.`population_real_value` / `pm`.`population_target_value`) * 100),2) else NULL end) AS `population_progress_percent`, (case when (`pm`.`product_target_value` > 0) then round(((`pm`.`product_real_value` / `pm`.`product_target_value`) * 100),2) else NULL end) AS `product_progress_percent`, `ac`.`id` AS `Evento_id`, `ac`.`start_date` AS `Evento_fecha_inicio`, `ac`.`end_date` AS `Evento_fecha_fin`, (case when (`ac`.`end_date` <= curdate()) then 'Completado' when (`ac`.`end_date` > curdate()) then 'Calendarizado' else 'Sin fecha' end) AS `Evento_estado`, count(distinct `br`.`beneficiaries_id`) AS `Beneficiarios_evento` FROM ((((((`projects` `p` left join `specific_objectives` `sp` on((`p`.`id` = `sp`.`projects_id`))) left join `activities` `a` on((`a`.`specific_objective_id` = `sp`.`id`))) left join `planned_metrics` `pm` on((`pm`.`activity_id` = `a`.`id`))) left join `activity_calendars` `ac` on((`ac`.`activity_id` = `a`.`id`))) left join `beneficiary_registries` `br` on((`br`.`activity_calendar_id` = `ac`.`id`))) left join `beneficiaries` `b` on((`b`.`id` = `br`.`beneficiaries_id`))) GROUP BY `p`.`id`, `p`.`name`, `p`.`start_date`, `p`.`end_date`, `p`.`funded_amount`, `p`.`financiers_id`, `p`.`followup_officer`, `p`.`project_base_file`, `a`.`id`, `a`.`name`, `a`.`description`, `pm`.`year`, `pm`.`month`, `pm`.`population_target_value`, `pm`.`population_real_value`, `pm`.`product_target_value`, `pm`.`product_real_value`, `ac`.`id`, `ac`.`start_date`, `ac`.`end_date` ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `fk_activities_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_activities_goals` FOREIGN KEY (`goals_id`) REFERENCES `goals` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_activities_specific_objectives` FOREIGN KEY (`specific_objective_id`) REFERENCES `specific_objectives` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `activity_calendars`
--
ALTER TABLE `activity_calendars`
  ADD CONSTRAINT `activity_calendars_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_activity_calendars_activities` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_activity_calendars_assigned_person` FOREIGN KEY (`assigned_person`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_activity_calendars_locations` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `activity_files`
--
ALTER TABLE `activity_files`
  ADD CONSTRAINT `activity_files_activity_calendar_id_foreign` FOREIGN KEY (`activity_calendar_id`) REFERENCES `activity_calendars` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `fk_activity_logs_activity` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_activity_logs_beneficiary` FOREIGN KEY (`beneficiary_registry_id`) REFERENCES `beneficiary_registries` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_activity_logs_calendar` FOREIGN KEY (`activity_calendar_id`) REFERENCES `activity_calendars` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  ADD CONSTRAINT `fk_beneficiaries_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  ADD CONSTRAINT `fk_beneficiary_registries_activity_calendar` FOREIGN KEY (`activity_calendar_id`) REFERENCES `activity_calendars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_beneficiary_registries_beneficiaries` FOREIGN KEY (`beneficiaries_id`) REFERENCES `beneficiaries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_publications`
--
ALTER TABLE `data_publications`
  ADD CONSTRAINT `data_publications_published_by_foreign` FOREIGN KEY (`published_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_data_publications_published_by` FOREIGN KEY (`published_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `goals`
--
ALTER TABLE `goals`
  ADD CONSTRAINT `fk_goals_organizations` FOREIGN KEY (`organizations_id`) REFERENCES `organizations` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `goals_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `planned_metrics`
--
ALTER TABLE `planned_metrics`
  ADD CONSTRAINT `fk_planned_metrics_activities` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `fk_projects_co_financiers` FOREIGN KEY (`co_financier_id`) REFERENCES `financiers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_projects_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_projects_financiers` FOREIGN KEY (`financiers_id`) REFERENCES `financiers` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `published_activities`
--
ALTER TABLE `published_activities`
  ADD CONSTRAINT `fk_published_activities_publication` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `published_activities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `published_activities_goals_id_foreign` FOREIGN KEY (`goals_id`) REFERENCES `goals` (`id`),
  ADD CONSTRAINT `published_activities_original_activity_id_foreign` FOREIGN KEY (`original_activity_id`) REFERENCES `activities` (`id`),
  ADD CONSTRAINT `published_activities_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `published_activities_specific_objective_id_foreign` FOREIGN KEY (`specific_objective_id`) REFERENCES `specific_objectives` (`id`);

--
-- Constraints for table `published_metrics`
--
ALTER TABLE `published_metrics`
  ADD CONSTRAINT `fk_published_metrics_publication` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `published_metrics_activity_id_foreign` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`),
  ADD CONSTRAINT `published_metrics_original_metric_id_foreign` FOREIGN KEY (`original_metric_id`) REFERENCES `planned_metrics` (`id`),
  ADD CONSTRAINT `published_metrics_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `published_projects`
--
ALTER TABLE `published_projects`
  ADD CONSTRAINT `fk_published_projects_publication` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `published_projects_co_financier_id_foreign` FOREIGN KEY (`co_financier_id`) REFERENCES `financiers` (`id`),
  ADD CONSTRAINT `published_projects_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `published_projects_financiers_id_foreign` FOREIGN KEY (`financiers_id`) REFERENCES `financiers` (`id`),
  ADD CONSTRAINT `published_projects_original_project_id_foreign` FOREIGN KEY (`original_project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `published_projects_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `specific_objectives`
--
ALTER TABLE `specific_objectives`
  ADD CONSTRAINT `fk_specific_objectives_projects` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_organizations` FOREIGN KEY (`organizations_id`) REFERENCES `organizations` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

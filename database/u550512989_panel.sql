-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 27-07-2025 a las 16:46:50
-- Versión del servidor: 10.11.10-MariaDB-log
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u550512989_panel`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `action_lines`
--

CREATE TABLE `action_lines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) NOT NULL,
  `program_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `action_lines`
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
-- Estructura de tabla para la tabla `activities`
--

CREATE TABLE `activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `specific_objective_id` bigint(20) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `goals_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `activities`
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
(69, 'Huertos urbanos en Riberas del Bravo', 9, 'Participación en huertos urbanos en Riberas del Bravo', 69, 3, '2025-07-25 18:39:40', '2025-07-25 18:39:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activity_calendars`
--

CREATE TABLE `activity_calendars` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `activity_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_hour` time DEFAULT NULL,
  `end_hour` time DEFAULT NULL,
  `address_backup` text DEFAULT NULL,
  `last_modified` timestamp NULL DEFAULT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `change_reason` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `assigned_person` bigint(20) UNSIGNED NOT NULL,
  `location_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `activity_calendars`
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
(28, 62, '2025-06-03', '2025-06-03', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 16:40:09', '2025-07-25 22:38:12'),
(29, 57, '2025-06-10', '2025-06-10', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 16:41:48', '2025-07-25 22:38:41'),
(30, 64, '2025-08-26', '2025-08-28', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 16:42:08', '2025-07-25 22:39:38'),
(31, 57, '2025-06-24', '2025-06-24', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 4, '2025-07-25 16:45:34', '2025-07-25 22:44:34'),
(32, 51, '2025-06-07', '2025-06-07', '09:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 16:48:38', '2025-07-25 22:57:12'),
(33, 64, '2025-08-27', '2025-08-27', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 17:13:46', '2025-07-25 22:38:53'),
(34, 64, '2025-08-20', '2025-08-20', '19:30:00', '20:30:00', NULL, NULL, 0, NULL, 3, 5, 4, '2025-07-25 17:16:21', '2025-07-25 22:42:08'),
(35, 51, '2025-06-14', '2025-06-14', '09:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 5, 3, '2025-07-25 17:27:29', '2025-07-25 22:42:11'),
(36, 64, '2025-08-18', '2025-08-18', '18:30:00', '19:30:00', NULL, NULL, 0, NULL, 3, 5, 7, '2025-07-25 17:27:29', '2025-07-25 22:43:50'),
(37, 51, '2025-06-21', '2025-06-21', '09:00:00', '11:00:00', NULL, NULL, 0, NULL, 4, 5, 1, '2025-07-25 17:28:59', '2025-07-25 22:44:04'),
(38, 56, '2025-06-05', '2025-06-05', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:31:12', '2025-07-25 22:56:06'),
(39, 56, '2025-06-12', '2025-06-12', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:32:31', '2025-07-25 22:56:45'),
(40, 56, '2025-06-19', '2025-06-19', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:33:27', '2025-07-25 22:43:16'),
(41, 56, '2025-06-26', '2025-06-26', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:34:46', '2025-07-25 22:44:54'),
(42, 56, '2025-06-06', '2025-06-06', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:35:46', '2025-07-25 22:56:25'),
(43, 56, '2025-06-13', '2025-06-13', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:37:44', '2025-07-25 22:41:36'),
(44, 56, '2025-06-20', '2025-06-20', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:38:36', '2025-07-25 22:43:37'),
(45, 56, '2025-06-27', '2025-06-27', '15:00:00', '17:00:00', NULL, NULL, 0, NULL, 4, 5, 5, '2025-07-25 17:39:32', '2025-07-25 22:45:10'),
(46, 64, '2025-08-19', '2025-08-19', '19:30:00', '20:00:00', NULL, NULL, 0, NULL, 3, 5, 1, '2025-07-25 17:39:45', '2025-07-25 22:43:02'),
(47, 56, '2025-06-09', '2025-06-09', '17:00:00', '19:00:00', NULL, NULL, 0, NULL, 4, 5, 7, '2025-07-25 17:42:31', '2025-07-25 22:57:26'),
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
(61, 51, '2025-07-08', '2025-07-08', '18:00:00', '20:00:00', NULL, NULL, 0, NULL, 4, 5, 2, '2025-07-25 18:00:30', '2025-07-25 22:47:45'),
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
(79, 49, '2025-08-06', '2025-08-06', '18:00:00', '19:00:00', NULL, NULL, 0, NULL, 3, 5, 2, '2025-07-25 18:23:49', '2025-07-25 22:51:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activity_files`
--

CREATE TABLE `activity_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(20) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `file_path` text DEFAULT NULL,
  `upload_date` timestamp NULL DEFAULT NULL,
  `activity_calendar_id` bigint(20) UNSIGNED DEFAULT NULL,
  `activity_log_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `planned_metrics_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `axes`
--

CREATE TABLE `axes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `axes`
--

INSERT INTO `axes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Formación y fortalecimiento de agentes', '2025-07-18 17:40:28', '2025-07-18 17:40:28'),
(2, 'Desarrollo del sector social', '2025-07-18 17:40:36', '2025-07-18 17:40:36'),
(3, 'Participación ciudadana', '2025-07-18 17:40:50', '2025-07-18 17:40:50'),
(4, 'Generación y divulgación de conocimiento', '2025-07-18 17:41:03', '2025-07-18 17:41:03'),
(5, 'Fortalecimiento institucional, sostenibilidad e innovación', '2025-07-18 17:41:09', '2025-07-18 17:41:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beneficiaries`
--

CREATE TABLE `beneficiaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `mother_last_name` varchar(100) DEFAULT NULL,
  `first_names` varchar(100) DEFAULT NULL,
  `birth_year` varchar(4) DEFAULT NULL,
  `gender` enum('M','F','Male','Female') DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address_backup` text DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beneficiary_registries`
--

CREATE TABLE `beneficiary_registries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `activity_calendar_id` bigint(20) UNSIGNED NOT NULL,
  `beneficiaries_id` bigint(20) UNSIGNED NOT NULL,
  `data_collectors_id` bigint(20) UNSIGNED NOT NULL,
  `signature` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('comunidades-v5-cache-livewire-rate-limiter:70ad878e7e6659901e3a630cae45dfda8686b50d', 'i:1;', 1753208980),
('comunidades-v5-cache-livewire-rate-limiter:70ad878e7e6659901e3a630cae45dfda8686b50d:timer', 'i:1753208980;', 1753208980),
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3', 'i:1;', 1753114381),
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer', 'i:1753114380;', 1753114381),
('comunidades-v5-cache-livewire-rate-limiter:efce1fb966eb6f174ab5329ea292d8eac8303759', 'i:1;', 1753125811),
('comunidades-v5-cache-livewire-rate-limiter:efce1fb966eb6f174ab5329ea292d8eac8303759:timer', 'i:1753125811;', 1753125811),
('comunidades-v5-cache-livewire-rate-limiter:f29930f7c05f188cc05566a6af979b3f15a1d343', 'i:2;', 1752888237),
('comunidades-v5-cache-livewire-rate-limiter:f29930f7c05f188cc05566a6af979b3f15a1d343:timer', 'i:1752888237;', 1752888237),
('comunidades-v5-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:285:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:17:\"view_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:21:\"view_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:19:\"create_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:19:\"update_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:20:\"restore_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:24:\"restore_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:22:\"replicate_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:20:\"reorder_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:19:\"delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:23:\"delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:25:\"force_delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:29:\"force_delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:13:\"view_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:17:\"view_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:15:\"create_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:15:\"update_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:16:\"restore_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:20:\"restore_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:18:\"replicate_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:16:\"reorder_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:15:\"delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:19:\"delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:21:\"force_delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:25:\"force_delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:23:\"view_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:27:\"view_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:25:\"create_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:25:\"update_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:26:\"restore_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:30:\"restore_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:28:\"replicate_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:26:\"reorder_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:25:\"delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:29:\"delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:31:\"force_delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:35:\"force_delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:19:\"view_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:23:\"view_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:21:\"create_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:21:\"update_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:22:\"restore_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:26:\"restore_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:24:\"replicate_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:22:\"reorder_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:21:\"delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:25:\"delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:27:\"force_delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:31:\"force_delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:18:\"view_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:22:\"view_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:20:\"create_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:20:\"update_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:21:\"restore_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:25:\"restore_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:23:\"replicate_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:21:\"reorder_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:20:\"delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:24:\"delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:26:\"force_delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:30:\"force_delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:8:\"view_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:12:\"view_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:10:\"create_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:10:\"update_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:11:\"restore_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:15:\"restore_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:13:\"replicate_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:11:\"reorder_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:10:\"delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:14:\"delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:16:\"force_delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:20:\"force_delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:16:\"view_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:73;a:4:{s:1:\"a\";i:74;s:1:\"b\";s:20:\"view_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:74;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:18:\"create_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:75;a:4:{s:1:\"a\";i:76;s:1:\"b\";s:18:\"update_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:76;a:4:{s:1:\"a\";i:77;s:1:\"b\";s:19:\"restore_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:4:{s:1:\"a\";i:78;s:1:\"b\";s:23:\"restore_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:4:{s:1:\"a\";i:79;s:1:\"b\";s:21:\"replicate_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:4:{s:1:\"a\";i:80;s:1:\"b\";s:19:\"reorder_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:4:{s:1:\"a\";i:81;s:1:\"b\";s:18:\"delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:4:{s:1:\"a\";i:82;s:1:\"b\";s:22:\"delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:4:{s:1:\"a\";i:83;s:1:\"b\";s:24:\"force_delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:4:{s:1:\"a\";i:84;s:1:\"b\";s:28:\"force_delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:26:\"view_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:4:{s:1:\"a\";i:86;s:1:\"b\";s:30:\"view_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:4:{s:1:\"a\";i:87;s:1:\"b\";s:28:\"create_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:4:{s:1:\"a\";i:88;s:1:\"b\";s:28:\"update_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:4:{s:1:\"a\";i:89;s:1:\"b\";s:29:\"restore_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:33:\"restore_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:4:{s:1:\"a\";i:91;s:1:\"b\";s:31:\"replicate_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:4:{s:1:\"a\";i:92;s:1:\"b\";s:29:\"reorder_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:4:{s:1:\"a\";i:93;s:1:\"b\";s:28:\"delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:4:{s:1:\"a\";i:94;s:1:\"b\";s:32:\"delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:4:{s:1:\"a\";i:95;s:1:\"b\";s:34:\"force_delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:4:{s:1:\"a\";i:96;s:1:\"b\";s:38:\"force_delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:4:{s:1:\"a\";i:97;s:1:\"b\";s:14:\"view_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:97;a:4:{s:1:\"a\";i:98;s:1:\"b\";s:18:\"view_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:98;a:4:{s:1:\"a\";i:99;s:1:\"b\";s:16:\"create_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:99;a:4:{s:1:\"a\";i:100;s:1:\"b\";s:16:\"update_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:100;a:4:{s:1:\"a\";i:101;s:1:\"b\";s:17:\"restore_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:101;a:4:{s:1:\"a\";i:102;s:1:\"b\";s:21:\"restore_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:102;a:4:{s:1:\"a\";i:103;s:1:\"b\";s:19:\"replicate_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:103;a:4:{s:1:\"a\";i:104;s:1:\"b\";s:17:\"reorder_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:104;a:4:{s:1:\"a\";i:105;s:1:\"b\";s:16:\"delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:105;a:4:{s:1:\"a\";i:106;s:1:\"b\";s:20:\"delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:106;a:4:{s:1:\"a\";i:107;s:1:\"b\";s:22:\"force_delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:107;a:4:{s:1:\"a\";i:108;s:1:\"b\";s:26:\"force_delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:108;a:4:{s:1:\"a\";i:109;s:1:\"b\";s:14:\"view_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:109;a:4:{s:1:\"a\";i:110;s:1:\"b\";s:18:\"view_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:110;a:4:{s:1:\"a\";i:111;s:1:\"b\";s:16:\"create_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:111;a:4:{s:1:\"a\";i:112;s:1:\"b\";s:16:\"update_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:112;a:4:{s:1:\"a\";i:113;s:1:\"b\";s:17:\"restore_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:113;a:4:{s:1:\"a\";i:114;s:1:\"b\";s:21:\"restore_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:114;a:4:{s:1:\"a\";i:115;s:1:\"b\";s:19:\"replicate_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:115;a:4:{s:1:\"a\";i:116;s:1:\"b\";s:17:\"reorder_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:116;a:4:{s:1:\"a\";i:117;s:1:\"b\";s:16:\"delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:117;a:4:{s:1:\"a\";i:118;s:1:\"b\";s:20:\"delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:118;a:4:{s:1:\"a\";i:119;s:1:\"b\";s:22:\"force_delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:119;a:4:{s:1:\"a\";i:120;s:1:\"b\";s:26:\"force_delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:120;a:4:{s:1:\"a\";i:121;s:1:\"b\";s:9:\"view_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:121;a:4:{s:1:\"a\";i:122;s:1:\"b\";s:13:\"view_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:122;a:4:{s:1:\"a\";i:123;s:1:\"b\";s:11:\"create_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:123;a:4:{s:1:\"a\";i:124;s:1:\"b\";s:11:\"update_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:124;a:4:{s:1:\"a\";i:125;s:1:\"b\";s:12:\"restore_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:125;a:4:{s:1:\"a\";i:126;s:1:\"b\";s:16:\"restore_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:126;a:4:{s:1:\"a\";i:127;s:1:\"b\";s:14:\"replicate_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:127;a:4:{s:1:\"a\";i:128;s:1:\"b\";s:12:\"reorder_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:128;a:4:{s:1:\"a\";i:129;s:1:\"b\";s:11:\"delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:129;a:4:{s:1:\"a\";i:130;s:1:\"b\";s:15:\"delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:130;a:4:{s:1:\"a\";i:131;s:1:\"b\";s:17:\"force_delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:131;a:4:{s:1:\"a\";i:132;s:1:\"b\";s:21:\"force_delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:132;a:4:{s:1:\"a\";i:133;s:1:\"b\";s:8:\"view_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:133;a:4:{s:1:\"a\";i:134;s:1:\"b\";s:12:\"view_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:134;a:4:{s:1:\"a\";i:135;s:1:\"b\";s:10:\"create_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:135;a:4:{s:1:\"a\";i:136;s:1:\"b\";s:10:\"update_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:136;a:4:{s:1:\"a\";i:137;s:1:\"b\";s:11:\"restore_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:137;a:4:{s:1:\"a\";i:138;s:1:\"b\";s:15:\"restore_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:138;a:4:{s:1:\"a\";i:139;s:1:\"b\";s:13:\"replicate_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:139;a:4:{s:1:\"a\";i:140;s:1:\"b\";s:11:\"reorder_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:140;a:4:{s:1:\"a\";i:141;s:1:\"b\";s:10:\"delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:141;a:4:{s:1:\"a\";i:142;s:1:\"b\";s:14:\"delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:142;a:4:{s:1:\"a\";i:143;s:1:\"b\";s:16:\"force_delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:143;a:4:{s:1:\"a\";i:144;s:1:\"b\";s:20:\"force_delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:144;a:4:{s:1:\"a\";i:145;s:1:\"b\";s:13:\"view_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:145;a:4:{s:1:\"a\";i:146;s:1:\"b\";s:17:\"view_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:146;a:4:{s:1:\"a\";i:147;s:1:\"b\";s:15:\"create_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:147;a:4:{s:1:\"a\";i:148;s:1:\"b\";s:15:\"update_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:148;a:4:{s:1:\"a\";i:149;s:1:\"b\";s:16:\"restore_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:149;a:4:{s:1:\"a\";i:150;s:1:\"b\";s:20:\"restore_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:150;a:4:{s:1:\"a\";i:151;s:1:\"b\";s:18:\"replicate_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:151;a:4:{s:1:\"a\";i:152;s:1:\"b\";s:16:\"reorder_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:152;a:4:{s:1:\"a\";i:153;s:1:\"b\";s:15:\"delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:153;a:4:{s:1:\"a\";i:154;s:1:\"b\";s:19:\"delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:154;a:4:{s:1:\"a\";i:155;s:1:\"b\";s:21:\"force_delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:155;a:4:{s:1:\"a\";i:156;s:1:\"b\";s:25:\"force_delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:156;a:4:{s:1:\"a\";i:157;s:1:\"b\";s:17:\"view_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:157;a:4:{s:1:\"a\";i:158;s:1:\"b\";s:21:\"view_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:158;a:4:{s:1:\"a\";i:159;s:1:\"b\";s:19:\"create_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:159;a:4:{s:1:\"a\";i:160;s:1:\"b\";s:19:\"update_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:160;a:4:{s:1:\"a\";i:161;s:1:\"b\";s:20:\"restore_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:161;a:4:{s:1:\"a\";i:162;s:1:\"b\";s:24:\"restore_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:162;a:4:{s:1:\"a\";i:163;s:1:\"b\";s:22:\"replicate_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:163;a:4:{s:1:\"a\";i:164;s:1:\"b\";s:20:\"reorder_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:164;a:4:{s:1:\"a\";i:165;s:1:\"b\";s:19:\"delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:165;a:4:{s:1:\"a\";i:166;s:1:\"b\";s:23:\"delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:166;a:4:{s:1:\"a\";i:167;s:1:\"b\";s:25:\"force_delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:167;a:4:{s:1:\"a\";i:168;s:1:\"b\";s:29:\"force_delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:168;a:4:{s:1:\"a\";i:169;s:1:\"b\";s:20:\"view_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:169;a:4:{s:1:\"a\";i:170;s:1:\"b\";s:24:\"view_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:170;a:4:{s:1:\"a\";i:171;s:1:\"b\";s:22:\"create_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:171;a:4:{s:1:\"a\";i:172;s:1:\"b\";s:22:\"update_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:172;a:4:{s:1:\"a\";i:173;s:1:\"b\";s:23:\"restore_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:173;a:4:{s:1:\"a\";i:174;s:1:\"b\";s:27:\"restore_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:174;a:4:{s:1:\"a\";i:175;s:1:\"b\";s:25:\"replicate_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:175;a:4:{s:1:\"a\";i:176;s:1:\"b\";s:23:\"reorder_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:176;a:4:{s:1:\"a\";i:177;s:1:\"b\";s:22:\"delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:177;a:4:{s:1:\"a\";i:178;s:1:\"b\";s:26:\"delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:178;a:4:{s:1:\"a\";i:179;s:1:\"b\";s:28:\"force_delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:179;a:4:{s:1:\"a\";i:180;s:1:\"b\";s:32:\"force_delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:180;a:4:{s:1:\"a\";i:181;s:1:\"b\";s:12:\"view_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:181;a:4:{s:1:\"a\";i:182;s:1:\"b\";s:16:\"view_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:182;a:4:{s:1:\"a\";i:183;s:1:\"b\";s:14:\"create_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:183;a:4:{s:1:\"a\";i:184;s:1:\"b\";s:14:\"update_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:184;a:4:{s:1:\"a\";i:185;s:1:\"b\";s:15:\"restore_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:185;a:4:{s:1:\"a\";i:186;s:1:\"b\";s:19:\"restore_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:186;a:4:{s:1:\"a\";i:187;s:1:\"b\";s:17:\"replicate_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:187;a:4:{s:1:\"a\";i:188;s:1:\"b\";s:15:\"reorder_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:188;a:4:{s:1:\"a\";i:189;s:1:\"b\";s:14:\"delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:189;a:4:{s:1:\"a\";i:190;s:1:\"b\";s:18:\"delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:190;a:4:{s:1:\"a\";i:191;s:1:\"b\";s:20:\"force_delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:191;a:4:{s:1:\"a\";i:192;s:1:\"b\";s:24:\"force_delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:192;a:4:{s:1:\"a\";i:193;s:1:\"b\";s:12:\"view_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:193;a:4:{s:1:\"a\";i:194;s:1:\"b\";s:16:\"view_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:194;a:4:{s:1:\"a\";i:195;s:1:\"b\";s:14:\"create_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:195;a:4:{s:1:\"a\";i:196;s:1:\"b\";s:14:\"update_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:196;a:4:{s:1:\"a\";i:197;s:1:\"b\";s:15:\"restore_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:197;a:4:{s:1:\"a\";i:198;s:1:\"b\";s:19:\"restore_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:198;a:4:{s:1:\"a\";i:199;s:1:\"b\";s:17:\"replicate_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:199;a:4:{s:1:\"a\";i:200;s:1:\"b\";s:15:\"reorder_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:200;a:4:{s:1:\"a\";i:201;s:1:\"b\";s:14:\"delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:201;a:4:{s:1:\"a\";i:202;s:1:\"b\";s:18:\"delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:202;a:4:{s:1:\"a\";i:203;s:1:\"b\";s:20:\"force_delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:203;a:4:{s:1:\"a\";i:204;s:1:\"b\";s:24:\"force_delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:204;a:4:{s:1:\"a\";i:205;s:1:\"b\";s:23:\"view_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:205;a:4:{s:1:\"a\";i:206;s:1:\"b\";s:27:\"view_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:206;a:4:{s:1:\"a\";i:207;s:1:\"b\";s:25:\"create_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:207;a:4:{s:1:\"a\";i:208;s:1:\"b\";s:25:\"update_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:208;a:4:{s:1:\"a\";i:209;s:1:\"b\";s:26:\"restore_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:209;a:4:{s:1:\"a\";i:210;s:1:\"b\";s:30:\"restore_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:210;a:4:{s:1:\"a\";i:211;s:1:\"b\";s:28:\"replicate_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:211;a:4:{s:1:\"a\";i:212;s:1:\"b\";s:26:\"reorder_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:212;a:4:{s:1:\"a\";i:213;s:1:\"b\";s:25:\"delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:213;a:4:{s:1:\"a\";i:214;s:1:\"b\";s:29:\"delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:214;a:4:{s:1:\"a\";i:215;s:1:\"b\";s:31:\"force_delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:215;a:4:{s:1:\"a\";i:216;s:1:\"b\";s:35:\"force_delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:216;a:4:{s:1:\"a\";i:217;s:1:\"b\";s:12:\"view_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:217;a:4:{s:1:\"a\";i:218;s:1:\"b\";s:16:\"view_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:218;a:4:{s:1:\"a\";i:219;s:1:\"b\";s:14:\"create_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:219;a:4:{s:1:\"a\";i:220;s:1:\"b\";s:14:\"update_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:220;a:4:{s:1:\"a\";i:221;s:1:\"b\";s:15:\"restore_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:221;a:4:{s:1:\"a\";i:222;s:1:\"b\";s:19:\"restore_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:222;a:4:{s:1:\"a\";i:223;s:1:\"b\";s:17:\"replicate_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:223;a:4:{s:1:\"a\";i:224;s:1:\"b\";s:15:\"reorder_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:224;a:4:{s:1:\"a\";i:225;s:1:\"b\";s:14:\"delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:225;a:4:{s:1:\"a\";i:226;s:1:\"b\";s:18:\"delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:226;a:4:{s:1:\"a\";i:227;s:1:\"b\";s:20:\"force_delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:227;a:4:{s:1:\"a\";i:228;s:1:\"b\";s:24:\"force_delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:228;a:4:{s:1:\"a\";i:229;s:1:\"b\";s:26:\"view_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:229;a:4:{s:1:\"a\";i:230;s:1:\"b\";s:30:\"view_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:230;a:4:{s:1:\"a\";i:231;s:1:\"b\";s:28:\"create_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:231;a:4:{s:1:\"a\";i:232;s:1:\"b\";s:28:\"update_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:232;a:4:{s:1:\"a\";i:233;s:1:\"b\";s:29:\"restore_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:233;a:4:{s:1:\"a\";i:234;s:1:\"b\";s:33:\"restore_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:234;a:4:{s:1:\"a\";i:235;s:1:\"b\";s:31:\"replicate_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:235;a:4:{s:1:\"a\";i:236;s:1:\"b\";s:29:\"reorder_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:236;a:4:{s:1:\"a\";i:237;s:1:\"b\";s:28:\"delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:237;a:4:{s:1:\"a\";i:238;s:1:\"b\";s:32:\"delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:238;a:4:{s:1:\"a\";i:239;s:1:\"b\";s:34:\"force_delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:239;a:4:{s:1:\"a\";i:240;s:1:\"b\";s:38:\"force_delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:240;a:4:{s:1:\"a\";i:241;s:1:\"b\";s:20:\"view_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:241;a:4:{s:1:\"a\";i:242;s:1:\"b\";s:24:\"view_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:242;a:4:{s:1:\"a\";i:243;s:1:\"b\";s:22:\"create_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:243;a:4:{s:1:\"a\";i:244;s:1:\"b\";s:22:\"update_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:244;a:4:{s:1:\"a\";i:245;s:1:\"b\";s:23:\"restore_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:245;a:4:{s:1:\"a\";i:246;s:1:\"b\";s:27:\"restore_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:246;a:4:{s:1:\"a\";i:247;s:1:\"b\";s:25:\"replicate_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:247;a:4:{s:1:\"a\";i:248;s:1:\"b\";s:23:\"reorder_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:248;a:4:{s:1:\"a\";i:249;s:1:\"b\";s:22:\"delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:249;a:4:{s:1:\"a\";i:250;s:1:\"b\";s:26:\"delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:250;a:4:{s:1:\"a\";i:251;s:1:\"b\";s:28:\"force_delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:251;a:4:{s:1:\"a\";i:252;s:1:\"b\";s:32:\"force_delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:252;a:4:{s:1:\"a\";i:253;s:1:\"b\";s:9:\"view_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:253;a:4:{s:1:\"a\";i:254;s:1:\"b\";s:13:\"view_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:254;a:4:{s:1:\"a\";i:255;s:1:\"b\";s:11:\"create_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:255;a:4:{s:1:\"a\";i:256;s:1:\"b\";s:11:\"update_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:256;a:4:{s:1:\"a\";i:257;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:257;a:4:{s:1:\"a\";i:258;s:1:\"b\";s:15:\"delete_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:258;a:4:{s:1:\"a\";i:259;s:1:\"b\";s:24:\"view_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:259;a:4:{s:1:\"a\";i:260;s:1:\"b\";s:28:\"view_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:260;a:4:{s:1:\"a\";i:261;s:1:\"b\";s:26:\"create_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:261;a:4:{s:1:\"a\";i:262;s:1:\"b\";s:26:\"update_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:262;a:4:{s:1:\"a\";i:263;s:1:\"b\";s:27:\"restore_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:263;a:4:{s:1:\"a\";i:264;s:1:\"b\";s:31:\"restore_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:264;a:4:{s:1:\"a\";i:265;s:1:\"b\";s:29:\"replicate_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:265;a:4:{s:1:\"a\";i:266;s:1:\"b\";s:27:\"reorder_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:266;a:4:{s:1:\"a\";i:267;s:1:\"b\";s:26:\"delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:267;a:4:{s:1:\"a\";i:268;s:1:\"b\";s:30:\"delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:268;a:4:{s:1:\"a\";i:269;s:1:\"b\";s:32:\"force_delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:269;a:4:{s:1:\"a\";i:270;s:1:\"b\";s:36:\"force_delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:270;a:4:{s:1:\"a\";i:271;s:1:\"b\";s:9:\"view_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:271;a:4:{s:1:\"a\";i:272;s:1:\"b\";s:13:\"view_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:272;a:4:{s:1:\"a\";i:273;s:1:\"b\";s:11:\"create_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:273;a:4:{s:1:\"a\";i:274;s:1:\"b\";s:11:\"update_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:274;a:4:{s:1:\"a\";i:275;s:1:\"b\";s:12:\"restore_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:275;a:4:{s:1:\"a\";i:276;s:1:\"b\";s:16:\"restore_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:276;a:4:{s:1:\"a\";i:277;s:1:\"b\";s:14:\"replicate_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:277;a:4:{s:1:\"a\";i:278;s:1:\"b\";s:12:\"reorder_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:278;a:4:{s:1:\"a\";i:279;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:279;a:4:{s:1:\"a\";i:280;s:1:\"b\";s:15:\"delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:280;a:4:{s:1:\"a\";i:281;s:1:\"b\";s:17:\"force_delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:281;a:4:{s:1:\"a\";i:282;s:1:\"b\";s:21:\"force_delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:282;a:4:{s:1:\"a\";i:283;s:1:\"b\";s:24:\"page_ActivityFileManager\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:283;a:4:{s:1:\"a\";i:284;s:1:\"b\";s:28:\"page_BeneficiaryRegistryView\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:284;a:4:{s:1:\"a\";i:285;s:1:\"b\";s:25:\"page_ProjectCreationGuide\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:1:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}}}', 1753295104),
('planeacion-estrategica-cache-livewire-rate-limiter:589105e1347c8137879db3df0a0938335d025ef1', 'i:1;', 1753240008),
('planeacion-estrategica-cache-livewire-rate-limiter:589105e1347c8137879db3df0a0938335d025ef1:timer', 'i:1753240008;', 1753240008),
('planeacion-estrategica-cache-livewire-rate-limiter:70ad878e7e6659901e3a630cae45dfda8686b50d', 'i:1;', 1753483047),
('planeacion-estrategica-cache-livewire-rate-limiter:70ad878e7e6659901e3a630cae45dfda8686b50d:timer', 'i:1753483047;', 1753483047);
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('planeacion-estrategica-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:288:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:17:\"view_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:21:\"view_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:19:\"create_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:19:\"update_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:20:\"restore_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:24:\"restore_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:22:\"replicate_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:20:\"reorder_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:19:\"delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:23:\"delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:25:\"force_delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:29:\"force_delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:13:\"view_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:17:\"view_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:15:\"create_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:15:\"update_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:16:\"restore_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:20:\"restore_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:18:\"replicate_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:16:\"reorder_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:15:\"delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:19:\"delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:21:\"force_delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:25:\"force_delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:23:\"view_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:27:\"view_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:25:\"create_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:25:\"update_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:26:\"restore_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:30:\"restore_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:28:\"replicate_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:26:\"reorder_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:25:\"delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:29:\"delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:31:\"force_delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:35:\"force_delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:19:\"view_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:23:\"view_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:21:\"create_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:21:\"update_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:22:\"restore_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:26:\"restore_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:24:\"replicate_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:22:\"reorder_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:21:\"delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:25:\"delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:27:\"force_delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:31:\"force_delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:18:\"view_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:22:\"view_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:20:\"create_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:20:\"update_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:21:\"restore_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:25:\"restore_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:23:\"replicate_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:21:\"reorder_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:20:\"delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:24:\"delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:26:\"force_delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:30:\"force_delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:8:\"view_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:12:\"view_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:10:\"create_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:10:\"update_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:11:\"restore_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:15:\"restore_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:13:\"replicate_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:11:\"reorder_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:10:\"delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:14:\"delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:16:\"force_delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:20:\"force_delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:16:\"view_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:73;a:4:{s:1:\"a\";i:74;s:1:\"b\";s:20:\"view_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:74;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:18:\"create_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:75;a:4:{s:1:\"a\";i:76;s:1:\"b\";s:18:\"update_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:76;a:4:{s:1:\"a\";i:77;s:1:\"b\";s:19:\"restore_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:4:{s:1:\"a\";i:78;s:1:\"b\";s:23:\"restore_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:4:{s:1:\"a\";i:79;s:1:\"b\";s:21:\"replicate_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:4:{s:1:\"a\";i:80;s:1:\"b\";s:19:\"reorder_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:4:{s:1:\"a\";i:81;s:1:\"b\";s:18:\"delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:4:{s:1:\"a\";i:82;s:1:\"b\";s:22:\"delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:4:{s:1:\"a\";i:83;s:1:\"b\";s:24:\"force_delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:4:{s:1:\"a\";i:84;s:1:\"b\";s:28:\"force_delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:26:\"view_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:4:{s:1:\"a\";i:86;s:1:\"b\";s:30:\"view_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:4:{s:1:\"a\";i:87;s:1:\"b\";s:28:\"create_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:4:{s:1:\"a\";i:88;s:1:\"b\";s:28:\"update_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:4:{s:1:\"a\";i:89;s:1:\"b\";s:29:\"restore_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:33:\"restore_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:4:{s:1:\"a\";i:91;s:1:\"b\";s:31:\"replicate_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:4:{s:1:\"a\";i:92;s:1:\"b\";s:29:\"reorder_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:4:{s:1:\"a\";i:93;s:1:\"b\";s:28:\"delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:4:{s:1:\"a\";i:94;s:1:\"b\";s:32:\"delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:4:{s:1:\"a\";i:95;s:1:\"b\";s:34:\"force_delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:4:{s:1:\"a\";i:96;s:1:\"b\";s:38:\"force_delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:4:{s:1:\"a\";i:97;s:1:\"b\";s:14:\"view_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:97;a:4:{s:1:\"a\";i:98;s:1:\"b\";s:18:\"view_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:98;a:4:{s:1:\"a\";i:99;s:1:\"b\";s:16:\"create_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:99;a:4:{s:1:\"a\";i:100;s:1:\"b\";s:16:\"update_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:100;a:4:{s:1:\"a\";i:101;s:1:\"b\";s:17:\"restore_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:101;a:4:{s:1:\"a\";i:102;s:1:\"b\";s:21:\"restore_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:102;a:4:{s:1:\"a\";i:103;s:1:\"b\";s:19:\"replicate_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:103;a:4:{s:1:\"a\";i:104;s:1:\"b\";s:17:\"reorder_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:104;a:4:{s:1:\"a\";i:105;s:1:\"b\";s:16:\"delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:105;a:4:{s:1:\"a\";i:106;s:1:\"b\";s:20:\"delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:106;a:4:{s:1:\"a\";i:107;s:1:\"b\";s:22:\"force_delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:107;a:4:{s:1:\"a\";i:108;s:1:\"b\";s:26:\"force_delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:108;a:4:{s:1:\"a\";i:109;s:1:\"b\";s:14:\"view_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:109;a:4:{s:1:\"a\";i:110;s:1:\"b\";s:18:\"view_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:110;a:4:{s:1:\"a\";i:111;s:1:\"b\";s:16:\"create_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:111;a:4:{s:1:\"a\";i:112;s:1:\"b\";s:16:\"update_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:112;a:4:{s:1:\"a\";i:113;s:1:\"b\";s:17:\"restore_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:113;a:4:{s:1:\"a\";i:114;s:1:\"b\";s:21:\"restore_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:114;a:4:{s:1:\"a\";i:115;s:1:\"b\";s:19:\"replicate_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:115;a:4:{s:1:\"a\";i:116;s:1:\"b\";s:17:\"reorder_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:116;a:4:{s:1:\"a\";i:117;s:1:\"b\";s:16:\"delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:117;a:4:{s:1:\"a\";i:118;s:1:\"b\";s:20:\"delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:118;a:4:{s:1:\"a\";i:119;s:1:\"b\";s:22:\"force_delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:119;a:4:{s:1:\"a\";i:120;s:1:\"b\";s:26:\"force_delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:120;a:4:{s:1:\"a\";i:121;s:1:\"b\";s:9:\"view_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:121;a:4:{s:1:\"a\";i:122;s:1:\"b\";s:13:\"view_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:122;a:4:{s:1:\"a\";i:123;s:1:\"b\";s:11:\"create_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:123;a:4:{s:1:\"a\";i:124;s:1:\"b\";s:11:\"update_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:124;a:4:{s:1:\"a\";i:125;s:1:\"b\";s:12:\"restore_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:125;a:4:{s:1:\"a\";i:126;s:1:\"b\";s:16:\"restore_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:126;a:4:{s:1:\"a\";i:127;s:1:\"b\";s:14:\"replicate_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:127;a:4:{s:1:\"a\";i:128;s:1:\"b\";s:12:\"reorder_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:128;a:4:{s:1:\"a\";i:129;s:1:\"b\";s:11:\"delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:129;a:4:{s:1:\"a\";i:130;s:1:\"b\";s:15:\"delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:130;a:4:{s:1:\"a\";i:131;s:1:\"b\";s:17:\"force_delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:131;a:4:{s:1:\"a\";i:132;s:1:\"b\";s:21:\"force_delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:132;a:4:{s:1:\"a\";i:133;s:1:\"b\";s:8:\"view_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:133;a:4:{s:1:\"a\";i:134;s:1:\"b\";s:12:\"view_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:134;a:4:{s:1:\"a\";i:135;s:1:\"b\";s:10:\"create_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:135;a:4:{s:1:\"a\";i:136;s:1:\"b\";s:10:\"update_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:136;a:4:{s:1:\"a\";i:137;s:1:\"b\";s:11:\"restore_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:137;a:4:{s:1:\"a\";i:138;s:1:\"b\";s:15:\"restore_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:138;a:4:{s:1:\"a\";i:139;s:1:\"b\";s:13:\"replicate_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:139;a:4:{s:1:\"a\";i:140;s:1:\"b\";s:11:\"reorder_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:140;a:4:{s:1:\"a\";i:141;s:1:\"b\";s:10:\"delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:141;a:4:{s:1:\"a\";i:142;s:1:\"b\";s:14:\"delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:142;a:4:{s:1:\"a\";i:143;s:1:\"b\";s:16:\"force_delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:143;a:4:{s:1:\"a\";i:144;s:1:\"b\";s:20:\"force_delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:144;a:4:{s:1:\"a\";i:145;s:1:\"b\";s:13:\"view_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:145;a:4:{s:1:\"a\";i:146;s:1:\"b\";s:17:\"view_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:146;a:4:{s:1:\"a\";i:147;s:1:\"b\";s:15:\"create_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:147;a:4:{s:1:\"a\";i:148;s:1:\"b\";s:15:\"update_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:148;a:4:{s:1:\"a\";i:149;s:1:\"b\";s:16:\"restore_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:149;a:4:{s:1:\"a\";i:150;s:1:\"b\";s:20:\"restore_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:150;a:4:{s:1:\"a\";i:151;s:1:\"b\";s:18:\"replicate_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:151;a:4:{s:1:\"a\";i:152;s:1:\"b\";s:16:\"reorder_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:152;a:4:{s:1:\"a\";i:153;s:1:\"b\";s:15:\"delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:153;a:4:{s:1:\"a\";i:154;s:1:\"b\";s:19:\"delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:154;a:4:{s:1:\"a\";i:155;s:1:\"b\";s:21:\"force_delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:155;a:4:{s:1:\"a\";i:156;s:1:\"b\";s:25:\"force_delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:156;a:4:{s:1:\"a\";i:157;s:1:\"b\";s:17:\"view_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:157;a:4:{s:1:\"a\";i:158;s:1:\"b\";s:21:\"view_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:158;a:4:{s:1:\"a\";i:159;s:1:\"b\";s:19:\"create_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:159;a:4:{s:1:\"a\";i:160;s:1:\"b\";s:19:\"update_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:160;a:4:{s:1:\"a\";i:161;s:1:\"b\";s:20:\"restore_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:161;a:4:{s:1:\"a\";i:162;s:1:\"b\";s:24:\"restore_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:162;a:4:{s:1:\"a\";i:163;s:1:\"b\";s:22:\"replicate_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:163;a:4:{s:1:\"a\";i:164;s:1:\"b\";s:20:\"reorder_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:164;a:4:{s:1:\"a\";i:165;s:1:\"b\";s:19:\"delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:165;a:4:{s:1:\"a\";i:166;s:1:\"b\";s:23:\"delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:166;a:4:{s:1:\"a\";i:167;s:1:\"b\";s:25:\"force_delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:167;a:4:{s:1:\"a\";i:168;s:1:\"b\";s:29:\"force_delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:168;a:4:{s:1:\"a\";i:169;s:1:\"b\";s:20:\"view_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:169;a:4:{s:1:\"a\";i:170;s:1:\"b\";s:24:\"view_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:170;a:4:{s:1:\"a\";i:171;s:1:\"b\";s:22:\"create_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:171;a:4:{s:1:\"a\";i:172;s:1:\"b\";s:22:\"update_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:172;a:4:{s:1:\"a\";i:173;s:1:\"b\";s:23:\"restore_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:173;a:4:{s:1:\"a\";i:174;s:1:\"b\";s:27:\"restore_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:174;a:4:{s:1:\"a\";i:175;s:1:\"b\";s:25:\"replicate_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:175;a:4:{s:1:\"a\";i:176;s:1:\"b\";s:23:\"reorder_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:176;a:4:{s:1:\"a\";i:177;s:1:\"b\";s:22:\"delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:177;a:4:{s:1:\"a\";i:178;s:1:\"b\";s:26:\"delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:178;a:4:{s:1:\"a\";i:179;s:1:\"b\";s:28:\"force_delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:179;a:4:{s:1:\"a\";i:180;s:1:\"b\";s:32:\"force_delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:180;a:4:{s:1:\"a\";i:181;s:1:\"b\";s:12:\"view_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:181;a:4:{s:1:\"a\";i:182;s:1:\"b\";s:16:\"view_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:182;a:4:{s:1:\"a\";i:183;s:1:\"b\";s:14:\"create_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:183;a:4:{s:1:\"a\";i:184;s:1:\"b\";s:14:\"update_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:184;a:4:{s:1:\"a\";i:185;s:1:\"b\";s:15:\"restore_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:185;a:4:{s:1:\"a\";i:186;s:1:\"b\";s:19:\"restore_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:186;a:4:{s:1:\"a\";i:187;s:1:\"b\";s:17:\"replicate_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:187;a:4:{s:1:\"a\";i:188;s:1:\"b\";s:15:\"reorder_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:188;a:4:{s:1:\"a\";i:189;s:1:\"b\";s:14:\"delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:189;a:4:{s:1:\"a\";i:190;s:1:\"b\";s:18:\"delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:190;a:4:{s:1:\"a\";i:191;s:1:\"b\";s:20:\"force_delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:191;a:4:{s:1:\"a\";i:192;s:1:\"b\";s:24:\"force_delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:192;a:4:{s:1:\"a\";i:193;s:1:\"b\";s:12:\"view_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:193;a:4:{s:1:\"a\";i:194;s:1:\"b\";s:16:\"view_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:194;a:4:{s:1:\"a\";i:195;s:1:\"b\";s:14:\"create_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:195;a:4:{s:1:\"a\";i:196;s:1:\"b\";s:14:\"update_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:196;a:4:{s:1:\"a\";i:197;s:1:\"b\";s:15:\"restore_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:197;a:4:{s:1:\"a\";i:198;s:1:\"b\";s:19:\"restore_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:198;a:4:{s:1:\"a\";i:199;s:1:\"b\";s:17:\"replicate_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:199;a:4:{s:1:\"a\";i:200;s:1:\"b\";s:15:\"reorder_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:200;a:4:{s:1:\"a\";i:201;s:1:\"b\";s:14:\"delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:201;a:4:{s:1:\"a\";i:202;s:1:\"b\";s:18:\"delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:202;a:4:{s:1:\"a\";i:203;s:1:\"b\";s:20:\"force_delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:203;a:4:{s:1:\"a\";i:204;s:1:\"b\";s:24:\"force_delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:204;a:4:{s:1:\"a\";i:205;s:1:\"b\";s:23:\"view_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:205;a:4:{s:1:\"a\";i:206;s:1:\"b\";s:27:\"view_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:206;a:4:{s:1:\"a\";i:207;s:1:\"b\";s:25:\"create_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:207;a:4:{s:1:\"a\";i:208;s:1:\"b\";s:25:\"update_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:208;a:4:{s:1:\"a\";i:209;s:1:\"b\";s:26:\"restore_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:209;a:4:{s:1:\"a\";i:210;s:1:\"b\";s:30:\"restore_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:210;a:4:{s:1:\"a\";i:211;s:1:\"b\";s:28:\"replicate_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:211;a:4:{s:1:\"a\";i:212;s:1:\"b\";s:26:\"reorder_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:212;a:4:{s:1:\"a\";i:213;s:1:\"b\";s:25:\"delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:213;a:4:{s:1:\"a\";i:214;s:1:\"b\";s:29:\"delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:214;a:4:{s:1:\"a\";i:215;s:1:\"b\";s:31:\"force_delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:215;a:4:{s:1:\"a\";i:216;s:1:\"b\";s:35:\"force_delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:216;a:4:{s:1:\"a\";i:217;s:1:\"b\";s:12:\"view_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:217;a:4:{s:1:\"a\";i:218;s:1:\"b\";s:16:\"view_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:218;a:4:{s:1:\"a\";i:219;s:1:\"b\";s:14:\"create_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:219;a:4:{s:1:\"a\";i:220;s:1:\"b\";s:14:\"update_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:220;a:4:{s:1:\"a\";i:221;s:1:\"b\";s:15:\"restore_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:221;a:4:{s:1:\"a\";i:222;s:1:\"b\";s:19:\"restore_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:222;a:4:{s:1:\"a\";i:223;s:1:\"b\";s:17:\"replicate_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:223;a:4:{s:1:\"a\";i:224;s:1:\"b\";s:15:\"reorder_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:224;a:4:{s:1:\"a\";i:225;s:1:\"b\";s:14:\"delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:225;a:4:{s:1:\"a\";i:226;s:1:\"b\";s:18:\"delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:226;a:4:{s:1:\"a\";i:227;s:1:\"b\";s:20:\"force_delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:227;a:4:{s:1:\"a\";i:228;s:1:\"b\";s:24:\"force_delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:228;a:4:{s:1:\"a\";i:229;s:1:\"b\";s:26:\"view_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:229;a:4:{s:1:\"a\";i:230;s:1:\"b\";s:30:\"view_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:230;a:4:{s:1:\"a\";i:231;s:1:\"b\";s:28:\"create_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:231;a:4:{s:1:\"a\";i:232;s:1:\"b\";s:28:\"update_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:232;a:4:{s:1:\"a\";i:233;s:1:\"b\";s:29:\"restore_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:233;a:4:{s:1:\"a\";i:234;s:1:\"b\";s:33:\"restore_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:234;a:4:{s:1:\"a\";i:235;s:1:\"b\";s:31:\"replicate_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:235;a:4:{s:1:\"a\";i:236;s:1:\"b\";s:29:\"reorder_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:236;a:4:{s:1:\"a\";i:237;s:1:\"b\";s:28:\"delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:237;a:4:{s:1:\"a\";i:238;s:1:\"b\";s:32:\"delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:238;a:4:{s:1:\"a\";i:239;s:1:\"b\";s:34:\"force_delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:239;a:4:{s:1:\"a\";i:240;s:1:\"b\";s:38:\"force_delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:240;a:4:{s:1:\"a\";i:241;s:1:\"b\";s:20:\"view_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:241;a:4:{s:1:\"a\";i:242;s:1:\"b\";s:24:\"view_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:242;a:4:{s:1:\"a\";i:243;s:1:\"b\";s:22:\"create_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:243;a:4:{s:1:\"a\";i:244;s:1:\"b\";s:22:\"update_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:244;a:4:{s:1:\"a\";i:245;s:1:\"b\";s:23:\"restore_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:245;a:4:{s:1:\"a\";i:246;s:1:\"b\";s:27:\"restore_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:246;a:4:{s:1:\"a\";i:247;s:1:\"b\";s:25:\"replicate_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:247;a:4:{s:1:\"a\";i:248;s:1:\"b\";s:23:\"reorder_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:248;a:4:{s:1:\"a\";i:249;s:1:\"b\";s:22:\"delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:249;a:4:{s:1:\"a\";i:250;s:1:\"b\";s:26:\"delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:250;a:4:{s:1:\"a\";i:251;s:1:\"b\";s:28:\"force_delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:251;a:4:{s:1:\"a\";i:252;s:1:\"b\";s:32:\"force_delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:252;a:4:{s:1:\"a\";i:253;s:1:\"b\";s:9:\"view_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:253;a:4:{s:1:\"a\";i:254;s:1:\"b\";s:13:\"view_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:254;a:4:{s:1:\"a\";i:255;s:1:\"b\";s:11:\"create_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:255;a:4:{s:1:\"a\";i:256;s:1:\"b\";s:11:\"update_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:256;a:4:{s:1:\"a\";i:257;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:257;a:4:{s:1:\"a\";i:258;s:1:\"b\";s:15:\"delete_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:258;a:4:{s:1:\"a\";i:259;s:1:\"b\";s:24:\"view_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:259;a:4:{s:1:\"a\";i:260;s:1:\"b\";s:28:\"view_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:260;a:4:{s:1:\"a\";i:261;s:1:\"b\";s:26:\"create_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:261;a:4:{s:1:\"a\";i:262;s:1:\"b\";s:26:\"update_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:262;a:4:{s:1:\"a\";i:263;s:1:\"b\";s:27:\"restore_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:263;a:4:{s:1:\"a\";i:264;s:1:\"b\";s:31:\"restore_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:264;a:4:{s:1:\"a\";i:265;s:1:\"b\";s:29:\"replicate_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:265;a:4:{s:1:\"a\";i:266;s:1:\"b\";s:27:\"reorder_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:266;a:4:{s:1:\"a\";i:267;s:1:\"b\";s:26:\"delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:267;a:4:{s:1:\"a\";i:268;s:1:\"b\";s:30:\"delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:268;a:4:{s:1:\"a\";i:269;s:1:\"b\";s:32:\"force_delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:269;a:4:{s:1:\"a\";i:270;s:1:\"b\";s:36:\"force_delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:270;a:4:{s:1:\"a\";i:271;s:1:\"b\";s:9:\"view_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:271;a:4:{s:1:\"a\";i:272;s:1:\"b\";s:13:\"view_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:272;a:4:{s:1:\"a\";i:273;s:1:\"b\";s:11:\"create_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:273;a:4:{s:1:\"a\";i:274;s:1:\"b\";s:11:\"update_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:274;a:4:{s:1:\"a\";i:275;s:1:\"b\";s:12:\"restore_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:275;a:4:{s:1:\"a\";i:276;s:1:\"b\";s:16:\"restore_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:276;a:4:{s:1:\"a\";i:277;s:1:\"b\";s:14:\"replicate_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:277;a:4:{s:1:\"a\";i:278;s:1:\"b\";s:12:\"reorder_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:278;a:4:{s:1:\"a\";i:279;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:279;a:4:{s:1:\"a\";i:280;s:1:\"b\";s:15:\"delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:280;a:4:{s:1:\"a\";i:281;s:1:\"b\";s:17:\"force_delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:281;a:4:{s:1:\"a\";i:282;s:1:\"b\";s:21:\"force_delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:282;a:4:{s:1:\"a\";i:283;s:1:\"b\";s:24:\"page_ActivityFileManager\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:283;a:4:{s:1:\"a\";i:284;s:1:\"b\";s:28:\"page_BeneficiaryRegistryView\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:284;a:3:{s:1:\"a\";i:285;s:1:\"b\";s:25:\"page_ProjectCreationGuide\";s:1:\"c\";s:3:\"web\";}i:285;a:4:{s:1:\"a\";i:286;s:1:\"b\";s:22:\"page_ProjectManagement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:286;a:4:{s:1:\"a\";i:287;s:1:\"b\";s:18:\"page_ProjectWizard\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:287;a:4:{s:1:\"a\";i:288;s:1:\"b\";s:28:\"page_DataPublicationApproval\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:1:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}}}', 1753720900);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `components`
--

CREATE TABLE `components` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `action_lines_id` bigint(20) UNSIGNED NOT NULL,
  `action_lines_program_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `components`
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
-- Estructura de tabla para la tabla `data_publications`
--

CREATE TABLE `data_publications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `publication_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `published_by` bigint(20) UNSIGNED NOT NULL,
  `publication_notes` text DEFAULT NULL,
  `metrics_count` int(11) NOT NULL DEFAULT 0,
  `projects_count` int(11) NOT NULL DEFAULT 0,
  `activities_count` int(11) NOT NULL DEFAULT 0,
  `period_from` date DEFAULT NULL,
  `period_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `financiers`
--

CREATE TABLE `financiers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `financiers`
--

INSERT INTO `financiers` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Fundación del Empresariado Chihuahuense (FECHAC) ', '2025-07-21 19:27:06', '2025-07-21 19:27:06'),
(2, 'Fundación Comunitaria de la Frontera Norte A.C.', '2025-07-21 20:35:49', '2025-07-21 20:35:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `goals`
--

CREATE TABLE `goals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `components_id` bigint(20) UNSIGNED NOT NULL,
  `components_action_lines_id` bigint(20) UNSIGNED NOT NULL,
  `components_action_lines_program_id` bigint(20) UNSIGNED NOT NULL,
  `organizations_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `goals`
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
(69, 1, '3.2 Lograr la participación de al menos 220 personas en actividades relacionadas con los huertos urbanos entre enero y diciembre de 2025.', NULL, 35, 32, 12, 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kpis`
--

CREATE TABLE `kpis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `initial_value` decimal(10,2) DEFAULT NULL,
  `final_value` decimal(10,2) DEFAULT NULL,
  `projects_id` bigint(20) UNSIGNED NOT NULL,
  `is_percentage` tinyint(1) DEFAULT NULL,
  `org_area` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `street` text DEFAULT NULL,
  `neighborhood` varchar(100) DEFAULT NULL,
  `ext_number` varchar(50) DEFAULT NULL,
  `int_number` varchar(50) DEFAULT NULL,
  `google_place_id` varchar(500) DEFAULT NULL,
  `polygons_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `locations`
--

INSERT INTO `locations` (`id`, `name`, `category`, `street`, `neighborhood`, `ext_number`, `int_number`, `google_place_id`, `polygons_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Parque C. Rivera de Urique', 'Parque público', 'C. Rivera de Urique  y C. Rivera del Cozumel', 'Riberas del Bravo', NULL, NULL, 'Ek5SaXZlcmEgZGUgVXJpcXVlLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iLiosChQKEglPhNEqWGjnhhHIO0pzzjeDxxIUChIJ0UCA7fdo54YRnEyYikVxXHk Rivera de Urique, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 20:55:18', '2025-07-24 21:38:21'),
(2, ' Parque C. Rivera de Peñasco y Rivera de Ixtapa', 'Parque público', 'C. Rivera de Peñasco y Rivera de Ixtapa', 'Riberas del Bravo', NULL, NULL, 'EmZDLiBSaXZlcmEgUGXDsWFzY28gJiBDLiBSaXZlcmEgZGUgSXh0YXBhLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEgk3Ryk6V2jnhhEWukjBZTpCIhIUChIJN0cpOldo54YRFrpIwWU6QiIaFAoSCSEBILL4aOeGEYOlVRGB6W9xGhQKEgkZAbDfWWjnhhHvyA1csT8y1yIKDUV42BIVxnqiwA C. Rivera Peñasco & C. Rivera de Ixtapa, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:17:46', '2025-07-24 22:00:08'),
(3, ' Parque C. Rivera Peñasco y del Florido', 'Parque público', 'C. Rivera Peñasco y C. del Florido', 'Riberas del Bravo', NULL, NULL, 'EmFDLiBSaXZlcmEgUGXDsWFzY28gJiBDLiBkZWwgRmxvcmlkbywgUGFyY2VsYXMgRWppZG8gSmVzw7pzIENhcnJhbnphLCAzMjU5NCBKdcOhcmV6LCBDaGloLiwgTWV4aWNvImYiZAoUChIJPx-ny_ho54YRRGIVsr4zPVkSFAoSCT8fp8v4aOeGEURiFbK-Mz1ZGhQKEgkhASCy-GjnhhGDpVURgelvcRoUChIJq17Kwvho54YRM01ayC4VFRciCg3RkdcSFVoSo8A C. Rivera Peñasco & C. del Florido, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:23:48', '2025-07-24 21:59:28'),
(4, ' Parque C. Rivera Peñasco y Rivera de Altamira', 'Parque público', ' C. Rivera Peñasco y Rivera de Altamira S/N', 'Riberas del Bravo', NULL, NULL, 'EmhDYWxsZSBSaXZlcmEgUGXDsWFzY28gJiBSaXZlcmEgZGUgQWx0YW1pcmEsIFBhcmNlbGFzIEVqaWRvIEplc8O6cyBDYXJyYW56YSwgMzI1OTQgSnXDoXJleiwgQ2hpaC4sIE1leGljbyJmImQKFAoSCTfavhtXaOeGEcHUrUVFOR8OEhQKEgk32r4bV2jnhhHB1K1FRTkfDhoUChIJIQEgsvho54YRg6VVEYHpb3EaFAoSCVVeLg1XaOeGEVTtuSBptYspIgoNQlPYEhV0j6LA Calle Rivera Peñasco & Rivera de Altamira, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:28:35', '2025-07-24 21:39:29'),
(5, 'Telebachillerato 8688 Víctor Hugo Rascón Banda', 'Escuela pública', 'C. Rivera de Agua Blanca y Ribera de la Bahía', 'Riberas del Bravo', NULL, NULL, 'ChIJmfjAJktp54YRmDZOgFd48Ek Rivera de Agua Blanca y Ribera de la Bahia Col, Rivera del Bravo, Riberas de bravo etapa I, 32594 Juárez, Chih., México', 1, 3, '2025-07-24 21:35:45', '2025-07-24 21:35:45'),
(6, 'Parque C. Rivera Batopilas y del Florido', 'Parque público', 'C. Rivera Batopilas y del Florido', 'Riberas del Bravo', NULL, NULL, 'EmVSaXZlcmEgZGUgQmF0b3BpbGFzICYgQ2FsbGUgZGVsIEZsb3JpZG8sIFBhcmNlbGFzIEVqaWRvIEplc8O6cyBDYXJyYW56YSwgMzI1OTQgSnXDoXJleiwgQ2hpaC4sIE1leGljbyJmImQKFAoSCX_qasP4aOeGEeJ-rAmCjDuPEhQKEgl_6mrD-GjnhhHifqwJgow7jxoUChIJU_us6vho54YRLoW3DlANepQaFAoSCateysL4aOeGETNNWsguFRUXIgoNHYHXEhUt7qLA Rivera de Batopilas & Calle del Florido, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:43:07', '2025-07-24 21:59:52'),
(7, 'Parque C. Rivera de Mezquite y Rivera de Galeon', 'Parque público', 'C. Rivera de Mezquite y Rivera de Galeon', 'Riberas del Bravo', NULL, NULL, 'EmNSaXZlcmEgZGUgTWV6cXVpdGUgJiBSaXZlcmEgZGUgR2FsZW9uLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEglXoHcV-2jnhhGF64Y9XWijpRIUChIJV6B3Ffto54YRheuGPV1oo6UaFAoSCTlCAUf7aOeGEULSsAELNtX9GhQKEgnp0vwi-2jnhhEpAjanth4pgSIKDVdT1hIVKNqiwA Rivera de Mezquite & Rivera de Galeon, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 21:58:45', '2025-07-24 21:58:45'),
(8, 'Parque C. Rincon de Río Conchos y Rincon de Río Verde', 'Parque público', 'C. Rincon de Río Conchos y Rincon de Río Verde', 'Riberas del Bravo', NULL, NULL, 'EoMBQy4gUmluY29uIGRlIFLDrW8gQ29uY2hvcyAmIEMuIFJpbmNvbiBkZWwgUmlvIFZlcmRlLCBSaW5jw7NuIGRlbCBSw61vLCBQYXJjZWxhcyBFamlkbyBKZXPDunMgQ2FycmFuemEsIDMyNTk0IEp1w6FyZXosIENoaWguLCBNZXhpY28iZiJkChQKEgnFwRbMUWjnhhHwLW_VJ8u_mRIUChIJxcEWzFFo54YR8C1v1SfLv5kaFAoSCSld1NJRaOeGEWcLjmgER8CoGhQKEgll2hbMUWjnhhEgfNrq1mj8QSIKDR5T2RIVIreiwA C. Rincon de Río Conchos & C. Rincon del Rio Verde, Rincón del Río, Parcelas Ejido Jesús Carranza, 32594 Juárez, Chih., México', 2, 3, '2025-07-24 22:16:13', '2025-07-24 22:16:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
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
(60, '2025_07_23_200000_add_project_id_to_goals', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 3),
(1, 'App\\Models\\User', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `organizations`
--

CREATE TABLE `organizations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Juárez Limpio A.C', '2025-07-24 18:42:33', '2025-07-24 18:42:33'),
(2, 'Asamblea de Organizaciones', '2025-07-24 18:42:41', '2025-07-24 18:42:41'),
(3, 'Plan Estratégico de Juárez A.C', '2025-07-24 18:43:34', '2025-07-24 18:43:34'),
(5, 'Red de Vecinos', '2025-07-24 18:44:07', '2025-07-24 18:49:15'),
(6, 'Arte en el Parque A.C', '2025-07-24 18:44:39', '2025-07-24 18:44:39'),
(7, 'Centro Humano de Liderazgo A.C.', '2025-07-24 18:45:23', '2025-07-24 18:45:23'),
(9, 'YoCiudadano', '2025-07-24 18:46:07', '2025-07-24 18:46:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
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
(288, 'page_DataPublicationApproval', 'web', '2025-07-23 03:06:25', '2025-07-23 03:06:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planned_metrics`
--

CREATE TABLE `planned_metrics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `activity_id` bigint(20) UNSIGNED NOT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `population_target_value` decimal(10,2) DEFAULT NULL,
  `population_real_value` decimal(10,2) NOT NULL DEFAULT 0.00,
  `product_target_value` decimal(10,2) DEFAULT NULL,
  `product_real_value` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `polygons`
--

CREATE TABLE `polygons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `polygons`
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
-- Estructura de tabla para la tabla `programs`
--

CREATE TABLE `programs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `axes_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `programs`
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
-- Estructura de tabla para la tabla `program_indicators`
--

CREATE TABLE `program_indicators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `initial_value` decimal(10,2) DEFAULT NULL,
  `final_value` decimal(10,2) DEFAULT NULL,
  `program_id` bigint(20) UNSIGNED NOT NULL,
  `program_axes_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) NOT NULL,
  `background` longtext DEFAULT NULL,
  `justification` longtext DEFAULT NULL,
  `general_objective` longtext DEFAULT NULL,
  `financiers_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `funded_amount` double DEFAULT NULL,
  `cofunding_amount` double DEFAULT NULL,
  `monthly_disbursement` double DEFAULT NULL,
  `followup_officer` text DEFAULT NULL,
  `agreement_file` text DEFAULT NULL,
  `project_base_file` text DEFAULT NULL,
  `co_financier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `projects`
--

INSERT INTO `projects` (`id`, `name`, `background`, `justification`, `general_objective`, `financiers_id`, `start_date`, `end_date`, `total_cost`, `funded_amount`, `cofunding_amount`, `monthly_disbursement`, `followup_officer`, `agreement_file`, `project_base_file`, `co_financier_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'La mejora de espacios públicos y la activación socioambiental en el suroriente de Ciudad Juárez, Chihuahua, 2024-2025', 'La población de Riberas del Bravo representa el 3% de la población total de Ciudad Juárez, mayoritariamente es joven, principalmente en una edad de 18 a 24 años en ambos sexos, como se muestra en la Gráfica 1 cuyos datos coinciden con la base de INEGI (2020). Asimismo, en dicha gráfica presenta en el rango de edad de 25 a 39 años en el sexo femenino que son mayoría, mientras que en los demás rangos predomina el sexo masculino, incluso en general se tiene mayor porcentaje de este sexo, con un 50.6%.\nCon respecto a la ocupación de la población, INEGI (2020) exterioriza que el 55% de su población es económicamente activa a diferencia del 52% que existe en Juárez. \nEn Riberas del Bravo, 33% es operador seguido de un 20.7% que se dedican al hogar, un 17.1% son estudiantes, un 16.2% son empleados, Se tiene un porcentaje menor que tienen otro tipo de ocupación como es ser comerciantes, se encuentran jubilados, no tienen alguna ocupación, entre otros (para más detalle de las otras ocupaciones ver documento de gráficas).\nEl 9% de las familias encuestadas algún miembro del hogar tiene alguna discapacidad, referida principalmente de tipo motriz. INEGI indica que el 4.2% de las personas tienen alguna discapacidad y un 11.4% de la población tiene limitación.\nINEGI (2020) señala que en Riberas del Bravo sólo el 4% es analfabeta: donde el 1.4% de la población de 15 años y más es analfabeta, para la ciudad es de una diferencia de 0.1%; es decir es de 1.3%; y el 2.6% de la población de 8 a 14 años no sabe leer y escribir, mismo porcentaje se presenta a nivel municipal. Asimismo, indica que el nivel de escolaridad de Riberas del Bravo es de 9 años, mismo que se tiene en Ciudad Juárez, además es el mismo dato que se reflejan en los resultados de la encuesta, donde el 42.1% tiene como último grado de estudios la secundaria, seguido de un 27.6% que tiene la primaria; es decir, un 69.7% de la población tiene nivel básico, mientras que un 18% preparatoria y solamente el 4.2% tienen alguna profesión.\nUn elemento considerado en la encuesta para conocer la cohesión social de la comunidad se encuentra relacionado con la existencia de una vinculación con diferentes actores: gobierno, organización religiosa y asociación civil. La Gráfica 1 expresa si estos actores han trabajado en algún programa o proyecto en la colonia, en los tres casos el mayor porcentaje se encuentra como respuesta que No, solamente el 22% de los encuestados identificó que el gobierno ha realizado estas acciones, el 4.8% que han sido organizaciones religiosas y un 2% alguna organización de la sociedad civil. \nLa población encuestada reconoció que, por parte del gobierno, las dependencias que han trabajado son del gobierno del Estado, el Municipio, SEDESOL la academia de policía y el Centro comunitario. Para el caso de las organizaciones religiosas reconocieron que han sido cristianas, católicas, y pentecostés, mientras que en el caso de las organizaciones identificaron como los comités de vecinos, Red de mujeres, pueblos indígenas, universidad y un solo caso a la FECHAC.\nDe la población que identificó que han trabajado estos actores en Riberas del Bravo, solamente el 5.4% participó en las acciones realizadas por el gobierno, el 2% lo hizo con las organizaciones religiosas y el 1.8% ha participado en las organizaciones de la sociedad civil. \nOtro elemento considerado en la cohesión social se encuentra en la descripción de la relación con los vecinos. En la Gráfica 2 se indica que en todas las etapas existe buena relación, incluso en las etapas a excepción de la I, existen casos donde la relación es excelente. Por otro lado, existen con un porcentaje inferior de casos que la relación es mala como son en las etapas II, IV, V, VI, y VIII y solamente en la etapa VIII se refleja que la relación es muy mala, con un 0.8%.\nLos parques del fraccionamiento Riberas del Bravo distribuidos en todas las etapas, son espacios que son considerados áreas recreativas. El 31.5% de la población ocupa estas áreas y lo hacen para realizar actividades como caminar, jugar, como forma de distracción para los menores o para realizar algún deporte.\nSobre los comercios de la zona; no existe un supermercado dentro del fraccionamiento, el más cercano se ubica en la avenida Juárez Porvenir, mientras que existen 17 tiendas de auto servicio. INEGI (2020) señala de las unidades económicas que existen en Riberas del Bravo, el 54% corresponden al comercio al por menor, un 22% son de otros servicios y el 10% servicios de alojamiento temporal y de preparación de alimentos y bebidas.\nEn Riberas del Bravo se encuentran como activos de cohesión social dos centros comunitarios: centro comunitario Municipal Riveras del Bravo etapa 8 y el centro comunitario Estatal etapa 3, donde se dan servicios como talleres de habilidades, deportivos, apoyo psicológico, secundaria y preparatoria abierta. En donde se tiene alianzas con organizaciones para realizar estas actividades, las cuales son EMMA, CAPA, SEDEX, MUSPAC, ICHEA y Programa Desafío.', 'Considerando el abandono histórico de que han sido sujetos los espacios públicos de Ciudad Juárez, y su impacto en la conversión de estos, en espacios altamente deteriorados, contaminados que incluso  dificultan la convivencia y niegan el derecho a un ambiente sano y al goce pleno de la ciudad, la intervención de Juárez Limpio A.C. colocará el énfasis de sus acciones en trabajar codo a codo con la comunidad para reconectarse con el ecosistema, identificar los riesgos que se asocian con la contaminación ambiental y poner acciones en marcha para mejorar sus espacios públicos, y regenerar con ello, el sentido de pertenencia y el tejido social. \nLa intervención va de la mano con el Modelo Integral de Desarrollo Social (MIDAS). Juárez Limpio A.C. se unirá a la intervención con los objetivos postulados en posteriores apartados a través de sus programas ambientales A Reforestar Juárez, Pasaporte Ambiental y Educación Ambiental a través de huertos urbanos.\nA Reforestar Juárez es un programa que recurre a la forestación urbana como herramienta para promover la cohesión social. Se comenzará a trabajar con las comunidades ya establecidas previamente en el MIDAS, se levantará una pequeña encuesta relacionada a las prácticas ambientales de las personas asistentes y se llevarán a cabo grupos focales para detectar áreas de oportunidad para forestar o mantener áreas forestadas. Luego, se prepararán los sitios con limpiezas, acolchado, sistemas de riego y talleres técnicos. Se realizarán las forestaciones con especies adaptadas a la zona. Posteriormente se dará seguimiento a los sitios y comunidades forestadas\nEl Pasaporte Ambiental (PA) es un programa que nace de la necesidad de la comunidad juarense de llevar a cabo actividades individuales de cuidado del ambiente. Este consiste en una aplicación móvil donde las personas se podrán inscribir, registrar sus actividades en favor del ambiente y observar las demás que se hacen en otras partes de la ciudad. Esto promoverá la participación ciudadana en temas ambientales. Previo al registro de personas en la aplicación móvil, se promoverán talleres de cuidado del ambiente como reforzamiento del aprendizaje significativo.\nLos huertos urbanos resultan alternativas relevantes para naturar espacios en las grandes urbes y como herramientas de educación ambiental e instrumentos de inclusión social, que inciden en la disminución de los índices delictivos, contribuyen a la soberanía alimentaria, enriquecen la creatividad, reducen la huella ecológica, apoyan las economías locales y generan una consciencia profunda sobre la producción de los alimentos disminuyendo su desperdicio.\nLos huertos comunitarios estimulan la cohesión social, la construcción y fortalecimiento de lazos comunitarios, contribuyen con la proliferación de biodiversidad, la salud de suelo y el aire, la mitigación del cambio climático, e incluso funcionan como actividades terapéutico– relajantes.\nEste proyecto busca contribuir a los objetivos de desarrollo sostenible 3,11 y 13 a través de la disminución de materiales tóxicos al alcance de las personas, contribuyendo a la mejora de los espacios públicos y fortaleciendo la capacidad de adaptación de los riesgos relacionados con el clima. ', 'Promover la participación de la comunidad habitante de Riberas del Bravo en actividades de activación para la solución de problemas ambientales, fortalecer la cohesión social a través de acciones en pro de la activación de los espacios públicos.', 1, '2024-11-04', '2025-12-31', 1297959.21, 864478.64, 433480.57, 0, 'Ana Luisa Sáenz', NULL, NULL, 2, 3, '2025-07-21 20:37:11', '2025-07-24 16:06:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_disbursements`
--

CREATE TABLE `project_disbursements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `projects_id` bigint(20) UNSIGNED NOT NULL,
  `amount` double DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `project_disbursements`
--

INSERT INTO `project_disbursements` (`id`, `projects_id`, `amount`, `disbursement_date`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 307774.99, '2025-05-01', 3, '2025-07-21 21:58:15', '2025-07-21 21:58:15'),
(2, 1, 372794.87, '2025-11-10', 3, '2025-07-21 22:03:36', '2025-07-21 22:03:36'),
(3, 1, 183935.9, '2026-02-09', 3, '2025-07-21 22:04:49', '2025-07-21 22:04:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `project_reports`
--

CREATE TABLE `project_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `report_date` date DEFAULT NULL,
  `report_file` text DEFAULT NULL,
  `projects_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `published_activities`
--

CREATE TABLE `published_activities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `publication_id` bigint(20) UNSIGNED NOT NULL,
  `original_activity_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `specific_objective_id` bigint(20) UNSIGNED NOT NULL,
  `goals_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `snapshot_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `published_metrics`
--

CREATE TABLE `published_metrics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `publication_id` bigint(20) UNSIGNED NOT NULL,
  `original_metric_id` bigint(20) UNSIGNED NOT NULL,
  `activity_id` bigint(20) UNSIGNED NOT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `population_target_value` decimal(10,2) DEFAULT NULL,
  `population_real_value` decimal(10,2) DEFAULT NULL,
  `product_target_value` decimal(10,2) DEFAULT NULL,
  `product_real_value` decimal(10,2) DEFAULT NULL,
  `snapshot_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `published_projects`
--

CREATE TABLE `published_projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `publication_id` bigint(20) UNSIGNED NOT NULL,
  `original_project_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) NOT NULL,
  `background` text DEFAULT NULL,
  `justification` text DEFAULT NULL,
  `general_objective` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `funded_amount` double DEFAULT NULL,
  `cofunding_amount` double DEFAULT NULL,
  `financiers_id` bigint(20) UNSIGNED NOT NULL,
  `co_financier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `snapshot_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'web', '2025-07-21 16:21:04', '2025-07-21 16:21:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_has_permissions`
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
(288, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('x3mA8bo5kxdv2qHQDpYQVCNEe3mrtk90uo6XMlUT', 1, '201.146.125.224', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiMkxzVkFidEg2eFhHVndvd3ZTNDZ0UVpqWkRiTjk5UjBXOUlOZ2M5QSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHBzOi8vcGFuZWwucGFydGljaXBhanVhcmV6Lm9yZy9hZG1pbi9nZXN0b3ItYWN0aXZpZGFkZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkS0lSOTltTFBhUjRBVU9LSjJQNGk5ZXpaRWxhV0Nsa21uYm11Y1ZGU1AyQlE5cFJoeGNCLk8iO30=', 1753634561);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `specific_objectives`
--

CREATE TABLE `specific_objectives` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `projects_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `specific_objectives`
--

INSERT INTO `specific_objectives` (`id`, `description`, `projects_id`, `created_at`, `updated_at`) VALUES
(7, 'OE1. Lograr que la comunidad habitante de Riberas del Bravo (80: Población femenina-39, Población masculina-41, Población de 0 a 14 años-23, Población de 15 a 29 años-24, Población de 30 a 59 años-31, Población de 60 años y más-2 ) se apropie de espacios públicos (incluyendo escuelas) en el polígono de Riberas del Bravo.', 1, '2025-07-24 16:06:03', '2025-07-24 16:06:03'),
(8, 'OE2.  Impartir actividades que promuevan la educación ambiental como herramienta de cohesión social en las comunidades habitantes de Riberas del Bravo (350: Población femenina-172, Población masculina-178, Población de 0 a 14 años-103, Población de 15 a 29 años-103, Población de 30 a 59 años-134, Población de 60 años y más-10 ) y el suroriente de Juárez.', 1, '2025-07-24 16:06:03', '2025-07-24 16:06:03'),
(9, 'OE3.  Divulgar temas de cuidado de los espacios públicos a la comunidad habitante de Riberas del Bravo (220: Población femenina-78, Población masculina-81, Población de 0 a 14 años-47, Población de 15 a 29 años-47, Población de 30 a 59 años-61, Población de 60 años y más-5), a través de la creación de dos huertos urbanos de la zona', 1, '2025-07-24 16:06:03', '2025-07-24 16:06:03'),
(10, 'OE1. Lograr que la comunidad habitante de Riberas del Bravo (80: Población femenina-39, Población masculina-41, Población de 0 a 14 años-23, Población de 15 a 29 años-24, Población de 30 a 59 años-31, Población de 60 años y más-2 ) se apropie de espacios públicos (incluyendo escuelas) en el polígono de Riberas del Bravo.', 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(11, 'OE2.  Impartir actividades que promuevan la educación ambiental como herramienta de cohesión social en las comunidades habitantes de Riberas del Bravo (350: Población femenina-172, Población masculina-178, Población de 0 a 14 años-103, Población de 15 a 29 años-103, Población de 30 a 59 años-134, Población de 60 años y más-10 ) y el suroriente de Juárez.', 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40'),
(12, 'OE3.  Divulgar temas de cuidado de los espacios públicos a la comunidad habitante de Riberas del Bravo (220: Población femenina-78, Población masculina-81, Población de 0 a 14 años-47, Población de 15 a 29 años-47, Población de 30 a 59 años-61, Población de 60 años y más-5), a través de la creación de dos huertos urbanos de la zona', 1, '2025-07-25 18:39:40', '2025-07-25 18:39:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `point_of_contact_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `org_role` varchar(45) DEFAULT NULL,
  `organizations_id` bigint(20) UNSIGNED DEFAULT NULL,
  `org_area` varchar(100) DEFAULT NULL,
  `can_publish_data` tinyint(1) NOT NULL DEFAULT 0,
  `last_publication_access` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `point_of_contact_id`, `phone`, `org_role`, `organizations_id`, `org_area`, `can_publish_data`, `last_publication_access`) VALUES
(1, 'David García', 'dgarcia@planjuarez.org', NULL, '$2y$12$KIR99mLPaR4AUOKJ2P4i9ezZElaWClkmnbmucVFSP2BQ9pRhxcB.O', 'zAOTkKlSwg8tnqoNLiXhtwJgStva6b9gHYRbS8xesYljfwInnvKoijKM3dgz', '2025-07-18 15:42:35', '2025-07-18 15:42:35', NULL, NULL, NULL, NULL, NULL, 0, NULL),
(2, 'Capturista', 'capturista@test.com', NULL, '$2y$12$Va4opuExiUMvvvjU2vgh8OjqmgyUzzyPtNedBys1g5AEI1YcTiUzO', NULL, '2025-07-18 18:49:25', '2025-07-18 18:49:25', NULL, NULL, NULL, NULL, NULL, 0, NULL),
(3, 'Judith Carrillo Carrera', 'jcarrillo@planjuarez.org', NULL, '$2y$12$59lZ6VvrfpB7gOCrfOI5FuZOrfHvYFWuacfDV0ndEUu.qIly960wu', NULL, '2025-07-21 19:22:31', '2025-07-21 19:22:31', NULL, NULL, NULL, NULL, NULL, 0, NULL),
(4, 'Lizeth López Martínez', 'llopez@planjuarez.org', NULL, '$2y$12$2LjLp3NeytBxo0PTUfXnceF8UKCeiP4vYTEW5rGZHDpbf5mWyxfAy', 'rbyArOvKXRHOhFbQlGNailSRmAYOcD5S6HZaLzw5AuRZxLcUzzLQvbq9O7cy', '2025-07-25 14:54:14', '2025-07-25 14:56:40', NULL, NULL, 'Ejecutivo (a)', 3, 'Estudios y planeación estratégica ', 0, NULL),
(5, 'Alejandra Villagrana', 'proyectosambientales@juarezlimpio.org', NULL, '$2y$12$QSIDUkgl8xF7hI46ZhR9QetAWAMyQP91lPMeaaHKdVEKWXm8sL1Jm', NULL, '2025-07-25 15:24:08', '2025-07-25 15:24:08', NULL, NULL, 'Coordinador (a)', 1, 'Proyectos  Ambientales', 0, NULL),
(6, 'Lluvia Herrera', 'vinculacion@juarezlimpio.org', NULL, '$2y$12$ftth3gULnr2jPWHtdFztUuHmtNaTehHFVSpBHTh0RIFbvx7zf5V.S', NULL, '2025-07-25 15:27:36', '2025-07-25 15:27:36', 5, '6567755145', 'Ejecutivo (a)', 1, 'Atención Comunitaria', 0, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `action_lines`
--
ALTER TABLE `action_lines`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `activity_calendars`
--
ALTER TABLE `activity_calendars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_calendars_location_id_foreign` (`location_id`);

--
-- Indices de la tabla `activity_files`
--
ALTER TABLE `activity_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_files_activity_calendar_id_foreign` (`activity_calendar_id`);

--
-- Indices de la tabla `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `axes`
--
ALTER TABLE `axes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `beneficiaries`
--
ALTER TABLE `beneficiaries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `beneficiaries_identifier_unique` (`identifier`);

--
-- Indices de la tabla `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `components`
--
ALTER TABLE `components`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `data_publications`
--
ALTER TABLE `data_publications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_publications_published_by_foreign` (`published_by`),
  ADD KEY `idx_publications_date` (`publication_date`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `financiers`
--
ALTER TABLE `financiers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `goals`
--
ALTER TABLE `goals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `goals_project_id_foreign` (`project_id`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `kpis`
--
ALTER TABLE `kpis`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `locations_name_unique` (`name`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `planned_metrics`
--
ALTER TABLE `planned_metrics`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `polygons`
--
ALTER TABLE `polygons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `polygons_name_unique` (`name`);

--
-- Indices de la tabla `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `program_indicators`
--
ALTER TABLE `program_indicators`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `project_disbursements`
--
ALTER TABLE `project_disbursements`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `project_reports`
--
ALTER TABLE `project_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `published_activities`
--
ALTER TABLE `published_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_activities_publication_id_foreign` (`publication_id`),
  ADD KEY `published_activities_specific_objective_id_foreign` (`specific_objective_id`),
  ADD KEY `published_activities_goals_id_foreign` (`goals_id`),
  ADD KEY `published_activities_created_by_foreign` (`created_by`),
  ADD KEY `idx_published_activities_original` (`original_activity_id`);

--
-- Indices de la tabla `published_metrics`
--
ALTER TABLE `published_metrics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_metrics_publication_id_foreign` (`publication_id`),
  ADD KEY `idx_published_metrics_activity` (`activity_id`),
  ADD KEY `idx_published_metrics_period` (`year`,`month`),
  ADD KEY `idx_published_metrics_original` (`original_metric_id`);

--
-- Indices de la tabla `published_projects`
--
ALTER TABLE `published_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_projects_publication_id_foreign` (`publication_id`),
  ADD KEY `published_projects_co_financier_id_foreign` (`co_financier_id`),
  ADD KEY `published_projects_created_by_foreign` (`created_by`),
  ADD KEY `idx_published_projects_original` (`original_project_id`),
  ADD KEY `idx_published_projects_financier` (`financiers_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `specific_objectives`
--
ALTER TABLE `specific_objectives`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `action_lines`
--
ALTER TABLE `action_lines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT de la tabla `activities`
--
ALTER TABLE `activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de la tabla `activity_calendars`
--
ALTER TABLE `activity_calendars`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT de la tabla `activity_files`
--
ALTER TABLE `activity_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `axes`
--
ALTER TABLE `axes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `components`
--
ALTER TABLE `components`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT de la tabla `data_publications`
--
ALTER TABLE `data_publications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `financiers`
--
ALTER TABLE `financiers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `goals`
--
ALTER TABLE `goals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `kpis`
--
ALTER TABLE `kpis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT de la tabla `planned_metrics`
--
ALTER TABLE `planned_metrics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `polygons`
--
ALTER TABLE `polygons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `programs`
--
ALTER TABLE `programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `program_indicators`
--
ALTER TABLE `program_indicators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `project_disbursements`
--
ALTER TABLE `project_disbursements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `project_reports`
--
ALTER TABLE `project_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `published_activities`
--
ALTER TABLE `published_activities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `published_metrics`
--
ALTER TABLE `published_metrics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `published_projects`
--
ALTER TABLE `published_projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `specific_objectives`
--
ALTER TABLE `specific_objectives`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `activity_calendars`
--
ALTER TABLE `activity_calendars`
  ADD CONSTRAINT `activity_calendars_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `activity_files`
--
ALTER TABLE `activity_files`
  ADD CONSTRAINT `activity_files_activity_calendar_id_foreign` FOREIGN KEY (`activity_calendar_id`) REFERENCES `activity_calendars` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `data_publications`
--
ALTER TABLE `data_publications`
  ADD CONSTRAINT `data_publications_published_by_foreign` FOREIGN KEY (`published_by`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `goals`
--
ALTER TABLE `goals`
  ADD CONSTRAINT `goals_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `published_activities`
--
ALTER TABLE `published_activities`
  ADD CONSTRAINT `published_activities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `published_activities_goals_id_foreign` FOREIGN KEY (`goals_id`) REFERENCES `goals` (`id`),
  ADD CONSTRAINT `published_activities_original_activity_id_foreign` FOREIGN KEY (`original_activity_id`) REFERENCES `activities` (`id`),
  ADD CONSTRAINT `published_activities_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `published_activities_specific_objective_id_foreign` FOREIGN KEY (`specific_objective_id`) REFERENCES `specific_objectives` (`id`);

--
-- Filtros para la tabla `published_metrics`
--
ALTER TABLE `published_metrics`
  ADD CONSTRAINT `published_metrics_activity_id_foreign` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`),
  ADD CONSTRAINT `published_metrics_original_metric_id_foreign` FOREIGN KEY (`original_metric_id`) REFERENCES `planned_metrics` (`id`),
  ADD CONSTRAINT `published_metrics_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `published_projects`
--
ALTER TABLE `published_projects`
  ADD CONSTRAINT `published_projects_co_financier_id_foreign` FOREIGN KEY (`co_financier_id`) REFERENCES `financiers` (`id`),
  ADD CONSTRAINT `published_projects_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `published_projects_financiers_id_foreign` FOREIGN KEY (`financiers_id`) REFERENCES `financiers` (`id`),
  ADD CONSTRAINT `published_projects_original_project_id_foreign` FOREIGN KEY (`original_project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `published_projects_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

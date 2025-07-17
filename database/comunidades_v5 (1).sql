-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 17, 2025 at 06:37 PM
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
-- Database: `comunidades_v5`
--

-- --------------------------------------------------------

--
-- Table structure for table `action_lines`
--

CREATE TABLE `action_lines` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `program_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `action_lines`
--

INSERT INTO `action_lines` (`id`, `name`, `program_id`, `created_at`, `updated_at`) VALUES
(1, 'Linea de acción 1', 1, '2025-07-17 20:25:24', '2025-07-17 20:25:24'),
(2, 'Linea de accion 2', 4, '2025-07-17 20:25:35', '2025-07-17 20:25:35'),
(3, 'Linea de accion 3', 2, '2025-07-17 20:25:45', '2025-07-17 20:25:45'),
(4, 'Linea de accion 4', 3, '2025-07-17 20:25:58', '2025-07-17 20:25:58');

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `specific_objective_id` bigint UNSIGNED NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `goals_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `name`, `specific_objective_id`, `description`, `goals_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Actividad 1', 2, 'Actividad 1 Descripcion', 2, 1, '2025-07-17 21:02:27', '2025-07-18 00:00:15');

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
  `address_backup` text COLLATE utf8mb4_unicode_ci,
  `last_modified` timestamp NULL DEFAULT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT '0',
  `change_reason` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `asigned_person` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_calendars`
--

INSERT INTO `activity_calendars` (`id`, `activity_id`, `start_date`, `end_date`, `start_hour`, `end_hour`, `address_backup`, `last_modified`, `cancelled`, `change_reason`, `created_by`, `asigned_person`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-07-18', '2025-07-18', '10:09:54', '11:09:59', NULL, NULL, 0, NULL, 1, 2, '2025-07-17 22:10:14', '2025-07-17 22:10:14'),
(2, 1, '2025-07-18', '2025-07-19', '10:13:28', '10:13:31', NULL, NULL, 0, NULL, 1, 2, '2025-07-17 22:13:42', '2025-07-17 22:13:42');

-- --------------------------------------------------------

--
-- Table structure for table `activity_files`
--

CREATE TABLE `activity_files` (
  `id` bigint UNSIGNED NOT NULL,
  `month` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` text COLLATE utf8mb4_unicode_ci,
  `upload_date` timestamp NULL DEFAULT NULL,
  `activity_progress_log_id` bigint UNSIGNED NOT NULL,
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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `axes`
--

CREATE TABLE `axes` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `axes`
--

INSERT INTO `axes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Eje 1', '2025-07-17 20:19:27', '2025-07-17 20:19:27'),
(2, 'Eje 2', '2025-07-17 20:20:00', '2025-07-17 20:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `beneficiaries`
--

CREATE TABLE `beneficiaries` (
  `id` bigint UNSIGNED NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_last_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_names` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_year` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('M','F','Male','Female') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_backup` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `beneficiary_registries`
--

CREATE TABLE `beneficiary_registries` (
  `id` bigint UNSIGNED NOT NULL,
  `activity_calendar_id` bigint UNSIGNED NOT NULL,
  `beneficiaries_id` bigint UNSIGNED NOT NULL,
  `data_collectors_id` bigint UNSIGNED NOT NULL,
  `signature` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3', 'i:1;', 1752761527),
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer', 'i:1752761527;', 1752761527);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `components`
--

CREATE TABLE `components` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_lines_id` bigint UNSIGNED NOT NULL,
  `action_lines_program_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `components`
--

INSERT INTO `components` (`id`, `name`, `action_lines_id`, `action_lines_program_id`, `created_at`, `updated_at`) VALUES
(1, 'Componente 1', 1, 1, '2025-07-17 20:28:25', '2025-07-17 20:28:25'),
(2, 'Componente 2', 2, 4, '2025-07-17 20:28:53', '2025-07-17 20:28:53'),
(3, 'Componente 3', 3, 2, '2025-07-17 20:29:06', '2025-07-17 20:29:06'),
(4, 'Componente 4', 4, 3, '2025-07-17 20:29:19', '2025-07-17 20:29:19');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `financiers`
--

CREATE TABLE `financiers` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financiers`
--

INSERT INTO `financiers` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Financiera 1', '2025-07-17 04:41:36', '2025-07-17 04:41:36'),
(2, 'Financiera 2', '2025-07-17 20:36:40', '2025-07-17 20:36:40');

-- --------------------------------------------------------

--
-- Table structure for table `goals`
--

CREATE TABLE `goals` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
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

INSERT INTO `goals` (`id`, `description`, `number`, `components_id`, `components_action_lines_id`, `components_action_lines_program_id`, `organizations_id`, `created_at`, `updated_at`) VALUES
(1, 'Meta 1', 1, 1, 1, 1, 1, '2025-07-17 20:34:30', '2025-07-17 20:34:30'),
(2, 'Meta 2', 2, 2, 2, 2, 2, '2025-07-17 20:34:49', '2025-07-17 20:34:49');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
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
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `initial_value` decimal(10,2) DEFAULT NULL,
  `final_value` decimal(10,2) DEFAULT NULL,
  `projects_id` bigint UNSIGNED NOT NULL,
  `is_percentage` tinyint(1) DEFAULT NULL,
  `org_area` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kpis`
--

INSERT INTO `kpis` (`id`, `name`, `description`, `initial_value`, `final_value`, `projects_id`, `is_percentage`, `org_area`, `created_at`, `updated_at`) VALUES
(1, 'KPI 1', 'KPI 1', 100.00, 1000.00, 1, 0, 'Mejora Continua', '2025-07-17 20:55:22', '2025-07-17 20:55:22'),
(2, 'KPI 2', 'KPI 2', 10.00, 100.00, 2, 1, 'Red de Vecinos', '2025-07-17 20:56:54', '2025-07-17 20:56:54');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` text COLLATE utf8mb4_unicode_ci,
  `neighborhood` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext_number` int DEFAULT NULL,
  `int_number` int DEFAULT NULL,
  `google_place_id` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `polygons_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `category`, `street`, `neighborhood`, `ext_number`, `int_number`, `google_place_id`, `polygons_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Ubicación 1', 'Categoria 1', 'Calle Cebada 7970\nColonia el granjero', 'Colonia 1', 1234, NULL, NULL, 1, 1, '2025-07-17 21:52:03', '2025-07-17 21:58:17');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(35, '0001_01_01_000000_create_users_table', 1),
(36, '0001_01_01_000001_create_cache_table', 1),
(37, '0001_01_01_000002_create_jobs_table', 1),
(38, '2025_07_16_210907_create_organizations_table', 1),
(39, '2025_07_16_210908_add_fields_to_users_table', 1),
(40, '2025_07_16_215251_create_axes_table', 1),
(41, '2025_07_16_215252_create_programs_table', 1),
(42, '2025_07_16_215253_create_action_lines_table', 1),
(43, '2025_07_16_215255_create_components_table', 1),
(44, '2025_07_16_215256_create_financiers_table', 1),
(45, '2025_07_16_215257_create_projects_table', 1),
(46, '2025_07_16_215258_create_kpis_table', 1),
(47, '2025_07_16_215259_create_program_indicators_table', 1),
(48, '2025_07_16_215300_create_specific_objectives_table', 1),
(49, '2025_07_16_215301_create_goals_table', 1),
(50, '2025_07_16_215302_create_activities_table', 1),
(51, '2025_07_16_215303_create_polygons_table', 1),
(52, '2025_07_16_215304_create_locations_table', 1),
(53, '2025_07_16_215305_create_activity_calendars_table', 1),
(54, '2025_07_16_215306_create_beneficiaries_table', 1),
(55, '2025_07_16_215307_create_beneficiary_registries_table', 1),
(56, '2025_07_16_215308_create_planned_metrics_table', 1),
(57, '2025_07_16_215309_create_activity_logs_table', 1),
(58, '2025_07_16_215310_create_project_reports_table', 1),
(59, '2025_07_16_215311_create_project_disbursements_table', 1),
(60, '2025_07_16_215312_create_activity_files_table', 1),
(61, '2025_07_17_020936_remove_belongs_to_from_programs_table', 2),
(62, '2025_07_17_023202_remove_belongs_to_from_action_lines_table', 2),
(63, '2025_07_17_023755_remove_belongs_to_from_components_table', 2),
(64, '2025_07_17_024029_remove_belongs_to_from_program_indicators_table', 2),
(65, '2025_07_17_024446_remove_belongs_to_from_goals_table', 2),
(66, '2025_07_17_025619_remove_belongs_to_from_projects_table', 2),
(67, '2025_07_17_031121_remove_belongs_to_from_kpis_table', 2),
(68, '2025_07_17_032039_remove_belongs_to_from_specific_objectives_table', 2),
(69, '2025_07_17_032352_remove_belongs_to_from_activities_table', 2),
(70, '2025_07_17_033218_remove_belongs_to_from_planned_metrics_table', 2),
(71, '2025_07_17_150803_make_activity_progress_log_id_nullable_in_planned_metrics_table', 3),
(72, '2025_07_17_153115_remove_belongs_to_from_locations_table', 4),
(73, '2025_07_17_160512_remove_belongsto_from_activity_calendars_table', 5),
(74, '2025_07_17_164522_remove_signature_from_beneficiaries_table', 6),
(75, '2025_07_17_171444_add_signature_to_beneficiaries_table', 7),
(76, '2025_07_17_172043_remove_belongsto_from_beneficiaries_table', 8),
(77, '2025_07_17_172120_remove_belongsto_from_beneficiary_registries_table', 8),
(78, '2025_07_17_173117_remove_belongsto_from_activity_logs_table', 9),
(79, '2025_07_17_173131_remove_belongsto_from_activity_files_table', 9),
(80, '2025_07_17_175856_add_name_to_activities_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Organización 1', '2025-07-17 04:41:20', '2025-07-17 04:41:20'),
(2, 'Organización 2', '2025-07-17 20:33:55', '2025-07-17 20:33:55');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `planned_metrics`
--

CREATE TABLE `planned_metrics` (
  `id` bigint UNSIGNED NOT NULL,
  `activity_id` bigint UNSIGNED NOT NULL,
  `unit` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `population_target_value` decimal(10,2) DEFAULT NULL,
  `population_real_value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `product_target_value` decimal(10,2) DEFAULT NULL,
  `product_real_value` decimal(10,2) DEFAULT NULL,
  `activity_progress_log_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `planned_metrics`
--

INSERT INTO `planned_metrics` (`id`, `activity_id`, `unit`, `year`, `month`, `population_target_value`, `population_real_value`, `product_target_value`, `product_real_value`, `activity_progress_log_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'Población', 2015, 12, 100.00, 50.00, NULL, NULL, NULL, '2025-07-17 21:09:09', '2025-07-17 21:09:09');

-- --------------------------------------------------------

--
-- Table structure for table `polygons`
--

CREATE TABLE `polygons` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `polygons`
--

INSERT INTO `polygons` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Poligono 1', 'Es un Ejemplo', '2025-07-17 04:41:50', '2025-07-17 04:42:22');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `id` bigint UNSIGNED NOT NULL,
  `axes_id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`id`, `axes_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'Programa 1', '2025-07-17 20:22:05', '2025-07-17 20:22:05'),
(2, 2, 'Programa 2', '2025-07-17 20:22:21', '2025-07-17 20:22:21'),
(3, 1, 'Programa 2', '2025-07-17 20:22:45', '2025-07-17 20:22:45'),
(4, 2, 'Programa 1', '2025-07-17 20:22:57', '2025-07-17 20:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `program_indicators`
--

CREATE TABLE `program_indicators` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `initial_value` decimal(10,2) DEFAULT NULL,
  `final_value` decimal(10,2) DEFAULT NULL,
  `program_id` bigint UNSIGNED NOT NULL,
  `program_axes_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `program_indicators`
--

INSERT INTO `program_indicators` (`id`, `name`, `description`, `initial_value`, `final_value`, `program_id`, `program_axes_id`, `created_at`, `updated_at`) VALUES
(1, 'Indicador de programa 1', 'Dexcripcion de indicador de programa 1', 10.00, 100.00, 1, 1, '2025-07-17 20:31:38', '2025-07-17 20:31:38'),
(2, 'Indicador de programa 2', 'Descripción indicador de programa 2', 20.00, 200.00, 4, 1, '2025-07-17 20:32:12', '2025-07-17 20:32:12'),
(3, 'Indicador de programa 3', 'Indicador de programa 3', 30.00, 300.00, 2, 2, '2025-07-17 20:32:35', '2025-07-17 20:32:35'),
(4, 'Indicador de programa 4', 'Indicador de programa 4', 40.00, 400.00, 3, 2, '2025-07-17 20:32:55', '2025-07-17 20:32:55');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `background` text COLLATE utf8mb4_unicode_ci,
  `justification` text COLLATE utf8mb4_unicode_ci,
  `general_objective` text COLLATE utf8mb4_unicode_ci,
  `financiers_id` bigint UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `funded_amount` double DEFAULT NULL,
  `cofunding_amount` double DEFAULT NULL,
  `monthly_disbursement` double DEFAULT NULL,
  `followup_officer` text COLLATE utf8mb4_unicode_ci,
  `agreement_file` text COLLATE utf8mb4_unicode_ci,
  `project_base_file` text COLLATE utf8mb4_unicode_ci,
  `co_financier_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `background`, `justification`, `general_objective`, `financiers_id`, `start_date`, `end_date`, `total_cost`, `funded_amount`, `cofunding_amount`, `monthly_disbursement`, `followup_officer`, `agreement_file`, `project_base_file`, `co_financier_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Proyecto 1', NULL, NULL, NULL, 2, '2025-08-01', '2026-08-01', 1000000, 750000, 250000, 50000, NULL, NULL, NULL, 1, 1, '2025-07-17 20:38:21', '2025-07-17 20:38:21'),
(2, 'Proyecto 2', NULL, NULL, NULL, 1, '2025-07-30', '2025-09-30', 2000000, 2000000, 0, 10000, NULL, NULL, NULL, NULL, 1, '2025-07-17 20:41:21', '2025-07-17 20:41:21');

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
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_reports`
--

CREATE TABLE `project_reports` (
  `id` bigint UNSIGNED NOT NULL,
  `report_date` date DEFAULT NULL,
  `report_file` text COLLATE utf8mb4_unicode_ci,
  `projects_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('kx4Vzy4x2zs1pYEdbutBfLFrjDw4rX1exkjPdb7K', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiSFJhNkRDWHVHa0Rlc1UxMzJiZjlDTVhxSVU3dWxZcDloczBiSWlRRyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM5OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYWRtaW4vYWN0aXZpZGFkZXMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkZTFCOEtzcVdsR1c3UHRnYm1ZMWxlZUlYb21Lb3NPU09YY2o1Wk5nL3U1TWxPUjdjd2FvcksiO3M6ODoiZmlsYW1lbnQiO2E6MDp7fX0=', 1752776696);

-- --------------------------------------------------------

--
-- Table structure for table `specific_objectives`
--

CREATE TABLE `specific_objectives` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `projects_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `specific_objectives`
--

INSERT INTO `specific_objectives` (`id`, `description`, `projects_id`, `created_at`, `updated_at`) VALUES
(1, 'Objetivo Especifico 1', 1, '2025-07-17 21:00:41', '2025-07-17 21:00:41'),
(2, 'Objetivo Especifico 2', 2, '2025-07-17 21:01:00', '2025-07-17 21:01:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `point_of_contact_id` bigint UNSIGNED DEFAULT NULL,
  `phone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `org_role` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organizations_id` bigint UNSIGNED DEFAULT NULL,
  `org_area` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `point_of_contact_id`, `phone`, `org_role`, `organizations_id`, `org_area`) VALUES
(1, 'David García', 'dgarcia@planjuarez.org', NULL, '$2y$12$e1B8KsqWlGW7PtgbmY1leeIXomKosOSOXcj5ZNg/u5MlOR7cwaorK', NULL, '2025-07-17 04:18:47', '2025-07-17 04:45:43', NULL, '6562786534', 'Desarrollador', 1, 'Mejora Continua'),
(2, 'Capturista', 'capturista@test.com', NULL, '$2y$12$M.FASMD4iDiOUawH77oOIOLjm3k6VrfnJG1mQ8662VSJJaY4TWTHm', NULL, '2025-07-17 04:51:11', '2025-07-17 04:51:11', 1, NULL, 'Promotor', 1, 'Red de Vecinos');

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activity_calendars`
--
ALTER TABLE `activity_calendars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activity_files`
--
ALTER TABLE `activity_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `axes`
--
ALTER TABLE `axes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `planned_metrics`
--
ALTER TABLE `planned_metrics`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `action_lines`
--
ALTER TABLE `action_lines`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `activity_calendars`
--
ALTER TABLE `activity_calendars`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `activity_files`
--
ALTER TABLE `activity_files`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `axes`
--
ALTER TABLE `axes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `components`
--
ALTER TABLE `components`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `financiers`
--
ALTER TABLE `financiers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `goals`
--
ALTER TABLE `goals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kpis`
--
ALTER TABLE `kpis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `planned_metrics`
--
ALTER TABLE `planned_metrics`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `polygons`
--
ALTER TABLE `polygons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `program_indicators`
--
ALTER TABLE `program_indicators`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `project_disbursements`
--
ALTER TABLE `project_disbursements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_reports`
--
ALTER TABLE `project_reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specific_objectives`
--
ALTER TABLE `specific_objectives`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 17, 2025 at 03:41 AM
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
(1, 'Linea de accion 1', 1, '2025-07-17 08:34:21', '2025-07-17 08:34:21'),
(2, 'Linea de accion 2', 2, '2025-07-17 08:34:35', '2025-07-17 08:34:35');

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` bigint UNSIGNED NOT NULL,
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

INSERT INTO `activities` (`id`, `specific_objective_id`, `description`, `goals_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'Actividad 1 descripcion', 1, 1, '2025-07-17 09:25:15', '2025-07-17 09:25:15');

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
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
(1, 'Eje 1', '2025-07-17 08:06:34', '2025-07-17 08:06:34'),
(2, 'Eje 2', '2025-07-17 08:06:42', '2025-07-17 08:06:42');

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
  `signature` text COLLATE utf8mb4_unicode_ci,
  `address_backup` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `created_by` bigint UNSIGNED NOT NULL,
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3', 'i:1;', 1752717481),
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer', 'i:1752717481;', 1752717481);

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
(1, 'Componente 1', 1, 1, '2025-07-17 08:38:52', '2025-07-17 08:38:52'),
(2, 'Componente 2', 2, 2, '2025-07-17 08:39:06', '2025-07-17 08:39:06'),
(3, 'Componente 3', 1, 2, '2025-07-17 08:39:17', '2025-07-17 08:39:17'),
(4, 'Componente 4', 2, 1, '2025-07-17 08:39:28', '2025-07-17 08:39:28');

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
(1, 'Financiera 1', '2025-07-17 07:52:07', '2025-07-17 07:52:07'),
(2, 'Financiera 2', '2025-07-17 07:52:17', '2025-07-17 07:52:17');

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
(1, 'Meta 1 Descripcion', 1, 1, 1, 1, 1, '2025-07-17 08:45:55', '2025-07-17 08:45:55'),
(2, 'Meta 2 Descripcion', 2, 2, 2, 2, 2, '2025-07-17 08:46:16', '2025-07-17 08:46:16');

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
(1, 'KPI 1', 'KPI 1 descripcion', 10.00, 100.00, 1, 1, 'Mejora Continua', '2025-07-17 09:13:13', '2025-07-17 09:13:13');

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
  `belongsTo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(27, '2025_07_17_020936_remove_belongs_to_from_programs_table', 2),
(28, '2025_07_17_023202_remove_belongs_to_from_action_lines_table', 3),
(29, '2025_07_17_023755_remove_belongs_to_from_components_table', 4),
(30, '2025_07_17_024029_remove_belongs_to_from_program_indicators_table', 5),
(31, '2025_07_17_024446_remove_belongs_to_from_goals_table', 6),
(32, '2025_07_17_025619_remove_belongs_to_from_projects_table', 7),
(33, '2025_07_17_031121_remove_belongs_to_from_kpis_table', 8),
(34, '2025_07_17_032039_remove_belongs_to_from_specific_objectives_table', 9),
(35, '2025_07_17_032352_remove_belongs_to_from_activities_table', 10),
(36, '2025_07_17_033218_remove_belongs_to_from_planned_metrics_table', 11);

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
(1, 'Organizacion 1', '2025-07-17 07:53:42', '2025-07-17 07:53:42'),
(2, 'Organizacion 2', '2025-07-17 07:53:58', '2025-07-17 07:53:58');

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
  `activity_progress_log_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'Poligono 1', 'Poligono 1 descripcion', '2025-07-17 07:54:31', '2025-07-17 07:54:31'),
(2, 'Poligono 2', 'Poligono 2 descripcion', '2025-07-17 07:55:18', '2025-07-17 07:55:18');

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
(1, 1, 'Programa 1', '2025-07-17 08:11:24', '2025-07-17 08:11:24'),
(2, 2, 'Programa 2', '2025-07-17 08:11:37', '2025-07-17 08:11:37');

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
(1, 'Indicador de Programa 1', 'Indicador de programa 1 descripcion ', 10.00, 100.00, 1, 1, '2025-07-17 08:43:18', '2025-07-17 08:43:18'),
(2, 'Indicador de programa 2', 'Indicador de programa 2 descripcion', 20.00, 200.00, 2, 2, '2025-07-17 08:43:45', '2025-07-17 08:43:45');

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
(1, 'Proyecto 1', 'Proyecto 1 Trasfondo', 'Proyecto 1 Justificacion', 'Proyecto 1 Objetivo General', 1, '2025-08-01', '2026-08-01', 1000000, 250000, 750000, 200000, NULL, NULL, NULL, 2, 1, '2025-07-17 09:01:00', '2025-07-17 09:06:47');

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
('5MW5X16bJct5oxqZSa40FitYjt4l9fuNzmXI6jjh', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo4OntzOjM6InVybCI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9wcm95ZWN0b3MvMS9lZGl0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo2OiJfdG9rZW4iO3M6NDA6Im5DbXhoblNwQlZlWUNJQXExT1Y2Vzg3Z042cjRhcE5aS1RFeGg1MG0iO3M6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRmQzA1M2ZLSXN5UTNvRy9rVlhTN3FPU2FkSE9Bc01lZnR1ay56b0J5cmtBL3h0RDFNWlE5SyI7czo4OiJmaWxhbWVudCI7YTowOnt9czo2OiJ0YWJsZXMiO2E6MTp7czo0ODoiNDU0NTc3ZmUxZTFiOTZlM2ZlNmMyZGE3NWM3MTI4ODRfdG9nZ2xlZF9jb2x1bW5zIjthOjI6e3M6MTA6ImNyZWF0ZWRfYXQiO2I6MTtzOjEwOiJ1cGRhdGVkX2F0IjtiOjA7fX19', 1752723635),
('NER8EBLyTXrNUltSTCJV7wdNtbYEUjdrnadp936P', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaGpFZHZ6cmZrYXJEQjg5VmhvbGtObTh1NVJLT0tpYXBsNEJVZzhVUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752716950);

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
(1, 'Objetivo Especifico 1 descripcion', 1, '2025-07-17 09:22:37', '2025-07-17 09:22:37');

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
(1, 'David Garcia', 'dgarcia@planjuarez.org', NULL, '$2y$12$fC053fKIsyQ3oG/kVXS7qOSadHOAsMeftuk.zoByrkA/xtD1MZQ9K', NULL, '2025-07-17 07:48:18', '2025-07-17 07:56:38', NULL, '6562786534', 'Desarrollador', 1, 'Mejora Continua'),
(2, 'Capturista', 'capturista@test.com', NULL, '$2y$12$9GZYBN88LJykzffA1ftobefmVGjyJfG/a.7Tvaz2mrqNnzrtVoJXO', NULL, '2025-07-17 08:00:48', '2025-07-17 08:00:48', 1, '0001234567', 'Promotor Comunitario', 2, 'Red de Vecinos');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `activity_calendars`
--
ALTER TABLE `activity_calendars`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `planned_metrics`
--
ALTER TABLE `planned_metrics`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `polygons`
--
ALTER TABLE `polygons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `program_indicators`
--
ALTER TABLE `program_indicators`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

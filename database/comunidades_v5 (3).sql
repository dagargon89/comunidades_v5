-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 21, 2025 at 06:34 PM
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
(1, 'Actividad 1', 2, 'Actividad 1 Descripcion', 2, 1, '2025-07-17 21:02:27', '2025-07-18 22:17:02'),
(2, 'Actividad 2', 2, 'Dexripcion actividad 2', 2, 2, '2025-07-18 00:45:40', '2025-07-18 22:17:15');

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
(2, 1, '2025-07-18', '2025-07-19', '10:13:28', '10:13:31', NULL, NULL, 0, NULL, 1, 2, '2025-07-17 22:13:42', '2025-07-17 22:13:42'),
(3, 2, '2025-07-26', '2025-07-26', '16:13:06', '18:13:10', NULL, NULL, 0, NULL, 2, 1, '2025-07-18 04:13:22', '2025-07-18 04:13:22');

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
  `activity_calendar_id` bigint UNSIGNED DEFAULT NULL,
  `activity_log_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_files`
--

INSERT INTO `activity_files` (`id`, `month`, `type`, `file_path`, `upload_date`, `activity_progress_log_id`, `activity_calendar_id`, `activity_log_id`, `created_at`, `updated_at`) VALUES
(1, 'Jul', 'PNG', 'activity-files/nueva estructura de bbdd.png', '2025-07-18 04:39:26', 1, NULL, 1, '2025-07-18 04:39:26', '2025-07-18 04:39:26'),
(2, 'Julio', 'PDF', 'activity-files/diagnostico_problematicas_OSC.pdf', '2025-07-18 04:39:26', 1, NULL, 1, '2025-07-18 04:39:26', '2025-07-18 04:39:26'),
(3, 'Julio', 'PNG', 'activity-files/nueva estructura de bbdd.png', '2025-07-18 04:47:28', 1, NULL, 1, '2025-07-18 04:47:28', '2025-07-18 04:47:28'),
(4, 'Julio', 'PDF', 'activity-files/diagnostico_problematicas_OSC.pdf', '2025-07-18 04:47:28', 1, NULL, 1, '2025-07-18 04:47:28', '2025-07-18 04:47:28');

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

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `planned_metrics_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-07-18 04:39:26', '2025-07-18 04:39:26');

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
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `beneficiaries`
--

INSERT INTO `beneficiaries` (`id`, `last_name`, `mother_last_name`, `first_names`, `birth_year`, `gender`, `phone`, `address_backup`, `identifier`, `created_by`, `created_at`, `updated_at`) VALUES
(3, 'Paterno 1', 'Materno 1', 'Nombre 1', '2000', 'Male', '0001234567', NULL, NULL, 1, '2025-07-18 03:08:10', '2025-07-18 03:08:10'),
(4, 'Paterno 2', 'Materno 2', 'Nombre 2', '1989', 'F', '0001234567', NULL, NULL, 1, '2025-07-18 04:14:59', '2025-07-18 04:14:59'),
(5, 'Paterno 3', 'Materno 3', 'Nombre 3', '2011', 'F', '0001234567', NULL, NULL, 1, '2025-07-18 04:14:59', '2025-07-18 04:14:59'),
(6, 'sad', 'sds', 'dsdsds', '1987', 'M', '0001234567', NULL, 'SSDX1987MADS', 1, '2025-07-18 22:20:48', '2025-07-18 22:20:48');

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

--
-- Dumping data for table `beneficiary_registries`
--

INSERT INTO `beneficiary_registries` (`id`, `activity_calendar_id`, `beneficiaries_id`, `data_collectors_id`, `signature`, `created_by`, `created_at`, `updated_at`) VALUES
(3, 1, 3, 1, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA1AAAACQCAYAAAAGG4oYAAAAAXNSR0IArs4c6QAAGUVJREFUeF7t3XmsbVV9B/CvQx1ABUVUSrWl2jqgVUQFVJB5koIgiiBGGusf1kbTak3a2lRN2ooxlbZWrVIVUVHBERQQRCa1isog1OJQR0BRQYWCRtHuX7Neenu8t2+/+86wzzmfndy8l3f3WXutz9oh58da6/e7XVwECBAgQIAAAQIECBAg0Evgdr3uchMBAgQIECBAgAABAgQIRADlJSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQIECBAgEBPAQFUTyi3ESBAgAABAgQIECBAQADlHSBAgAABAgQI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', 1, '2025-07-18 03:08:10', '2025-07-18 22:17:35'),
(4, 2, 3, 1, NULL, 1, '2025-07-18 03:48:44', '2025-07-18 03:48:44'),
(5, 3, 4, 1, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA1AAAACQCAYAAAAGG4oYAAAAAXNSR0IArs4c6QAAGdpJREFUeF7t3QewZUlZB/APSatEyUsOu4QlChJcYEGQ5EKJSBQRCSKCIIJgFVikIggL6gqIIEEQEUGw2CUHSYqAomQEhSULCgIuuBLX88e+eOpx38x58+570/fcX1dNzbyZc/t2//q8N/c73f31GUohQIAAAQIECBAgQIAAgUkCZ5h0lYsIECBAgAABAgQIECBAoARQbgICBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECBAgQIECAAAECBARQ7gECBAgQIECAAAECBAhMFBBATYRyGQECaydw4aHFj6yqX97S8o9V1ber6utVddaqunhVnaOq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', 1, '2025-07-18 04:14:59', '2025-07-18 22:13:14'),
(6, 3, 5, 1, NULL, 1, '2025-07-18 04:14:59', '2025-07-18 04:21:03'),
(7, 2, 6, 1, 'data:image/png;base64,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', 1, '2025-07-18 22:20:48', '2025-07-18 22:20:48');

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
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3', 'i:1;', 1753116261),
('comunidades-v5-cache-livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer', 'i:1753116261;', 1753116261),
('comunidades-v5-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:333:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:9:\"view_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:13:\"view_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:11:\"create_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:11:\"update_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:15:\"delete_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:17:\"view_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:21:\"view_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:19:\"create_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:19:\"update_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:20:\"restore_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:24:\"restore_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:22:\"replicate_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:20:\"reorder_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:19:\"delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:23:\"delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:25:\"force_delete_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:29:\"force_delete_any_action::line\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:13:\"view_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:17:\"view_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:15:\"create_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:15:\"update_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:16:\"restore_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:20:\"restore_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:18:\"replicate_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:16:\"reorder_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:15:\"delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:19:\"delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:21:\"force_delete_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:25:\"force_delete_any_activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:23:\"view_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:27:\"view_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:25:\"create_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:25:\"update_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:26:\"restore_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:30:\"restore_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:28:\"replicate_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:26:\"reorder_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:25:\"delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:29:\"delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:31:\"force_delete_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:35:\"force_delete_any_activity::calendar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:19:\"view_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:23:\"view_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:21:\"create_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:21:\"update_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:22:\"restore_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:26:\"restore_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:24:\"replicate_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:22:\"reorder_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:21:\"delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:25:\"delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:27:\"force_delete_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:31:\"force_delete_any_activity::file\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:18:\"view_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:22:\"view_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:20:\"create_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:20:\"update_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:21:\"restore_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:25:\"restore_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:23:\"replicate_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:21:\"reorder_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:20:\"delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:24:\"delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:26:\"force_delete_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:30:\"force_delete_any_activity::log\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:8:\"view_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:12:\"view_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:10:\"create_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:10:\"update_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:11:\"restore_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:15:\"restore_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:13:\"replicate_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:73;a:4:{s:1:\"a\";i:74;s:1:\"b\";s:11:\"reorder_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:74;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:10:\"delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:75;a:4:{s:1:\"a\";i:76;s:1:\"b\";s:14:\"delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:76;a:4:{s:1:\"a\";i:77;s:1:\"b\";s:16:\"force_delete_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:4:{s:1:\"a\";i:78;s:1:\"b\";s:20:\"force_delete_any_axe\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:4:{s:1:\"a\";i:79;s:1:\"b\";s:16:\"view_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:4:{s:1:\"a\";i:80;s:1:\"b\";s:20:\"view_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:4:{s:1:\"a\";i:81;s:1:\"b\";s:18:\"create_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:4:{s:1:\"a\";i:82;s:1:\"b\";s:18:\"update_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:4:{s:1:\"a\";i:83;s:1:\"b\";s:19:\"restore_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:4:{s:1:\"a\";i:84;s:1:\"b\";s:23:\"restore_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:21:\"replicate_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:4:{s:1:\"a\";i:86;s:1:\"b\";s:19:\"reorder_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:4:{s:1:\"a\";i:87;s:1:\"b\";s:18:\"delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:4:{s:1:\"a\";i:88;s:1:\"b\";s:22:\"delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:4:{s:1:\"a\";i:89;s:1:\"b\";s:24:\"force_delete_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:28:\"force_delete_any_beneficiary\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:4:{s:1:\"a\";i:91;s:1:\"b\";s:26:\"view_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:4:{s:1:\"a\";i:92;s:1:\"b\";s:30:\"view_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:4:{s:1:\"a\";i:93;s:1:\"b\";s:28:\"create_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:4:{s:1:\"a\";i:94;s:1:\"b\";s:28:\"update_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:4:{s:1:\"a\";i:95;s:1:\"b\";s:29:\"restore_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:4:{s:1:\"a\";i:96;s:1:\"b\";s:33:\"restore_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:4:{s:1:\"a\";i:97;s:1:\"b\";s:31:\"replicate_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:97;a:4:{s:1:\"a\";i:98;s:1:\"b\";s:29:\"reorder_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:98;a:4:{s:1:\"a\";i:99;s:1:\"b\";s:28:\"delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:99;a:4:{s:1:\"a\";i:100;s:1:\"b\";s:32:\"delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:100;a:4:{s:1:\"a\";i:101;s:1:\"b\";s:34:\"force_delete_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:101;a:4:{s:1:\"a\";i:102;s:1:\"b\";s:38:\"force_delete_any_beneficiary::registry\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:102;a:4:{s:1:\"a\";i:103;s:1:\"b\";s:14:\"view_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:103;a:4:{s:1:\"a\";i:104;s:1:\"b\";s:18:\"view_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:104;a:4:{s:1:\"a\";i:105;s:1:\"b\";s:16:\"create_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:105;a:4:{s:1:\"a\";i:106;s:1:\"b\";s:16:\"update_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:106;a:4:{s:1:\"a\";i:107;s:1:\"b\";s:17:\"restore_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:107;a:4:{s:1:\"a\";i:108;s:1:\"b\";s:21:\"restore_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:108;a:4:{s:1:\"a\";i:109;s:1:\"b\";s:19:\"replicate_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:109;a:4:{s:1:\"a\";i:110;s:1:\"b\";s:17:\"reorder_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:110;a:4:{s:1:\"a\";i:111;s:1:\"b\";s:16:\"delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:111;a:4:{s:1:\"a\";i:112;s:1:\"b\";s:20:\"delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:112;a:4:{s:1:\"a\";i:113;s:1:\"b\";s:22:\"force_delete_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:113;a:4:{s:1:\"a\";i:114;s:1:\"b\";s:26:\"force_delete_any_component\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:114;a:4:{s:1:\"a\";i:115;s:1:\"b\";s:14:\"view_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:115;a:4:{s:1:\"a\";i:116;s:1:\"b\";s:18:\"view_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:116;a:4:{s:1:\"a\";i:117;s:1:\"b\";s:16:\"create_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:117;a:4:{s:1:\"a\";i:118;s:1:\"b\";s:16:\"update_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:118;a:4:{s:1:\"a\";i:119;s:1:\"b\";s:17:\"restore_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:119;a:4:{s:1:\"a\";i:120;s:1:\"b\";s:21:\"restore_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:120;a:4:{s:1:\"a\";i:121;s:1:\"b\";s:19:\"replicate_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:121;a:4:{s:1:\"a\";i:122;s:1:\"b\";s:17:\"reorder_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:122;a:4:{s:1:\"a\";i:123;s:1:\"b\";s:16:\"delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:123;a:4:{s:1:\"a\";i:124;s:1:\"b\";s:20:\"delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:124;a:4:{s:1:\"a\";i:125;s:1:\"b\";s:22:\"force_delete_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:125;a:4:{s:1:\"a\";i:126;s:1:\"b\";s:26:\"force_delete_any_financier\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:126;a:4:{s:1:\"a\";i:127;s:1:\"b\";s:9:\"view_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:127;a:4:{s:1:\"a\";i:128;s:1:\"b\";s:13:\"view_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:128;a:4:{s:1:\"a\";i:129;s:1:\"b\";s:11:\"create_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:129;a:4:{s:1:\"a\";i:130;s:1:\"b\";s:11:\"update_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:130;a:4:{s:1:\"a\";i:131;s:1:\"b\";s:12:\"restore_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:131;a:4:{s:1:\"a\";i:132;s:1:\"b\";s:16:\"restore_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:132;a:4:{s:1:\"a\";i:133;s:1:\"b\";s:14:\"replicate_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:133;a:4:{s:1:\"a\";i:134;s:1:\"b\";s:12:\"reorder_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:134;a:4:{s:1:\"a\";i:135;s:1:\"b\";s:11:\"delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:135;a:4:{s:1:\"a\";i:136;s:1:\"b\";s:15:\"delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:136;a:4:{s:1:\"a\";i:137;s:1:\"b\";s:17:\"force_delete_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:137;a:4:{s:1:\"a\";i:138;s:1:\"b\";s:21:\"force_delete_any_goal\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:138;a:4:{s:1:\"a\";i:139;s:1:\"b\";s:8:\"view_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:139;a:4:{s:1:\"a\";i:140;s:1:\"b\";s:12:\"view_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:140;a:4:{s:1:\"a\";i:141;s:1:\"b\";s:10:\"create_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:141;a:4:{s:1:\"a\";i:142;s:1:\"b\";s:10:\"update_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:142;a:4:{s:1:\"a\";i:143;s:1:\"b\";s:11:\"restore_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:143;a:4:{s:1:\"a\";i:144;s:1:\"b\";s:15:\"restore_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:144;a:4:{s:1:\"a\";i:145;s:1:\"b\";s:13:\"replicate_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:145;a:4:{s:1:\"a\";i:146;s:1:\"b\";s:11:\"reorder_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:146;a:4:{s:1:\"a\";i:147;s:1:\"b\";s:10:\"delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:147;a:4:{s:1:\"a\";i:148;s:1:\"b\";s:14:\"delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:148;a:4:{s:1:\"a\";i:149;s:1:\"b\";s:16:\"force_delete_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:149;a:4:{s:1:\"a\";i:150;s:1:\"b\";s:20:\"force_delete_any_kpi\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:150;a:4:{s:1:\"a\";i:151;s:1:\"b\";s:13:\"view_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:151;a:4:{s:1:\"a\";i:152;s:1:\"b\";s:17:\"view_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:152;a:4:{s:1:\"a\";i:153;s:1:\"b\";s:15:\"create_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:153;a:4:{s:1:\"a\";i:154;s:1:\"b\";s:15:\"update_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:154;a:4:{s:1:\"a\";i:155;s:1:\"b\";s:16:\"restore_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:155;a:4:{s:1:\"a\";i:156;s:1:\"b\";s:20:\"restore_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:156;a:4:{s:1:\"a\";i:157;s:1:\"b\";s:18:\"replicate_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:157;a:4:{s:1:\"a\";i:158;s:1:\"b\";s:16:\"reorder_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:158;a:4:{s:1:\"a\";i:159;s:1:\"b\";s:15:\"delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:159;a:4:{s:1:\"a\";i:160;s:1:\"b\";s:19:\"delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:160;a:4:{s:1:\"a\";i:161;s:1:\"b\";s:21:\"force_delete_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:161;a:4:{s:1:\"a\";i:162;s:1:\"b\";s:25:\"force_delete_any_location\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:162;a:4:{s:1:\"a\";i:163;s:1:\"b\";s:17:\"view_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:163;a:4:{s:1:\"a\";i:164;s:1:\"b\";s:21:\"view_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:164;a:4:{s:1:\"a\";i:165;s:1:\"b\";s:19:\"create_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:165;a:4:{s:1:\"a\";i:166;s:1:\"b\";s:19:\"update_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:166;a:4:{s:1:\"a\";i:167;s:1:\"b\";s:20:\"restore_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:167;a:4:{s:1:\"a\";i:168;s:1:\"b\";s:24:\"restore_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:168;a:4:{s:1:\"a\";i:169;s:1:\"b\";s:22:\"replicate_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:169;a:4:{s:1:\"a\";i:170;s:1:\"b\";s:20:\"reorder_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:170;a:4:{s:1:\"a\";i:171;s:1:\"b\";s:19:\"delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:171;a:4:{s:1:\"a\";i:172;s:1:\"b\";s:23:\"delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:172;a:4:{s:1:\"a\";i:173;s:1:\"b\";s:25:\"force_delete_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:173;a:4:{s:1:\"a\";i:174;s:1:\"b\";s:29:\"force_delete_any_organization\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:174;a:4:{s:1:\"a\";i:175;s:1:\"b\";s:20:\"view_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:175;a:4:{s:1:\"a\";i:176;s:1:\"b\";s:24:\"view_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:176;a:4:{s:1:\"a\";i:177;s:1:\"b\";s:22:\"create_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:177;a:4:{s:1:\"a\";i:178;s:1:\"b\";s:22:\"update_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:178;a:4:{s:1:\"a\";i:179;s:1:\"b\";s:23:\"restore_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:179;a:4:{s:1:\"a\";i:180;s:1:\"b\";s:27:\"restore_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:180;a:4:{s:1:\"a\";i:181;s:1:\"b\";s:25:\"replicate_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:181;a:4:{s:1:\"a\";i:182;s:1:\"b\";s:23:\"reorder_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:182;a:4:{s:1:\"a\";i:183;s:1:\"b\";s:22:\"delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:183;a:4:{s:1:\"a\";i:184;s:1:\"b\";s:26:\"delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:184;a:4:{s:1:\"a\";i:185;s:1:\"b\";s:28:\"force_delete_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:185;a:4:{s:1:\"a\";i:186;s:1:\"b\";s:32:\"force_delete_any_planned::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:186;a:4:{s:1:\"a\";i:187;s:1:\"b\";s:12:\"view_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:187;a:4:{s:1:\"a\";i:188;s:1:\"b\";s:16:\"view_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:188;a:4:{s:1:\"a\";i:189;s:1:\"b\";s:14:\"create_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:189;a:4:{s:1:\"a\";i:190;s:1:\"b\";s:14:\"update_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:190;a:4:{s:1:\"a\";i:191;s:1:\"b\";s:15:\"restore_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:191;a:4:{s:1:\"a\";i:192;s:1:\"b\";s:19:\"restore_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:192;a:4:{s:1:\"a\";i:193;s:1:\"b\";s:17:\"replicate_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:193;a:4:{s:1:\"a\";i:194;s:1:\"b\";s:15:\"reorder_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:194;a:4:{s:1:\"a\";i:195;s:1:\"b\";s:14:\"delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:195;a:4:{s:1:\"a\";i:196;s:1:\"b\";s:18:\"delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:196;a:4:{s:1:\"a\";i:197;s:1:\"b\";s:20:\"force_delete_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:197;a:4:{s:1:\"a\";i:198;s:1:\"b\";s:24:\"force_delete_any_polygon\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:198;a:4:{s:1:\"a\";i:199;s:1:\"b\";s:12:\"view_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:199;a:4:{s:1:\"a\";i:200;s:1:\"b\";s:16:\"view_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:200;a:4:{s:1:\"a\";i:201;s:1:\"b\";s:14:\"create_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:201;a:4:{s:1:\"a\";i:202;s:1:\"b\";s:14:\"update_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:202;a:4:{s:1:\"a\";i:203;s:1:\"b\";s:15:\"restore_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:203;a:4:{s:1:\"a\";i:204;s:1:\"b\";s:19:\"restore_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:204;a:4:{s:1:\"a\";i:205;s:1:\"b\";s:17:\"replicate_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:205;a:4:{s:1:\"a\";i:206;s:1:\"b\";s:15:\"reorder_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:206;a:4:{s:1:\"a\";i:207;s:1:\"b\";s:14:\"delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:207;a:4:{s:1:\"a\";i:208;s:1:\"b\";s:18:\"delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:208;a:4:{s:1:\"a\";i:209;s:1:\"b\";s:20:\"force_delete_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:209;a:4:{s:1:\"a\";i:210;s:1:\"b\";s:24:\"force_delete_any_program\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:210;a:4:{s:1:\"a\";i:211;s:1:\"b\";s:23:\"view_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:211;a:4:{s:1:\"a\";i:212;s:1:\"b\";s:27:\"view_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:212;a:4:{s:1:\"a\";i:213;s:1:\"b\";s:25:\"create_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:213;a:4:{s:1:\"a\";i:214;s:1:\"b\";s:25:\"update_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:214;a:4:{s:1:\"a\";i:215;s:1:\"b\";s:26:\"restore_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:215;a:4:{s:1:\"a\";i:216;s:1:\"b\";s:30:\"restore_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:216;a:4:{s:1:\"a\";i:217;s:1:\"b\";s:28:\"replicate_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:217;a:4:{s:1:\"a\";i:218;s:1:\"b\";s:26:\"reorder_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:218;a:4:{s:1:\"a\";i:219;s:1:\"b\";s:25:\"delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:219;a:4:{s:1:\"a\";i:220;s:1:\"b\";s:29:\"delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:220;a:4:{s:1:\"a\";i:221;s:1:\"b\";s:31:\"force_delete_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:221;a:4:{s:1:\"a\";i:222;s:1:\"b\";s:35:\"force_delete_any_program::indicator\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:222;a:4:{s:1:\"a\";i:223;s:1:\"b\";s:12:\"view_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:223;a:4:{s:1:\"a\";i:224;s:1:\"b\";s:16:\"view_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:224;a:4:{s:1:\"a\";i:225;s:1:\"b\";s:14:\"create_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:225;a:4:{s:1:\"a\";i:226;s:1:\"b\";s:14:\"update_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:226;a:4:{s:1:\"a\";i:227;s:1:\"b\";s:15:\"restore_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:227;a:4:{s:1:\"a\";i:228;s:1:\"b\";s:19:\"restore_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:228;a:4:{s:1:\"a\";i:229;s:1:\"b\";s:17:\"replicate_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:229;a:4:{s:1:\"a\";i:230;s:1:\"b\";s:15:\"reorder_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:230;a:4:{s:1:\"a\";i:231;s:1:\"b\";s:14:\"delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:231;a:4:{s:1:\"a\";i:232;s:1:\"b\";s:18:\"delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:232;a:4:{s:1:\"a\";i:233;s:1:\"b\";s:20:\"force_delete_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:233;a:4:{s:1:\"a\";i:234;s:1:\"b\";s:24:\"force_delete_any_project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:234;a:4:{s:1:\"a\";i:235;s:1:\"b\";s:26:\"view_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:235;a:4:{s:1:\"a\";i:236;s:1:\"b\";s:30:\"view_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:236;a:4:{s:1:\"a\";i:237;s:1:\"b\";s:28:\"create_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:237;a:4:{s:1:\"a\";i:238;s:1:\"b\";s:28:\"update_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:238;a:4:{s:1:\"a\";i:239;s:1:\"b\";s:29:\"restore_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:239;a:4:{s:1:\"a\";i:240;s:1:\"b\";s:33:\"restore_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:240;a:4:{s:1:\"a\";i:241;s:1:\"b\";s:31:\"replicate_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:241;a:4:{s:1:\"a\";i:242;s:1:\"b\";s:29:\"reorder_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:242;a:4:{s:1:\"a\";i:243;s:1:\"b\";s:28:\"delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:243;a:4:{s:1:\"a\";i:244;s:1:\"b\";s:32:\"delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:244;a:4:{s:1:\"a\";i:245;s:1:\"b\";s:34:\"force_delete_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:245;a:4:{s:1:\"a\";i:246;s:1:\"b\";s:38:\"force_delete_any_project::disbursement\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:246;a:4:{s:1:\"a\";i:247;s:1:\"b\";s:20:\"view_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:247;a:4:{s:1:\"a\";i:248;s:1:\"b\";s:24:\"view_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:248;a:4:{s:1:\"a\";i:249;s:1:\"b\";s:22:\"create_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:249;a:4:{s:1:\"a\";i:250;s:1:\"b\";s:22:\"update_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:250;a:4:{s:1:\"a\";i:251;s:1:\"b\";s:23:\"restore_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:251;a:4:{s:1:\"a\";i:252;s:1:\"b\";s:27:\"restore_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:252;a:4:{s:1:\"a\";i:253;s:1:\"b\";s:25:\"replicate_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:253;a:4:{s:1:\"a\";i:254;s:1:\"b\";s:23:\"reorder_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:254;a:4:{s:1:\"a\";i:255;s:1:\"b\";s:22:\"delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:255;a:4:{s:1:\"a\";i:256;s:1:\"b\";s:26:\"delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:256;a:4:{s:1:\"a\";i:257;s:1:\"b\";s:28:\"force_delete_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:257;a:4:{s:1:\"a\";i:258;s:1:\"b\";s:32:\"force_delete_any_project::report\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:258;a:4:{s:1:\"a\";i:259;s:1:\"b\";s:24:\"view_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:259;a:4:{s:1:\"a\";i:260;s:1:\"b\";s:28:\"view_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:260;a:4:{s:1:\"a\";i:261;s:1:\"b\";s:26:\"create_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:261;a:4:{s:1:\"a\";i:262;s:1:\"b\";s:26:\"update_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:262;a:4:{s:1:\"a\";i:263;s:1:\"b\";s:27:\"restore_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:263;a:4:{s:1:\"a\";i:264;s:1:\"b\";s:31:\"restore_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:264;a:4:{s:1:\"a\";i:265;s:1:\"b\";s:29:\"replicate_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:265;a:4:{s:1:\"a\";i:266;s:1:\"b\";s:27:\"reorder_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:266;a:4:{s:1:\"a\";i:267;s:1:\"b\";s:26:\"delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:267;a:4:{s:1:\"a\";i:268;s:1:\"b\";s:30:\"delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:268;a:4:{s:1:\"a\";i:269;s:1:\"b\";s:32:\"force_delete_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:269;a:4:{s:1:\"a\";i:270;s:1:\"b\";s:36:\"force_delete_any_specific::objective\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:270;a:4:{s:1:\"a\";i:271;s:1:\"b\";s:9:\"view_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:271;a:4:{s:1:\"a\";i:272;s:1:\"b\";s:13:\"view_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:272;a:4:{s:1:\"a\";i:273;s:1:\"b\";s:11:\"create_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:273;a:4:{s:1:\"a\";i:274;s:1:\"b\";s:11:\"update_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:274;a:4:{s:1:\"a\";i:275;s:1:\"b\";s:12:\"restore_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:275;a:4:{s:1:\"a\";i:276;s:1:\"b\";s:16:\"restore_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:276;a:4:{s:1:\"a\";i:277;s:1:\"b\";s:14:\"replicate_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:277;a:4:{s:1:\"a\";i:278;s:1:\"b\";s:12:\"reorder_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:278;a:4:{s:1:\"a\";i:279;s:1:\"b\";s:11:\"delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:279;a:4:{s:1:\"a\";i:280;s:1:\"b\";s:15:\"delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:280;a:4:{s:1:\"a\";i:281;s:1:\"b\";s:17:\"force_delete_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:281;a:4:{s:1:\"a\";i:282;s:1:\"b\";s:21:\"force_delete_any_user\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:282;a:4:{s:1:\"a\";i:283;s:1:\"b\";s:24:\"page_ActivityFileManager\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:283;a:4:{s:1:\"a\";i:284;s:1:\"b\";s:28:\"page_BeneficiaryRegistryView\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:284;a:4:{s:1:\"a\";i:285;s:1:\"b\";s:25:\"page_ProjectCreationGuide\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:285;a:4:{s:1:\"a\";i:286;s:1:\"b\";s:22:\"view_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:286;a:4:{s:1:\"a\";i:287;s:1:\"b\";s:26:\"view_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:287;a:4:{s:1:\"a\";i:288;s:1:\"b\";s:24:\"create_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:288;a:4:{s:1:\"a\";i:289;s:1:\"b\";s:24:\"update_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:289;a:4:{s:1:\"a\";i:290;s:1:\"b\";s:25:\"restore_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:290;a:4:{s:1:\"a\";i:291;s:1:\"b\";s:29:\"restore_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:291;a:4:{s:1:\"a\";i:292;s:1:\"b\";s:27:\"replicate_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:292;a:4:{s:1:\"a\";i:293;s:1:\"b\";s:25:\"reorder_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:293;a:4:{s:1:\"a\";i:294;s:1:\"b\";s:24:\"delete_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:294;a:4:{s:1:\"a\";i:295;s:1:\"b\";s:28:\"delete_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:295;a:4:{s:1:\"a\";i:296;s:1:\"b\";s:30:\"force_delete_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:296;a:4:{s:1:\"a\";i:297;s:1:\"b\";s:34:\"force_delete_any_data::publication\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:297;a:4:{s:1:\"a\";i:298;s:1:\"b\";s:24:\"view_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:298;a:4:{s:1:\"a\";i:299;s:1:\"b\";s:28:\"view_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:299;a:4:{s:1:\"a\";i:300;s:1:\"b\";s:26:\"create_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:300;a:4:{s:1:\"a\";i:301;s:1:\"b\";s:26:\"update_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:301;a:4:{s:1:\"a\";i:302;s:1:\"b\";s:27:\"restore_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:302;a:4:{s:1:\"a\";i:303;s:1:\"b\";s:31:\"restore_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:303;a:4:{s:1:\"a\";i:304;s:1:\"b\";s:29:\"replicate_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:304;a:4:{s:1:\"a\";i:305;s:1:\"b\";s:27:\"reorder_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:305;a:4:{s:1:\"a\";i:306;s:1:\"b\";s:26:\"delete_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:306;a:4:{s:1:\"a\";i:307;s:1:\"b\";s:30:\"delete_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:307;a:4:{s:1:\"a\";i:308;s:1:\"b\";s:32:\"force_delete_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:308;a:4:{s:1:\"a\";i:309;s:1:\"b\";s:36:\"force_delete_any_published::activity\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:309;a:4:{s:1:\"a\";i:310;s:1:\"b\";s:22:\"view_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:310;a:4:{s:1:\"a\";i:311;s:1:\"b\";s:26:\"view_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:311;a:4:{s:1:\"a\";i:312;s:1:\"b\";s:24:\"create_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:312;a:4:{s:1:\"a\";i:313;s:1:\"b\";s:24:\"update_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:313;a:4:{s:1:\"a\";i:314;s:1:\"b\";s:25:\"restore_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:314;a:4:{s:1:\"a\";i:315;s:1:\"b\";s:29:\"restore_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:315;a:4:{s:1:\"a\";i:316;s:1:\"b\";s:27:\"replicate_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:316;a:4:{s:1:\"a\";i:317;s:1:\"b\";s:25:\"reorder_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:317;a:4:{s:1:\"a\";i:318;s:1:\"b\";s:24:\"delete_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:318;a:4:{s:1:\"a\";i:319;s:1:\"b\";s:28:\"delete_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:319;a:4:{s:1:\"a\";i:320;s:1:\"b\";s:30:\"force_delete_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:320;a:4:{s:1:\"a\";i:321;s:1:\"b\";s:34:\"force_delete_any_published::metric\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:321;a:4:{s:1:\"a\";i:322;s:1:\"b\";s:23:\"view_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:322;a:4:{s:1:\"a\";i:323;s:1:\"b\";s:27:\"view_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:323;a:4:{s:1:\"a\";i:324;s:1:\"b\";s:25:\"create_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:324;a:4:{s:1:\"a\";i:325;s:1:\"b\";s:25:\"update_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:325;a:4:{s:1:\"a\";i:326;s:1:\"b\";s:26:\"restore_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:326;a:4:{s:1:\"a\";i:327;s:1:\"b\";s:30:\"restore_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:327;a:4:{s:1:\"a\";i:328;s:1:\"b\";s:28:\"replicate_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:328;a:4:{s:1:\"a\";i:329;s:1:\"b\";s:26:\"reorder_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:329;a:4:{s:1:\"a\";i:330;s:1:\"b\";s:25:\"delete_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:330;a:4:{s:1:\"a\";i:331;s:1:\"b\";s:29:\"delete_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:331;a:4:{s:1:\"a\";i:332;s:1:\"b\";s:31:\"force_delete_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:332;a:4:{s:1:\"a\";i:333;s:1:\"b\";s:35:\"force_delete_any_published::project\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:1:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}}}', 1753207063);

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
-- Table structure for table `data_publications`
--

CREATE TABLE `data_publications` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `published_by` bigint UNSIGNED NOT NULL,
  `publication_notes` text COLLATE utf8mb4_unicode_ci,
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
(83, '2025_07_17_153115_remove_belongs_to_from_locations_table', 4),
(84, '2025_07_17_160512_remove_belongsto_from_activity_calendars_table', 4),
(85, '2025_07_17_164522_remove_signature_from_beneficiaries_table', 4),
(86, '2025_07_17_171444_add_signature_to_beneficiaries_table', 4),
(87, '2025_07_17_172043_remove_belongsto_from_beneficiaries_table', 4),
(88, '2025_07_17_172120_remove_belongsto_from_beneficiary_registries_table', 4),
(89, '2025_07_17_173117_remove_belongsto_from_activity_logs_table', 4),
(90, '2025_07_17_173131_remove_belongsto_from_activity_files_table', 4),
(91, '2025_07_17_175856_add_name_to_activities_table', 4),
(92, '2025_07_17_210051_add_identifier_to_beneficiaries_table', 4),
(93, '2025_07_17_224315_add_activity_calendar_id_to_activity_files_table', 4),
(94, '2025_07_21_152134_create_permission_tables', 5),
(95, '2025_07_21_171725_create_data_publications_table', 6),
(96, '2025_07_21_171732_create_published_projects_table', 6),
(97, '2025_07_21_171738_create_published_activities_table', 6),
(98, '2025_07_21_171746_create_published_metrics_table', 6),
(99, '2025_07_21_172027_add_publish_fields_to_users_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1);

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
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'view_role', 'web', '2025-07-21 21:22:13', '2025-07-21 21:22:13'),
(2, 'view_any_role', 'web', '2025-07-21 21:22:13', '2025-07-21 21:22:13'),
(3, 'create_role', 'web', '2025-07-21 21:22:13', '2025-07-21 21:22:13'),
(4, 'update_role', 'web', '2025-07-21 21:22:13', '2025-07-21 21:22:13'),
(5, 'delete_role', 'web', '2025-07-21 21:22:13', '2025-07-21 21:22:13'),
(6, 'delete_any_role', 'web', '2025-07-21 21:22:13', '2025-07-21 21:22:13'),
(7, 'view_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(8, 'view_any_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(9, 'create_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(10, 'update_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(11, 'restore_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(12, 'restore_any_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(13, 'replicate_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(14, 'reorder_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(15, 'delete_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(16, 'delete_any_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(17, 'force_delete_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(18, 'force_delete_any_action::line', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(19, 'view_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(20, 'view_any_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(21, 'create_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(22, 'update_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(23, 'restore_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(24, 'restore_any_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(25, 'replicate_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(26, 'reorder_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(27, 'delete_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(28, 'delete_any_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(29, 'force_delete_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(30, 'force_delete_any_activity', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(31, 'view_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(32, 'view_any_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(33, 'create_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(34, 'update_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(35, 'restore_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(36, 'restore_any_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(37, 'replicate_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(38, 'reorder_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(39, 'delete_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(40, 'delete_any_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(41, 'force_delete_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(42, 'force_delete_any_activity::calendar', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(43, 'view_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(44, 'view_any_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(45, 'create_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(46, 'update_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(47, 'restore_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(48, 'restore_any_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(49, 'replicate_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(50, 'reorder_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(51, 'delete_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(52, 'delete_any_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(53, 'force_delete_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(54, 'force_delete_any_activity::file', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(55, 'view_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(56, 'view_any_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(57, 'create_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(58, 'update_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(59, 'restore_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(60, 'restore_any_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(61, 'replicate_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(62, 'reorder_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(63, 'delete_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(64, 'delete_any_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(65, 'force_delete_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(66, 'force_delete_any_activity::log', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(67, 'view_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(68, 'view_any_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(69, 'create_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(70, 'update_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(71, 'restore_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(72, 'restore_any_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(73, 'replicate_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(74, 'reorder_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(75, 'delete_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(76, 'delete_any_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(77, 'force_delete_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(78, 'force_delete_any_axe', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(79, 'view_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(80, 'view_any_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(81, 'create_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(82, 'update_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(83, 'restore_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(84, 'restore_any_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(85, 'replicate_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(86, 'reorder_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(87, 'delete_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(88, 'delete_any_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(89, 'force_delete_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(90, 'force_delete_any_beneficiary', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(91, 'view_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(92, 'view_any_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(93, 'create_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(94, 'update_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(95, 'restore_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(96, 'restore_any_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(97, 'replicate_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(98, 'reorder_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(99, 'delete_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(100, 'delete_any_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(101, 'force_delete_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(102, 'force_delete_any_beneficiary::registry', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(103, 'view_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(104, 'view_any_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(105, 'create_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(106, 'update_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(107, 'restore_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(108, 'restore_any_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(109, 'replicate_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(110, 'reorder_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(111, 'delete_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(112, 'delete_any_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(113, 'force_delete_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(114, 'force_delete_any_component', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(115, 'view_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(116, 'view_any_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(117, 'create_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(118, 'update_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(119, 'restore_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(120, 'restore_any_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(121, 'replicate_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(122, 'reorder_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(123, 'delete_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(124, 'delete_any_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(125, 'force_delete_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(126, 'force_delete_any_financier', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(127, 'view_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(128, 'view_any_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(129, 'create_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(130, 'update_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(131, 'restore_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(132, 'restore_any_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(133, 'replicate_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(134, 'reorder_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(135, 'delete_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(136, 'delete_any_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(137, 'force_delete_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(138, 'force_delete_any_goal', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(139, 'view_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(140, 'view_any_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(141, 'create_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(142, 'update_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(143, 'restore_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(144, 'restore_any_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(145, 'replicate_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(146, 'reorder_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(147, 'delete_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(148, 'delete_any_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(149, 'force_delete_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(150, 'force_delete_any_kpi', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(151, 'view_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(152, 'view_any_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(153, 'create_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(154, 'update_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(155, 'restore_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(156, 'restore_any_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(157, 'replicate_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(158, 'reorder_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(159, 'delete_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(160, 'delete_any_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(161, 'force_delete_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(162, 'force_delete_any_location', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(163, 'view_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(164, 'view_any_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(165, 'create_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(166, 'update_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(167, 'restore_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(168, 'restore_any_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(169, 'replicate_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(170, 'reorder_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(171, 'delete_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(172, 'delete_any_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(173, 'force_delete_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(174, 'force_delete_any_organization', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(175, 'view_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(176, 'view_any_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(177, 'create_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(178, 'update_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(179, 'restore_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(180, 'restore_any_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(181, 'replicate_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(182, 'reorder_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(183, 'delete_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(184, 'delete_any_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(185, 'force_delete_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(186, 'force_delete_any_planned::metric', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(187, 'view_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(188, 'view_any_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(189, 'create_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(190, 'update_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(191, 'restore_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(192, 'restore_any_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(193, 'replicate_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(194, 'reorder_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(195, 'delete_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(196, 'delete_any_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(197, 'force_delete_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(198, 'force_delete_any_polygon', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(199, 'view_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(200, 'view_any_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(201, 'create_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(202, 'update_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(203, 'restore_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(204, 'restore_any_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(205, 'replicate_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(206, 'reorder_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(207, 'delete_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(208, 'delete_any_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(209, 'force_delete_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(210, 'force_delete_any_program', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(211, 'view_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(212, 'view_any_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(213, 'create_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(214, 'update_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(215, 'restore_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(216, 'restore_any_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(217, 'replicate_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(218, 'reorder_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(219, 'delete_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(220, 'delete_any_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(221, 'force_delete_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(222, 'force_delete_any_program::indicator', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(223, 'view_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(224, 'view_any_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(225, 'create_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(226, 'update_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(227, 'restore_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(228, 'restore_any_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(229, 'replicate_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(230, 'reorder_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(231, 'delete_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(232, 'delete_any_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(233, 'force_delete_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(234, 'force_delete_any_project', 'web', '2025-07-21 21:35:31', '2025-07-21 21:35:31'),
(235, 'view_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(236, 'view_any_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(237, 'create_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(238, 'update_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(239, 'restore_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(240, 'restore_any_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(241, 'replicate_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(242, 'reorder_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(243, 'delete_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(244, 'delete_any_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(245, 'force_delete_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(246, 'force_delete_any_project::disbursement', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(247, 'view_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(248, 'view_any_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(249, 'create_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(250, 'update_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(251, 'restore_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(252, 'restore_any_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(253, 'replicate_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(254, 'reorder_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(255, 'delete_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(256, 'delete_any_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(257, 'force_delete_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(258, 'force_delete_any_project::report', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(259, 'view_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(260, 'view_any_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(261, 'create_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(262, 'update_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(263, 'restore_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(264, 'restore_any_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(265, 'replicate_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(266, 'reorder_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(267, 'delete_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(268, 'delete_any_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(269, 'force_delete_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(270, 'force_delete_any_specific::objective', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(271, 'view_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(272, 'view_any_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(273, 'create_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(274, 'update_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(275, 'restore_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(276, 'restore_any_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(277, 'replicate_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(278, 'reorder_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(279, 'delete_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(280, 'delete_any_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(281, 'force_delete_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(282, 'force_delete_any_user', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(283, 'page_ActivityFileManager', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(284, 'page_BeneficiaryRegistryView', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(285, 'page_ProjectCreationGuide', 'web', '2025-07-21 21:35:32', '2025-07-21 21:35:32'),
(286, 'view_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(287, 'view_any_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(288, 'create_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(289, 'update_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(290, 'restore_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(291, 'restore_any_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(292, 'replicate_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(293, 'reorder_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(294, 'delete_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(295, 'delete_any_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(296, 'force_delete_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(297, 'force_delete_any_data::publication', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(298, 'view_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(299, 'view_any_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(300, 'create_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(301, 'update_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(302, 'restore_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(303, 'restore_any_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(304, 'replicate_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(305, 'reorder_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(306, 'delete_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(307, 'delete_any_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(308, 'force_delete_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(309, 'force_delete_any_published::activity', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(310, 'view_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(311, 'view_any_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(312, 'create_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(313, 'update_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(314, 'restore_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(315, 'restore_any_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(316, 'replicate_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(317, 'reorder_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(318, 'delete_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(319, 'delete_any_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(320, 'force_delete_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(321, 'force_delete_any_published::metric', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(322, 'view_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(323, 'view_any_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(324, 'create_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(325, 'update_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(326, 'restore_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(327, 'restore_any_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(328, 'replicate_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(329, 'reorder_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(330, 'delete_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(331, 'delete_any_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(332, 'force_delete_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17'),
(333, 'force_delete_any_published::project', 'web', '2025-07-21 23:57:17', '2025-07-21 23:57:17');

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
-- Table structure for table `published_activities`
--

CREATE TABLE `published_activities` (
  `id` bigint UNSIGNED NOT NULL,
  `publication_id` bigint UNSIGNED NOT NULL,
  `original_activity_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
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
  `unit` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `background` text COLLATE utf8mb4_unicode_ci,
  `justification` text COLLATE utf8mb4_unicode_ci,
  `general_objective` text COLLATE utf8mb4_unicode_ci,
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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'web', '2025-07-21 21:22:13', '2025-07-21 21:22:13'),
(2, 'prueba', 'web', '2025-07-21 21:43:53', '2025-07-21 21:43:53');

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
(285, 1),
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
(333, 1);

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
('4Q9FqYASGjnY37VvFr6cJ4dbH3VwLXS1N7qMXTds', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZEZmNHc5M29nRnpidmhKcDRNeGhBT01aaFpDSUJ1Ym1rblhXeDduWSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbiI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRlMUI4S3NxV2xHVzdQdGdibVkxbGVlSVhvbUtvc09TT1hjajVaTmcvdTVNbE9SN2N3YW9ySyI7fQ==', 1753113094),
('BrA4kseZJzmmhh3ig3mtiu4ghqaXvkDhXQv9VsIc', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiSEJQZmVUVnpWRFpvS0lkcFFxRXRuazZMcjd5cjBGbXVaMTVDVTJKNCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYWRtaW4vcHJveWVjdG9zIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJGUxQjhLc3FXbEdXN1B0Z2JtWTFsZWVJWG9tS29zT1NPWGNqNVpOZy91NU1sT1I3Y3dhb3JLIjtzOjg6ImZpbGFtZW50IjthOjA6e31zOjIyOiJwcm9qZWN0X2NyZWF0aW9uX2d1aWRlIjthOjc6e3M6NzoicHJvamVjdCI7YToxMzp7czo0OiJuYW1lIjtzOjIwOiJQcm95ZWN0byBwcnVlYmEgZ3VpYSI7czoxMzoiZmluYW5jaWVyc19pZCI7czoxOiIxIjtzOjE3OiJnZW5lcmFsX29iamVjdGl2ZSI7czo5OiJkc2Zkc2Zhc2QiO3M6MTA6ImJhY2tncm91bmQiO3M6MTI6InNhZGZhc2RmYXNkZiI7czoxMzoianVzdGlmaWNhdGlvbiI7czoxMjoiYXNkZmFzZGZhc2RmIjtzOjEwOiJzdGFydF9kYXRlIjtzOjEwOiIyMDI1LTA3LTE4IjtzOjg6ImVuZF9kYXRlIjtzOjEwOiIyMDI1LTA4LTE4IjtzOjEwOiJ0b3RhbF9jb3N0IjtzOjI6IjEyIjtzOjEzOiJmdW5kZWRfYW1vdW50IjtzOjI6IjIzIjtzOjIwOiJtb250aGx5X2Rpc2J1cnNlbWVudCI7czoxOiIxIjtzOjE2OiJmb2xsb3d1cF9vZmZpY2VyIjtOO3M6MTQ6ImFncmVlbWVudF9maWxlIjtOO3M6MTc6InByb2plY3RfYmFzZV9maWxlIjtOO31zOjEwOiJvYmplY3RpdmVzIjthOjA6e31zOjQ6ImtwaXMiO2E6MDp7fXM6MTI6ImNvZmluYW5jaWVycyI7YTowOnt9czoxMDoiYWN0aXZpdGllcyI7YTowOnt9czo5OiJsb2NhdGlvbnMiO2E6MDp7fXM6MjA6InNjaGVkdWxlZF9hY3Rpdml0aWVzIjthOjA6e319fQ==', 1752874686),
('MAFqi5KdVHVfuG8nlqyF6ezyhhOzfgnkSgpOC1lk', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoibWpoMVJQalVYUEVnVVZPZUY1aDFGRjlFcUZ4OGhEYlpyT1d6YjgyTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXRhLXB1YmxpY2F0aW9uLWFwcHJvdmFsIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRlMUI4S3NxV2xHVzdQdGdibVkxbGVlSVhvbUtvc09TT1hjajVaTmcvdTVNbE9SN2N3YW9ySyI7czo4OiJmaWxhbWVudCI7YTowOnt9fQ==', 1753122836);

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
  `org_area` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `can_publish_data` tinyint(1) NOT NULL DEFAULT '0',
  `last_publication_access` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `point_of_contact_id`, `phone`, `org_role`, `organizations_id`, `org_area`, `can_publish_data`, `last_publication_access`) VALUES
(1, 'David García', 'dgarcia@planjuarez.org', NULL, '$2y$12$e1B8KsqWlGW7PtgbmY1leeIXomKosOSOXcj5ZNg/u5MlOR7cwaorK', NULL, '2025-07-17 04:18:47', '2025-07-21 23:44:38', NULL, '6562786534', 'Desarrollador', 1, 'Mejora Continua', 1, NULL),
(2, 'Capturista', 'capturista@test.com', NULL, '$2y$12$M.FASMD4iDiOUawH77oOIOLjm3k6VrfnJG1mQ8662VSJJaY4TWTHm', NULL, '2025-07-17 04:51:11', '2025-07-21 23:44:19', 1, NULL, 'Promotor', 1, 'Red de Vecinos', 0, NULL);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_files_activity_calendar_id_foreign` (`activity_calendar_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `beneficiaries_identifier_unique` (`identifier`);

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
-- Indexes for table `data_publications`
--
ALTER TABLE `data_publications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_publications_published_by_foreign` (`published_by`),
  ADD KEY `idx_publications_date` (`publication_date`);

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
-- Indexes for table `published_activities`
--
ALTER TABLE `published_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_activities_publication_id_foreign` (`publication_id`),
  ADD KEY `published_activities_specific_objective_id_foreign` (`specific_objective_id`),
  ADD KEY `published_activities_goals_id_foreign` (`goals_id`),
  ADD KEY `published_activities_created_by_foreign` (`created_by`),
  ADD KEY `idx_published_activities_original` (`original_activity_id`);

--
-- Indexes for table `published_metrics`
--
ALTER TABLE `published_metrics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_metrics_publication_id_foreign` (`publication_id`),
  ADD KEY `idx_published_metrics_activity` (`activity_id`),
  ADD KEY `idx_published_metrics_period` (`year`,`month`),
  ADD KEY `idx_published_metrics_original` (`original_metric_id`);

--
-- Indexes for table `published_projects`
--
ALTER TABLE `published_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `published_projects_publication_id_foreign` (`publication_id`),
  ADD KEY `published_projects_co_financier_id_foreign` (`co_financier_id`),
  ADD KEY `published_projects_created_by_foreign` (`created_by`),
  ADD KEY `idx_published_projects_original` (`original_project_id`),
  ADD KEY `idx_published_projects_financier` (`financiers_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `activity_calendars`
--
ALTER TABLE `activity_calendars`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `activity_files`
--
ALTER TABLE `activity_files`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `axes`
--
ALTER TABLE `axes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `beneficiary_registries`
--
ALTER TABLE `beneficiary_registries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `components`
--
ALTER TABLE `components`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=334;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_files`
--
ALTER TABLE `activity_files`
  ADD CONSTRAINT `activity_files_activity_calendar_id_foreign` FOREIGN KEY (`activity_calendar_id`) REFERENCES `activity_calendars` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `data_publications`
--
ALTER TABLE `data_publications`
  ADD CONSTRAINT `data_publications_published_by_foreign` FOREIGN KEY (`published_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT;

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
-- Constraints for table `published_activities`
--
ALTER TABLE `published_activities`
  ADD CONSTRAINT `published_activities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_activities_goals_id_foreign` FOREIGN KEY (`goals_id`) REFERENCES `goals` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_activities_original_activity_id_foreign` FOREIGN KEY (`original_activity_id`) REFERENCES `activities` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_activities_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `published_activities_specific_objective_id_foreign` FOREIGN KEY (`specific_objective_id`) REFERENCES `specific_objectives` (`id`) ON DELETE RESTRICT;

--
-- Constraints for table `published_metrics`
--
ALTER TABLE `published_metrics`
  ADD CONSTRAINT `published_metrics_activity_id_foreign` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_metrics_original_metric_id_foreign` FOREIGN KEY (`original_metric_id`) REFERENCES `planned_metrics` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_metrics_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `published_projects`
--
ALTER TABLE `published_projects`
  ADD CONSTRAINT `published_projects_co_financier_id_foreign` FOREIGN KEY (`co_financier_id`) REFERENCES `financiers` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_projects_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_projects_financiers_id_foreign` FOREIGN KEY (`financiers_id`) REFERENCES `financiers` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_projects_original_project_id_foreign` FOREIGN KEY (`original_project_id`) REFERENCES `projects` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `published_projects_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `data_publications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

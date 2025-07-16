-- MySQL Workbench Forward Engineering - Consolidated Schema
-- All tables consolidated into project_management schema

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema project_management (Single consolidated schema)
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project_management` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `project_management` ;

-- -----------------------------------------------------
-- Table `project_management`.`axes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`axes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`Program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`Program` (
  `id` INT NOT NULL,
  `axes_id` INT NOT NULL,
  `name` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`, `axes_id`),
  INDEX `fk_Program_axes_idx` (`axes_id` ASC) VISIBLE,
  CONSTRAINT `fk_Program_axes`
    FOREIGN KEY (`axes_id`)
    REFERENCES `project_management`.`axes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`action_lines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`action_lines` (
  `id` INT NOT NULL,
  `name` VARCHAR(500) NOT NULL,
  `Program_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Program_id`),
  INDEX `fk_action_lines_Program1_idx` (`Program_id` ASC) VISIBLE,
  CONSTRAINT `fk_action_lines_Program1`
    FOREIGN KEY (`Program_id`)
    REFERENCES `project_management`.`Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`organizations` (
  `id` INT NOT NULL,
  `name` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`components`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`components` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `action_lines_id` INT NOT NULL,
  `action_lines_Program_id` INT NOT NULL,
  PRIMARY KEY (`id`, `action_lines_id`, `action_lines_Program_id`),
  INDEX `fk_components_action_lines1_idx` (`action_lines_id` ASC, `action_lines_Program_id` ASC) VISIBLE,
  CONSTRAINT `fk_components_action_lines1`
    FOREIGN KEY (`action_lines_id` , `action_lines_Program_id`)
    REFERENCES `project_management`.`action_lines` (`id` , `Program_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`financiers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`financiers` (
  `id` INT NOT NULL,
  `name` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`users` (
  `id` INT NOT NULL,
  `point_of_contact_id` INT NULL,
  `first_name` VARCHAR(45) NULL,
  `mid_name` VARCHAR(45) NULL,
  `last_name_1` VARCHAR(45) NULL,
  `last_name_2` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `org_role` VARCHAR(45) NULL,
  `system_role` VARCHAR(45) NULL,
  `organizations_id` INT NOT NULL,
  `org_area` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_organizations1_idx` (`organizations_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `project_management`.`organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`projects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `background` TEXT NULL,
  `justification` TEXT NULL,
  `general_objective` TEXT NULL,
  `financiers_id` INT NOT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `total_cost` REAL NULL,
  `funded_amount` REAL NULL,
  `cofunding_amount` REAL NULL,
  `monthly_disbursement` REAL NULL,
  `followup_officer` TEXT NULL,
  `agreement_file` TEXT NULL,
  `project_base_file` TEXT NULL,
  `co-financier id` INT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_projects_financiers1_idx` (`financiers_id` ASC) VISIBLE,
  INDEX `fk_projects_financiers2_idx` (`co-financier id` ASC) VISIBLE,
  INDEX `fk_projects_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_projects_financiers1`
    FOREIGN KEY (`financiers_id`)
    REFERENCES `project_management`.`financiers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_financiers2`
    FOREIGN KEY (`co-financier id`)
    REFERENCES `project_management`.`financiers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`kpi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`kpi` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  `description` TEXT NULL,
  `initial_value` DECIMAL(10,2) NULL,
  `final_value` DECIMAL(10,2) NULL,
  `projects_id` INT NOT NULL,
  `is_percentage` BINARY NULL,
  `org_area` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kpi_projects1_idx` (`projects_id` ASC) VISIBLE,
  CONSTRAINT `fk_kpi_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `project_management`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`program_indicators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`program_indicators` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `initial_value` DECIMAL(10,2) NULL,
  `final_value` DECIMAL(10,2) NULL,
  `Program_id` INT NOT NULL,
  `Program_axes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_program_indicators_Program1_idx` (`Program_id` ASC, `Program_axes_id` ASC) VISIBLE,
  CONSTRAINT `fk_program_indicators_Program1`
    FOREIGN KEY (`Program_id` , `Program_axes_id`)
    REFERENCES `project_management`.`Program` (`id` , `axes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`specific_objectives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`specific_objectives` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `projects_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_specific_objectives_projects1_idx` (`projects_id` ASC) VISIBLE,
  CONSTRAINT `fk_specific_objectives_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `project_management`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`goals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`goals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `number` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `components_id` INT NOT NULL,
  `components_action_lines_id` INT NOT NULL,
  `components_action_lines_Program_id` INT NOT NULL,
  `organizations_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_goals_components1_idx` (`components_id` ASC, `components_action_lines_id` ASC, `components_action_lines_Program_id` ASC) VISIBLE,
  INDEX `fk_goals_organizations1_idx` (`organizations_id` ASC) VISIBLE,
  CONSTRAINT `fk_goals_components1`
    FOREIGN KEY (`components_id` , `components_action_lines_id` , `components_action_lines_Program_id`)
    REFERENCES `project_management`.`components` (`id` , `action_lines_id` , `action_lines_Program_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_goals_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `project_management`.`organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `specific_objective_id` INT NOT NULL,
  `description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `goals_id` INT NOT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`, `goals_id`),
  INDEX `idx_activities_specific_objective` (`specific_objective_id` ASC) VISIBLE,
  INDEX `idx_activities_complete` (`specific_objective_id` ASC) VISIBLE,
  INDEX `fk_activities_goals1_idx` (`goals_id` ASC) VISIBLE,
  INDEX `fk_activities_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `activities_ibfk_1`
    FOREIGN KEY (`specific_objective_id`)
    REFERENCES `project_management`.`specific_objectives` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_activities_goals1`
    FOREIGN KEY (`goals_id`)
    REFERENCES `project_management`.`goals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activities_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`polygons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`polygons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE,
  INDEX `idx_polygons_name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`locations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `category` VARCHAR(50) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Street` TEXT NULL,
  `neighborhood` VARCHAR(100) NULL,
  `ext_number` INT NULL,
  `int_number` INT NULL,
  `google_place_id` VARCHAR(500) NULL,
  `polygons_id` INT NOT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE,
  INDEX `idx_locations_name` (`name` ASC) VISIBLE,
  INDEX `idx_locations_category` (`category` ASC) VISIBLE,
  INDEX `fk_locations_polygons1_idx` (`polygons_id` ASC) VISIBLE,
  INDEX `fk_locations_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_locations_polygons1`
    FOREIGN KEY (`polygons_id`)
    REFERENCES `project_management`.`polygons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locations_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`activity_calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`activity_calendar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `activity_id` INT NOT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `start_hour` TIME NULL DEFAULT NULL,
  `end_hour` TIME NULL DEFAULT NULL,
  `address_backup` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `last_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cancelled` TINYINT(1) NULL DEFAULT '0',
  `change_reason` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INT NOT NULL,
  `asigned_person` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_activity_calendar_activity` (`activity_id` ASC) VISIBLE,
  INDEX `idx_activity_calendar_dates` (`start_date` ASC, `end_date` ASC) VISIBLE,
  INDEX `idx_activity_calendar_cancelled` (`cancelled` ASC) VISIBLE,
  INDEX `fk_activity_calendar_locations1_idx` (`created_by` ASC) VISIBLE,
  INDEX `fk_activity_calendar_users1_idx` (`asigned_person` ASC) VISIBLE,
  CONSTRAINT `activity_calendar_ibfk_1`
    FOREIGN KEY (`activity_id`)
    REFERENCES `project_management`.`activities` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_activity_calendar_locations1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_calendar_users1`
    FOREIGN KEY (`asigned_person`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`beneficiaries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`beneficiaries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(100) NULL DEFAULT NULL,
  `mother_last_name` VARCHAR(100) NULL DEFAULT NULL,
  `first_names` VARCHAR(100) NULL DEFAULT NULL,
  `birth_year` VARCHAR(4) NULL DEFAULT NULL,
  `gender` ENUM('M', 'F', 'Male', 'Female') NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `signature` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `address_backup` TEXT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_beneficiary_registry_names` (`last_name` ASC, `mother_last_name` ASC) VISIBLE,
  INDEX `idx_beneficiary_registry_first_names` (`first_names` ASC) VISIBLE,
  INDEX `fk_beneficiaries_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_beneficiaries_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`beneficiary_registry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`beneficiary_registry` (
  `id` INT NOT NULL,
  `activity_calendar_id` INT NOT NULL,
  `beneficiaries_id` INT NOT NULL,
  `data_collectors_id` INT NOT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_activity_events_activity_calendar1_idx` (`activity_calendar_id` ASC) VISIBLE,
  INDEX `fk_beneficiary_registry_beneficiaries1_idx` (`beneficiaries_id` ASC) VISIBLE,
  INDEX `fk_beneficiary_registry_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_activity_events_activity_calendar1`
    FOREIGN KEY (`activity_calendar_id`)
    REFERENCES `project_management`.`activity_calendar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_beneficiary_registry_beneficiaries1`
    FOREIGN KEY (`beneficiaries_id`)
    REFERENCES `project_management`.`beneficiaries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_beneficiary_registry_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`planned_metrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`planned_metrics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `activity_id` INT NOT NULL,
  `unit` VARCHAR(100) NULL DEFAULT NULL,
  `year` INT NULL DEFAULT NULL,
  `month` INT NULL DEFAULT NULL,
  `population_target_value` DECIMAL(10,2) NULL DEFAULT NULL,
  `population_real_value` DECIMAL(10,2) NULL DEFAULT '0.00',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `product_target_value` DECIMAL(10,2) NULL DEFAULT NULL,
  `product_real_value` DECIMAL(10,2) NULL DEFAULT NULL,
  `activity_progress_log_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_planned_metrics_activity_period` (`activity_id` ASC, `year` ASC, `month` ASC) VISIBLE,
  CONSTRAINT `planned_metrics_ibfk_2`
    FOREIGN KEY (`activity_id`)
    REFERENCES `project_management`.`activities` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Table `project_management`.`activity_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`activity_log` (
  `id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `planned_metrics_id` INT NOT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_activity_log_planned_metrics1_idx` (`planned_metrics_id` ASC) VISIBLE,
  INDEX `fk_activity_log_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_activity_log_planned_metrics1`
    FOREIGN KEY (`planned_metrics_id`)
    REFERENCES `project_management`.`planned_metrics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_log_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`project_reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`project_reports` (
  `id` INT NOT NULL,
  `report_date` DATE NULL,
  `report_file` TEXT NULL,
  `projects_id` INT NOT NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`, `projects_id`),
  INDEX `fk_project_reports_projects1_idx` (`projects_id` ASC) VISIBLE,
  INDEX `fk_project_reports_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_project_reports_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `project_management`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_reports_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`project_disbursements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`project_disbursements` (
  `id` INT NOT NULL,
  `projects_id` INT NOT NULL,
  `amount` REAL NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `disbursement_date` DATE NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`, `projects_id`),
  INDEX `fk_project_disbursements_projects1_idx` (`projects_id` ASC) VISIBLE,
  INDEX `fk_project_disbursements_users1_idx` (`created_by` ASC) VISIBLE,
  CONSTRAINT `fk_project_disbursements_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `project_management`.`projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_disbursements_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `project_management`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `project_management`.`activity_files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_management`.`activity_files` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `month` VARCHAR(20) NULL DEFAULT NULL,
  `type` VARCHAR(100) NULL DEFAULT NULL,
  `file_path` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL,
  `upload_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `activity_progress_log_id` INT NOT NULL,
  `activity_log_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_activity_files_period` (`month` ASC) VISIBLE,
  INDEX `fk_activity_files_activity_log1_idx` (`activity_log_id` ASC) VISIBLE,
  CONSTRAINT `fk_activity_files_activity_log1`
    FOREIGN KEY (`activity_log_id`)
    REFERENCES `project_management`.`activity_log` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
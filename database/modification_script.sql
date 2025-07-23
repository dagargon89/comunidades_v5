-- Convierte el esquema original al esquema corregido con FKs cascadeantes
-- EJECUTALO EN ORDEN SECUENCIAL

USE `project_management`;

SET FOREIGN_KEY_CHECKS = 0;


-- CORRECCIONES


-- Corregir nombre de columna en projects de co-financier id -> co_financier_id
-- Eliminar la FK constraint 
ALTER TABLE `projects` 
DROP FOREIGN KEY `fk_projects_financiers2`;

-- Cambiar nombre
ALTER TABLE `projects` 
CHANGE COLUMN `co-financier id` `co_financier_id` INT NULL;

-- Recrear la FK constraint 
ALTER TABLE `projects` 
ADD CONSTRAINT `fk_projects_financiers2`
    FOREIGN KEY (`co_financier_id`)
    REFERENCES `financiers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- Corregir activity_calendar
-- Eliminar FK constraint  de created_by
ALTER TABLE `activity_calendar` 
DROP FOREIGN KEY `fk_activity_calendar_locations1`;

-- Cambiar nombre de columna de asigned_person -> assigned_person
ALTER TABLE `activity_calendar` 
CHANGE COLUMN `asigned_person` `assigned_person` INT NOT NULL;

-- Agregar columna location_id
ALTER TABLE `activity_calendar` 
ADD COLUMN `location_id` INT NULL AFTER `assigned_person`;

-- Recrear FK constraint correcta para created_by (hacia users)
ALTER TABLE `activity_calendar` 
ADD CONSTRAINT `fk_activity_calendar_users1`
    FOREIGN KEY (`created_by`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- Agregar FK constraint para location_id
ALTER TABLE `activity_calendar` 
ADD CONSTRAINT `fk_activity_calendar_locations1`
    FOREIGN KEY (`location_id`)
    REFERENCES `locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


-- AGREGAR FOREIGN KEYS CASCADEANTES

-- Actualizar tabla action_lines para incluir Program_axes_id
ALTER TABLE `action_lines` 
ADD COLUMN `Program_axes_id` INT NOT NULL AFTER `Program_id`;

-- Actualizar referencias 
UPDATE `action_lines` al 
JOIN `Program` p ON al.Program_id = p.id 
SET al.Program_axes_id = p.axes_id;

-- Actualizar FK constraint en action_lines
ALTER TABLE `action_lines` 
DROP FOREIGN KEY `fk_action_lines_Program1`;

ALTER TABLE `action_lines` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `Program_id`, `Program_axes_id`);

ALTER TABLE `action_lines` 
ADD CONSTRAINT `fk_action_lines_Program1`
    FOREIGN KEY (`Program_id`, `Program_axes_id`)
    REFERENCES `Program` (`id`, `axes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--  Actualizar tabla components para incluir action_lines_Program_axes_id
ALTER TABLE `components` 
ADD COLUMN `action_lines_Program_axes_id` INT NOT NULL AFTER `action_lines_Program_id`;

-- Actualizar referencias 
UPDATE `components` c 
JOIN `action_lines` al ON c.action_lines_id = al.id AND c.action_lines_Program_id = al.Program_id 
SET c.action_lines_Program_axes_id = al.Program_axes_id;

-- Actualizar FK constraint en components
ALTER TABLE `components` 
DROP FOREIGN KEY `fk_components_action_lines1`;

ALTER TABLE `components` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `action_lines_id`, `action_lines_Program_id`, `action_lines_Program_axes_id`);

ALTER TABLE `components` 
ADD CONSTRAINT `fk_components_action_lines1`
    FOREIGN KEY (`action_lines_id`, `action_lines_Program_id`, `action_lines_Program_axes_id`)
    REFERENCES `action_lines` (`id`, `Program_id`, `Program_axes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- Actualizar tabla goals para incluir components_action_lines_Program_axes_id
ALTER TABLE `goals` 
ADD COLUMN `components_action_lines_Program_axes_id` INT NOT NULL AFTER `components_action_lines_Program_id`;

-- Actualizar referencias 
UPDATE `goals` g 
JOIN `components` c ON g.components_id = c.id 
    AND g.components_action_lines_id = c.action_lines_id 
    AND g.components_action_lines_Program_id = c.action_lines_Program_id 
SET g.components_action_lines_Program_axes_id = c.action_lines_Program_axes_id;

-- Actualizar FK constraint en goals
ALTER TABLE `goals` 
DROP FOREIGN KEY `fk_goals_components1`;

ALTER TABLE `goals` 
ADD CONSTRAINT `fk_goals_components1`
    FOREIGN KEY (`components_id`, `components_action_lines_id`, `components_action_lines_Program_id`, `components_action_lines_Program_axes_id`)
    REFERENCES `components` (`id`, `action_lines_id`, `action_lines_Program_id`, `action_lines_Program_axes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- Agregar FKs cascadeantes a tabla activities
ALTER TABLE `activities` 
ADD COLUMN `projects_id` INT NOT NULL AFTER `created_by`,
ADD COLUMN `components_id` INT NOT NULL AFTER `projects_id`,
ADD COLUMN `action_lines_id` INT NOT NULL AFTER `components_id`,
ADD COLUMN `Program_id` INT NOT NULL AFTER `action_lines_id`,
ADD COLUMN `axes_id` INT NOT NULL AFTER `Program_id`,
ADD COLUMN `organizations_id` INT NOT NULL AFTER `axes_id`;

-- Actualizar valores basados en las relaciones existentes
UPDATE `activities` a 
JOIN `specific_objectives` so ON a.specific_objective_id = so.id 
JOIN `projects` p ON so.projects_id = p.id 
SET a.projects_id = p.id;

UPDATE `activities` a 
JOIN `goals` g ON a.goals_id = g.id 
SET a.components_id = g.components_id,
    a.action_lines_id = g.components_action_lines_id,
    a.Program_id = g.components_action_lines_Program_id,
    a.axes_id = g.components_action_lines_Program_axes_id,
    a.organizations_id = g.organizations_id;

-- Agregar index y FKs para activities
ALTER TABLE `activities` 
ADD INDEX `fk_activities_projects1_idx` (`projects_id`),
ADD INDEX `fk_activities_components1_idx` (`components_id`),
ADD INDEX `fk_activities_action_lines1_idx` (`action_lines_id`),
ADD INDEX `fk_activities_Program1_idx` (`Program_id`),
ADD INDEX `fk_activities_axes1_idx` (`axes_id`),
ADD INDEX `fk_activities_organizations1_idx` (`organizations_id`);

ALTER TABLE `activities` 
ADD CONSTRAINT `fk_activities_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activities_components1`
    FOREIGN KEY (`components_id`)
    REFERENCES `components` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activities_action_lines1`
    FOREIGN KEY (`action_lines_id`)
    REFERENCES `action_lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activities_Program1`
    FOREIGN KEY (`Program_id`)
    REFERENCES `Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activities_axes1`
    FOREIGN KEY (`axes_id`)
    REFERENCES `axes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activities_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--  Agregar FKs  a tabla activity_calendar
ALTER TABLE `activity_calendar` 
ADD COLUMN `specific_objective_id` INT NOT NULL AFTER `location_id`,
ADD COLUMN `projects_id` INT NOT NULL AFTER `specific_objective_id`,
ADD COLUMN `goals_id` INT NOT NULL AFTER `projects_id`,
ADD COLUMN `components_id` INT NOT NULL AFTER `goals_id`,
ADD COLUMN `action_lines_id` INT NOT NULL AFTER `components_id`,
ADD COLUMN `Program_id` INT NOT NULL AFTER `action_lines_id`,
ADD COLUMN `axes_id` INT NOT NULL AFTER `Program_id`,
ADD COLUMN `organizations_id` INT NOT NULL AFTER `axes_id`;

-- Actualizar valores basados en las relaciones existentes
UPDATE `activity_calendar` ac 
JOIN `activities` a ON ac.activity_id = a.id 
SET ac.specific_objective_id = a.specific_objective_id,
    ac.projects_id = a.projects_id,
    ac.goals_id = a.goals_id,
    ac.components_id = a.components_id,
    ac.action_lines_id = a.action_lines_id,
    ac.Program_id = a.Program_id,
    ac.axes_id = a.axes_id,
    ac.organizations_id = a.organizations_id;

-- Agregar indexes y FKs para activity_calendar
ALTER TABLE `activity_calendar` 
ADD INDEX `fk_activity_calendar_specific_objectives1_idx` (`specific_objective_id`),
ADD INDEX `fk_activity_calendar_projects1_idx` (`projects_id`),
ADD INDEX `fk_activity_calendar_goals1_idx` (`goals_id`),
ADD INDEX `fk_activity_calendar_components1_idx` (`components_id`),
ADD INDEX `fk_activity_calendar_action_lines1_idx` (`action_lines_id`),
ADD INDEX `fk_activity_calendar_Program1_idx` (`Program_id`),
ADD INDEX `fk_activity_calendar_axes1_idx` (`axes_id`),
ADD INDEX `fk_activity_calendar_organizations1_idx` (`organizations_id`);

ALTER TABLE `activity_calendar` 
ADD CONSTRAINT `fk_activity_calendar_specific_objectives1`
    FOREIGN KEY (`specific_objective_id`)
    REFERENCES `specific_objectives` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_calendar_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_calendar_goals1`
    FOREIGN KEY (`goals_id`)
    REFERENCES `goals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_calendar_components1`
    FOREIGN KEY (`components_id`)
    REFERENCES `components` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_calendar_action_lines1`
    FOREIGN KEY (`action_lines_id`)
    REFERENCES `action_lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_calendar_Program1`
    FOREIGN KEY (`Program_id`)
    REFERENCES `Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_calendar_axes1`
    FOREIGN KEY (`axes_id`)
    REFERENCES `axes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_calendar_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- 2.6 Agregar FKs  a tabla planned_metrics
-- Primero eliminar la columna activity_progress_log_id si existe (error en el esquema actual)
ALTER TABLE `planned_metrics` 
DROP COLUMN IF EXISTS `activity_progress_log_id`;

ALTER TABLE `planned_metrics` 
ADD COLUMN `specific_objective_id` INT NOT NULL AFTER `product_real_value`,
ADD COLUMN `projects_id` INT NOT NULL AFTER `specific_objective_id`,
ADD COLUMN `goals_id` INT NOT NULL AFTER `projects_id`,
ADD COLUMN `components_id` INT NOT NULL AFTER `goals_id`,
ADD COLUMN `action_lines_id` INT NOT NULL AFTER `components_id`,
ADD COLUMN `Program_id` INT NOT NULL AFTER `action_lines_id`,
ADD COLUMN `axes_id` INT NOT NULL AFTER `Program_id`,
ADD COLUMN `organizations_id` INT NOT NULL AFTER `axes_id`;

-- Actualizar valores basados en las relaciones existentes
UPDATE `planned_metrics` pm 
JOIN `activities` a ON pm.activity_id = a.id 
SET pm.specific_objective_id = a.specific_objective_id,
    pm.projects_id = a.projects_id,
    pm.goals_id = a.goals_id,
    pm.components_id = a.components_id,
    pm.action_lines_id = a.action_lines_id,
    pm.Program_id = a.Program_id,
    pm.axes_id = a.axes_id,
    pm.organizations_id = a.organizations_id;

-- Agregar indexes y FKs para planned_metrics
ALTER TABLE `planned_metrics` 
ADD INDEX `fk_planned_metrics_specific_objectives1_idx` (`specific_objective_id`),
ADD INDEX `fk_planned_metrics_projects1_idx` (`projects_id`),
ADD INDEX `fk_planned_metrics_goals1_idx` (`goals_id`),
ADD INDEX `fk_planned_metrics_components1_idx` (`components_id`),
ADD INDEX `fk_planned_metrics_action_lines1_idx` (`action_lines_id`),
ADD INDEX `fk_planned_metrics_Program1_idx` (`Program_id`),
ADD INDEX `fk_planned_metrics_axes1_idx` (`axes_id`),
ADD INDEX `fk_planned_metrics_organizations1_idx` (`organizations_id`);

ALTER TABLE `planned_metrics` 
ADD CONSTRAINT `fk_planned_metrics_specific_objectives1`
    FOREIGN KEY (`specific_objective_id`)
    REFERENCES `specific_objectives` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_planned_metrics_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_planned_metrics_goals1`
    FOREIGN KEY (`goals_id`)
    REFERENCES `goals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_planned_metrics_components1`
    FOREIGN KEY (`components_id`)
    REFERENCES `components` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_planned_metrics_action_lines1`
    FOREIGN KEY (`action_lines_id`)
    REFERENCES `action_lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_planned_metrics_Program1`
    FOREIGN KEY (`Program_id`)
    REFERENCES `Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_planned_metrics_axes1`
    FOREIGN KEY (`axes_id`)
    REFERENCES `axes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_planned_metrics_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--  Agregar FKs cascadeantes a tabla activity_log
ALTER TABLE `activity_log` 
ADD COLUMN `activity_id` INT NOT NULL AFTER `created_by`,
ADD COLUMN `specific_objective_id` INT NOT NULL AFTER `activity_id`,
ADD COLUMN `projects_id` INT NOT NULL AFTER `specific_objective_id`,
ADD COLUMN `goals_id` INT NOT NULL AFTER `projects_id`,
ADD COLUMN `components_id` INT NOT NULL AFTER `goals_id`,
ADD COLUMN `action_lines_id` INT NOT NULL AFTER `components_id`,
ADD COLUMN `Program_id` INT NOT NULL AFTER `action_lines_id`,
ADD COLUMN `axes_id` INT NOT NULL AFTER `Program_id`,
ADD COLUMN `organizations_id` INT NOT NULL AFTER `axes_id`;

-- Actualizar valores basados en las relaciones existentes
UPDATE `activity_log` al 
JOIN `planned_metrics` pm ON al.planned_metrics_id = pm.id 
SET al.activity_id = pm.activity_id,
    al.specific_objective_id = pm.specific_objective_id,
    al.projects_id = pm.projects_id,
    al.goals_id = pm.goals_id,
    al.components_id = pm.components_id,
    al.action_lines_id = pm.action_lines_id,
    al.Program_id = pm.Program_id,
    al.axes_id = pm.axes_id,
    al.organizations_id = pm.organizations_id;

-- Agregar indexes y FKs para activity_log
ALTER TABLE `activity_log` 
ADD INDEX `fk_activity_log_activities1_idx` (`activity_id`),
ADD INDEX `fk_activity_log_specific_objectives1_idx` (`specific_objective_id`),
ADD INDEX `fk_activity_log_projects1_idx` (`projects_id`),
ADD INDEX `fk_activity_log_goals1_idx` (`goals_id`),
ADD INDEX `fk_activity_log_components1_idx` (`components_id`),
ADD INDEX `fk_activity_log_action_lines1_idx` (`action_lines_id`),
ADD INDEX `fk_activity_log_Program1_idx` (`Program_id`),
ADD INDEX `fk_activity_log_axes1_idx` (`axes_id`),
ADD INDEX `fk_activity_log_organizations1_idx` (`organizations_id`);

ALTER TABLE `activity_log` 
ADD CONSTRAINT `fk_activity_log_activities1`
    FOREIGN KEY (`activity_id`)
    REFERENCES `activities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_specific_objectives1`
    FOREIGN KEY (`specific_objective_id`)
    REFERENCES `specific_objectives` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_goals1`
    FOREIGN KEY (`goals_id`)
    REFERENCES `goals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_components1`
    FOREIGN KEY (`components_id`)
    REFERENCES `components` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_action_lines1`
    FOREIGN KEY (`action_lines_id`)
    REFERENCES `action_lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_Program1`
    FOREIGN KEY (`Program_id`)
    REFERENCES `Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_axes1`
    FOREIGN KEY (`axes_id`)
    REFERENCES `axes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_log_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- Agregar FKs  a tabla activity_files
-- Eliminar columna activity_progress_log_id si existe (error)
ALTER TABLE `activity_files` 
DROP COLUMN IF EXISTS `activity_progress_log_id`;

ALTER TABLE `activity_files` 
ADD COLUMN `planned_metrics_id` INT NOT NULL AFTER `activity_log_id`,
ADD COLUMN `activity_id` INT NOT NULL AFTER `planned_metrics_id`,
ADD COLUMN `specific_objective_id` INT NOT NULL AFTER `activity_id`,
ADD COLUMN `projects_id` INT NOT NULL AFTER `specific_objective_id`,
ADD COLUMN `goals_id` INT NOT NULL AFTER `projects_id`,
ADD COLUMN `components_id` INT NOT NULL AFTER `goals_id`,
ADD COLUMN `action_lines_id` INT NOT NULL AFTER `components_id`,
ADD COLUMN `Program_id` INT NOT NULL AFTER `action_lines_id`,
ADD COLUMN `axes_id` INT NOT NULL AFTER `Program_id`,
ADD COLUMN `organizations_id` INT NOT NULL AFTER `axes_id`;

-- Actualizar valores basados en las relaciones existentes
UPDATE `activity_files` af 
JOIN `activity_log` al ON af.activity_log_id = al.id 
SET af.planned_metrics_id = al.planned_metrics_id,
    af.activity_id = al.activity_id,
    af.specific_objective_id = al.specific_objective_id,
    af.projects_id = al.projects_id,
    af.goals_id = al.goals_id,
    af.components_id = al.components_id,
    af.action_lines_id = al.action_lines_id,
    af.Program_id = al.Program_id,
    af.axes_id = al.axes_id,
    af.organizations_id = al.organizations_id;

-- Agregar indexes y FKs para activity_files
ALTER TABLE `activity_files` 
ADD INDEX `fk_activity_files_planned_metrics1_idx` (`planned_metrics_id`),
ADD INDEX `fk_activity_files_activities1_idx` (`activity_id`),
ADD INDEX `fk_activity_files_specific_objectives1_idx` (`specific_objective_id`),
ADD INDEX `fk_activity_files_projects1_idx` (`projects_id`),
ADD INDEX `fk_activity_files_goals1_idx` (`goals_id`),
ADD INDEX `fk_activity_files_components1_idx` (`components_id`),
ADD INDEX `fk_activity_files_action_lines1_idx` (`action_lines_id`),
ADD INDEX `fk_activity_files_Program1_idx` (`Program_id`),
ADD INDEX `fk_activity_files_axes1_idx` (`axes_id`),
ADD INDEX `fk_activity_files_organizations1_idx` (`organizations_id`);

ALTER TABLE `activity_files` 
ADD CONSTRAINT `fk_activity_files_planned_metrics1`
    FOREIGN KEY (`planned_metrics_id`)
    REFERENCES `planned_metrics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_activities1`
    FOREIGN KEY (`activity_id`)
    REFERENCES `activities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_specific_objectives1`
    FOREIGN KEY (`specific_objective_id`)
    REFERENCES `specific_objectives` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_goals1`
    FOREIGN KEY (`goals_id`)
    REFERENCES `goals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_components1`
    FOREIGN KEY (`components_id`)
    REFERENCES `components` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_action_lines1`
    FOREIGN KEY (`action_lines_id`)
    REFERENCES `action_lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_Program1`
    FOREIGN KEY (`Program_id`)
    REFERENCES `Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_axes1`
    FOREIGN KEY (`axes_id`)
    REFERENCES `axes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_activity_files_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- Agregar FKs  a tabla beneficiary_registry
ALTER TABLE `beneficiary_registry` 
ADD COLUMN `activity_id` INT NOT NULL AFTER `created_by`,
ADD COLUMN `specific_objective_id` INT NOT NULL AFTER `activity_id`,
ADD COLUMN `projects_id` INT NOT NULL AFTER `specific_objective_id`,
ADD COLUMN `goals_id` INT NOT NULL AFTER `projects_id`,
ADD COLUMN `components_id` INT NOT NULL AFTER `goals_id`,
ADD COLUMN `action_lines_id` INT NOT NULL AFTER `components_id`,
ADD COLUMN `Program_id` INT NOT NULL AFTER `action_lines_id`,
ADD COLUMN `axes_id` INT NOT NULL AFTER `Program_id`,
ADD COLUMN `organizations_id` INT NOT NULL AFTER `axes_id`;

-- Actualizar valores basados en las relaciones existentes
UPDATE `beneficiary_registry` br 
JOIN `activity_calendar` ac ON br.activity_calendar_id = ac.id 
SET br.activity_id = ac.activity_id,
    br.specific_objective_id = ac.specific_objective_id,
    br.projects_id = ac.projects_id,
    br.goals_id = ac.goals_id,
    br.components_id = ac.components_id,
    br.action_lines_id = ac.action_lines_id,
    br.Program_id = ac.Program_id,
    br.axes_id = ac.axes_id,
    br.organizations_id = ac.organizations_id;

-- Agregar indexes y FKs para beneficiary_registry
ALTER TABLE `beneficiary_registry` 
ADD INDEX `fk_beneficiary_registry_activities1_idx` (`activity_id`),
ADD INDEX `fk_beneficiary_registry_specific_objectives1_idx` (`specific_objective_id`),
ADD INDEX `fk_beneficiary_registry_projects1_idx` (`projects_id`),
ADD INDEX `fk_beneficiary_registry_goals1_idx` (`goals_id`),
ADD INDEX `fk_beneficiary_registry_components1_idx` (`components_id`),
ADD INDEX `fk_beneficiary_registry_action_lines1_idx` (`action_lines_id`),
ADD INDEX `fk_beneficiary_registry_Program1_idx` (`Program_id`),
ADD INDEX `fk_beneficiary_registry_axes1_idx` (`axes_id`),
ADD INDEX `fk_beneficiary_registry_organizations1_idx` (`organizations_id`);

ALTER TABLE `beneficiary_registry` 
ADD CONSTRAINT `fk_beneficiary_registry_activities1`
    FOREIGN KEY (`activity_id`)
    REFERENCES `activities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_specific_objectives1`
    FOREIGN KEY (`specific_objective_id`)
    REFERENCES `specific_objectives` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `projects` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_goals1`
    FOREIGN KEY (`goals_id`)
    REFERENCES `goals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_components1`
    FOREIGN KEY (`components_id`)
    REFERENCES `components` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_action_lines1`
    FOREIGN KEY (`action_lines_id`)
    REFERENCES `action_lines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_Program1`
    FOREIGN KEY (`Program_id`)
    REFERENCES `Program` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_axes1`
    FOREIGN KEY (`axes_id`)
    REFERENCES `axes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_beneficiary_registry_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- =====================================================
-- SECCIÓN 3: ACTUALIZAR PROCEDIMIENTO ALMACENADO
-- =====================================================

-- Actualizar el procedimiento para usar la columna correcta
DROP PROCEDURE IF EXISTS PublishDataSnapshot;

DELIMITER $$

CREATE PROCEDURE PublishDataSnapshot(
    IN p_published_by INT,
    IN p_publication_notes TEXT,
    IN p_period_from DATE,
    IN p_period_to DATE
)
BEGIN
    DECLARE v_publication_id INT;
    DECLARE v_projects_count INT DEFAULT 0;
    DECLARE v_activities_count INT DEFAULT 0;
    DECLARE v_metrics_count INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;

    -- Crear nuevo registro de publicación
    INSERT INTO data_publications (
        published_by, publication_notes, period_from, period_to
    ) VALUES (
        p_published_by, p_publication_notes, p_period_from, p_period_to
    );

    SET v_publication_id = LAST_INSERT_ID();

    -- Publicar proyectos (Con nombre corregido)
    INSERT INTO published_projects (
        publication_id, original_project_id, name, background, justification,
        general_objective, start_date, end_date, total_cost, funded_amount,
        cofunding_amount, financiers_id, co_financier_id, created_by
    )
    SELECT v_publication_id, id, name, background, justification, general_objective,
           start_date, end_date, total_cost, funded_amount, cofunding_amount,
           financiers_id, co_financier_id, created_by
    FROM projects;

    SET v_projects_count = ROW_COUNT();

    -- Publicar actividades
    INSERT INTO published_activities (
        publication_id, original_activity_id, name, description,
        specific_objective_id, goals_id, created_by
    )
    SELECT v_publication_id, id, name, description, specific_objective_id,
           goals_id, created_by
    FROM activities;

    SET v_activities_count = ROW_COUNT();

    -- Publicar métricas (con filtro de período opcional)
    INSERT INTO published_metrics (
        publication_id, original_metric_id, activity_id, unit, year, month,
        population_target_value, population_real_value, product_target_value,
        product_real_value
    )
    SELECT v_publication_id, id, activity_id, unit, year, month,
           population_target_value, population_real_value, product_target_value,
           product_real_value
    FROM planned_metrics
    WHERE (p_period_from IS NULL OR DATE(CONCAT(year, '-', LPAD(month, 2, '0'), '-01')) >= p_period_from)
      AND (p_period_to IS NULL OR DATE(CONCAT(year, '-', LPAD(month, 2, '0'), '-01')) <= p_period_to);

    SET v_metrics_count = ROW_COUNT();

    -- Actualizar contadores en el registro de publicación
    UPDATE data_publications
    SET projects_count = v_projects_count,
        activities_count = v_activities_count,
        metrics_count = v_metrics_count
    WHERE id = v_publication_id;

    -- Actualizar último acceso del usuario
    UPDATE users
    SET last_publication_access = NOW()
    WHERE id = p_published_by;

    COMMIT;

    -- Retornar resultado
    SELECT
        v_publication_id AS publication_id,
        v_projects_count AS projects_published,
        v_activities_count AS activities_published,
        v_metrics_count AS metrics_published,
        'SUCCESS' AS status;

END$$

DELIMITER ;

-- =====================================================
-- SECCIÓN 4: VALIDACIÓN FINAL
-- =====================================================

SET FOREIGN_KEY_CHECKS = 1;

-- Mostrar resumen de cambios aplicados
SELECT 'MODIFICACIONES COMPLETADAS EXITOSAMENTE' AS STATUS;

SELECT 
    'activities' AS tabla,
    COUNT(*) AS registros,
    'FKs cascadeantes agregados: projects_id, components_id, action_lines_id, Program_id, axes_id, organizations_id' AS cambios
FROM activities

UNION ALL

SELECT 
    'activity_calendar' AS tabla,
    COUNT(*) AS registros,
    'Columna asigned_person -> assigned_person, FK created_by corregido, location_id agregado, FKs cascadeantes' AS cambios
FROM activity_calendar

UNION ALL

SELECT 
    'planned_metrics' AS tabla,
    COUNT(*) AS registros,
    'FKs cascadeantes agregados: specific_objective_id, projects_id, goals_id, etc.' AS cambios
FROM planned_metrics

UNION ALL

SELECT 
    'projects' AS tabla,
    COUNT(*) AS registros,
    'Columna co-financier id -> co_financier_id corregida' AS cambios
FROM projects;

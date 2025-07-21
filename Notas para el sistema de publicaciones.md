# Lógica
El equipo de Estudios y Planeación Estratégica aprueba los datos con los que se compone el dashboard para las financiadoras. El flujo es:

Datos crudos -> Estudios revisa los cambios y hace click en "Publicar" -> Financiadoras ven los "ultimos" datos

# Tablas SQL
## Tabla para registrar publicaciones
### data_publications

Registra las veces que los datos han sido publicados para las financiadoras

```mysql
CREATE TABLE IF NOT EXISTS `project_management`.`data_publications` ( `id` INT NOT NULL AUTO_INCREMENT,
`publication_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
`published_by` INT NOT NULL,
`publication_notes` TEXT NULL DEFAULT NULL,
`metrics_count` INT DEFAULT 0,
`projects_count` INT DEFAULT 0, 
`activities_count` INT DEFAULT 0,
`period_from` DATE NULL DEFAULT NULL, 
`period_to` DATE NULL DEFAULT NULL,
PRIMARY KEY (`id`),
INDEX `idx_publications_date` (`publication_date` ASC),
INDEX `fk_publications_user_idx` (`published_by` ASC),
CONSTRAINT `fk_publications_user`
	FOREIGN KEY (`published_by`)
	REFERENCES `project_management`.`users` (`id`) 
) ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4 
COLLATE = utf8mb4_unicode_ci;
```

### published_projects

Datos de proyectos aprobados para publicar a financiadoras

```mysql
CREATE TABLE IF NOT EXISTS `project_management`.`published_projects` (
`id` INT NOT NULL AUTO_INCREMENT,
`publication_id` INT NOT NULL,
`original_project_id` INT NOT NULL,
`name` VARCHAR(500) NOT NULL,
`background` TEXT NULL DEFAULT NULL,
`justification` TEXT NULL DEFAULT NULL,
`general_objective` TEXT NULL DEFAULT NULL,
`start_date` DATE NULL DEFAULT NULL,
`end_date` DATE NULL DEFAULT NULL,
`total_cost` DOUBLE NULL DEFAULT NULL,
`funded_amount` DOUBLE NULL DEFAULT NULL,
`cofunding_amount` DOUBLE NULL DEFAULT NULL,
`financiers_id` INT NOT NULL,
`co_financier_id` INT NULL DEFAULT NULL,
`created_by` INT NOT NULL,
`snapshot_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`),
INDEX `idx_published_projects_original` (`original_project_id` ASC),
INDEX `idx_published_projects_financier` (`financiers_id` ASC),
INDEX `fk_published_projects_publication_idx` (`publication_id` ASC), CONSTRAINT `fk_published_projects_publication`
FOREIGN KEY (`publication_id`) 
REFERENCES `project_management`.`data_publications` (`id`),
CONSTRAINT `fk_published_projects_original`
FOREIGN KEY (`original_project_id`)
REFERENCES `project_management`.`projects` (`id`)
) ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4 
COLLATE = utf8mb4_unicode_ci;
```

###  published_metrics

Datos de metricas aprobadas para publicar a financiadoras

```mysql
CREATE TABLE IF NOT EXISTS `project_management`.`published_metrics` (
`id` INT NOT NULL AUTO_INCREMENT,
`publication_id` INT NOT NULL,
`original_metric_id` INT NOT NULL,
`activity_id` INT NOT NULL,
`unit` VARCHAR(100) NULL DEFAULT NULL,
`year` INT NULL DEFAULT NULL,
`month` INT NULL DEFAULT NULL,
`population_target_value` DECIMAL(10,2) NULL DEFAULT NULL, `population_real_value` DECIMAL(10,2) NULL DEFAULT NULL, `product_target_value` DECIMAL(10,2) NULL DEFAULT NULL,
`product_real_value` DECIMAL(10,2) NULL DEFAULT NULL,
`snapshot_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`),
INDEX `idx_published_metrics_activity` (`activity_id` ASC),
INDEX `idx_published_metrics_period` (`year` ASC, `month` ASC),
INDEX `idx_published_metrics_original` (`original_metric_id` ASC),
INDEX `fk_published_metrics_publication_idx` (`publication_id` ASC), CONSTRAINT `fk_published_metrics_publication`
FOREIGN KEY (`publication_id`)
REFERENCES `project_management`.`data_publications` (`id`),
CONSTRAINT `fk_published_metrics_original`
FOREIGN KEY (`original_metric_id`)
REFERENCES `project_management`.`planned_metrics` (`id`),
CONSTRAINT `fk_published_metrics_activity`
FOREIGN KEY (`activity_id`)
REFERENCES `project_management`.`activities` (`id`) 
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;
```

### published_activities

Datos de actividades aprobadas para publicar a financiadoras

```mysql
CREATE TABLE IF NOT EXISTS `project_management`.`published_activities` (
`id` INT NOT NULL AUTO_INCREMENT,
`publication_id` INT NOT NULL,
`original_activity_id` INT NOT NULL,
`name` VARCHAR(200) NULL DEFAULT NULL,
`description` TEXT NULL DEFAULT NULL,
`specific_objective_id` INT NOT NULL,
`goals_id` INT NOT NULL,
`created_by` INT NOT NULL,
`snapshot_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`),
INDEX `idx_published_activities_original` (`original_activity_id` ASC),
INDEX `fk_published_activities_publication_idx` (`publication_id` ASC), CONSTRAINT `fk_published_activities_publication`
FOREIGN KEY (`publication_id`)
REFERENCES `project_management`.`data_publications` (`id`),
CONSTRAINT `fk_published_activities_original`
FOREIGN KEY (`original_activity_id`)
REFERENCES `project_management`.`activities` (`id`) 
) ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;
```

## Modificaciones
Agregar derechos de acceso a publicar a usuarios del area de estudios
```mysql
ALTER TABLE `project_management`.`users` ADD COLUMN IF NOT EXISTS `can_publish_data` TINYINT(1) DEFAULT 0, ADD COLUMN IF NOT EXISTS `last_publication_access` TIMESTAMP NULL DEFAULT NULL;
```


```mysql
UPDATE users 
SET can_publish_data = 1 
WHERE system_role = 'estudios' OR org_role = 'estudios';
```
## Vistas para el proceso

### view_publication_comparison

Vista para comparar datos actuales con los publicados por ultima vez
```mysql
CREATE OR REPLACE VIEW view_publication_comparison AS
SELECT
	'metrics' AS data_type,
	 pm.id AS current_id,
	 pm.activity_id,
	 a.name AS activity_name,
	 pm.year, 
	 pm.month, 
	 pm.unit, 

	 pm.population_target_value AS current_pop_target,
	 pm.population_real_value AS current_pop_real, 
	 pm.product_target_value AS current_prod_target, 
	 pm.product_real_value AS current_prod_real, 
	 pm.updated_at AS current_updated_at, 

	 pubm.population_target_value AS published_pop_target, 
	 pubm.population_real_value AS published_pop_real, 
	 pubm.product_target_value AS published_prod_target, 
	 pubm.product_real_value AS published_prod_real, 
	 pubm.snapshot_date AS published_date, 
	 pub.published_by AS last_published_by, 
	 CONCAT(publisher.first_name, ' ', publisher.last_name_1) AS publisher_name, 

	 CASE 
	 WHEN pubm.id IS NULL THEN 'NEW' 
	 WHEN pm.population_real_value != pubm.population_real_value 
	 OR pm.product_real_value != pubm.product_real_value THEN 'CHANGED' 
	 ELSE 'UNCHANGED' END AS change_status, 

	 CASE 
	 WHEN pubm.id IS NULL THEN NULL 
	 ELSE (pm.population_real_value - pubm.population_real_value) 
	 END AS pop_real_change, 
	 
	 CASE 
	 WHEN pubm.id IS NULL THEN NULL 
	 ELSE (pm.product_real_value - pubm.product_real_value) 
	 END AS prod_real_change, 
	 -- Project context 
	 p.id AS project_id, 
	 p.name AS project_name, 
	 p.financiers_id, 
	 f.name AS financier_name 
	 
FROM planned_metrics pm 
LEFT JOIN activities a ON pm.activity_id = a.id 
LEFT JOIN specific_objectives so ON a.specific_objective_id = so.id 
LEFT JOIN projects p ON so.projects_id = p.id 
LEFT JOIN financiers f ON p.financiers_id = f.id 


LEFT JOIN ( 
	SELECT 
		pubm.*, 
		ROW_NUMBER() OVER (PARTITION BY pubm.original_metric_id ORDER BY pub.publication_date DESC) as rn 
		FROM published_metrics pubm 
		JOIN data_publications pub ON pubm.publication_id = pub.id ) pubm_ranked ON pm.id = pubm_ranked.original_metric_id AND pubm_ranked.rn = 1 
		
LEFT JOIN published_metrics pubm ON pubm_ranked.id = pubm.id 
LEFT JOIN data_publications pub ON pubm.publication_id = pub.id 
LEFT JOIN users publisher ON pub.published_by = publisher.id 
ORDER BY 
	CASE 
		WHEN pubm.id IS NULL THEN 1  
		WHEN pm.population_real_value != pubm.population_real_value 
		OR pm.product_real_value != pubm.product_real_value THEN 2 
		ELSE 3 
		END, p.name, a.name, pm.year DESC, pm.month DESC;
```


### view_publication_summary

Resumen de cambios por publicar

```mysql
CREATE OR REPLACE VIEW view_publication_summary AS
SELECT 
	-- Counts by change status 
	COUNT(*) AS total_records, 
	SUM(CASE WHEN change_status = 'NEW' THEN 1 ELSE 0 END) AS new_records, 
	SUM(CASE WHEN change_status = 'CHANGED' THEN 1 ELSE 0 END) AS changed_records, 
	SUM(CASE WHEN change_status = 'UNCHANGED' THEN 1 ELSE 0 END) AS unchanged_records, 
	-- By project 
	COUNT(DISTINCT project_id) AS projects_with_changes, 
	COUNT(DISTINCT CASE WHEN change_status IN ('NEW', 'CHANGED') THEN project_id END) AS projects_needing_update, 
	-- By financier 
	COUNT(DISTINCT financiers_id) AS financiers_affected, 
	-- Last publication info 
	(SELECT MAX(publication_date) FROM data_publications) AS last_publication_date, 
	(SELECT COUNT(*) FROM data_publications) AS total_publications,
	 -- Recent activity 
	 COUNT(CASE WHEN current_updated_at > DATE_SUB(NOW(), INTERVAL 7 DAY) THEN 1 END) AS updated_last_week, 
	 COUNT(CASE WHEN current_updated_at > DATE_SUB(NOW(), INTERVAL 30 DAY) THEN 1 END) AS updated_last_month 
	 FROM view_publication_comparison;
```

## Vistas para las financiadoras

### view_financier_published_dashboard

Vista para financiadoras usando solo datos publicados

```mysql
CREATE OR REPLACE VIEW view_financier_published_dashboard AS
	SELECT 
		pp.original_project_id AS project_id, 
		pp.name AS project_name, 
		pp.start_date, 
		pp.end_date, 
		pp.total_cost, 
		pp.funded_amount, 
		pp.cofunding_amount, 
		pp.financiers_id, 
		pp.co_financier_id, 
		f.name AS financier_name, 
		cf.name AS co_financier_name, 
		-- Published activity information 
		pa.original_activity_id AS activity_id, 
		pa.name AS activity_name, 
		pa.description AS activity_description, 
		-- Published metrics 
		pm.year, 
		pm.month, 
		pm.unit, 
		pm.population_target_value, 
		pm.population_real_value, 
		pm.product_target_value, 
		pm.product_real_value, 
		-- Progress calculations 
		CASE 
			WHEN pm.population_target_value > 0 THEN 
				ROUND((pm.population_real_value / pm.population_target_value) * 100, 2) 
			ELSE NULL 
		END AS population_progress_percent, 
		CASE 
			WHEN pm.product_target_value > 0 THEN 
		
				ROUND((pm.product_real_value / pm.product_target_value) * 100, 2) 
			ELSE NULL 
		END AS product_progress_percent, 
		-- Publication metadata 
		pub.publication_date AS data_as_of_date, 
		CONCAT(publisher.first_name, ' ',publisher.last_name_1) AS published_by_name, 
		pub.publication_notes, 
		-- Data freshness indicator 
		DATEDIFF(NOW(), pub.publication_date) AS days_since_update,
		CASE 
		WHEN DATEDIFF(NOW(), pub.publication_date) <= 7 THEN 'Fresh'
		WHEN DATEDIFF(NOW(), pub.publication_date) <= 30 THEN 'Recent' 
		WHEN DATEDIFF(NOW(), pub.publication_date) <= 90 THEN 'Stale' 
		ELSE 'Very Old' 
	END AS data_freshness 
FROM published_projects pp 
LEFT JOIN data_publications pub ON pp.publication_id = pub.id 
LEFT JOIN users publisher ON pub.published_by = publisher.id 
LEFT JOIN financiers f ON pp.financiers_id = f.id 
LEFT JOIN financiers cf ON pp.co_financier_id = cf.id 
LEFT JOIN published_activities pa ON pp.publication_id = pa.publication_id 
LEFT JOIN published_metrics pm ON pa.publication_id = pm.publication_id 
	AND pa.original_activity_id = pm.activity_id 

-- Only show the most recent publication for each project 
WHERE pp.publication_id = ( 
	SELECT MAX(pp2.publication_id) 
	FROM published_projects pp2 
	WHERE pp2.original_project_id = pp.original_project_id 
) 
ORDER BY pub.publication_date DESC, pp.name, pa.name;
```

## Procedimiento para el proceso de publicación

### PublishDataSnapshot


```mysql
CREATE PROCEDURE PublishDataSnapshot(
	IN p_published_by INT, 
	IN p_publication_notes TEXT, 
	IN p_period_from DATE, 
	IN p_period_to DATE
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
	 
	INSERT INTO data_publications (
		published_by, publication_notes, period_from, period_to 
	) VALUES ( 
	p_published_by, p_publication_notes, p_period_from, p_period_to 
	); 
	
	SET v_publication_id = LAST_INSERT_ID(); 
	

	INSERT INTO published_projects (
	 publication_id, original_project_id, name, background, justification, general_objective, start_date, end_date, total_cost, funded_amount, cofunding_amount, financiers_id, co_financier_id, created_by 
	 ) 
	 SELECT v_publication_id, id, name, background, justification, general_objective, start_date, end_date, total_cost, funded_amount, cofunding_amount, financiers_id, `co-financier_id`, created_by 
	 FROM projects;
	 
	 SET v_projects_count = ROW_COUNT();
	  

	INSERT INTO published_activities (
	 publication_id, original_activity_id, name, description, specific_objective_id, goals_id, created_by 
	 )
	 SELECT v_publication_id, id, name, description, specific_objective_id, goals_id, created_by 
	 FROM activities; 
	 
	 SET v_activities_count = ROW_COUNT();
	  

	INSERT INTO published_metrics ( 
	publication_id, original_metric_id, activity_id, unit, year, month, population_target_value, population_real_value, product_target_value, product_real_value 
	) 
	SELECT v_publication_id, id, activity_id, unit, year, month, population_target_value, population_real_value, product_target_value, product_real_value 
	FROM planned_metrics 
	WHERE (p_period_from IS NULL OR DATE(CONCAT(year, '-', LPAD(month, 2, '0'), '-01')) >= p_period_from) 
	AND (p_period_to IS NULL OR DATE(CONCAT(year, '-', LPAD(month, 2, '0'), '-01')) <= p_period_to); 
	
	SET v_metrics_count = ROW_COUNT(); 

	UPDATE data_publications 
	SET projects_count = v_projects_count, activities_count = v_activities_count, metrics_count = v_metrics_count 
	WHERE id = v_publication_id; 

	UPDATE users 
	SET last_publication_access = NOW() 
	WHERE id = p_published_by; 
	
	COMMIT;

	SELECT 
	v_publication_id AS publication_id,
	v_projects_count AS projects_published,
	v_activities_count AS activities_published,
	v_metrics_count AS metrics_published,
	'SUCCESS' AS status;
	 
END //
	  
DELIMITER ;
```

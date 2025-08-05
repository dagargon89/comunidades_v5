DELIMITER $$

DROP PROCEDURE IF EXISTS PublishDataSnapshot$$

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

    -- Publicar proyectos
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

    -- Publicar actividades CON relación al proyecto
    INSERT INTO published_activities (
        publication_id, original_activity_id, project_id, name, description,
        specific_objective_id, goals_id, created_by
    )
    SELECT v_publication_id, a.id, so.projects_id, a.name, a.description,
           a.specific_objective_id, a.goals_id, a.created_by
    FROM activities a
    JOIN specific_objectives so ON a.specific_objective_id = so.id;
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

DELIMITER;

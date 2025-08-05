-- Vista para mostrar el progreso de proyectos
-- Esta vista consolida información de proyectos, actividades, métricas planificadas,
-- calendarios de actividades y registros de beneficiarios

CREATE VIEW vista_progreso_proyectos AS
SELECT
    p.name AS Proyecto,
    p.id as Proyecto_ID,
    p.start_date as Proyecto_Fecha_Inicio,
    p.end_date as Proyecto_Fecha_Final,
    p.funded_amount as Proyecto_cantidad_financiada,
    p.financiers_id as Financiadora_id,
    p.followup_officer as Encargado_seguimiento,
    p.project_base_file as Proyecto_base,
    a.name AS Actividad,
    a.id AS Actividad_id,
    a.description AS Actividad_descripcion,
    pm.year AS year_actividad,
    pm.month AS mes_actividad,
    pm.population_target_value AS Poblacion_meta,
    pm.population_real_value AS Poblacion_alcanzada,
    pm.product_target_value AS Productos_meta,
    pm.product_real_value AS Productos_realizados,
    CASE
        WHEN pm.population_target_value > 0 THEN ROUND(
            (
                pm.population_real_value / pm.population_target_value
            ) * 100,
            2
        )
        ELSE NULL
    END AS population_progress_percent,
    CASE
        WHEN pm.product_target_value > 0 THEN ROUND(
            (
                pm.product_real_value / pm.product_target_value
            ) * 100,
            2
        )
        ELSE NULL
    END AS product_progress_percent,
    COUNT(
        DISTINCT CASE
            WHEN ac.end_date <= CURDATE() THEN ac.id
        END
    ) AS Eventos_completados,
    COUNT(
        DISTINCT CASE
            WHEN ac.end_date > CURDATE() THEN ac.id
        END
    ) AS Eventos_calendarizados,
    COUNT(DISTINCT br.beneficiaries_id) AS Beneficiarios_registrados
FROM
    projects p
    LEFT JOIN specific_objectives sp ON p.id = sp.projects_id
    LEFT JOIN activities a ON a.specific_objective_id = sp.id
    LEFT JOIN planned_metrics pm ON pm.activity_id = a.id
    LEFT JOIN activity_calendars ac ON ac.activity_id = a.id
    LEFT JOIN beneficiary_registries br ON br.activity_calendar_id = ac.id
    LEFT JOIN beneficiaries b ON b.id = br.beneficiaries_id
GROUP BY
    p.id,
    p.name,
    a.id,
    a.name,
    pm.population_target_value,
    pm.population_real_value,
    pm.product_target_value,
    pm.product_real_value;

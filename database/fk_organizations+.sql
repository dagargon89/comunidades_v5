

-- Verificar que no hay FKs
/*
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE 
    REFERENCED_TABLE_SCHEMA = DATABASE()
    AND REFERENCED_TABLE_NAME IS NOT NULL
    AND (TABLE_NAME IN ('users', 'goals', 'projects', 'activities') 
         OR REFERENCED_TABLE_NAME = 'organizations')
ORDER BY TABLE_NAME, COLUMN_NAME;
*/

-- 1. RELACIONES DIRECTAS CON ORGANIZATIONS

-- Agregar FK para users.organizations_id -> organizations.id
-- Esta es la relacion mas importantes
ALTER TABLE users 
ADD CONSTRAINT fk_users_organizations 
FOREIGN KEY (organizations_id) REFERENCES organizations(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Agregar FK para goals.organizations_id -> organizations.id

ALTER TABLE goals 
ADD CONSTRAINT fk_goals_organizations 
FOREIGN KEY (organizations_id) REFERENCES organizations(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;


-- 2. RELACIONES RELACIONADAS CON USUARIOS (conexión indirecta a organizaciones)


-- Agregar FK para projects.created_by -> users.id
-- Rastrea que usuario crea el projecto
ALTER TABLE projects 
ADD CONSTRAINT fk_projects_created_by 
FOREIGN KEY (created_by) REFERENCES users(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Agregar FK para activities.created_by -> users.id
-- Rrastrea qué usuario creó cada actividad
ALTER TABLE activities 
ADD CONSTRAINT fk_activities_created_by 
FOREIGN KEY (created_by) REFERENCES users(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Agregar FK para beneficiaries.created_by -> users.id
-- Rastrea qué usuario registró cada beneficiario
ALTER TABLE beneficiaries 
ADD CONSTRAINT fk_beneficiaries_created_by 
FOREIGN KEY (created_by) REFERENCES users(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;


-- 3. RELACIONES DE JERARQUÍA DE PROYECTOS


-- Agregar FK para activities.goals_id -> goals.id

ALTER TABLE activities 
ADD CONSTRAINT fk_activities_goals 
FOREIGN KEY (goals_id) REFERENCES goals(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Agregar FK para activities.specific_objective_id -> specific_objectives.id
-- Vincula objectivos especificos con sus actividades
ALTER TABLE activities 
ADD CONSTRAINT fk_activities_specific_objectives 
FOREIGN KEY (specific_objective_id) REFERENCES specific_objectives(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Agregar FK para specific_objectives.projects_id -> projects.id
-- Vincula objetivos específicos con sus proyectos
ALTER TABLE specific_objectives 
ADD CONSTRAINT fk_specific_objectives_projects 
FOREIGN KEY (projects_id) REFERENCES projects(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- 4. RELACIONES DE FINANCIAMIENTO

-- Agregar FK para projects.financiers_id -> financiers.id
-- Vincula proyectos con su financiadora principal
ALTER TABLE projects 
ADD CONSTRAINT fk_projects_financiers 
FOREIGN KEY (financiers_id) REFERENCES financiers(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Agregar FK para projects.co_financier_id -> financiers.id
-- Vincula proyectos con su co-financiadora (si existe)
ALTER TABLE projects 
ADD CONSTRAINT fk_projects_co_financiers 
FOREIGN KEY (co_financier_id) REFERENCES financiers(id) 
ON DELETE SET NULL ON UPDATE CASCADE;


-- 5. RELACIONES DE CALENDARIO Y PROGRAMACIÓN


-- Agregar FK para activity_calendars.activity_id -> activities.id

ALTER TABLE activity_calendars 
ADD CONSTRAINT fk_activity_calendars_activities 
FOREIGN KEY (activity_id) REFERENCES activities(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- Agregar FK para activity_calendars.assigned_person -> users.id

ALTER TABLE activity_calendars 
ADD CONSTRAINT fk_activity_calendars_assigned_person 
FOREIGN KEY (assigned_person) REFERENCES users(id) 
ON DELETE SET NULL ON UPDATE CASCADE;

-- Agregar FK para activity_calendars.location_id -> locations.id

ALTER TABLE activity_calendars 
ADD CONSTRAINT fk_activity_calendars_locations 
FOREIGN KEY (location_id) REFERENCES locations(id) 
ON DELETE SET NULL ON UPDATE CASCADE;


-- 6. RELACIONES DE REGISTRO DE BENEFICIARIOS  


-- Agregar FK para beneficiary_registries.activity_calendar_id -> activity_calendars.id
-- Vincula registros de beneficiarios con eventos del calendario
ALTER TABLE beneficiary_registries 
ADD CONSTRAINT fk_beneficiary_registries_activity_calendar 
FOREIGN KEY (activity_calendar_id) REFERENCES activity_calendars(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- Agregar FK para beneficiary_registries.beneficiaries_id -> beneficiaries.id
-- Vincula registros con los beneficiarios
ALTER TABLE beneficiary_registries 
ADD CONSTRAINT fk_beneficiary_registries_beneficiaries 
FOREIGN KEY (beneficiaries_id) REFERENCES beneficiaries(id) 
ON DELETE CASCADE ON UPDATE CASCADE;


-- 7. RELACIONES DE MÉTRICAS


-- Agregar FK para planned_metrics.activity_id -> activities.id
-- Vincula métricas planificadas con sus actividades correspondientes
ALTER TABLE planned_metrics 
ADD CONSTRAINT fk_planned_metrics_activities 
FOREIGN KEY (activity_id) REFERENCES activities(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- 8. RELACIONES DEL SISTEMA DE PUBLICACIÓN

-- Agregar FK para data_publications.published_by -> users.id
-- Rastrea qué usuario realizó cada publicación de datos
ALTER TABLE data_publications 
ADD CONSTRAINT fk_data_publications_published_by 
FOREIGN KEY (published_by) REFERENCES users(id) 
ON DELETE RESTRICT ON UPDATE CASCADE;

-- Agregar FK para published_projects.publication_id -> data_publications.id
-- Vincula  proyectos publicados con su evento de publicación
ALTER TABLE published_projects 
ADD CONSTRAINT fk_published_projects_publication 
FOREIGN KEY (publication_id) REFERENCES data_publications(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- Agregar FK para published_activities.publication_id -> data_publications.id
-- Bincula  actividades publicadas con su evento de publicación
ALTER TABLE published_activities 
ADD CONSTRAINT fk_published_activities_publication 
FOREIGN KEY (publication_id) REFERENCES data_publications(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- Agregar FK para published_metrics.publication_id -> data_publications.id
-- Vincula  métricas publicadas con su evento de publicación
ALTER TABLE published_metrics 
ADD CONSTRAINT fk_published_metrics_publication 
FOREIGN KEY (publication_id) REFERENCES data_publications(id) 
ON DELETE CASCADE ON UPDATE CASCADE;

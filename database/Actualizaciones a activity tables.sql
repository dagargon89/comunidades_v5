

-- 1: Agregar columnas de FKs
ALTER TABLE activity_logs 
ADD COLUMN activity_calendar_id BIGINT(20) UNSIGNED,
ADD COLUMN beneficiary_registry_id BIGINT(20) UNSIGNED,
ADD COLUMN activity_id BIGINT(20) UNSIGNED;

-- 2: Agregar las nuevas columnas
ALTER TABLE activity_logs 
ADD COLUMN population_value INT DEFAULT 0,
ADD COLUMN product_value INT;

-- 3: Agregar restricciones de FKs
ALTER TABLE activity_logs 
ADD CONSTRAINT fk_activity_logs_calendar 
    FOREIGN KEY (activity_calendar_id) REFERENCES activity_calendar(id) 
    ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE activity_logs 
ADD CONSTRAINT fk_activity_logs_beneficiary 
    FOREIGN KEY (beneficiary_registry_id) REFERENCES beneficiary_registries(id) 
    ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE activity_logs 
ADD CONSTRAINT fk_activity_logs_activity 
    FOREIGN KEY (activity_id) REFERENCES activities(id) 
    ON DELETE CASCADE ON UPDATE CASCADE;

-- 4: Crear funciones para valores calculados
-- Función para calcular population_value (conteo de beneficiary_registries)
DELIMITER //

CREATE FUNCTION calculate_population_value(calendar_id BIGINT) 
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE pop_count INT DEFAULT 0;
    
    SELECT COUNT(br.id) INTO pop_count
    FROM beneficiary_registries br
    WHERE br.activity_calendar_id = calendar_id;
    
    RETURN pop_count;
END //

-- Calcular population_real_value para planned_metrics
CREATE FUNCTION calculate_population_real_value(activity_id BIGINT) 
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE total_pop INT DEFAULT 0;
    
    SELECT COALESCE(SUM(al.population_value), 0) INTO total_pop
    FROM activity_logs al
    WHERE al.activity_id = activity_id;
    
    RETURN total_pop;
END //

-- Calcular product_real_value para planned_metrics
CREATE FUNCTION calculate_product_real_value(activity_id BIGINT) 
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE total_prod INT DEFAULT 0;
    
    SELECT COALESCE(SUM(al.product_value), 0) INTO total_prod
    FROM activity_logs al
    WHERE al.activity_id = activity_id;
    
    RETURN total_prod;
END //

DELIMITER ;

-- 5: Actualizar registros existentes con valores calculados
-- Actualizar population_value en activity_logs
UPDATE activity_logs al
SET population_value = calculate_population_value(al.activity_calendar_id)
WHERE al.activity_calendar_id IS NOT NULL;

-- Actualizar planned_metrics con valores reales calculados
UPDATE planned_metrics pm
SET 
    population_real_value = calculate_population_real_value(pm.id),
    product_real_value = calculate_product_real_value(pm.id);

-- Paso 6: Triggers para actualizaciones automáticas
-- Triggers para la tabla activity_logs
DELIMITER //

CREATE TRIGGER update_population_value_on_insert
    BEFORE INSERT ON activity_logs
    FOR EACH ROW
BEGIN
    IF NEW.activity_calendar_id IS NOT NULL THEN
        SET NEW.population_value = calculate_population_value(NEW.activity_calendar_id);
    END IF;
END //

CREATE TRIGGER update_population_value_on_update
    BEFORE UPDATE ON activity_logs
    FOR EACH ROW
BEGIN
    IF NEW.activity_calendar_id != OLD.activity_calendar_id 
       OR (NEW.activity_calendar_id IS NOT NULL AND OLD.activity_calendar_id IS NULL) THEN
        SET NEW.population_value = calculate_population_value(NEW.activity_calendar_id);
    END IF;
END //

-- Trigger para actualizar planned_metrics cuando activity_logs cambia
CREATE TRIGGER update_planned_metrics_after_insert
    AFTER INSERT ON activity_logs
    FOR EACH ROW
BEGIN
    IF NEW.activity_id IS NOT NULL THEN
        UPDATE planned_metrics pm
        SET 
            population_real_value = calculate_population_real_value(NEW.activity_id),
            product_real_value = calculate_product_real_value(NEW.activity_id)
        WHERE pm.id = NEW.activity_id;
    END IF;
END //

CREATE TRIGGER update_planned_metrics_after_update
    AFTER UPDATE ON activity_logs
    FOR EACH ROW
BEGIN
    -- Actualizar para el nuevo activity_id
    IF NEW.activity_id IS NOT NULL THEN
        UPDATE planned_metrics pm
        SET 
            population_real_value = calculate_population_real_value(NEW.activity_id),
            product_real_value = calculate_product_real_value(NEW.activity_id)
        WHERE pm.id = NEW.activity_id;
    END IF;
    
    -- Actualizar para el activity_id anterior si era diferente
    IF OLD.activity_id IS NOT NULL AND OLD.activity_id != NEW.activity_id THEN
        UPDATE planned_metrics pm
        SET 
            population_real_value = calculate_population_real_value(OLD.activity_id),
            product_real_value = calculate_product_real_value(OLD.activity_id)
        WHERE pm.id = OLD.activity_id;
    END IF;
END //

CREATE TRIGGER update_planned_metrics_after_delete
    AFTER DELETE ON activity_logs
    FOR EACH ROW
BEGIN
    IF OLD.activity_id IS NOT NULL THEN
        UPDATE planned_metrics pm
        SET 
            population_real_value = calculate_population_real_value(OLD.activity_id),
            product_real_value = calculate_product_real_value(OLD.activity_id)
        WHERE pm.id = OLD.activity_id;
    END IF;
END //

DELIMITER ;



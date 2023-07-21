DELIMITER //

CREATE OR REPLACE PROCEDURE DVYOLYCTE(
    IN p_name VARCHAR(100),
    IN p_account VARCHAR(50),
    IN p_role VARCHAR(50),
    IN p_month VARCHAR(7),
    IN p_deliveries INT
)
BEGIN
    DECLARE p_employeeId INT;
    DECLARE p_currentDate DATE;
    
    -- Validar el formato del mes (YYYY-MM)
    IF LENGTH(p_month) != 7 OR SUBSTRING(p_month, 5, 1) != '-' OR SUBSTRING(p_month, 1, 4) REGEXP '[^0-9]' OR SUBSTRING(p_month, 6, 2) REGEXP '[^0-9]' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El formato del mes no es válido. Debe ser YYYY-MM.';
    END IF;
    
    -- Obtener la fecha actual
    SET p_currentDate = CURDATE();
    
    -- Validar que el mes no sea mayor al día de hoy
    IF CONCAT(p_month, '-01') > p_currentDate THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El mes no puede ser mayor al día de hoy.';
    END IF;
    
    -- Verificar si el account existe en la tabla employees
    SELECT id INTO p_employeeId
    FROM employees
    WHERE account = p_account;
    
    IF p_employeeId IS NULL THEN
        -- Si el account no existe, regresar un mensaje de error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de cuenta no existe en la tabla employees';
    ELSE
        -- Verificar si ya existe una entrega para el mismo mes y empleado
        IF EXISTS (SELECT 1 FROM deliveries WHERE id_employee = p_employeeId AND month = p_month) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe una entrega registrada para el mismo empleado y mes.';
        ELSE
            -- Si el account existe y no hay duplicados, registrar la entrega en la tabla deliveries_table
            INSERT INTO deliveries (id_employee, month, deliveries)
            VALUES (p_employeeId, p_month, p_deliveries);
            
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entrega registrada exitosamente';
        END IF;
    END IF;
    
END//

DELIMITER ;

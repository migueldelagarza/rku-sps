DELIMITER //

CREATE OR REPLACE PROCEDURE DVYOLYCTE(
    IN name VARCHAR(100),
    IN account VARCHAR(50),
    IN role VARCHAR(50),
    IN month VARCHAR(7),
    IN deliveries INT
)
BEGIN
    DECLARE employeeId INT;
    DECLARE currentDate DATE;
    
    -- Validar el formato del mes (YYYY-MM)
    IF LENGTH(month) != 7 OR SUBSTRING(month, 5, 1) != '-' OR NOT IS_NUMERIC(SUBSTRING(month, 1, 4)) OR NOT IS_NUMERIC(SUBSTRING(month, 6, 2)) THEN
        SELECT 'El formato del mes no es válido. Debe ser YYYY-MM.' AS ErrorMessage;
        LEAVE DVYOLYCTEProcedure;
    END IF;
    
    -- Obtener la fecha actual
    SET currentDate = CURDATE();
    
    -- Validar que el mes no sea mayor al día de hoy
    IF CONCAT(month, '-01') > currentDate THEN
        SELECT 'El mes no puede ser mayor al día de hoy.' AS ErrorMessage;
        LEAVE DVYOLYCTEProcedure;
    END IF;
    
    -- Verificar si el account existe en la tabla employees
    SELECT id_employee INTO employeeId
    FROM employees
    WHERE account = account;
    
    IF employeeId IS NULL THEN
        -- Si el account no existe, regresar un mensaje de error
        SELECT 'El número de cuenta no existe en la tabla employees' AS ErrorMessage;
    ELSE
        -- Verificar si ya existe una entrega para el mismo mes y empleado
        IF EXISTS (SELECT 1 FROM deliveries_table WHERE id_employee = employeeId AND month = month) THEN
            SELECT 'Ya existe una entrega registrada para el mismo empleado y mes.' AS ErrorMessage;
        ELSE
            -- Si el account existe y no hay duplicados, registrar la entrega en la tabla deliveries_table
            INSERT INTO deliveries_table (id_employee, month, deliveries)
            VALUES (employeeId, month, deliveries);
            
            SELECT 'Entrega registrada exitosamente' AS SuccessMessage;
        END IF;
    END IF;

    -- Etiqueta para salir del SP en caso de errores
    LEAVE DVYOLYCTEProcedure;
    
END DVYOLYCTEProcedure //

DELIMITER ;


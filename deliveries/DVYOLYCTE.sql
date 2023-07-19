DELIMITER //

CREATE OR REPLACE PROCEDURE DVYOLYCTE(
    IN name VARCHAR(100),
    IN account VARCHAR(50),
    IN role VARCHAR(50),
    IN month VARCHAR(20),
    IN deliveries INT
)
BEGIN
    DECLARE employeeId INT;
    
    -- Verificar si el número de empleado existe en la tabla employees
    SELECT id INTO employeeId
    FROM employees
    WHERE account = account;
    
    IF employeeId IS NULL THEN
        -- Si el account no existe, regresar un mensaje de error
        SELECT 'El número de empleado no existe.' AS ErrorMessage;
    ELSE
        -- Si el account existe, registrar la entrega en la tabla deliveries_table
        INSERT INTO deliveries (id_employee, month, deliveries)
        VALUES (employeeId, month, deliveries);
        
        SELECT 'Entregas registradas' AS SuccessMessage;
    END IF;
END //

DELIMITER ;

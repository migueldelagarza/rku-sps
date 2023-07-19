DELIMITER //
-- Consultar cantidad de entregas por número de empleado y mes
CREATE OR REPLACE PROCEDURE DVYOLYMNTCON(
    IN account VARCHAR(50),
    IN month VARCHAR(20)
)
BEGIN
    DECLARE employeeId INT;
    
    -- Verificar si el account existe en la tabla employees y obtener el id_employee
    SELECT id INTO employeeId
    FROM employees
    WHERE account = account;
    
    IF employeeId IS NULL THEN
        -- Si el número de empleado no existe, regresar un mensaje de error
        SELECT 'El número de empleado no existe en la tabla employees' AS ErrorMessage;
    ELSE
        -- Si el account existe, obtener la fila correspondiente de la tabla deliveries_table
        SELECT deliveries
        FROM deliveries
        WHERE id_employee = employeeId AND month = month;
    END IF;
END //

DELIMITER ;

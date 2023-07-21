DELIMITER //
-- SP para consultar empleado por su número
CREATE OR REPLACE PROCEDURE EMPOLYACCCON(
    IN p_account VARCHAR(100)
)
BEGIN
    -- Validar que la cuenta contenga sólo números
    IF p_account REGEXP '^[0-9]+$' = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta debe contener solo números.';
    END IF;

    -- Verificar si la cuenta existe en la base de datos
    IF NOT EXISTS (SELECT 1 FROM employees WHERE account = p_account) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cuenta no existe en la base de datos.';
    END IF;

    -- Consultar detalles del empleado por cuenta
    SELECT name, account, role
    FROM employees
    WHERE account = p_account;
END //

DELIMITER ;

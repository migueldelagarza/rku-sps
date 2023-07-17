DELIMITER //
-- SP para crear empleado
CREATE OR REPLACE PROCEDURE EMPOLYCTE(
    IN p_name VARCHAR(100),
    IN p_account VARCHAR(100),
    IN p_role_name VARCHAR(50)
)
BEGIN
    DECLARE p_role_id INT;
    DECLARE count_account INT;

    -- Validar que ningún campo sea NULL
    IF p_name IS NULL OR p_account IS NULL OR p_role_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Todos los campos deben ser proporcionados.';
    END IF;

    -- Obtener el ID del rol
    SELECT id INTO p_role_id FROM roles WHERE name = p_role_name;
    IF p_role_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de rol no es válido.';
    END IF;

    -- Validar el tipo de dato para el número de cuenta (p_account)
    IF p_account REGEXP '^[0-9]+$' = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de cuenta debe ser numérico.';
    END IF;

    -- Validar que el número de cuenta no se repita
    SELECT COUNT(*) INTO count_account FROM employees WHERE account = p_account;
    IF count_account > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El número de cuenta ya existe.';
    END IF;

    -- Insertar el nuevo empleado
    INSERT INTO employees (name, account, role, role_id)
    VALUES (p_name, p_account, p_role_name, p_role_id);
END //

DELIMITER ;

DELIMITER //
-- SP para consultar todos los empleados
-- Se imite id por seguridad
CREATE PROCEDURE EMPALLCON()
BEGIN
    SELECT name, account, role FROM employees;
END //

DELIMITER ;

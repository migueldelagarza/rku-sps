DELIMITER //
-- SP para consultar todos los empleados activos
-- Se imite id por seguridad
CREATE OR REPLACE PROCEDURE EMPALLCON()
BEGIN
    SELECT name, account, role FROM employees WHERE isActive = 1;
END //

DELIMITER ;

DELIMITER //
-- SP para consultar todos los roles
CREATE OR REPLACE PROCEDURE RLEALLCON()
BEGIN
  SELECT name from roles;
END //

DELIMITER ;

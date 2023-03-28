DELIMITER $$
CREATE PROCEDURE `sp_total_ingreso_por_dia`(IN fecha DATE)
BEGIN
DECLARE total INT;
SELECT `fc_calcular_total_por_dia`(fecha)
INTO total;
INSERT INTO `_auditoria_total_ingreso_por_dia` (fecha, total_por_dia)
VALUES (fecha, total);
END$$

CALL `sp_total_ingreso_por_dia`(DATE('2023-03-08'));

-- Creo un store procedure de los empleados

DELIMITER $$
CREATE PROCEDURE `sp_empleados`(IN id INT)
BEGIN
	SELECT * FROM empleado;
END $$

CALL sp_empleados();
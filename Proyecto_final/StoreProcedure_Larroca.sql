/* Creo un sp que recibe como parametro de entrada una fecha y llame a una función que calcula el total (monto) por día del estacionamiento y 
luego lo inserserte en la tabla `_auditoria_total_ingreso_por_dia` */

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

select DATE('2023-03-08 23:00:12')
SELECT `fc_calcular_total_por_dia`(DATE('2023-03-08'))

-- Creo un store procedure que me diga cuántos empleados activos tengo en el estacionamiento

DELIMITER $$
CREATE PROCEDURE `sp_empleados`()
BEGIN
	
SELECT COUNT(e.id) AS total_historico_empleados, ee.fecha_alta, ee.fecha_baja
    FROM empleado e
    JOIN estacionamiento_empleado ee ON e.id = ee.id_empleado
    WHERE ee.fecha_baja IS NULL;
END$$

CALL sp_empleados();

-- practicar 
DELIMITER $$
CREATE PROCEDURE `sp_patente`()
BEGIN
SELECT patente
FROM vehiculo v
WHERE patente like '_F%';
END$$


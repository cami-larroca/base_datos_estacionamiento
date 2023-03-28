
DELIMITER $$
CREATE FUNCTION `fc_insert_auditoria_pago`(nombre_apellido_empleado VARCHAR(45), 
										tipo_pago VARCHAR(45), 
                                        monto INT, 
                                        fecha_alta DATETIME, 
                                        operacion VARCHAR(20)) RETURNS BOOLEAN
READS SQL DATA
BEGIN
INSERT INTO `_auditoria_pago` (nombre_apellido_empleado, tipo_pago, monto, fecha_alta, operacion) 
VALUES (nombre_apellido_empleado, tipo_pago, monto, fecha_alta, operacion);
RETURN TRUE;
END$$

DELIMITER $$
CREATE FUNCTION `fc_calcular_total_por_dia`(fecha DATE) RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
DECLARE total_por_dia INT;
SELECT SUM(total)
INTO total_por_dia
FROM pago
WHERE DATE(fecha_pago) = fecha;
RETURN total_por_dia;
END$$








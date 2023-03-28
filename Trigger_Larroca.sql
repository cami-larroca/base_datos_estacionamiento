
/* Creo un trigger a partir de la tabla estacionamiento_vehiculo, cada vez que se inserta un nuevo registro en ella (ingresa un nuevo vehiculo)
luego se inserta en la tabla _auditoria */

 CREATE TRIGGER `tr_insert_vehiculo`
 AFTER INSERT ON `estacionamiento_vehiculo`
 FOR EACH ROW
 INSERT INTO `_auditoria` (id_estac_vehiculo, fecha_hora_registro, operacion)
 VALUES (NEW.id, new.fecha_ingreso, 'insert');
  
 
/* Creo un trigger a partir de la tabla estacionamiento_vehiculo, hago un after update insert, luego de actualizar un registro, 
se inserta en la tabla _auditoria, con fecha actual  */

 CREATE TRIGGER `tr_insert_update_vehiculo`
 AFTER UPDATE ON `estacionamiento_vehiculo`
 FOR EACH ROW
 INSERT INTO `_auditoria` (id_estac_vehiculo, id_pago, fecha_hora_registro, operacion)
 VALUES (NEW.id, NEW.id_pago, CURRENT_TIMESTAMP(), 'insert_update');
  
  
/* Creo un trigger a partir de la tabla estacionamiento_vehiculo, con un before insert, antes de que se inserte un nuevo registro en ella
inserto la fecha y hora actual*/

DELIMITER $$
CREATE TRIGGER `tr_before_insert_vehiculo`
BEFORE INSERT
ON `estacionamiento_vehiculo` FOR EACH ROW
BEGIN
    set NEW.fecha_ingreso = CURRENT_TIMESTAMP();
END$$

-
/* Creo un trigger a partir de la tabla pago, cada vez que se inserta un nuevo registro en ella
luego se inserta en la tabla _auditoria_pago */

DELIMITER $$
CREATE TRIGGER `tr_after_insert_pago`
AFTER INSERT
ON pago FOR EACH ROW
BEGIN
 DECLARE nombre_apellido VARCHAR(45);
 DECLARE tipo_pago VARCHAR(45);
 DECLARE resultado_funcion_boolean BOOLEAN;
 SELECT CONCAT(e.nombre, ' ', e.apellido), tp.tipo
 INTO nombre_apellido, tipo_pago 
 FROM empleado e, tipo_pago tp
 WHERE e.id = NEW.id_empleado 
 AND tp.id = NEW.id_tipo_pago;
 SELECT `fc_insert_auditoria_pago`(nombre_apellido, tipo_pago, NEW.total, NEW.fecha_pago, 'insert')
 INTO resultado_funcion_boolean;
END$$

DROP TRIGGER `tr_after_insert_pago`;


/* Creo un trigger a partir de la tabla pago, con un before insert, para que antes de insertar un nuevo registro, me inserte la fecha y hora actual*/

DELIMITER $$
CREATE TRIGGER `tr_before_insert_pago`
BEFORE INSERT
ON `pago` FOR EACH ROW
BEGIN
    set NEW.fecha_pago = CURRENT_TIMESTAMP();
END$$
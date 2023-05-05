SELECT @@AUTOCOMMIT;

SET AUTOCOMMIT = 0;

START TRANSACTION;
DELETE FROM vehiculo
WHERE color = 'Verde';

-- commit;

START TRANSACTION;
DELETE FROM estacionamiento_empleado
WHERE id_turno = '2';

-- rollback;

START TRANSACTION;
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (1, 'AF367GH', 'Blanco');
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (1, 'AD888VC', 'Negro');
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (1, 'AE112BH', 'Gris');
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (1, 'AE990KO', 'Blanco');
savepoint lote_1;
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (2, 'AF366YT', 'Blanco');
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (2, 'AF330LO', 'Blanco');
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (2, 'AE223RE', 'Blanco');
INSERT INTO vehiculo (id_tipo_vehiculo, patente, color) VALUES (2, 'AE441ZQ', 'Blanco');
savepoint lote_2;

SELECT * FROM vehiculo;

-- ROLLBACK TO lote_1;

SELECT * FROM vehiculo;

-- RELEASE SAVEPOINT lote_1;

rollback;



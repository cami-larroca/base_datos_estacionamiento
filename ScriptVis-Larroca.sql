-- Creo una vista para que de forma rápida y detallada me brinde un listado de los autos que se encuentran en el estacionamiento

CREATE VIEW autos_en_estacionamiento AS
(SELECT v.patente, v.color, ev.fecha_ingreso   
FROM estacionamiento_vehiculo as ev
INNER JOIN vehiculo as v ON ev.id_vehiculo = v.id
WHERE ev.fecha_egreso IS NULL AND ev.id_pago IS NULL);

SELECT * FROM autos_en_estacionamiento;

-- Creo una vista que me detalle el movimiento de los vehiculos y el total a abonar. 

CREATE VIEW movimiento_vehiculo AS
(SELECT ev.id_vehiculo, ev.fecha_ingreso, ev.fecha_egreso, p.total
FROM estacionamiento_vehiculo as ev
INNER JOIN pago as p ON ev.id_vehiculo = p.id
WHERE ev.fecha_egreso IS NOT NULL);

SELECT * FROM movimiento_vehiculo;

-- Creo una vista que me liste a los empleados activos del estacionamiento

CREATE VIEW empleados_activos AS
(SELECT em.id, em.nombre, em.apellido, ee.fecha_alta
FROM empleado as em
INNER JOIN estacionamiento_empleado as ee ON em.id = ee.id_empleado
WHERE ee.fecha_baja IS NULL);

-- Modifico la vista anterior, le agrego un campo que me muestre a qué turno pertenece el empleado activo 

CREATE OR REPLACE VIEW empleados_activos AS
(SELECT tt.tipo as tipo_turno, em.id as id_empleado, em.nombre, em.apellido, ee.fecha_alta
FROM empleado as em
INNER JOIN estacionamiento_empleado as ee ON em.id = ee.id_empleado
INNER JOIN turno as t ON ee.id_turno = t.id
INNER JOIN turno_tipo as tt ON t.id_tipo_turno = tt.id
WHERE ee.fecha_baja IS NULL);

SELECT * FROM empleados_activos;

-- Creo una vista que me detalle el precio por hora vigente por vehiculo

CREATE VIEW precio_actualizado_por_vehiculo AS
(SELECT p.id_estacionamiento, p.precio, p.fecha_desde, tt.tipo
FROM precio as p 
INNER JOIN tipo_vehiculo as tt ON p.id_tipo_vehiculo = tt.id
WHERE p.fecha_hasta IS NULL);

SELECT * FROM precio_actualizado_por_vehiculo;

-- Creo una vista que me muestre qué turno tiene el mayor recaudo 

CREATE VIEW total_facturado_por_turno AS 
(SELECT tt.tipo, SUM(p.total) as total
FROM estacionamiento_vehiculo as ev
INNER JOIN pago as p ON p.id = ev.id_pago
INNER JOIN empleado as e ON e.id = p.id_empleado
INNER JOIN estacionamiento_empleado as ee ON ee.id_empleado = e.id
INNER JOIN turno as t ON t.id = ee.id_turno
INNER JOIN turno_tipo tt ON t.id = tt.id
GROUP BY tt.tipo
ORDER BY tt.tipo);

SELECT * FROM total_facturado_por_turno;

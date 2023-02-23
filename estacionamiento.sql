CREATE SCHEMA estacionamiento;

USE estacionamiento;

CREATE TABLE turno_tipo (
id int NOT NULL AUTO_INCREMENT,
tipo varchar(10) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE tipo_pago (
id int NOT NULL AUTO_INCREMENT,
tipo varchar(25) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE tipo_vehiculo (
id int NOT NULL AUTO_INCREMENT,
tipo varchar(15) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE empleado (
id int NOT NULL AUTO_INCREMENT,
nombre varchar(30) NOT NULL,
apellido varchar(30) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE estacionamiento (
id int NOT NULL AUTO_INCREMENT,
nombre varchar(30) NOT NULL,
razon_social varchar(50) DEFAULT NULL,
cuit varchar(15) DEFAULT NULL,
capacidad_total int NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE vehiculo (
id int NOT NULL AUTO_INCREMENT,
id_tipo_vehiculo int NOT NULL,
patente varchar(20) DEFAULT NULL,
color varchar(20) DEFAULT NULL,
PRIMARY KEY (id),
KEY FK_vehiculo_tipo_idx (id_tipo_vehiculo),
CONSTRAINT FK_vehiculo_tipo FOREIGN KEY (id_tipo_vehiculo) REFERENCES tipo_vehiculo (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE pago (
id int NOT NULL AUTO_INCREMENT,
id_tipo_pago int NOT NULL,
total decimal(10,0) NOT NULL,
fecha_pago datetime NOT NULL,
PRIMARY KEY (id),
KEY FK_pago_tipo_pago_idx (id_tipo_pago),
CONSTRAINT FK_pago_tipo_pago FOREIGN KEY (id_tipo_pago) REFERENCES tipo_pago (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE precio (
id int NOT NULL AUTO_INCREMENT,
id_estacionamiento int NOT NULL,
precio int NOT NULL,
fecha_desde datetime NOT NULL,
fecha_hasta datetime DEFAULT NULL,
PRIMARY KEY (id),
KEY FK_precio_estacionamiento_idx (id_estacionamiento),
CONSTRAINT FK_precio_estacionamiento FOREIGN KEY (id_estacionamiento) REFERENCES estacionamiento (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE telefono (
id int NOT NULL AUTO_INCREMENT,
id_estacionamiento int NOT NULL,
codigo_area int NOT NULL,
numero int NOT NULL,
fecha_desde datetime NOT NULL,
fecha_hasta datetime DEFAULT NULL,
PRIMARY KEY (id),
KEY FK_telefono_estacionamiento_idx (id_estacionamiento),
CONSTRAINT FK_telefono_estacionamiento FOREIGN KEY (id_estacionamiento) REFERENCES estacionamiento (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE turno (
id int NOT NULL AUTO_INCREMENT,
id_tipo_turno int NOT NULL,
hora_desde time NOT NULL,
hora_hasta time NOT NULL,
PRIMARY KEY (id),
KEY FK_turno_tipo_idx (id_tipo_turno),
CONSTRAINT FK_turno_tipo FOREIGN KEY (id_tipo_turno) REFERENCES turno_tipo (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE estacionamiento_empleado (
id_estacionamiento int NOT NULL,
id_empleado int NOT NULL,
id_turno int NOT NULL,
fecha_alta datetime NOT NULL,
fecha_baja datetime DEFAULT NULL,
PRIMARY KEY (id_estacionamiento,id_empleado,fecha_alta),
KEY FK_estacionamiento_empleado_turno_idx (id_turno),
KEY FK_estacionamiento_empleado_idx (id_empleado),
CONSTRAINT FK_estacionamiento_empleado FOREIGN KEY (id_empleado) REFERENCES empleado (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT FK_estacionamiento_empleado_estacionamiento FOREIGN KEY (id_estacionamiento) REFERENCES estacionamiento (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT FK_estacionamiento_empleado_turno FOREIGN KEY (id_turno) REFERENCES turno (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE estacionamiento_vehiculo (
id_estacionamiento int NOT NULL,
id_vehiculo int NOT NULL,
id_pago int NOT NULL,
fecha_ingreso datetime NOT NULL,
fecha_egreso datetime DEFAULT NULL,
PRIMARY KEY (id_estacionamiento,id_vehiculo,id_pago),
KEY FK_estacionamiento_vehiculo_pago_idx (id_pago),
KEY FK_estacionamiento_vehiculo_vehiculo_idx (id_vehiculo),
CONSTRAINT FK_estacionamiento_vehiculo_estacionamiento FOREIGN KEY (id_estacionamiento) REFERENCES estacionamiento (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT FK_estacionamiento_vehiculo_pago FOREIGN KEY (id_pago) REFERENCES pago (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT FK_estacionamiento_vehiculo_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE precio_tipo_vehiculo (
id_precio int NOT NULL,
id_tipo_vehiculo int NOT NULL,
PRIMARY KEY (id_precio,id_tipo_vehiculo),
KEY FK_precio_tipo_vehiculo_idx (id_tipo_vehiculo),
CONSTRAINT FK_precio_precio FOREIGN KEY (id_precio) REFERENCES precio (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT FK_precio_tipo_vehiculo FOREIGN KEY (id_tipo_vehiculo) REFERENCES vehiculo (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE auditoria (
id int NOT NULL AUTO_INCREMENT,
id_estac_vehiculo int NOT NULL,
id_estac_empleado int NOT NULL,
id_pago int NOT NULL,
PRIMARY KEY (id),
KEY FK_auditoria_estacionamiento_vehiculo_idx (id_estac_vehiculo),
KEY FK_auditoria_estacionamiento_empleado_idx (id_estac_empleado),
KEY FK_auditoria_pago_idx (id_pago),
CONSTRAINT FK_auditoria_estacionamiento_empleado FOREIGN KEY (id_estac_empleado) REFERENCES estacionamiento_empleado (id_estacionamiento) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT FK_auditoria_estacionamiento_vehiculo FOREIGN KEY (id_estac_vehiculo) REFERENCES estacionamiento_vehiculo (id_estacionamiento) ON DELETE RESTRICT ON UPDATE RESTRICT,
CONSTRAINT FK_auditoria_pago FOREIGN KEY (id_pago) REFERENCES pago (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);
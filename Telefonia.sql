/*
	CREADO POR: DANIEL VILLALOBOS HERNÁNDEZ
	FECHA: 25 de Enero de 2018
	PARA: BASES DE DATOS
*/

DROP DATABASE IF EXISTS Telefonia; 
CREATE DATABASE Telefonia;
USE Telefonia;

CREATE TABLE clientes (
	DNI CHAR(9),
	Nombre VARCHAR(20),
	Apellidos VARCHAR(50),
	Telefono CHAR(9),
	Email TEXT,
	CONSTRAINT PK_clientes PRIMARY KEY (DNI)
);

CREATE TABLE tiendas (
	nombre VARCHAR(20),
	provincia VARCHAR(20),
	localidad VARCHAR(20) ,
	Direccion TEXT,
	telefono CHAR(9),
	DiaApertura ENUM ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'),
	DiaCierre ENUM ('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'),
	HoraApertura TIME,
	HoraCierre TIME,
	CONSTRAINT PK_tiendas PRIMARY KEY (nombre)
);

CREATE TABLE operadoras (
	nombre VARCHAR(20),
	colorLogo VARCHAR(20),
	PorcentajeCobertura INT(2) UNSIGNED,
	FrecuenciaGSM FLOAT(4,1) UNSIGNED,
	PaginaWeb TEXT,
	CONSTRAINT PK_operadoras PRIMARY KEY (nombre)
);

CREATE TABLE tarifas (
	nombre VARCHAR(20),
	nombre_OPERADORAS VARCHAR(20),
	TamañoDatos INT(2) UNSIGNED,
	TipoDatos CHAR(2),
	MinutosGratis INT(3) UNSIGNED,
	SMSGratis INT(3) UNSIGNED,
	CONSTRAINT PK_tarifas PRIMARY KEY (nombre),
	CONSTRAINT FK_operadoras FOREIGN KEY (nombre_OPERADORAS) REFERENCES operadoras (nombre) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE moviles (
	marca VARCHAR(20),
	modelo VARCHAR(20),
	descripcion TEXT,
	SO VARCHAR(30),
	RAM INT(1) UNSIGNED,
	PulgadasPantalla FLOAT(2.1) UNSIGNED,
	CamaraMpx INT(2) UNSIGNED,
	CONSTRAINT PK_moviles PRIMARY KEY (marca, modelo)
);

CREATE TABLE movil_libre (
	marca_MOVILES VARCHAR(20),
	modelo_MOVILES VARCHAR(20),
	precio FLOAT (4.2) UNSIGNED,
	CONSTRAINT FK_moviles FOREIGN KEY (marca_MOVILES, modelo_MOVILES) REFERENCES moviles (marca, modelo) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE movil_contrato (
	marca_MOVILES VARCHAR(20),
	modelo_MOVILES VARCHAR(20),
	nombre_OPERADORAS VARCHAR(20),
	precio FLOAT(4.2) UNSIGNED,
	CONSTRAINT FK_moviles1 FOREIGN KEY (marca_MOVILES, modelo_MOVILES) REFERENCES moviles (marca, modelo) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_operadoras1 FOREIGN KEY (nombre_OPERADORAS) REFERENCES operadoras	(nombre) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE ofertas (
	nombre_OPERADORAS_TARIFAS VARCHAR(20),
	nombre_TARIFAS VARCHAR(20),
	marca_MOVIL_CONTRATO VARCHAR(20),
	modelo_MOVIL_CONTRATO VARCHAR(20),
	CONSTRAINT FK_TARIFAS FOREIGN KEY (nombre_OPERADORAS_TARIFAS, nombre_TARIFAS) REFERENCES tarifas	(nombre_OPERADORAS, nombre) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_CONTRATO FOREIGN KEY (marca_MOVIL_CONTRATO, modelo_MOVIL_CONTRATO) REFERENCES movil_contrato (marca_MOVILES, modelo_MOVILES) ON DELETE RESTRICT ON UPDATE RESTRICT  
);


CREATE TABLE compras (
	DNI_CLIENTES CHAR(9),
	Nombre_TIENDA VARCHAR(20),
	Marca_MOVILES_LIBRE VARCHAR(20),
	Modelo_MOVILES_LIBRE VARCHAR(20),
	dia DATE,
	CONSTRAINT FK_clientes FOREIGN KEY (DNI_CLIENTES) REFERENCES clientes (DNI) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_tienda FOREIGN KEY (Nombre_TIENDA) REFERENCES tiendas (nombre) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_MOVILES_LIBRE FOREIGN KEY (Marca_MOVILES_LIBRE, Modelo_MOVILES_LIBRE) REFERENCES movil_libre (marca_MOVILES, modelo_MOVILES) ON DELETE RESTRICT ON UPDATE RESTRICT
);


CREATE TABLE contratos (
	DNI_CLIENTE CHAR(9),
	Nombre_TIENDA VARCHAR(20),
	Nombre_OPERADORAS_TARIFAS_OFERTAS VARCHAR(20),
	Nombre_TARIFAS_OFERTAS VARCHAR(20),
	Marca_MOVILES_OFERTAS VARCHAR(20),
	Modelos_MOVILES_OFERTAS VARCHAR(20),
	dia DATE,
	CONSTRAINT FK_clientes1 FOREIGN KEY (DNI_CLIENTE) REFERENCES clientes (DNI) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_tienda1 FOREIGN KEY (Nombre_TIENDA) REFERENCES tiendas (nombre) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_OFERTAS FOREIGN KEY  (Nombre_OPERADORAS_TARIFAS_OFERTAS, Nombre_TARIFAS_OFERTAS) REFERENCES ofertas (nombre_OPERADORAS_TARIFAS, nombre_TARIFAS) ON DELETE RESTRICT ON UPDATE RESTRICT,
	CONSTRAINT FK_MOVILES_OFERTAS FOREIGN KEY (Marca_MOVILES_OFERTAS, Modelos_MOVILES_OFERTAS) REFERENCES ofertas (marca_MOVIL_CONTRATO, modelo_MOVIL_CONTRATO) ON DELETE RESTRICT ON UPDATE RESTRICT
);


INSERT INTO clientes (DNI, Nombre, Apellidos, Telefono, Email) VALUES
	('09068748D', 'Daniel', 'Villalobos Hernandez', '636642858', 'danielvh@gmail.com' ),
	('01234567A', 'Jose', 'Nuñez Garcia', '123456789', 'elcejas@gmail.com' ),
	('11111111Z', 'Samuel', 'Zuñiga Velez', '666148818', 'dalemacarena@gmail.com' ),
	('33687826G', 'Emilio', 'Muñoz Rangel', '606874825', 'e.muñoz@gmail.com' ),
	('41159512D', 'Carlos', 'Lopez Holgera', '605802275', 'CLH1488@gmail.com' );

INSERT INTO tiendas (nombre, provincia, localidad, Direccion, telefono, DiaApertura, DiaCierre, HoraApertura, HoraCierre) VALUES
	('MOVISTAR', 'MADRID', 'MADRID', 'Paseo de la Castellana 51', '918027723', 'Lunes', 'Sabado', '09:00:00', '21:00:00'),
	('VODAFONE', 'MADRID', 'MADRID', 'C.Isaac Peral 4', '902874825', 'Lunes', 'Miercoles', '10:00:00', '20:00:00'),
	('PEPEPHONE', 'GALICIA', 'ACORUÑA', 'Rúa San Leandro 5', '802504666', 'Lunes', 'Domingo', '8:30:00', '18:00:00'),
	('YOIGO', 'ASTURIAS', 'OVIEDO', 'Calle José Ramón Zaragoza 6', '981249830', 'Lunes', NULL , '09:00:00', '17:30:00' ),
	('ORANGE', 'ANDALUCÍA', 'SEVILLA', 'Av. de la Palmera s/n 41012 Sevilla', '954230600', 'Miercoles', 'Sabado', '09:00:00', '21:00:00');

INSERT INTO operadoras (nombre, colorLogo, PorcentajeCobertura, FrecuenciaGSM, PaginaWeb) VALUES
	('Movistar', 'azul', '70', '380.2', 'www.movistar.es'),
	('Vodafone', 'rojo', '71', '410.2', 'www.vodafone.es' ),
	('Masmovil', 'naranja', '56', '450.4', 'www.masmovil.es' ),
	('pepephone', 'rojo', '60', '478.8', 'www.pepephone.es' ),
	('yoigo', 'morado', '50', '698.0', 'www.yoigo.es' ),
	('orange', 'naranja', '65', '824.0', 'www.orange.es' );

INSERT INTO tarifas (nombre, nombre_OPERADORAS, TamañoDatos, TipoDatos, MinutosGratis, SMSGratis) VALUES
	('One Light', 'Vodafone', '3', 'GB', '200', '100'),
	('La combinada verde', 'yoigo', '5', 'GB', '200', '100'),
	('One', 'Vodafone', '2', 'GB', '0', '100'),
	('Love', 'orange', '4', 'GB', '999', '100'),
	('La combinada morada', 'yoigo', '5', 'GB', '999', '100');

INSERT INTO moviles (marca, modelo, descripcion, SO, RAM, PulgadasPantalla, CamaraMpx) VALUES 
	('Apple', 'Iphone X', 'El nuevo iPhone X es el modelo de teléfono de Apple más arriesgado y completo desde que hace ya diez años se presentará el primer iPhone. En su ficha técnica nos encontramos con numerosas novedades, giros y cambios respecto a las bases que Apple había mantenido para el iPhone en estos diez años.', 'iOS11', '3', '5.8', '12'), 
	('Samsung', 'Note 8', 'La tendencia del mercado es la de ofrecer dispositivos alargados. Teléfonos que abandonan progresivamente los 16:9 para ir más allá, hasta los 18:9 como en el caso de LG, o incluso hasta los 18,5:9 en el caso de Samsung. Un aspecto que ya vimos en los Galaxy S8 y S8 Plus y que se perpetúa en este Galaxy Note 8 meses después.', 'Android 7.1.1', '6', '6.3', '12'),
	('LG', 'V30', ' LG por fin deja atrás ese tiempo en el que su serie V era una exclusiva de Estados Unidos y se suma a la tendencia de otros fabricantes de lanzar dos gama alta en el mismo año. Primero fue el LG G6 y ahora le toca el turno al LG V30.', 'Android7.1.2', '4', '6.0', '16'), 
	('Bq', 'Aquiaris X', 'Ganar en la gama media no es fácil cuando implica dar en el clavo en el gran abanico de posibilidades de quien no quiere ni mucho ni poco, pero además hay que destacar de alguna manera. BQ sigue apostando por la sencillez', 'Android 7.1.1', '3', '5.2', '16'),
	('Alcatel', 'U5', 'Este modelo cuenta con prestaciones comedidas. Está destinado a aquellos usuarios que necesitan un móvil para usar apps, juegos sencillos, navegar… Su diseño, además, es elegante y discreto. Con bordes ligeramente redondeados que van a permitir un mejor agarre.', 'Android 6.0', '1', '5.0', '5');

INSERT INTO movil_libre (marca_MOVILES, modelo_MOVILES, precio) VALUES
	('Apple', 'Iphone X', '1100.00'),
	('Samsung', 'Note 8', '1010.33'),
	('LG', 'V30', '899.00'),
	('Bq', 'Aquiaris X', '253.76'),
	('Alcatel', 'U5', '100.00');

INSERT INTO movil_contrato (marca_MOVILES, modelo_MOVILES, nombre_OPERADORAS, precio) VALUES
	('Apple', 'Iphone X', 'Vodafone', '1009.00'),
	('Samsung', 'Note 8', 'yoigo', '999.33'),
	('LG', 'V30', 'Masmovil', '500.00'),
	('Bq', 'Aquiaris X', 'pepephone', '253.76'),
	('Alcatel', 'U5', 'orange', '100.00');

INSERT INTO ofertas (nombre_OPERADORAS_TARIFAS, nombre_TARIFAS, marca_MOVIL_CONTRATO, modelo_MOVIL_CONTRATO ) VALUES
	('Vodafone', 'One Light', 'Apple', 'Iphone X'),
	('yoigo', 'La combinada verde','Samsung', 'Note 8'),
	('Vodafone', 'One', 'LG', 'V30'),
	('orange', 'Love','Bq', 'Aquiaris X'),
	('yoigo', 'La combinada morada','Alcatel', 'U5');

INSERT INTO compras (DNI_CLIENTES, Nombre_TIENDA, Marca_MOVILES_LIBRE, Modelo_MOVILES_LIBRE, dia) VALUES
	('09068748D','MOVISTAR','Apple','Iphone X','1997/09/04'),
	('01234567A','VODAFONE','Samsung','Note 8','1996/02/08'),
	('11111111Z','YOIGO','LG','V30','1967/08/11'),
	('33687826G','PEPEPHONE','Bq','Aquiaris X','1968/11/3'),
	('41159512D','ORANGE','Alcatel','U5','1998/12/10'); 

INSERT INTO contratos (DNI_CLIENTE, Nombre_TIENDA, Nombre_OPERADORAS_TARIFAS_OFERTAS, Nombre_TARIFAS_OFERTAS, Marca_MOVILES_OFERTAS, Modelos_MOVILES_OFERTAS, dia) VALUES 
	('09068748D','VODAFONE','Vodafone','One light', 'Apple', 'Iphone X','1997/09/04'),
	('01234567A','ORANGE','orange','Love','Bq', 'Aquiaris X','1996/02/08'),
	('11111111Z','YOIGO','yoigo','La combinada verde','Samsung', 'Note 8','1967/08/11'),
	('33687826G','ORANGE','orange','Love','Bq', 'Aquiaris X','1968/11/3'),
	('41159512D','ORANGE','orange','Love','Bq', 'Aquiaris X','1998/12/10'); 




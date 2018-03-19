/*
	CREADO POR: DANIEL VILLALOBOS HERNÁNDEZ
	FECHA: 05 de Febrero de 2018
	PARA: BASES DE DATOS
*/

/*
Entrar desde la linea de comandos a MYSQL con usuario root y sin que se vea la escritura de la contraseña

	mysql -u root -p
*/

SHOW DATABASES;
DROP DATABASE IF EXISTS meteo;
CREATE DATABASE meteo;
USE meteo;

CREATE TABLE Ciudad (
	Codigo INT(2),
	Nombre VARCHAR(20),
	CONSTRAINT PK_Ciudad PRIMARY KEY (Codigo)
);

CREATE TABLE Temperatura (
	Dia DATE,
	Codigo_Ciudad INT(2),
	Grados INT(2),
	CONSTRAINT FK_Ciudad_Temp FOREIGN KEY (Codigo_Ciudad) REFERENCES Ciudad (Codigo)
);

CREATE TABLE Humedad (
	Dia DATE,
	Codigo_Ciudad INT(2),
	Porcentaje INT(3),
	CONSTRAINT FK_Ciudad_Hume FOREIGN KEY (Codigo_Ciudad) REFERENCES Ciudad (Codigo)
);

CREATE TABLE Informe (
	ID INT (2) AUTO_INCREMENT,
	Dia DATE,
	Codigo_Ciudad INT(2),
	CONSTRAINT PK_Informe PRIMARY KEY (ID),
	CONSTRAINT FK_Ciudad_Inf FOREIGN KEY (Codigo_Ciudad) REFERENCES Ciudad (Codigo)
	
);

INSERT INTO Ciudad (Codigo, Nombre) VALUES 
	('1', 'Madrid'),
	('2', 'Barcelona'),
	('3', 'Sevilla'),
	('4', 'Alicante'),
	('5', 'Alcala De Henares');

INSERT INTO Temperatura (Dia, Codigo_Ciudad, Grados) VALUES 
	('2018/02/05', '1', '2'),
	('2018/02/05', '2', '9'),
	('2018/02/05', '3', '1'),
	('2018/02/05', '4', '9'),
	('2018/02/05', '5', '2');

INSERT INTO Humedad (Dia, Codigo_Ciudad, Porcentaje) VALUES 
	('2018/02/05', '1', '89'),
	('2018/02/05', '2', '86'),
	('2018/02/05', '3', '100'),
	('2018/02/05', '4', '87'),
	('2018/02/05', '5', '96');

INSERT INTO Informe (Dia, Codigo_Ciudad) VALUES 
	('2018/02/05', '1'),
	('2018/02/05', '2'),
	('2018/02/05', '3'),
	('2018/02/05', '4'),
	('2018/02/05', '5');


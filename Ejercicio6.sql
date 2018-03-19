DROP DATABASE IF EXISTS Ejercicio6;
CREATE DATABASE Ejercicio6;
USE Ejercicio6;

CREATE TABLE zoo (
	nombre VARCHAR(30),
	ciudad VARCHAR(20),
	pais VARCHAR(20),
	tamaños ENUM('Categoria A', 'Categoria B'),
	presupuesto FLOAT(10) UNSIGNED CHECK (presupuesto < 0),
	CONSTRAINT PK_zoo PRIMARY KEY (nombre)
);
CREATE TABLE especie (
	nomcientifico VARCHAR(40),
	nomvulgar VARCHAR(20),
	familia VARCHAR(20),
	peligro ENUM('Alto', 'Bajo', 'Medio'),
	CONSTRAINT PK_especies PRIMARY KEY (nomcientifico)
);
CREATE TABLE animal (
	ID INT(3) UNSIGNED,
	nomzoo VARCHAR(30),
	nomespecie VARCHAR(40),
	sexo ENUM('Masculino', 'Femenino'),
	añonacim YEAR,
	pais VARCHAR(20),
	continente VARCHAR(20),
	CONSTRAINT PK_especie PRIMARY KEY (ID),
	CONSTRAINT FK_zoo FOREIGN KEY (nomzoo) REFERENCES zoo (nombre),
	CONSTRAINT FK_especies FOREIGN KEY (nomespecie) REFERENCES especie (nomcientifico)
);

/*Apartado B*/

ALTER TABLE animal MODIFY ID INT AUTO_INCREMENT;
ALTER TABLE animal DROP FOREIGN KEY FK_zoo;
ALTER TABLE animal ADD CONSTRAINT FK_zoo FOREIGN KEY (nomzoo) REFERENCES zoo (nombre) ON DELETE SET NULL ON UPDATE CASCADE;

/*Apartado C*/

INSERT INTO zoo VALUES ('Zoo Madrid', 'Madrid', 'España', 'Categoria A', 608.42);
INSERT INTO especie VALUES ('Panthera tigris', 'Tigre', 'Felino', 'Alto');
INSERT INTO animal (nomzoo, nomespecie, sexo, añonacim, pais, continente) VALUES ('Zoo Madrid', 'Panthera tigris', 'Masculino', '2013', 'India', 'Asia');

/*Apartado D*/

UPDATE zoo SET nombre = 'zoo Madrid - vodafone' WHERE nombre = 'Zoo Madrid';

/******************************************************/

INSERT INTO zoo VALUES ('Zoo Madid', 'Madrid', 'España', 'Categoria A', 0);

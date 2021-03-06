DROP DATABASE IF EXISTS Ejercicio5;
CREATE DATABASE Ejercicio5;
USE Ejercicio5;

CREATE TABLE Personas(
	ID INT AUTO_INCREMENT,
	Nombre VARCHAR(20),
	Apellidos VARCHAR(40),
	Fecha_Nacimiento DATE,
	PrecioPujado DECIMAL(10,2),
	Ciudad VARCHAR(20),
	CONSTRAINT PK_Personas PRIMARY KEY(ID)
);

CREATE TABLE Orden(
	ID INT AUTO_INCREMENT,
	NumeroOrden TINYINT UNSIGNED,
	ID_Personas INT,
	CONSTRAINT PK_Orden PRIMARY KEY (ID),
	CONSTRAINT FK_Personas FOREIGN KEY (ID_Personas) REFERENCES Personas (ID) ON UPDATE CASCADE
); 

SOURCE ejercicio5_datos.sql

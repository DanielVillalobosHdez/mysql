/*
	CREADO POR: DANIEL VILLALOBOS HERNÁNDEZ
	FECHA: 05 de Febrero de 2018
	PARA: BASES DE DATOS
*/

DROP DATABASE IF EXISTS biblio;
CREATE DATABASE biblio;
USE biblio;

CREATE TABLE Socios (
	Nombre VARCHAR(20) NOT NULL,
	Direccion VARCHAR(30),
	Telefono CHAR(15),
	F_Inscripcion DATE,
	N_Socio INT AUTO_INCREMENT,
	CONSTRAINT PK_socios PRIMARY KEY (N_Socio)
);

CREATE TABLE Libros (
	Titulo VARCHAR(30) NOT NULL,
	Autor VARCHAR (20),
	FECHA_EDICION DATE,
	N_Libro INT AUTO_INCREMENT,
	CONSTRAINT PK_Libros PRIMARY KEY (N_Libro)
);

CREATE TABLE Prestamos (
	Fecha_retiro 

);

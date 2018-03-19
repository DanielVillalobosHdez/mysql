/*
	CREADO POR: DANIEL VILLALOBOS HERNÁNDEZ
	FECHA: 27 de Enero de 2018
	PARA: BASES DE DATOS
*/

DROP DATABASE IF EXISTS Starwars; 
CREATE DATABASE Starwars;
USE Starwars;

CREATE TABLE actores (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT,
	Nombre VARCHAR(20),
	Fecha DATE,
	Nacionalidad VARCHAR(20),
	CONSTRAINT PK_actores PRIMARY KEY (Codigo)
);

CREATE TABLE personajes (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT,
	Nombre VARCHAR(20),
	Raza VARCHAR(20),
	Grado INT (2),
	Codigo_Actores INT(2) UNSIGNED,
	CodigoSuperior_Personajes INT(2) UNSIGNED,
	CONSTRAINT PK_personajes PRIMARY KEY (Codigo),
	CONSTRAINT FK_actores FOREIGN KEY (Codigo_Actores) REFERENCES actores (Codigo),
	CONSTRAINT FK_personajes FOREIGN KEY (CodigoSuperior_Personajes) REFERENCES personajes (Codigo)
);

CREATE TABLE planetas (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT,
	Galaxia VARCHAR(20),
	Nombre VARCHAR(20),
	CONSTRAINT PK_planeta PRIMARY KEY (Codigo)
);

CREATE TABLE peliculas (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT,
	Titulo VARCHAR(50),
	Director VARCHAR(20),
	Año YEAR,
	CONSTRAINT PK_peliculas PRIMARY KEY (Codigo)
);

CREATE TABLE personajespeliculas (
	Codigo_Personajes INT(2) UNSIGNED,
	Codigo_peliculas INT(2) UNSIGNED,
	CONSTRAINT FK_personajes1 FOREIGN KEY (Codigo_Personajes) REFERENCES personajes(Codigo),
	CONSTRAINT FK_peliculas FOREIGN KEY (Codigo_peliculas) REFERENCES peliculas (Codigo)		
);

CREATE TABLE naves (
	Codigo INT (2) UNSIGNED AUTO_INCREMENT,
	NTripulantes INT(4) UNSIGNED,
	Nombre VARCHAR (20),
	CONSTRAINT PK_naves PRIMARY KEY (Codigo)
);

CREATE TABLE visitas (
	Codigo_Naves INT (2) UNSIGNED,
	Codigo_Planetas INT(2) UNSIGNED,
	Codigo_Peliculas INT (2) UNSIGNED,
	CONSTRAINT FK_naves FOREIGN KEY (Codigo_Naves) REFERENCES naves (Codigo),
	CONSTRAINT FK_planetas FOREIGN KEY (Codigo_Planetas) REFERENCES planetas (Codigo),
	CONSTRAINT FK_peliculas1 FOREIGN KEY (Codigo_peliculas) REFERENCES peliculas (Codigo)	
);

/******************************************************************************************************/
INSERT INTO actores (Codigo, Nombre, Fecha, Nacionalidad) VALUES 
	('1', 'Ewan McGregor', '1971/03/31', 'Escocés'),
	('2','Harrison Ford','1942/07/13','Estadounidense'),
	('3','Carrie Fisher','1956/10/21','Estadounidense'),
	('4','Mark Hamil','1951/09/25','Estadounidense'),
	('5','Kenny Baker','1934/08/14','Reino Unido');

INSERT INTO personajes (Codigo, Nombre, Raza, Grado, Codigo_Actores, CodigoSuperior_Personajes) VALUES
	('1','Obi-Wan Kenobi','Humano','10','1','1'),
	('2','Han Solo','Humano','7','2','2'),
	('3','Leia Organa','Humano','5','3','3'),
	('4','Luke Skywalker','Humano','8','4','4'),
	('5','R2-D2','Droide','2', '5','5'); 

INSERT INTO planetas (Codigo, Galaxia, Nombre) VALUES
	('1','stewjon','La galaxia'),
	('2','Corellia','Corellia'),
	('3','Alderaan','Polis Massa'),
	('4','Tatooine','Polis Massa'),
	('5','naboo','naboo');

INSERT INTO peliculas (Codigo, Titulo, Director, Año) VALUES
	('1','La amenaza fantasma','George Lucas','1999'),
	('2','El ataque de los clones','George Lucas','2002'),
	('3','La venganza de los Sith','George Lucas','2005'),
	('4','Una nueva esperanza','George Lucas','1977'),
	('5','El Imperio contraataca','Irvin Kershner','1980'),
	('6','El retorno del Jedi','Richard Marquand','1983'),
	('7','El despertar de la Fuerza','J. J. Abrams','2015'),
	('8','Los ultimos Jedi','Rian Johnson','2017');

INSERT INTO personajespeliculas (Codigo_Personajes, Codigo_peliculas) VALUES
	('1','5'),
	('2','4'),
	('3','4'),
	('4','3'),
	('5','8');

INSERT INTO naves (Codigo, NTripulantes, Nombre) VALUES
	('1','1000','Dreadnought'),
	('2','50','Halcon milenario'),
	('3','500','Malevolence'),
	('4','15','Escolta'),
	('5','30','LAAT');

INSERT INTO visitas (Codigo_Naves, Codigo_Planetas, Codigo_Peliculas) VALUES
	('1','5','1'),
	('2','2','8'),
	('3','4','2'),
	('4','3','7'),
	('5','1','3'); 



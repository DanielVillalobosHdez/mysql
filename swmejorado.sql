/*
	CREADO POR: DANIEL VILLALOBOS HERNÁNDEZ
	FECHA: 28 de Enero de 2018
	PARA: BASES DE DATOS
*/

/*
1. IF EXISTS, IF NOT EXISTS - 
2. PK AUTO_INCREMENT -
3. AÑO TIPO YEAR -
4. FOREIGN KEY -
5. CHARSET UTF8 -
6. ACTUALIZAR AUTOMATICAMENTE DATOS FOREIGN KEY -
7. FK BORRADOS A NULL-
8. ELIMINAR CODIGOSUPERIOR-
9. AÑADIR LadoFuerza VALORES Jedi, Sith -
10. LOAD DATA LOCAL INFILE 'ruta' INTO TABLE tabla; -
11. ACTUALIZAR VALOR NO CLAVE EN TABLA -
12. ACTUALIZAR VALOR CLAVE EN TABLA -
13. ACTUALIZAR VALOR CLAVE FORANEA EN TABLA -
14. BORRAR VALOR NO CLAVE EN TABLA -
15. BORRAR VALOR CLAVE EN TABLA -
16. BORRAR VALOR CLAVE FORANEA EN TABLA -
17. BORRAR TABLA VISITAS
18. BORRAR TABLA ACTORES
*/


DROP DATABASE IF EXISTS swmejorado; /*Apartado 1*/
CREATE DATABASE swmejorado;
USE swmejorado;
CREATE TABLE actores (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT, /*Apartado 2*/
	Nombre VARCHAR(20),
	Fecha DATE,
	Nacionalidad VARCHAR(20),
	CONSTRAINT PK_actores PRIMARY KEY (Codigo)
);

CREATE TABLE personajes (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT, /*Apartado 2*/
	Nombre VARCHAR(20),
	Raza VARCHAR(20),
	Grado INT (2),
	Codigo_Actores INT(2) UNSIGNED,
	CodigoSuperior_Personajes INT(2) UNSIGNED,
	CONSTRAINT PK_personajes PRIMARY KEY (Codigo),
	CONSTRAINT FK_actores FOREIGN KEY (Codigo_Actores) REFERENCES actores (Codigo) , /*Apartado 4*/
	CONSTRAINT FK_personajes FOREIGN KEY (CodigoSuperior_Personajes) REFERENCES personajes (Codigo) /*Apartado 4*/ 
);

CREATE TABLE planetas (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT, /*Apartado 2*/
	Galaxia VARCHAR(20),
	Nombre VARCHAR(20),
	CONSTRAINT PK_planeta PRIMARY KEY (Codigo)
);

CREATE TABLE peliculas (
	Codigo INT(2) UNSIGNED AUTO_INCREMENT, /*Apartado 2*/
	Titulo VARCHAR(50),
	Director VARCHAR(20),
	Año YEAR, /*Apartado 3*/ 
	CONSTRAINT PK_peliculas PRIMARY KEY (Codigo)
);

CREATE TABLE personajespeliculas (
	Codigo_Personajes INT(2) UNSIGNED,
	Codigo_peliculas INT(2) UNSIGNED,
	CONSTRAINT FK_personajes1 FOREIGN KEY (Codigo_Personajes) REFERENCES personajes(Codigo), /*Apartado 4*/
	CONSTRAINT FK_peliculas FOREIGN KEY (Codigo_peliculas) REFERENCES peliculas (Codigo) /*Apartado 4*/		
);

CREATE TABLE naves (
	Codigo INT (2) UNSIGNED AUTO_INCREMENT, /*Apartado 2*/
	NTripulantes INT(4) UNSIGNED,
	Nombre VARCHAR (20),
	CONSTRAINT PK_naves PRIMARY KEY (Codigo)
);

CREATE TABLE visitas (
	Codigo_Naves INT (2) UNSIGNED,
	Codigo_Planetas INT(2) UNSIGNED,
	Codigo_Peliculas INT (2) UNSIGNED,
	CONSTRAINT FK_naves FOREIGN KEY (Codigo_Naves) REFERENCES naves (Codigo) ,
	CONSTRAINT FK_planetas FOREIGN KEY (Codigo_Planetas) REFERENCES planetas (Codigo) ,
	CONSTRAINT FK_peliculas1 FOREIGN KEY (Codigo_peliculas) REFERENCES peliculas (Codigo) 	
);

/******************************************************************************************************/

INSERT INTO actores (Nombre, Fecha, Nacionalidad) VALUES 
	('Ewan McGregor', '1971/03/31', 'Escocés'),
	('Harrison Ford','1942/07/13','Estadounidense'),
	('Carrie Fisher','1956/10/21','Estadounidense'),
	('Mark Hamil','1951/09/25','Estadounidense'),
	('Kenny Baker','1934/08/14','Reino Unido');

INSERT INTO personajes (Nombre, Raza, Grado, Codigo_Actores, CodigoSuperior_Personajes) VALUES
	('Obi-Wan Kenobi','Humano','10','1','1'),
	('Han Solo','Humano','7','2','2'),
	('Leia Organa','Humano','5','3','3'),
	('Luke Skywalker','Humano','8','4','4'),
	('R2-D2','Droide','2', '5','5'); 

INSERT INTO planetas (Galaxia, Nombre) VALUES
	('stewjon','La galaxia'),
	('Corellia','Corellia'),
	('Alderaan','Polis Massa'),
	('Tatooine','Polis Massa'),
	('naboo','naboo');

INSERT INTO peliculas (Titulo, Director, Año) VALUES
	('La amenaza fantasma','George Lucas','1999'),
	('El ataque de los clones','George Lucas','2002'),
	('La venganza de los Sith','George Lucas','2005'),
	('Una nueva esperanza','George Lucas','1977'),
	('El Imperio contraataca','Irvin Kershner','1980'),
	('El retorno del Jedi','Richard Marquand','1983'),
	('El despertar de la Fuerza','J. J. Abrams','2015'),
	('Los ultimos Jedi','Rian Johnson','2017');

INSERT INTO personajespeliculas (Codigo_Personajes, Codigo_peliculas) VALUES
	('1','5'),
	('2','4'),
	('3','4'),
	('3','3'),
	('5','8');

INSERT INTO naves (NTripulantes, Nombre) VALUES
	('1000','Dreadnought'),
	('50','Halcon milenario'),
	('500','Malevolence'),
	('15','Escolta'),
	('30','LAAT');

INSERT INTO visitas (Codigo_Naves, Codigo_Planetas, Codigo_Peliculas) VALUES
	('1','5','1'),
	('2','2','8'),
	('3','4','2'),
	('4','3','7'),
	('5','1','3'); 

/*************************************************************************************/

/*Apartado 5*/

ALTER TABLE actores CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE personajes CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE planetas CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE peliculas CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE personajespeliculas CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE naves CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE visitas CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;

/*Apartado 6 y 7*/

ALTER TABLE personajes DROP FOREIGN KEY FK_actores;
ALTER TABLE personajes DROP FOREIGN KEY FK_personajes;
ALTER TABLE personajespeliculas DROP FOREIGN KEY FK_personajes1;
ALTER TABLE personajespeliculas DROP FOREIGN KEY FK_peliculas;
ALTER TABLE visitas DROP FOREIGN KEY FK_naves;
ALTER TABLE visitas DROP FOREIGN KEY FK_planetas;
ALTER TABLE visitas DROP FOREIGN KEY FK_peliculas1;

ALTER TABLE personajes ADD CONSTRAINT FK_actores FOREIGN KEY (Codigo_Actores) REFERENCES actores (Codigo) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE personajes ADD CONSTRAINT FK_personajes FOREIGN KEY (CodigoSuperior_Personajes) REFERENCES personajes (Codigo) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE personajespeliculas ADD CONSTRAINT FK_personajes1 FOREIGN KEY (Codigo_Personajes) REFERENCES personajes(Codigo) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE personajespeliculas ADD CONSTRAINT FK_peliculas FOREIGN KEY (Codigo_peliculas) REFERENCES peliculas (Codigo) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE visitas ADD CONSTRAINT FK_naves FOREIGN KEY (Codigo_Naves) REFERENCES naves (Codigo) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE visitas ADD CONSTRAINT FK_planetas FOREIGN KEY (Codigo_Planetas) REFERENCES planetas (Codigo) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE visitas ADD CONSTRAINT FK_peliculas1 FOREIGN KEY (Codigo_peliculas) REFERENCES peliculas (Codigo) ON DELETE SET NULL ON UPDATE CASCADE;

/*Apartado 8*/

ALTER TABLE personajes DROP FOREIGN KEY FK_personajes;
ALTER TABLE personajes DROP CodigoSuperior_Personajes;

/*Apartado 9*/

ALTER TABLE personajes ADD COLUMN ladofuerza ENUM ('jedi', 'sith');
UPDATE personajes SET ladofuerza = 'jedi' WHERE Codigo = 1;
UPDATE personajes SET ladofuerza = 'jedi' WHERE Codigo = 2;
UPDATE personajes SET ladofuerza = 'sith' WHERE Codigo = 3;
UPDATE personajes SET ladofuerza = 'jedi' WHERE Codigo = 4;
UPDATE personajes SET ladofuerza = 'sith' WHERE Codigo = 5;

/*Apartado 10*/

LOAD DATA LOCAL INFILE 'swmejorado.txt' INTO TABLE actores;

/*Apartado 11*/

UPDATE actores SET Nacionalidad = 'Inglesa' WHERE Codigo = 1;

/*Apartado 12*/

UPDATE actores SET Codigo = 11 WHERE Codigo = 1;

/*Apartado 13*/

ALTER TABLE personajes DROP FOREIGN KEY FK_actores;
UPDATE personajes SET Codigo_Actores = 1 WHERE Codigo_Actores = 11;

/*Apartado 14*/

DELETE FROM peliculas WHERE Año = 1999;

/*Apartado 15*/

DELETE FROM peliculas WHERE Codigo = 1;

/*Apartado 16*/

DELETE FROM personajespeliculas WHERE Codigo_Personajes = 1;

/*Apartado 17*/

DROP TABLE visitas;

/*Apartado 18*/

DROP TABLE actores;





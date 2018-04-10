/************************************************************************************************
 *  Autor: Daniel Villalobos									*
 *  Fecha: 10/04/2018										*
 *												*
 *			TÍTULO: sql practice pro						*
 *												*
 ************************************************************************************************/

/*ESTRUCTURA*/
DROP DATABASE IF EXISTS Profesores;
CREATE DATABASE Profesores;
Use Profesores;

CREATE TABLE Salarios (
	NombreProfesor TEXT,
	Departamento TEXT,
	Salario INT
);

CREATE TABLE Libros (
        ID INT AUTO_INCREMENT,
        NombreLibro TEXT,
        Autor TEXT,
	CONSTRAINT PK_Libros PRIMARY KEY (ID)
);

CREATE TABLE Control (
        PrimerNombre TEXT,
        SegudoNombre TEXT,
        IDLibro INT,
        CONSTRAINT FK_Libros FOREIGN KEY (IDLibro) REFERENCES Libros (ID)
);

INSERT INTO Salarios VALUES 
	('Zanilo', 'Informatica', '130000'),
	('Eggert', 'Informatica', '170000'),
	('Cho', 'Informatica', '150000'),
        ('Fowler', 'Antropologia', '80000'),
        ('Wertheim', 'Antropologia', '95000'),
        ('Yang', 'Antropologia', '120000'),
        ('Kreger', 'Politicas', '190000'),
        ('Saverin', 'Politicas', '90000'),
        ('Chen', 'Ingenieria Electrica', '125000'),
        ('White', 'Administracion', '150000'),
        ('Calderon', 'Periodismo', '200000'),
        ('Lee', 'Informatica', '250000'),
        ('Jacob', 'Biologia', '175000'),
        ('Ng', 'Sociologia', '50000'),
        ('Hsieh', 'Ingenieria Quimica', '400000'),
        ('Muniain', 'Español', '160000'),
        ('Guerin', 'Administracion', '500000'),
        ('John', 'Economia', '250000');



/*CONSULTAS*/

/*1. Escriba una consulta que muestre todos los contenidos de la tabla Salarios.*/
SELECT * FROM Salarios;
/*2. Escriba una consulta que devuelva los nombres de todos los profesores de la tabla Salarios.*/
SELECT NombreProfesor FROM Salarios;
/*3. Escriba una consulta que devuelva todos los departamentos en la tabla Salarios (sin duplicados).*/
SELECT DISTINCT Departamento FROM Salarios;
/*4. Escriba una consulta que devuelva la cantidad de profesores cuyo salario sea superior a 150000.*/
SELECT COUNT(NombreProfesor) FROM Salarios WHERE Salario > 150000;
/*5. Escriba una consulta que devuelva todos los departamentos y sus salarios agregados (en este orden de columnas).*/
SELECT Departamento, SUM(Salario) FROM Salarios GROUP BY Departamento;
/*6. Escriba una consulta que devuelva el nombre y el salario (en este orden de columnas) del profesor con el + salario más alto.*/
SELECT NombreProfesor, MAX(Salario) FROM Salarios; /*No se puede utilizar una función de agregación sin el GROUP BY*/
/*7. Escriba una consulta que devuelva el nombre y el salario (en este orden de columnas) del profesor con el salario más alto en el departamento de informática.*/
/*8. Escriba una consulta que devuelva el nombre y los salarios (en este orden de columnas) de los 5 mejores profesores con mayores ingresos.*/
/*9. Escriba una consulta que devuelva el nombre y el salario (en este orden de columnas) del profesor con las ganancias más bajas.*/
/*10. Escribe una consulta que devuelva el departamento en el que trabaja el profesor Zaniolo.*/
/*11. Escriba una consulta que devuelva todos los nombres de los profesores que comienzan con la letra 'C'.*/
/*12. Escriba una consulta que devuelva el tercer salario más alto en la tabla. Los salarios duplicados cuentan como uno. Por ejemplo, si tiene 20, 20, 10 y 5, 10 es el segundo salario más alto.*/
/*13. Escriba una consulta que devuelva el nombre y apellido (en este orden de columnas) de las personas que comparten su apellido con alguien que también ha prestado un libro.*/
/*14. Escriba una consulta que devuelva el nombre y apellido de todas las personas que retiraron un libro de Terry Crews.*/
/*15. Escriba una consulta que devuelva el nombre y apellido de todas las personas que se registraron como "Matar a un ruiseñor" por Harper Lee.*/
/*16. Escribe una consulta que devuelva el salario promedio de los profesores en la tabla. Cada profesor en el departamento de Ciencias de la Computación acaba de obtener un aumento de 10.000 dólares.*/
/*17. Escriba una consulta que dé los nombres y los nuevos salarios (en este orden de columnas) de los profesores de Ciencias de la Computación.*/
/*18. Escriba una consulta que emita la instrucción SQL utilizada para crear la tabla anterior.*/
/*19. Escriba una consulta que devuelva el nombre y el salario (en este orden de columnas) de todos los profesores que ganan más de 4 veces más que el profesor peor pagado.*/
/*20. Escriba una consulta que devuelva la cantidad de autores únicos que han escrito libros en esta tabla.*/
/*21. Escriba una consulta que devuelva el nombre y el salario (en este orden de columnas) de los profesores que ganen entre 120000 y 250000 por año (inclusive).*/
/*22. Escriba una consulta que devuelva a todos los profesores (todas las columnas) que trabajan en el departamento de Antropología o ganan más de 150000 al año.*/
/*23. Escriba una consulta que devuelva el salario más alto en el departamento de informática.*/
/*24. Escriba una consulta que devuelva la cantidad de profesores que ganan más del doble que el profesor con el salario más bajo en el departamento de Ciencias Políticas.*/
/*25. Escriba una consulta que devuelva los nombres de todos los libros prestados por Justin (nombre) Lee (apellido).*/
/*26. Escriba una consulta que devuelva los nombres completos (nombre completo es el primer nombre seguido de un espacio y luego el apellido) de todos los que han sacado un libro. ¡Sin duplicados!*/
/*27. Escriba una consulta que devuelva el departamento que más aprovecha junto con el salario agregado total de ese departamento.*/
/*28. Escriba una consulta que devuelva el departamento con el salario promedio más alto junto con ese salario promedio.*/
/*29. Escriba una consulta que devuelva el nombre, el departamento y el salario (en este orden de columnas) de cada profesor que tenga el ingreso más alto en su departamento.*/
/*30. Escriba una consulta que devuelva el nombre y el salario (en este orden de columnas) de cada profesor que sea uno de los 3 principales o los 3 principales (incluya lazos).*/
/*31. Escriba una consulta que devuelva todos los departamentos y la cantidad de profesores en cada uno (en este orden de columnas).*/
/*32. Escriba una consulta que devuelva el departamento con la mayor cantidad de profesores y esa cantidad (en este orden de columnas).*/

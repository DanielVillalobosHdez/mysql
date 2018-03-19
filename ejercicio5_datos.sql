INSERT INTO Personas (Nombre, Apellidos, Fecha_Nacimiento, PrecioPujado, Ciudad) VALUES 
	('Fernando','de la Mata','1985-12-06',2350.50,'Madrid'),
	('Fernando','de la Mata','1985-12-06',2350.50,'Madrid'),
	('Fernando','de la Mata','1985-12-06',2350.50,'Madrid');
INSERT INTO Orden (NumeroOrden, ID_Personas) VALUES
	(1, 3),
	(2, 2),
	(3, 1);

UPDATE Personas SET ID = 5 WHERE ID = 1;
DELETE FROM Orden WHERE ID_Persona = 1;

SHOW CREATE TABLE Orden;
ALTER TABLE Orden DROP FOREIGN KEY FK_Personas;
ALTER TABLE Personas DROP PRIMARY KEY;

	

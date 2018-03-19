
/*
Se alteran todas las tablas para que el charset admita caracteres como la ñ.
*/

ALTER TABLE AEROPUERTO CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE TERMINALES CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE COMPAÑIA CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE VUELO CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE ASIENTOS CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE PASAJEROS CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE RESERVA CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE RESERVA_VUELOS CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE MALETAS CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE AVION CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;
ALTER TABLE BILLETE CHARACTER SET utf8mb4 COLLATE  utf8mb4_unicode_ci;

/*
Se altera la tabla billetes para crearle una columna llamada ID y que esta columna sea primary key, a continuación la borramos la primary key y la columan.
*/

ALTER TABLE BILLETE ADD COLUMN ID INT UNSIGNED FIRST;
UPDATE BILLETE SET ID = 1 WHERE Numero_TERMINALES = 1;
UPDATE BILLETE SET ID = 2 WHERE Numero_TERMINALES = 2;
UPDATE BILLETE SET ID = 3 WHERE Numero_TERMINALES = 4;
UPDATE BILLETE SET ID = 4 WHERE Numero_TERMINALES = 5;
UPDATE BILLETE SET ID = 5 WHERE Numero_TERMINALES = 3;
ALTER TABLE BILLETE ADD CONSTRAINT PK_BILLETE PRIMARY KEY (ID);
ALTER TABLE BILLETE DROP PRIMARY KEY;
ALTER TABLE BILLETE DROP COLUMN ID;

/*
Borramos la foreign key de la tabla terminales para luego generar otra foreign key que al  borrar un dato se ponga a NULL y que cuando se actualice la columna codIATA y Nombre de la tabla AEROPUERTO se cambien en la tabla.
*/

ALTER TABLE TERMINALES DROP FOREIGN KEY FK_AEROPUERTO;
ALTER TABLE TERMINALES ADD CONSTRAINT FK_AEROPUERTO FOREIGN KEY (CodIATA_AEROPUERTO, Nombre_AEROPUERTO) REFERENCES AEROPUERTO (codIATA, Nombre) ON DELETE SET NULL ON UPDATE CASCADE;

/*
Queremos añadir a la columna ID de la tabla AVION un AUTO_INCREMENT, para ello tenemos que borrar la PRIMARY KEY de AVION y despues regenerarla añadiendo ID, y ya podemos modificar la columna y añadir el AUTO_INCREMENT.
*/

ALTER TABLE AVION DROP PRIMARY KEY;
ALTER TABLE AVION ADD CONSTRAINT PK_AVION PRIMARY KEY (ID, modelo);
ALTER TABLE AVION MODIFY COLUMN ID INT UNSIGNED AUTO_INCREMENT;
ALTER TABLE AVION MODIFY COLUMN ID INT UNSIGNED;

/*
Creamos una columna puntuación en la tabla compañias en la cual se guardara la opinion que tiene la compañia de vuelo sobre tu comportamiento en el avion, es decir si usas a menudo esa aerolinea y no tienes incidentes tendras más alta puntuación que uno que siempre tiene incidencias pudiendo a llegar al 100 o al -99.

Y posteriormente tenemos que ponerla como UNSIGNED
*/ 

ALTER TABLE COMPAÑIA ADD COLUMN Puntuacion INT(3);
ALTER TABLE COMPAÑIA MODIFY COLUMN Puntuacion INT(3) UNSIGNED;

/* Y por ultimo la borramos al no tener datos */

ALTER TABLE COMPAÑIA DROP COLUMN Puntuacion;

/*
borramos UN_VUELO y después la volvemos a crear. Para ello borramos todas la FOREIGN KEY que hagan referencia a ella, a continuación borramos el UNIQUE y por ultimo añadimos el UNIQUE y volvemos a crear la FOREIGN KEY
*/

ALTER TABLE BILLETE DROP FOREIGN KEY FK_VUELO1;
ALTER TABLE VUELO DROP INDEX UN_VUELO;
ALTER TABLE VUELO ADD UNIQUE (Hora_Embarque);
ALTER TABLE BILLETE ADD CONSTRAINT FK_VUELO1 FOREIGN KEY (Hora_Embarque_VUELO) REFERENCES VUELO (Hora_Embarque);


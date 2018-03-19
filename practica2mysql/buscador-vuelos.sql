DROP DATABASE IF EXISTS buscador_vuelos;
CREATE DATABASE buscador_vuelos;
USE buscador_vuelos;

CREATE TABLE AEROPUERTO (
	CodIATA CHAR(3),
/*ponemos char de 3 por que el codigo solo va a tener 3 letras*/
	Nombre VARCHAR(30),
	Ciudad VARCHAR(30),
	País VARCHAR(20),
	CONSTRAINT PK_AEROPUERTO PRIMARY KEY (CodIATA, Nombre)
/*Ponemos CodIATA y Nombre como primary key devido a que algunos codigos se repiten*/
);

CREATE TABLE TERMINALES (
	Numero INT(2) UNSIGNED,
/*Ponemos 2 por que consideramos que no habrá Terminales con más de 2 cifras*/
	CodIATA_AEROPUERTO CHAR(3),
	Nombre_AEROPUERTO VARCHAR(30),
	CONSTRAINT PK_TERMINALES PRIMARY KEY (Numero),	
	CONSTRAINT FK_AEROPUERTO FOREIGN KEY (CodIATA_AEROPUERTO, Nombre_AEROPUERTO) REFERENCES AEROPUERTO (codIATA, Nombre)
/*En este caso añadimos también el nombre de la tabla AEROPUERTO, por si se repite el código.*/
);

CREATE TABLE COMPAÑIA (
	CodCompañia CHAR(3),
/* El codigo compañia lo asignamos como un char de tres caracteres ya que el OACI solo puede tener 3 letras*/
	Nombre VARCHAR(40),
	Logo TEXT,
/*Ponemos text por que no sabemos cuanto puede alcanzar la ruta al archivo del logo*/
	CONSTRAINT PK_COMPAÑIA PRIMARY KEY (CodCompañia), 
	CONSTRAINT UN_COMPAÑIA UNIQUE KEY (Nombre)	
);

CREATE TABLE VUELO (
	CodVuelo INT(4),
	CodCompañia CHAR(3),
	CodIATA_Origen CHAR(3),
	AeropuertoOrigen VARCHAR(30),
	CodIATA_Destino CHAR(3),
	AeropuertoDestino VARCHAR(30),
	Hora_Embarque TIME,
	Duracción TIME,
	Estado ENUM ('En hora', 'Retrasado', 'Cancelado'),
	CONSTRAINT PK_VUELO PRIMARY KEY (CodVuelo),
	CONSTRAINT FK_COMPAÑIA FOREIGN KEY (CodCompañia) REFERENCES COMPAÑIA (CodCompañia),
	CONSTRAINT FK_AEROPUERTO1 FOREIGN KEY (CodIATA_Origen, AeropuertoOrigen) REFERENCES AEROPUERTO (CodIATA, Nombre),
	CONSTRAINT FK_AEROPUERTO2 FOREIGN KEY (CodIATA_Destino, AeropuertoDestino) REFERENCES AEROPUERTO (CodIATA, Nombre),
	CONSTRAINT UN_VUELO UNIQUE KEY (Hora_Embarque)
);  

/* Hacemos referencia a CodIATA y Nombre de la tabla AEROPUERTO ya que solo con el codigo IATA en ocasiones no se podria diferenciar entre un aeropuerto u otro */

CREATE TABLE ASIENTOS (
	CodAsiento CHAR(3),
	TipoClase ENUM ('Turista', 'Turista Superior', 'Ejecutiva', 'Primera Clase'),
	CONSTRAINT PK_ASIENTOS PRIMARY KEY (CodAsiento)
);

CREATE TABLE PASAJEROS (
	DNI CHAR(9),
	Nombre VARCHAR(20),
	Apellido1 VARCHAR(20),
	Apellido2 VARCHAR(20),
	edad INT(2), /* Añadimos la edad del pasajero para saber si son niños, adultos o jovenes */ 
	tipo_embarque ENUM('Preferente', 'normal') , /* Añadimos el tipo de embarque para luego en el billete ponerlo*/
	Discapacidad ENUM('Si', 'No'), /* Añadimos el campo discapacidad para que en el billete conste que necesita atención especializada para el embarque y el vuelo*/
	CONSTRAINT PK_PASAJEROS PRIMARY KEY (DNI, Nombre)
);

CREATE TABLE RESERVA (
	Localizador CHAR(9), 
	DNI_PASAJEROS CHAR(9),
	Precio FLOAT(6),
	CONSTRAINT PK_RESERVA PRIMARY KEY (Localizador),
	CONSTRAINT FK_PASAJEROS FOREIGN KEY (DNI_PASAJEROS) REFERENCES PASAJEROS (DNI)
);

CREATE TABLE RESERVA_VUELOS (
	Localizador_RESERVA CHAR(9),
	CodVuelo_VUELO INT(4),
	CONSTRAINT FK_RESERVA FOREIGN KEY (Localizador_RESERVA) REFERENCES RESERVA (Localizador),
	CONSTRAINT FK_VUELO FOREIGN KEY (CodVuelo_VUELO) REFERENCES VUELO (CodVuelo)
);

/*
Creamos la tabla maleta en el cual consta el localizador del billete, la altura y anchura para determinar si puede o no ir en cabina y la localización por si el pasajero quiere reservarlo 
*/	
CREATE TABLE MALETAS (
	Localizador CHAR(9), 
	Altura FLOAT(3),
	Anchura FLOAT(3),
	Localización ENUM ('cabina', 'bodega'),
	CONSTRAINT FK_RESERVA1 FOREIGN KEY (Localizador) REFERENCES RESERVA (Localizador)
);	

/*
Creamos la tabla avion ya que suponemos que hay se almacena la información que envia la compañia al buscador para que tenga información sobre los asientos disponibles para vender y la distribucción según el modelo, y los distintos servicios que obrece la compañia de vuelos
*/

CREATE TABLE AVION (
	ID INT UNSIGNED, /*Añadimos un 'ID' que luego se borrara de las estructura*/
	modelo VARCHAR(20),
	compañia_fabricante VARCHAR(20),
	compañia_compradora_COMPAÑIA VARCHAR(30),
	N_asientos INT(3),
	Localizacion ENUM('Hangares', 'Terminal', 'Pista', 'Aire'),
	Servicios ENUM('Cobro', 'incluido'),
	CONSTRAINT PK_AVION PRIMARY KEY (modelo),	
	CONSTRAINT FK_COMPAÑIA1 FOREIGN KEY (compañia_compradora_COMPAÑIA) REFERENCES COMPAÑIA (Nombre)

);	

/*
Creamos la tabla billetes que recojera la información de las distintas tablas
*/

CREATE TABLE BILLETE (
	Nombre_PASAJEROS VARCHAR(20),
	DNI_PASAJEROS CHAR(9),
	CodIATA_AEROPUERTO CHAR(3),
	Nombre_AEROPUERTO VARCHAR(30),
	Numero_TERMINALES INT(2) UNSIGNED,
	CodCompañia_COMPAÑIA CHAR(3),
	Hora_Embarque_VUELO TIME,
	CodAsiento_ASIENTOS CHAR(3),
	Localizador_RESERVA CHAR(9),
	CONSTRAINT FK_PASAJERO1 FOREIGN KEY (DNI_PASAJEROS, Nombre_PASAJEROS) REFERENCES PASAJEROS (DNI, Nombre),
	CONSTRAINT FK_AEROPUERTO3 FOREIGN KEY (CodIATA_AEROPUERTO, Nombre_AEROPUERTO) REFERENCES AEROPUERTO (CodIATA, Nombre),
	CONSTRAINT FK_RESERVA2 FOREIGN KEY (Localizador_RESERVA) REFERENCES RESERVA (Localizador),

	CONSTRAINT FK_TERMINALES FOREIGN KEY (Numero_TERMINALES) REFERENCES TERMINALES (Numero),
	CONSTRAINT FK_COMPAÑIA2 FOREIGN KEY (CodCompañia_COMPAÑIA) REFERENCES COMPAÑIA (CodCompañia),
	CONSTRAINT FK_VUELO1 FOREIGN KEY (Hora_Embarque_VUELO) REFERENCES VUELO (Hora_Embarque),
	CONSTRAINT FK_ASIENTOS FOREIGN KEY (CodAsiento_ASIENTOS) REFERENCES ASIENTOS (CodAsiento)
		
);

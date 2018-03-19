INSERT INTO AEROPUERTO (CodIATA, Nombre, Ciudad, País) VALUES
	('MAD', 'Madrid Barajas Airport', 'Madrid', 'España'),
	('AJA', 'Ajaccio Airport', 'Ajaccio', 'Francia'),
	('NAP', 'Nápoles Airport', 'Nápoles', 'Italia'),
	('BER', 'Berlín Brandeburgo Airport', 'Berlín', 'Alemania'),
	('SVQ', 'Sevilla Airport', 'Sevilla', 'España'),
	('LPA', 'Gran Canaria Airport', 'Gran Canaria', 'España'),
	('DBV', 'Dubrovnik Airport', 'Ajaccio', 'Francia'),
	('MRS', 'Marsella Airport', 'Marsella', 'Francia');

INSERT INTO TERMINALES (Numero, CodIATA_AEROPUERTO, Nombre_AEROPUERTO) VALUES
	('1', 'MAD', 'Madrid Barajas Airport'),
	('2', 'AJA', 'Ajaccio Airport'),
	('4', 'NAP', 'Nápoles Airport'),
	('5', 'BER', 'Berlín Brandeburgo Airport'),
	('3', 'SVQ', 'Sevilla Airport');

INSERT INTO COMPAÑIA (CodCompañia, Nombre, Logo) VALUES
	('IBE', 'IBERIA' , '/home/cristian/imagenes/iberia.png'),
	('IAZ', 'INDUSCHART', '/home/cristian/imagenes/induschart.png'),
	('ISS', 'MERAIR', '/home/cristian/imagenes/merair.png'),
	('BER', 'AIR BERLINE', '/home/cristian/imagenes/berline.png'),
	('PMI', 'AIR REGIONAL', '/home/cristian/imagenes/regional.png');

INSERT INTO VUELO (CodVuelo, CodCompañia, CodIATA_Origen, AeropuertoOrigen, CodIATA_Destino, AeropuertoDestino, Hora_embarque, Duracción, Estado) VALUES
	('5022', 'IBE', 'MAD', 'Madrid Barajas Airport', 'LPA', 'Gran Canaria Airport', '12:30:00', '02:31:00', 'En hora'),
	('3503', 'IAZ', 'AJA', 'Ajaccio Airport', 'DBV', 'Dubrovnik Airport', '08:50:00', '01:18:00', 'En hora'),
	('4022', 'ISS', 'NAP', 'Nápoles Airport', 'MAD', 'Madrid Barajas Airport', '17:30:00', '02:12:00', 'Cancelado'),
	('1450', 'BER', 'BER', 'Berlín Brandeburgo Airport', 'MRS', 'Marsella Airport', '10:00:00', '02:15:00', 'Retrasado'),
	('2345', 'PMI', 'SVQ', 'Sevilla Airport', 'LPA', 'Gran Canaria Airport', '22:30:00', '02:30:00', 'Retrasado'); 

INSERT INTO ASIENTOS (CodAsiento, TipoClase) VALUES
	('56C', 'Turista'),
	('12A', 'Primera Clase'),
	('23C', 'Ejecutiva'),
	('36C', 'Turista Superior'),
	('56B', 'Turista');

INSERT INTO PASAJEROS (DNI, Nombre, Apellido1, Apellido2, edad, Discapacidad) VALUES
	('08756349K', 'Carlos', 'Ferrera', 'Martinez', '21', 'Si'),
	('07493929Q', 'Alberto', 'Benito', 'Rodriguez', '18', 'No'),
	('05869395R', 'Marta', 'Lozano', 'Arquero', '32', 'Si'),
	('00847392T', 'Sara', 'Romero', 'Sanchez', '26', 'No'),
	('02046548M', 'David', 'Guzman', 'Albornoz', '47', 'Si');

INSERT INTO RESERVA (Localizador, DNI_PASAJEROS, Precio) VALUES
	('5LX3TN', '08756349K', '200'),
	('4YTRIE', '07493929Q', '100'),
	('2RT5TG', '05869395R', '500'),
	('5REDSN', '00847392T', '250'),
	('5LRYTN', '02046548M', '500');

INSERT INTO RESERVA_VUELOS (Localizador_RESERVA, CodVuelo_VUELO) VALUES
	('5LX3TN', '5022'),
	('4YTRIE', '3503'),
	('2RT5TG', '4022'),
	('5REDSN', '1450'),
	('5LRYTN', '2345');

INSERT INTO MALETAS (Localizador, Altura, Anchura, Localización) VALUES
	('5LX3TN', '50', '18', 'bodega'),
	('5RT6TT', '55', '15', 'cabina'),
	('5MN2RN', '60', '20', 'bodega'),
	('5FJ4TN', '52', '12', 'bodega'),
	('5TT5PU', '55', '19', 'cabina');

INSERT INTO AVION (ID, modelo, compañia_fabricante, compañia_compradora_COMPAÑIA, N_asientos, Localizacion, Servicios) VALUES
	('1', 'Boeing 757', 'Iberia', 'IBERIA', '289', 'Terminal', 'incluido'),
	('2', 'Boeing 787', 'Ana', 'INDUSCHART', '200', 'Pista', 'cobro'),
	('3', 'A320', 'Airbus', 'MERAIR', '190', 'Aire', 'incluido'),
	('4', 'Boeing 767', 'Condor', 'AIR BERLINE', '230', 'Hangares', 'incluido'),
	('5', 'Boeing 727', 'Lufthansa', 'AIR REGIONAL', '175', 'Terminal', 'cobro');

INSERT INTO BILLETE (Nombre_PASAJEROS, DNI_PASAJEROS, CodIATA_AEROPUERTO, Nombre_AEROPUERTO, Numero_TERMINALES, CodCompañia_COMPAÑIA, Hora_Embarque_VUELO, CodAsiento_ASIENTOS, Localizador_RESERVA) VALUES
	('Carlos', '08756349K', 'MAD', 'Madrid Barajas Airport', '1', 'IBE', '12:30:00', '56C', '5LX3TN'),
	('Alberto', '07493929Q', 'AJA', 'Ajaccio Airport', '2', 'IAZ', '08:50:00', '12A', '4YTRIE'),
	('Marta', '05869395R', 'NAP', 'Nápoles Airport', '4', 'ISS', '17:30:00', '23C', '2RT5TG'),
	('Sara', '00847392T', 'BER', 'Berlín Brandeburgo Airport', '5', 'BER', '10:00:00', '36C', '5REDSN'),
	('David', '02046548M', 'SVQ', 'Sevilla Airport', '3', 'PMI', '22:30:00', '56B', '5LRYTN');  
	

UPDATE TERMINALES SET Numero = 5 WHERE Numero = 7; 
UPDATE PASAJEROS SET Apellido1 = Ferrera WHERE Apellido1 = Mompó;
UPDATE PASAJEROS SET edad = 47 WHERE edad = 22;
UPDATE RESERVA SET Precio = 500 WHERE Precio = 150;
UPDATE VUELO SET Estado = Cancelado WHERE Estado = Retrasado; 
DELETE FROM AVION WHERE N_asientos = 175;
DELETE FROM MALETAS WHERE Anchura = 20;
DELETE FROM AVION WHERE N_asientos = 200;
DELETE FROM AVION WHERE N_asientos = 289;
DELETE FROM AVION WHERE N_asientos = 230;

/************************************************************************************************************
	HECHO POR: Daniel Villalobos y David Gúzman
	
	FECHA: 20/MAYO/2018

	TITULO: USO Y EJEMPLOS DEL TRIGGER

*************************************************************************************************************/






DROP DATABASE IF EXISTS _trigger;
CREATE DATABASE _trigger;

USE _trigger;

CREATE TABLE account (
	acct_num INT,
	amount DECIMAL(10,2)
);

CREATE TRIGGER ins_sum BEFORE INSERT ON account FOR EACH ROW SET @sum = @sum + NEW.amount;
SET @sum = 0;

INSERT INTO account VALUES
	(137,14.98),
	(141,1937.50),
	(97,-100.00);

SELECT @sum AS 'Total amount inserted';




CREATE TABLE ejemplo (
	PrecioProducto DECIMAL(10,2),
	PrecioVenta DECIMAL(10,2)
);

delimiter //
CREATE TRIGGER producto BEFORE INSERT ON ejemplo FOR EACH ROW IF NEW.PrecioProducto < 0 THEN SET NEW.PrecioProducto = 1;
END IF;
//
delimiter ;

delimiter //
CREATE TRIGGER venta BEFORE INSERT ON ejemplo FOR EACH ROW IF NEW.PrecioVenta < 0 THEN SET NEW.PrecioVenta = 2*NEW.PrecioProducto; 
END IF;
//
delimiter ;

CREATE TRIGGER beneficio BEFORE INSERT ON ejemplo FOR EACH ROW SET @be = @be + (NEW.PrecioVenta - NEW.PrecioProducto);

SET @be = 0;

INSERT INTO ejemplo VALUES 
	(-5,10),
	(15,-30),
	(-1,-3);

SELECT @be AS BeneficioNeto;
SELECT * FROM ejemplo;



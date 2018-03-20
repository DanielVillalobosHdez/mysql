/************************************************************************************************
 *  Autor: Daniel Villalobos									*
 *  Fecha: 19/03/2018, 20/03/2018								*
 *												*
 *			TÍTULO: Consultas							*
 *												*
 ************************************************************************************************/

/* FUNCIONES DE AGREGACIÓN */
/* GROUP BY [DESC || ASC]*/

/*Columnas de agregación*/
/*SUM(), MAX(), MIN(), AVG(), COUNT()*/


USE jardineria;

/*Palabras que empiezan por OR*/
SELECT Codigoproducto FROM Productos WHERE Codigoproducto LIKE "OR%";														
																						
/*ERROR*/ 																					
SELECT Estado, CodigoPedido FROM Pedidos GROUP BY Estado;							

/*Devuelve las repeticiones de una palabra*/ 																
SELECT Estado, COUNT(*) FROM Pedidos GROUP BY Estado;

/*Muestra el valor más alto*/
SELECT MAX(PrecioVenta) FROM Productos;

/*Muestra numero de oficinas por pais*/
SELECT Pais, COUNT(*) FROM Oficinas GROUP BY Pais;

/*Media de cada gama de productos*/
SELECT Gama, AVG(PrecioVenta) FROM Productos GROUP BY Gama;

/*De cada producto cuantos pedidos tiene*/
SELECT CodigoPedido, SUM(Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*De cada pedido cuanto cuesta en total*/
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*De cada pedido cuanto cuesta en total mayores de 1500*/
/*comparar función de agregación*/
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) AS total FROM DetallePedidos GROUP BY CodigoPedido HAVING total>1500;
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) AS 'total' FROM DetallePedidos GROUP BY CodigoPedido HAVING total>1500;

/*Mostra los productos mayores que le media*/
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>(SELECT AVG(PrecioVenta) FROM Productos);

/*Mostrar producto más caro*/
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>(SELECT MAX(PrecioVenta) FROM Productos);

/*Mostrar productos que esten entre 200 y 300 */
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>200 AND PrecioVenta<300;
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta BETWEEN 200 AND 300;

/*Muestra el codigo de oficina de España y EEUU */
SELECT CodigoOficina, Pais FROM Oficinas WHERE Pais IN ('España', 'EEUU');

/*Muestra los empleados que no tengan jefe*/
SELECT CodigoEmpleado, CodigoJefe FROM Empleados WHERE CodigoJefe IS NULL;

/*Mostrar empleados que si tengan jefe*/
SELECT CodigoEmpleado, CodigoJefe FROM Empleados WHERE CodigoJefe IS NOT NULL;

/*Sacar el codigo oficina y la ciudad donde hay oficinas*/
SELECT CodigoOficina, Ciudad FROM Oficinas;
/*Sacar cuantos empleados hay en la compañia*/
/*Sacar cuantos clientes tiene cada pais*/
/*Sacar cual fue el pago medio en 2009*/
/*Sacar cuantos pedidos estan en cada estado ordenado descendentemente por el número de pedido*/
/*Sacar el precio del producto más caro y de el más barato*/


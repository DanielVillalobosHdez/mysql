/************************************************************************************************
 *  Autor: Daniel Villalobos									*
 *  Fecha: 19/03/2018, 20/03/2018, 04/04/2018							*
 *												*
 *			TÍTULO: Consultas							*
 *												*
 ************************************************************************************************/

/* FUNCIONES DE AGREGACIÓN */
/* GROUP BY [DESC || ASC]*/

/*Columnas de agregación*/
/*SUM(), MAX(), MIN(), AVG(), COUNT()*/


/*Palabras que empiezan por OR*/
SELECT CodigoProducto FROM Productos WHERE CodigoProducto LIKE "OR%";

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
SELECT (SELECT MAX(PrecioVenta) FROM Productos) FROM Productos;

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
SELECT COUNT(CodigoEmpleado) FROM Empleados;
SELECT COUNT(*) FROM Empleados;

/*Sacar cuantos clientes tiene cada pais*/
SELECT Pais, COUNT(CodigoCliente) FROM Clientes GROUP BY Pais;
SELECT Pais, COUNT(*) FROM Clientes GROUP BY Pais;

/*Sacar cual fue el pago medio en 2009*/
SELECT (SELECT AVG(Cantidad) FROM Pagos WHERE FechaPago LIKE '2009%') AS Media FROM Pagos GROUP BY FechaPago HAVING FechaPago LIKE '2009%' LIMIT 1;
SELECT AVG(Cantidad) FROM Pagos WHERE YEAR(FechaPago)=2009;

/*Sacar cuantos pedidos estan en cada estado ordenado descendentemente por el número de pedido*/
SELECT Estado, COUNT(CodigoPedido) AS Pedido FROM Pedidos GROUP BY Estado ORDER BY Pedido DESC;
SELECT Estado, COUNT(*) AS Pedido FROM Pedidos GROUP BY Estado ORDER BY Pedido DESC;

/*Sacar el precio del producto más caro y de el más barato*/
SELECT (SELECT MIN(PrecioVenta) FROM Productos) AS Minimo, (SELECT MAX(PrecioVenta) FROM Productos) AS Maximo FROM Productos LIMIT 1;
SELECT MAX(PrecioVenta), MIN(PrecioVenta) FROM Productos;




/*Mustra el nombre del jefe de cada empleado*/
SELECT Curritos.CodigoEmpleado, Curritos.Nombre, Curritos.CodigoJefe, Jefe.Nombre FROM Empleados AS Curritos, Empleados AS Jefe WHERE Curritos.CodigoJefe = Jefe.CodigoEmpleado;
SELECT Curritos.CodigoEmpleado AS Empleado, Curritos.Nombre AS NombreEmpleado, Curritos.CodigoJefe AS Jefe, Jefe.Nombre AS NombreJefe FROM Empleados AS Curritos, Empleados AS Jefe WHERE Curritos.CodigoJefe = Jefe.CodigoEmpleado;

/*Mustra el nombre y apllido del jefe de cada empleado*/


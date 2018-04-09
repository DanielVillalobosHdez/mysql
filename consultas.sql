/************************************************************************************************
 *  Autor: Daniel Villalobos									*
 *  Fecha: 19/03/2018, 20/03/2018, 04/04/2018, 09/04/2018					*
 *												*
 *			TÍTULO: Consultas							*
 *												*
 ************************************************************************************************/

/* FUNCIONES DE AGREGACIÓN */
/* GROUP BY [DESC || ASC]*/

/*Columnas de agregación*/
/*SUM(), MAX(), MIN(), AVG(), COUNT()*/


/*1. Palabras que empiezan por OR*/
SELECT CodigoProducto FROM Productos WHERE CodigoProducto LIKE "OR%";

/*2. Devuelve las repeticiones de una palabra*/
SELECT Estado, COUNT(*) FROM Pedidos GROUP BY Estado;

/*3. Muestra el valor más alto*/
SELECT MAX(PrecioVenta) FROM Productos;

/*4. Muestra numero de oficinas por pais*/
SELECT Pais, COUNT(*) FROM Oficinas GROUP BY Pais;

/*5. Media de cada gama de productos*/
SELECT Gama, AVG(PrecioVenta) FROM Productos GROUP BY Gama;

/*6. De cada producto cuantos pedidos tiene*/
SELECT CodigoPedido, SUM(Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*7. De cada pedido cuanto cuesta en total*/
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*8. De cada pedido cuanto cuesta en total mayores de 1500*/
/*comparar función de agregación*/
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) AS total FROM DetallePedidos GROUP BY CodigoPedido HAVING total>1500;
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) AS 'total' FROM DetallePedidos GROUP BY CodigoPedido HAVING total>1500;

/*9. Mostra los productos mayores que le media*/
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>(SELECT AVG(PrecioVenta) FROM Productos);

/*10. Mostrar producto más caro*/
SELECT (SELECT MAX(PrecioVenta) FROM Productos) FROM Productos;

/*11. Mostrar productos que esten entre 200 y 300 */
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>200 AND PrecioVenta<300;
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta BETWEEN 200 AND 300;

/*12. Muestra el codigo de oficina de España y EEUU */
SELECT CodigoOficina, Pais FROM Oficinas WHERE Pais IN ('España', 'EEUU');

/*13. Muestra los empleados que no tengan jefe*/
SELECT CodigoEmpleado, CodigoJefe FROM Empleados WHERE CodigoJefe IS NULL;

/*14. Mostrar empleados que si tengan jefe*/
SELECT CodigoEmpleado, CodigoJefe FROM Empleados WHERE CodigoJefe IS NOT NULL;


/*15. Sacar el codigo oficina y la ciudad donde hay oficinas*/
SELECT CodigoOficina, Ciudad FROM Oficinas;

/*16. Sacar cuantos empleados hay en la compañia*/
SELECT COUNT(CodigoEmpleado) FROM Empleados;
SELECT COUNT(*) FROM Empleados;

/*17. Sacar cuantos clientes tiene cada pais*/
SELECT Pais, COUNT(CodigoCliente) FROM Clientes GROUP BY Pais;
SELECT Pais, COUNT(*) FROM Clientes GROUP BY Pais;

/*18. Sacar cual fue el pago medio en 2009*/
SELECT (SELECT AVG(Cantidad) FROM Pagos WHERE FechaPago LIKE '2009%') AS Media FROM Pagos GROUP BY FechaPago HAVING FechaPago LIKE '2009%' LIMIT 1;
SELECT AVG(Cantidad) FROM Pagos WHERE YEAR(FechaPago)=2009;

/*19. Sacar cuantos pedidos estan en cada estado ordenado descendentemente por el número de pedido*/
SELECT Estado, COUNT(CodigoPedido) AS Pedido FROM Pedidos GROUP BY Estado ORDER BY Pedido DESC;
SELECT Estado, COUNT(*) AS Pedido FROM Pedidos GROUP BY Estado ORDER BY Pedido DESC;

/*20. Sacar el precio del producto más caro y de el más barato*/
SELECT (SELECT MIN(PrecioVenta) FROM Productos) AS Minimo, (SELECT MAX(PrecioVenta) FROM Productos) AS Maximo FROM Productos LIMIT 1;
SELECT MAX(PrecioVenta), MIN(PrecioVenta) FROM Productos;


/*21. Mustra el nombre del jefe de cada empleado*/
SELECT Curritos.CodigoEmpleado, Curritos.Nombre, Curritos.CodigoJefe, Jefe.Nombre FROM Empleados AS Curritos, Empleados AS Jefe WHERE Curritos.CodigoJefe = Jefe.CodigoEmpleado;
SELECT Curritos.CodigoEmpleado AS Empleado, Curritos.Nombre AS NombreEmpleado, Curritos.CodigoJefe AS Jefe, Jefe.Nombre AS NombreJefe FROM Empleados AS Curritos, Empleados AS Jefe WHERE Curritos.CodigoJefe = Jefe.CodigoEmpleado;

/*22. Mustra el nombre y apllido del jefe de cada empleado*/
SELECT Curritos.CodigoEmpleado, CONCAT(Curritos.Nombre,' ', Curritos.Apellido1) AS NombreEmpleado, CONCAT(Jefes.Nombre,' ', Jefes.Apellido1) AS NombreJefe FROM Empleados AS Curritos, Empleados AS Jefes WHERE Curritos.CodigoJefe=Jefes.CodigoEmpleado;


/*23. Cuantos pedidos hay por pais*/
SELECT Clientes.Pais, COUNT(*) FROM Pedidos, Clientes WHERE Clientes.CodigoCliente=Pedidos.CodigoCliente GROUP BY Clientes.Pais;

/*24. Cuantos pedidos ha hecho cada cliente*/
SELECT CodigoCliente, COUNT(*) FROM Pedidos GROUP BY CodigoCliente;

/*25. Cuanto cuesta cada pedido*/
SELECT CodigoPedido AS Pedido, SUM(Cantidad * PrecioUnidad) AS Pago FROM DetallePedidos GROUP BY CodigoPedido;

/*26. De cada cliente cuanto se ha gastado*/
SELECT Pedidos.CodigoCliente AS Cliente, SUM(DetallePedidos.Cantidad * DetallePedidos.PrecioUnidad) AS Pago FROM Pedidos, DetallePedidos WHERE Pedidos.CodigoPedido=DetallePedidos.CodigoPedido GROUP BY Pedidos.CodigoCliente;

/*27. USO DEL JOIN (De cada cliente cuanto se ha gastado)*/
SELECT Pedidos.CodigoCliente AS Cliente, SUM(DetallePedidos.Cantidad * DetallePedidos.PrecioUnidad) AS Pago FROM Pedidos JOIN DetallePedidos ON Pedidos.CodigoPedido=DetallePedidos.CodigoPedido GROUP BY Pedidos.CodigoCliente;
SELECT Pedidos.CodigoCliente AS Cliente, SUM(DetallePedidos.Cantidad * DetallePedidos.PrecioUnidad) AS Pago FROM Pedidos NATURAL JOIN DetallePedidos GROUP BY Pedidos.CodigoCliente;

/*28. Muestra de cada cliente su responsable de venta*/
/*Para un NATURAL JOIN se necesita que se tenga el mismo nombre en todos las columnas y que sea una FOREIGN KEY de la otra*/
SELECT Clientes.CodigoCliente, Clientes.NombreCliente, Clientes.CodigoEmpleadoRepVentas, Empleados.CodigoEmpleado, Empleados.Nombre FROM Clientes JOIN Empleados ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado;

/*29. Muestra los empleados que tengan clientes*/
SELECT DISTINCT Clientes.CodigoEmpleadoRepVentas, Empleados.Nombre FROM Clientes JOIN Empleados ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado;

/*30. Mustra todos los empleados que hay y si alguno tiene un cliente mostrar/los*/
SELECT Empleados.CodigoEmpleado, Empleados.Nombre, Clientes.CodigoCliente, Clientes.NombreCliente FROM Clientes RIGHT JOIN Empleados ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado ORDER BY CodigoEmpleado;
SELECT Empleados.CodigoEmpleado, Empleados.Nombre, Clientes.CodigoCliente, Clientes.NombreCliente FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado ORDER BY CodigoEmpleado;

/*31. */

/*Descaragar aplicación de consultas mysql (sqlpractisepro)*/

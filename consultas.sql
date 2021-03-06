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
SELECT MAX(PrecioVenta) FROM Productos;

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

/*22. Mustra el nombre y apellido del jefe de cada empleado*/
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

/*31. Obtener nombre del cliente con mayor limite de credito*/
SELECT NombreCliente FROM Clientes WHERE LimiteCredito = (SELECT MAX(LimiteCredito) FROM Clientes);

/*32. Obtener Nombre, Apellido1 y cargo de los empleados que no representen a ningun cliente*/
SELECT Empleados.Nombre, Empleados.Apellido1, Empleados.Puesto, Clientes.CodigoCliente, Clientes.NombreCliente FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado WHERE Clientes.CodigoEmpleadoRepVentas IS NULL;
SELECT CONCAT(Empleados.Nombre, ' ', Empleados.Apellido1) AS Empleado, Empleados.Puesto AS Puesto FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado WHERE Clientes.CodigoEmpleadoRepVentas IS NULL;

/*33. Saca un listado con el nombre de cada cliente y nombre y apellido de su representante de venta*/
SELECT Clientes.NombreCliente, CONCAT(Empleados.Nombre, ' ', Empleados.Apellido1) AS Representante FROM Clientes JOIN Empleados ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado;

/*34. Muestra el nombre de los clientes que no hayan realizado el pago con su representante de ventas*/
SELECT Clientes.NombreCliente, Empleados.Nombre, Pagos.FechaPago FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas = Empleados.CodigoEmpleado LEFT JOIN Pagos ON Clientes.CodigoCliente = Pagos.CodigoCliente WHERE FechaPago IS NULL AND NombreCliente IS NOT NULL;

/*35. Listar las ventas totales de los productos que hayan faturado más de 3.000 €, se mostrara el nombre del producto, unidades vendidas, total facturado y total facturado con el 21% de IVA*/
SELECT Productos.Nombre, SUM(Cantidad) AS Unidades, SUM(Cantidad * PrecioUnidad) AS Total, SUM(Cantidad * PrecioUnidad)*21/100+SUM(Cantidad * PrecioUnidad) AS IVA FROM DetallePedidos NATURAL JOIN Productos GROUP BY Productos.CodigoProducto HAVING Total > 3000;

/*36. Listar la dirección de las oficinas que tengan clientes en Fuenla*/
SELECT Oficinas.LineaDireccion1, Clientes.NombreCliente FROM Oficinas LEFT JOIN Empleados ON Oficinas.CodigoOficina=Empleados.CodigoOficina RIGHT JOIN Clientes ON Empleados.CodigoEmpleado = Clientes.CodigoEmpleadoRepVentas WHERE Clientes.LineaDireccion2 LIKE 'Fuen%';
SELECT CONCAT(Oficinas.LineaDireccion1, ' ', Oficinas.LineaDireccion2) AS 'Dirección' FROM Clientes JOIN Empleados NATURAL JOIN Oficinas ON(Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado) WHERE Clientes.Ciudad='Fuenlabrada' ORDER BY Clientes.CodigoCliente;


/*37. Cliente (CodigoCliente, Nombre, Cuantia) que hizo el pedido de mayor cuantia*/
SELECT Clientes.NombreCliente, Pedidos.CodigoPedido, SUM(Detalle.PrecioUnidad*Detalle.Cantidad) as Precio FROM DetallePedidos as Detalle JOIN Pedidos as Pedidos JOIN Clientes as Clientes ON Detalle.CodigoPedido = Pedidos.CodigoPedido AND Pedidos.CodigoCliente = Clientes.CodigoCliente GROUP BY Detalle.CodigoPedido HAVING Precio = (SELECT SUM(PrecioUnidad*Cantidad) as Precio FROM DetallePedidos GROUP BY CodigoPedido ORDER BY Precio DESC LIMIT 1);

/*38. Cuantos clientes tienen las ciudades que empiezan por M*/
SELECT COUNT(NombreCliente), Ciudad FROM Clientes WHERE Ciudad LIKE 'M%' GROUP BY Ciudad;

/*39. Sacar el codigo del empleado y el numero de clientes que atiende cada representante de ventas*/
SELECT Clientes.CodigoEmpleadoRepVentas, COUNT(Clientes.NombreCliente) FROM Clientes as Clientes GROUP BY CodigoEmpleadoRepVentas;

/*40. Sacar el numero de clientes que no tienen asignado representante de ventas*/
SELECT COUNT(Clientes.NombreCliente), Clientes.CodigoEmpleadoRepVentas FROM Clientes GROUP BY CodigoEmpleadoRepVentas HAVING CodigoEmpleadoRepVentas IS NULL;


/*41. Sacar cual fue el primer y ultimo pago que hizo algun cliente*/
SELECT MAX(FechaPago), MIN(FechaPago), CodigoCliente FROM Pagos GROUP BY CodigoCliente LIMIT 1;
SELECT * FROM Pagos WHERE FechaPago = (SELECT MAX(FechaPago) FROM Pagos WHERE CodigoCliente = 1) OR (SELECT MIN(FechaPago) FROM Pagos WHERE CodigoCliente = 1) AND CodigoCliente = 1;

/*42. Sacar el codigo de cliente de aquellos clientes que realizaron pagos en 2008*/
SELECT DISTINCT CodigoCliente FROM Pagos WHERE YEAR(FechaPago) = "2008";

/*43. Sacar el numero de pedidos, codigo cliente, fecha requerida, fecha de entrega de los pedidos que no han sido entregados a tiempo*/
SELECT CodigoPedido, CodigoCliente, FechaEsperada, FechaEntrega FROM Pedidos WHERE FechaEsperada>FechaEntrega;

/*44. Sacar cuantos productos existen en cada linea de pedido*/
SELECT CodigoPedido, COUNT(Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*45. Sacar un listado de los 20 codigos de productos más pedidos ordenado por cantidad pedidos*/
SELECT CodigoProducto, Cantidad FROM DetallePedidos ORDER BY Cantidad DESC LIMIT 20;

/*46. Sacar el numero de pedido, codigo cliente, fecha requerida, fecha de entrega de cuyos pedidos se entregaron minimo dos días antes (FUNCION RELACIONADA CON DATE)*/
SELECT CodigoPedido, CodigoCliente, FechaEntrega, FechaEsperada FROM Pedidos WHERE DATE(FechaEsperada)-2 >= DATE(FechaEntrega);

/*47. Sacar la faturación que ha tenido la empresa en toda la historia, indicando la base imponible (coste+unidades), el IVA (21% de la base imponible) y total facturado (BI + IVA)*/
SELECT SUM(PrecioUnidad*Cantidad) AS BI, (SUM(PrecioUnidad*Cantidad)*21)/100 AS IVA, (SUM(PrecioUnidad*Cantidad)+(SUM(PrecioUnidad*Cantidad)*21)/100) AS Total FROM DetallePedidos;

/*48. Sacar la misma información que la pregunta anterior pero agrupada por codigo de producto, filtrada por los codigos que empiezen por FR*/ 
SELECT SUM(PrecioUnidad*Cantidad) AS BI, (SUM(PrecioUnidad*Cantidad)*21)/100 AS IVA, (SUM(PrecioUnidad*Cantidad)+(SUM(PrecioUnidad*Cantidad)*21)/100) AS Total FROM DetallePedidos WHERE CodigoProducto LIKE 'FR%';

/*49. Obtener listado del nombre de empleados con el nombre de sus jefes*/
SELECT Emplea2.CodigoEmpleado, CONCAT(Emplea2.Nombre,' ', Emplea2.Apellido1) AS NombreEmpleado, CONCAT(Jefes.Nombre,' ', Jefes.Apellido1) AS NombreJefe FROM Empleados AS Emplea2, Empleados AS Jefes WHERE Emplea2.CodigoJefe=Jefes.CodigoEmpleado;

/*50. Sacar el listado de jefes y de empleados a su cargo ordenados por el numero de subordinados*/
SELECT Emplea2.CodigoEmpleado, CONCAT(Emplea2.Nombre,' ', Emplea2.Apellido1) AS NombreEmpleado, CONCAT(Jefes.Nombre,' ', Jefes.Apellido1) AS NombreJefe FROM Empleados AS Emplea2, Empleados AS Jefes WHERE Emplea2.CodigoJefe=Jefes.CodigoEmpleado ORDER BY Emplea2.CodigoEmpleado;

/*51. Obtener el nombre de los clientes al que no se les ha entregado a tiempo un pedido*/
SELECT DISTINCT Clientes.NombreCliente FROM Clientes JOIN Pedidos ON Pedidos.CodigoCliente = Clientes.CodigoCliente WHERE FechaEsperada>FechaEntrega;

/*52. Sacar el importe medio de los pedidos*/
SELECT CodigoPedido, AVG(PrecioUnidad*Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*53. Cual es el pedido más caro del empleado que más clientes tiene*/

SELECT Clientes.NombreCliente, Pedidos.CodigoPedido, SUM(Detalle.PrecioUnidad*Detalle.Cantidad) as Precio FROM DetallePedidos as Detalle JOIN Pedidos as Pedidos JOIN Clientes as Clientes ON Detalle.CodigoPedido = Pedidos.CodigoPedido AND Pedidos.CodigoCliente = Clientes.CodigoCliente GROUP BY Detalle.CodigoPedido HAVING Precio = (SELECT MAX(SUM(PrecioUnidad*Cantidad)) as Precio FROM DetallePedidos GROUP BY CodigoPedido);

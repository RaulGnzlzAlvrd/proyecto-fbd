USE TaqueroMucho;

-- 1. Platillo más vendido por sucursal

SELECT 
       pl.nombre AS nombre_platillo,
       COUNT(pl.id_platillo)as total_ventas,
       s.numero_sucursal
FROM Sucrusales s
INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
GROUP BY s.numero_sucursal, pl.nombre
HAVING COUNT(pl.id_platillo) >= ALL (  SELECT 
									       COUNT(pl.id_platillo)
										FROM Sucrusales s
										INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
										INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
										INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
										GROUP BY s.numero_sucursal);


-- 2. Ganancia por dia en sucursales

SELECT SUM(pr.precio)as total_vendido,
	   p.fecha as fecha
	FROM Sucrusales s
	INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
	INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
	INNER JOIN Precios pr on pr.id_platillo = pl.id_platillo
	GROUP BY s.numero_sucursal,p.fecha;
	
-- 3. Tiempo que lleva cada empleado en las sucursales que ha estado. 
SELECT CASE WHEN fecha_contratacion IS NULL THEN DATEDIFF(day,fecha_contratacion,getdate())
            ELSE DATEDIFF(day,fecha_contratacion,getdate())
       END AS dias_trabajados,
	   es.rfc AS rfc_empleado,
	   s.numero_sucursal
FROM Sucrusales s
INNER JOIN EmpleadosSucursal es ON s.numero_sucursal = es.numero_sucursal
GROUP BY es.rfc,s.numero_sucursal, fecha_contratacion;

-- 4. El platillo y salsa más comprado de cada cliente

-- 5. El proveedor al que más se le compra

SELECT MAX(ventas.articulo_comprados_vendedor) AS ventas,
	  ventas.rfc AS proveedores_con_compramax
FROM (
	SELECT SUM(cantidad) AS articulo_comprados_vendedor,
		   v.rfc AS rfc
	FROM Vendedores v
	INNER JOIN Inventario i on v.rfc = i.rfc_provedor
	GROUP BY v.rfc) ventas
GROUP BY ventas.rfc;

-- 6. Precio actual de cada platillo por sucursal.
SELECT sub.nombre AS nombre_platillo ,
	   MAX (sub.fecha) AS fecha_precio,
	   sub.precio,
	   sub.sucursal
FROM ( 
	SELECT s.numero_sucursal AS sucursal,
		   pr.fecha AS fecha,
		   pr.precio AS precio,
		   pl.nombre AS nombre
	FROM Sucrusales s
	INNER JOIN Pedidos p on p.numero_sucursal = s.numero_sucursal
	INNER JOIN PlatillosPedido pp on pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
	INNER JOIN Precios pr ON pr.id_platillo = pl.id_platillo
	) sub
GROUP BY sub.nombre, sub.fecha, sub.precio,sub.sucursal
;
-- 6 ALT

SELECT pl.nombre AS nombre_platillo ,
	   MAX (pr.fecha) AS fecha_precio,
	   pr.precio,
	   s.numero_sucursal
FROM Sucrusales s
INNER JOIN Pedidos p on p.numero_sucursal = s.numero_sucursal
INNER JOIN PlatillosPedido pp on pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
INNER JOIN Precios pr ON pr.id_platillo = pl.id_platillo
GROUP BY pl.nombre, pr.precio, s.numero_sucursal;
-- SI NO JALA CAMBIAR POR pl.id_platillo aqui

-- 7. Platillos más vendidos con tarjeta de credito
SELECT COUNT(pl.id_platillo) AS total_vendidos,
       pl.nombre AS nombre_platillo,
       p.metodo_pago
FROM Pedidos p
INNER JOIN PlatillosPedido pp on pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
WHERE p.metodo_pago = 'credito'
GROUP BY pl.id_platillo, pl.nombre, p.metodo_pago;
-- si no jala quitar la ultima fila


-- 8. Numero de platillo entregados por tipo de transporte en cada sucursal
SELECT SUM(pl.id_platillo) AS platillos_vendidos,
       em.tipo_transporte 
FROM Empleados em 
INNER JOIN EmpleadosSucursal es ON es.rfc = em.rfc
INNER JOIN Sucrusales s ON s.numero_sucursal = es.numero_sucursal
INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
GROUP BY pl.id_platillo, em.tipo_transporte;

-- 9. Cantidad y precio del inventario dividido por mes 
--10. Numero de clientes del estado con mas usuarios
SELECT  estado, COUNT(correo)  AS Numero_clientes
		
FROM    Clientes
GROUP BY
        estado
HAVING  COUNT(correo) >= ALL (SELECT COUNT(correo)
                              FROM   Clientes
                              GROUP BY estado) ;
                                           
         
INSERT INTO Clientes VALUES('fyaugihoj','vghbkjl','vgbhj','ghj',7,'34313','1231,',12,'Mexico','gotiam','311')
INSERT INTO Clientes VALUES('wfgehk','vghbkjl','vgbhj','ghj',7,'34313','1231,',12,'Mexico','gotiam','311')
INSERT INTO Clientes VALUES('231','vghbkjl','vgbhj','ghj',7,'34313','1231,',12,'Mexico','gotiam','311')

INSERT INTO Clientes VALUES('2311','vghbkjl','vgbhj','ghj',7,'34313','1231,',12,'Mexic1o','gotiam','311')

-- 11. El método de pago más usado en cada sucursal
-- si no jala usar un sum dentro de un max.
SELECT  s.numero_sucursal, 
		metodo_pago,
        COUNT(metodo_pago) AS veces_usado
FROM    Sucrusales s
INNER JOIN Pedidos p ON p.numero_sucursal = s.numero_sucursal
GROUP BY
        metodo_pago, s.numero_sucursal
HAVING  COUNT(metodo_pago) >= ALL (SELECT COUNT(metodo_pago)
                              FROM Sucrusales s
							  INNER JOIN Pedidos p ON p.numero_sucursal = s.numero_sucursal
							  GROUP BY metodo_pago );
     
-- 12. Los platillos que lleven más de 4 ingredientes y cuesten mas de 60 pesos
SELECT COUNT(mp.id_articulo) AS ingredientes,
       pl.nombre AS nombre_platillo
FROM Platillos pl 
INNER JOIN IngredientesPlatillo ip on pl.id_platillo = ip.id_platillo
INNER JOIN MateriaPrima mp ON mp.id_articulo = ip.id_articulo
INNER JOIN Precios pr ON pr.id_platillo = pl.id_platillo
GROUP BY pl.nombre,pr.precio
HAVING COUNT(mp.id_articulo) > 4 and pr.precio > 60;

-- 13. El total de todos los pagos hechos a empleados. 
-- Se asume que el salario es mensual.
SELECT SUM(salario * DATEDIFF(month,fecha_contratacion,getdate()))  AS total_pagado
FROM EmpleadosSucursal es; 

-- 14. El cliente que más ha gastado en los últimos 6 meses en cada sucursal.

SELECT MAX(suma) AS total_comprado,
       sub.nu AS numero_sucursal
FROM
	(SELECT SUM(pr.precio) AS suma,
		   s.numero_sucursal AS nu,
		   c.correo AS co
	FROM Clientes c 
	INNER JOIN Sucrusales s ON s.numero_sucursal = c.numero_sucursal
	INNER JOIN Pedidos p on p.numero_sucursal = s.numero_sucursal
	INNER JOIN PlatillosPedido pp on pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
	INNER JOIN Precios pr ON pr.id_platillo = pl.id_platillo
	WHERE DATEDIFF(month,p.fecha,getdate()) <= 6
	GROUP BY s.numero_sucursal,c.correo)sub
GROUP BY sub.nu
;

-- 15. La salsa más vendida junto con tacos.
SELECT COUNT(sp.nombre_salsa) AS veces_vendida_con_tacos,
		sp.nombre_salsa
FROM PlatillosPedido pp 
INNER JOIN Pedidos p ON p.numero_ticket = pp.numero_ticket
INNER JOIN SalsasPedido sp ON sp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
INNER JOIN Tipo t ON  t.id_tipo = pl.id_tipo
WHERE t.nombre = 'tacos'
GROUP BY sp.nombre_salsa
HAVING COUNT(sp.nombre_salsa) >= ALL (  SELECT COUNT(sp.nombre_salsa)
										FROM PlatillosPedido pp 
										INNER JOIN Pedidos p ON p.numero_ticket = pp.numero_ticket
										INNER JOIN SalsasPedido sp ON sp.numero_ticket = p.numero_ticket
										INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
										INNER JOIN Tipo t ON  t.id_tipo = pl.id_tipo
										WHERE t.nombre = 'tacos'
										GROUP BY sp.nombre_salsa);

--16. El tipo de ingrediente más utilizado en tortas.
--17 El total de los pedidos que no tienen un cliente guardado
SELECT COUNT(mp.nombre) AS ventas,
       mp.nombre AS ingrediente_con_torta
FROM PlatillosPedido pp 
INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
INNER JOIN Tipo t ON  t.id_tipo = pl.id_tipo
INNER JOIN IngredientesPlatillo ip ON ip.id_platillo = pl.id_platillo
INNER JOIN MateriaPrima mp ON mp.id_articulo = ip.id_platillo
WHERE t.nombre = 'tortas'
GROUP BY mp.nombre
HAVING COUNT(mp.nombre) >= ALL (SELECT COUNT(mp.nombre)
								FROM PlatillosPedido pp 
								INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
								INNER JOIN Tipo t ON  t.id_tipo = pl.id_tipo
								INNER JOIN IngredientesPlatillo ip ON ip.id_platillo = pl.id_platillo
								INNER JOIN MateriaPrima mp ON mp.id_articulo = ip.id_platillo
								WHERE t.nombre = 'tortas'
								GROUP BY mp.nombre
);













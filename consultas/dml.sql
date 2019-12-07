USE TaqueroMucho;

-- 1. Sucursal que más ha vendido

SELECT 
       COUNT(pl.id_platillo)as total_ventas,
       s.numero_sucursal
FROM Sucursales s
INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
GROUP BY s.numero_sucursal
HAVING COUNT(pl.id_platillo) >= ALL (  SELECT 
									       COUNT(pl.id_platillo)
										FROM Sucursales s
										INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
										INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
										INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
										GROUP BY s.numero_sucursal);


-- 2. Ganancia por dia en sucursales

SELECT SUM(pr.precio)as total_vendido,
	   s.numero_sucursal,
	   p.fecha
	FROM Sucursales s
	INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
	INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
	INNER JOIN Precios pr on pr.id_platillo = pl.id_platillo
	GROUP BY s.numero_sucursal,p.fecha;
	
-- 3. Tiempo que lleva cada empleado en las sucursales que ha trabajado. 
SELECT CASE WHEN fecha_contratacion IS NULL THEN DATEDIFF(day,fecha_contratacion,getdate())
            ELSE DATEDIFF(day,fecha_contratacion,getdate())
       END AS dias_trabajados,
	   es.rfc AS rfc_empleado,
	   s.numero_sucursal
FROM Sucursales s
INNER JOIN Empleados es ON s.numero_sucursal = es.numero_sucursal
GROUP BY es.rfc,s.numero_sucursal, fecha_contratacion;

-- 4. Ventas totales de cada platillo
SELECT COUNT(pl.nombre) AS veces_comprado,
		pl.nombre
FROM Clientes c 
INNER JOIN Sucursales s ON s.numero_sucursal = c.numero_sucursal
INNER JOIN Pedidos p ON p.numero_sucursal = s.numero_sucursal
INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
GROUP BY pl.nombre;

-- 5. El proveedor al que más se le compra
SELECT SUM(cantidad) AS articulo_comprados_vendedor,
		   v.rfc AS rfc
	FROM Vendedores v
	INNER JOIN Inventario i on v.rfc = i.rfc_provedor
	GROUP BY v.rfc HAVING SUM(cantidad) >= ALL (SELECT SUM(cantidad) 
													FROM Vendedores v
													INNER JOIN Inventario i on v.rfc = i.rfc_provedor
													GROUP BY v.rfc);
	
-- 6. Precio actual de cada platillo por sucursal.
SELECT 
	   MAX (sub.fecha) AS fecha_precio,
	   sub.precio, sub.sucursal
FROM ( 
	SELECT s.numero_sucursal AS sucursal,
		   pr.fecha AS fecha,
		   pr.precio AS precio,
		   pl.nombre AS nombre
	FROM Sucursales s
	INNER JOIN Pedidos p on p.numero_sucursal = s.numero_sucursal
	INNER JOIN PlatillosPedido pp on pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
	INNER JOIN Precios pr ON pr.id_platillo = pl.id_platillo
	) sub
GROUP BY sub.sucursal,sub.fecha, sub.precio
;
-- 7. Platillos más vendidos usando efectivo.
SELECT COUNT(pl.id_platillo) AS total_vendidos,
       pl.nombre AS nombre_platillo,
       p.metodo_pago
FROM Pedidos p
INNER JOIN PlatillosPedido pp on pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
WHERE p.metodo_pago = 'Crédito' OR p.metodo_pago = 'Débito'
GROUP BY pl.id_platillo, pl.nombre, p.metodo_pago;

-- 8. Numero de platillo entregados por tipo de transporte en cada sucursal
SELECT SUM(pl.id_platillo) AS platillos_vendidos,
       em.tipo_transporte 
FROM Empleados em 
INNER JOIN Sucursales s ON s.numero_sucursal = em.numero_sucursal
INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
GROUP BY pl.id_platillo, em.tipo_transporte;

--9 . Numero de clientes del estado con mas usuarios
SELECT  estado, COUNT(correo_electronico)  AS Numero_clientes		
FROM    Clientes
WHERE estado != 'NULL'
GROUP BY estado
HAVING  COUNT(correo_electronico) >= ALL (SELECT COUNT(correo_electronico)
                              FROM   Clientes
                              WHERE estado != 'NULL'
                              GROUP BY estado) ;

                                           
        
-- 10. Veces que cada metodo de pago ha sido usado en cada sucursal
SELECT  s.numero_sucursal, 
		metodo_pago,
        COUNT(metodo_pago) AS veces_usado
FROM    Sucursales s
INNER JOIN Pedidos p ON p.numero_sucursal = s.numero_sucursal
GROUP BY metodo_pago, s.numero_sucursal;
     
-- 11. Los platillos que lleven más de 4 ingredientes y cuesten mas de 60 pesos
SELECT COUNT(mp.id_articulo) AS ingredientes,
       pl.nombre AS nombre_platillo
FROM Platillos pl 
INNER JOIN IngredientesPlatillo ip on pl.id_platillo = ip.id_platillo
INNER JOIN MateriaPrima mp ON mp.id_articulo = ip.id_articulo
INNER JOIN Precios pr ON pr.id_platillo = pl.id_platillo
GROUP BY pl.nombre,pr.precio
HAVING COUNT(mp.id_articulo) > 4 and pr.precio > 60;

-- 12. El total de todos los pagos hechos a empleados. 
-- Se asume que el salario es mensual.
SELECT SUM(salario * DATEDIFF(month,fecha_contratacion,getdate()))  AS total_pagado
FROM Empleados es; 

-- 13. La cantidad de dinero que más ha gastado un cliente en los últimos 6 meses en cada sucursal.

SELECT MAX(suma) AS total_comprado,
       sub.nu AS numero_sucursal
FROM
	(SELECT SUM(pr.precio) AS suma,
		   s.numero_sucursal AS nu,
		   c.correo_electronico AS co
	FROM Clientes c 
	INNER JOIN Sucursales s ON s.numero_sucursal = c.numero_sucursal
	INNER JOIN Pedidos p on p.numero_sucursal = s.numero_sucursal
	INNER JOIN PlatillosPedido pp on pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
	INNER JOIN Precios pr ON pr.id_platillo = pl.id_platillo
	WHERE DATEDIFF(month,p.fecha,getdate()) <= 6
	GROUP BY s.numero_sucursal,c.correo_electronico)sub
GROUP BY sub.nu
;

-- 14. La salsa más vendida junto con tacos.
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

--15. El tipo de ingrediente más utilizado en tacos
SELECT COUNT(mp.nombre) AS ventas,
       mp.nombre AS ingrediente_con_tacos
FROM PlatillosPedido pp 
INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
INNER JOIN Tipo t ON  t.id_tipo = pl.id_tipo
INNER JOIN IngredientesPlatillo ip ON ip.id_platillo = pl.id_platillo
INNER JOIN MateriaPrima mp ON mp.id_articulo = ip.id_platillo
WHERE t.nombre = 'Tacos'
GROUP BY mp.nombre
HAVING COUNT(mp.nombre) >= ALL (SELECT COUNT(mp.nombre)
								FROM PlatillosPedido pp 
								INNER JOIN Platillos pl ON pl.id_platillo = pp.id_platillo
								INNER JOIN Tipo t ON  t.id_tipo = pl.id_tipo
								INNER JOIN IngredientesPlatillo ip ON ip.id_platillo = pl.id_platillo
								INNER JOIN MateriaPrima mp ON mp.id_articulo = ip.id_platillo
								WHERE t.nombre = 'Tacos'
								GROUP BY mp.nombre
);













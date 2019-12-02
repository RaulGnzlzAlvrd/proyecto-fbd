USE TaqueroMucho;

-- Platillo más vendido por sucursal
/*
SELECT MAX(total) as maximo 
FROM (

	SELECT COUNT(pl.id_platillo)as total,
	       s.numero_sucursal
	FROM Sucrusales s
	INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
	INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
	GROUP BY s.numero_sucursal);

*/
-- 2. Ganancia por dia en sucursales

SELECT SUM(pr.precio)as total_vendido,
	   p.fecha as fecha
	FROM Sucrusales s
	INNER JOIN Pedidos p ON s.numero_sucursal = p.numero_sucursal
	INNER JOIN PlatillosPedido pp ON pp.numero_ticket = p.numero_ticket
	INNER JOIN Platillos pl on pp.id_platillo = pl.id_platillo
	INNER JOIN Precios pr on pr.id_platillo = pl.id_platillo
	GROUP BY s.numero_sucursal,p.fecha;
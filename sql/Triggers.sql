USE TaqueroMucho;

-- Este Trigger sirve para que el cliente DEFAULT se añada de manera automática al crear una sucursal
CREATE TRIGGER Cliente_Default ON Sucursales
AFTER INSERT AS
BEGIN
SET NOCOUNT ON
DECLARE @suc int
SELECT @suc = s.numero_sucursal FROM Sucursales s JOIN Inserted i ON s.numero_sucursal = i.numero_sucursal
insert into Clientes(correo_electronico, nombre, apellido_paterno, apellido_materno, numero_sucursal) values(TRIM(CONCAT(STR(@suc), '@DEFAULT')), 'DEFAULT', 'DEFAULT', 'DEFAULT', @suc)
END;
GO

-- Este trigger añade automáticamente la promoción que corresponde al día y al producto de un pedido si es que aplica.
CREATE TRIGGER PromoPedido ON PlatillosPedido
AFTER INSERT AS
BEGIN
SET NOCOUNT ON
DECLARE @dia int
DECLARE @promo int
DECLARE @ped int
SELECT @ped = p.numero_ticket FROM Inserted i JOIN Pedidos p ON p.numero_ticket = i.numero_ticket
IF NOT EXISTS (SELECT * FROM PromocionesPedido WHERE numero_ticket = @ped)
BEGIN
	SELECT @dia = DAY(p.fecha) FROM Pedidos p WHERE p.numero_ticket = @ped
	SELECT @promo = pr.id_promocion FROM Promociones pr WHERE pr.dia = @dia
	IF @dia is NOT NULL AND @promo IS NOT NULL
		BEGIN
		INSERT into PromocionesPedido values(@ped, @promo)
		END
END
END;
GO
-- Trigger que automáticamente Añade las Presentaciones de Salsas al añadir una salsa
CREATE TRIGGER ADD_Salsas ON Salsas
AFTER INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE @nombre nvarchar(20)
	SELECT @nombre = i.nombre_salsa FROM Inserted i 
	INSERT INTO PresentacionSalsas values(@nombre, '1 lt')
	INSERT INTO PresentacionSalsas values(@nombre, '30 mg')
	INSERT INTO PresentacionSalsas values(@nombre, '1 Kg')
END;
GO
-- Función que regresa 0 si el id que se le pasa como parámetro no corresponde a un ingrediente.
CREATE FUNCTION EsIngrediente(@id int)
RETURNS bit AS
BEGIN
	DECLARE @tipo nvarchar(20)
	SELECT @tipo = tipo FROM MateriaPrima WHERE id_articulo = @id
	IF @tipo = 'Ingrediente'
		RETURN 1
	RETURN 0
END;
GO

-- Función que nos regresa el precio actual de un platillo
CREATE FUNCTION PrecioActual(@id int)
RETURNS float AS
BEGIN
	DECLARE @precio float
	SELECT @precio = X.precio FROM (SELECT TOP(1) precio FROM Precios WHERE id_platillo = @id ORDER BY fecha DESC) AS X
	RETURN @precio
END;
GO
-- Función que nos regresa el precio actual de una presentación de salsa
CREATE FUNCTION PrecioActualSalsa(@nombre nvarchar(20), @pres nvarchar(10))
RETURNS float AS
BEGIN
	DECLARE @precio float
	SELECT @precio = X.precio FROM 
	(SELECT TOP(1) precio 
	FROM PreciosSalsas WHERE nombre_salsa = @nombre AND tamanio = @pres
	ORDER BY fecha DESC) AS X
	RETURN @precio
END;
GO
-- Función Auxiliar que nos devuelve lo gastado en platillos de un pedido con ticket @ticket
CREATE FUNCTION Total_Ped_Platillos(@ticket int)
RETURNS float AS
BEGIN
	DECLARE @res float
	SELECT @res = SUM(TOTAL) 
	FROM 
	(SELECT dbo.PrecioActual(id_platillo)*cantidad Total FROM PlatillosPedido WHERE numero_ticket = @ticket) AS X
	IF @res IS NULL
		RETURN 0.0
	RETURN @res 	
END;
GO
-- Función Auxiliar que nos devuelve lo gastado en salsas de un pedido con ticket @ticket
CREATE FUNCTION Total_Ped_Salsas(@ticket int)
RETURNS float AS
BEGIN
	DECLARE @res float
	SELECT @res = SUM(TOTAL) 
	FROM 
	(SELECT dbo.PrecioActualSalsa(nombre_salsa, tamanio)*cantidad Total 
	FROM SalsasPedido WHERE numero_ticket = @ticket) AS X
	IF @res IS NULL
		RETURN 0.0
	RETURN @res 	
END;
GO
-- Función que nos regresa el total de un pedido con un número de ticket @ticket
CREATE FUNCTION Total_Pedido(@ticket int)
RETURNS float AS
BEGIN
RETURN dbo.Total_Ped_Salsas(@ticket) + dbo.Total_Ped_Platillos(@ticket)
END;
GO
-- Función que revisa que si un cliente va a pagar con puntos y pide un platillo, le alcance
CREATE FUNCTION Valida_Platillos(@ticket int, @platillo int) 
RETURNS bit AS
BEGIN
	DECLARE @pago nvarchar(30)
	DECLARE @puntos int
	DECLARE @total float
	SELECT @puntos = c.puntos 
	FROM Clientes c JOIN (SELECT * FROM Pedidos WHERE numero_ticket = @ticket) AS P ON c.correo_electronico = p.correo_cliente
	SELECT @total = dbo.PrecioActual(id_platillo)*cantidad 
	FROM PlatillosPedido 
	WHERE numero_ticket = @ticket AND id_platillo = @platillo
	SELECT @pago = metodo_pago FROM Pedidos WHERE numero_ticket = @ticket
	IF @pago = 'puntos' AND CEILING(@total) > @puntos
		RETURN 0
	RETURN 1	
END;
GO
-- Función que revisa que si un cliente va a pagar con puntos y pide una salsa, le alcance
CREATE FUNCTION Valida_Salsas(@ticket int, @nom nvarchar(20), @tam nvarchar(20)) 
RETURNS bit AS
BEGIN
	DECLARE @pago nvarchar(30)
	DECLARE @puntos int
	DECLARE @total float
	SELECT @puntos = c.puntos 
	FROM Clientes c JOIN (SELECT * FROM Pedidos WHERE numero_ticket = @ticket) AS P ON c.correo_electronico = p.correo_cliente
	SELECT @total = dbo.PrecioActualSalsa(@nom, @tam)*cantidad 
	FROM SalsasPedido 
	WHERE numero_ticket = @ticket AND nombre_salsa = @nom AND tamanio = @tam
	SELECT @pago = metodo_pago FROM Pedidos WHERE numero_ticket = @ticket
	IF @pago = 'puntos' AND CEILING(@total) > @puntos
		RETURN 0
	RETURN 1	
END;
GO
-- Añadimos Un Check a PlatillosPedido y Salsas Pedido para que no acepte platillos si no alcanzan los puntos
ALTER TABLE PlatillosPedido ADD CONSTRAINT CK_Alcanza_Puntos CHECK(dbo.Valida_Platillos([numero_ticket], [id_platillo]) = 1);
ALTER TABLE SalsasPedido 
ADD CONSTRAINT CK_Alcanza_Puntos_Salsa CHECK(dbo.Valida_Salsas([numero_ticket], [nombre_salsa], [tamanio]) = 1);
GO
-- Trigger que decrementa el número de puntos de un cliente al comprar platillos que paga con puntos, 
-- y los aumenta si no paga con puntos

CREATE TRIGGER AumentaPuntos ON PlatillosPedido
AFTER INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE @correo nvarchar(50)
	DECLARE @puntos int
	DECLARE @bono int
	DECLARE @metpago nvarchar(20)
	SELECT @metpago = P.metodo_pago FROM Pedidos P JOIN Inserted i ON P.numero_ticket = i.numero_ticket
	SELECT @bono = FLOOR(dbo.PrecioActual(i.id_platillo)*i.Cantidad)
	FROM Inserted i
	SELECT @correo = c.correo_electronico, @puntos = c.puntos 
	FROM Clientes c JOIN Pedidos p ON c.correo_electronico = p.correo_cliente JOIN Inserted i ON p.numero_ticket = i.numero_ticket
	IF @metpago = 'puntos'
		UPDATE Clientes SET puntos = @puntos - @bono WHERE correo_electronico = @correo
	ELSE
		UPDATE Clientes SET puntos = @puntos + FLOOR(@bono*.1) WHERE correo_electronico = @correo
END;
GO
-- Trigger que aumenta o decrementa el número de puntos de un cliente al comprar salsas dependiendo de si ága con puntos o no.
CREATE TRIGGER AumentaPuntosSalsa ON SalsasPedido
AFTER INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE @correo nvarchar(50)
	DECLARE @puntos int
	DECLARE @bono int
	DECLARE @metpago nvarchar(20)
	SELECT @metpago = P.metodo_pago FROM Pedidos P JOIN Inserted i ON P.numero_ticket = i.numero_ticket
	SELECT @bono = FLOOR(dbo.PrecioActualSalsa(i.nombre_salsa, i.tamanio)*i.Cantidad)*.1 
	FROM Inserted i
	SELECT @correo = c.correo_electronico, @puntos = c.puntos 
	FROM Clientes c JOIN Pedidos p ON c.correo_electronico = p.correo_cliente JOIN Inserted i ON p.numero_ticket = i.numero_ticket
	IF @metpago = 'puntos'
		UPDATE Clientes SET puntos = @puntos - @bono WHERE correo_electronico = @correo
	ELSE
		UPDATE Clientes SET puntos = @puntos + @bono WHERE correo_electronico = @correo
END;
GO
-- Agregamos un Check a IngredientesPlatillo e IngredientesSalsas para que sólo sean ingredientes y no mobiliario
ALTER TABLE IngredientesPlatillo ADD CONSTRAINT "CK_EsIngrediente_Platillos" CHECK(dbo.EsIngrediente([id_articulo]) = 1);
ALTER TABLE IngredientesSalsa ADD CONSTRAINT "CK_EsIngrediente_Salsas" CHECK(dbo.EsIngrediente([id_articulo]) = 1);
GO

-- Creamos una vista de Precios para consultar
CREATE VIEW PreciosHoy AS
SELECT DISTINCT pl.nombre, FORMAT(dbo.PrecioActual(p.id_platillo), 'c') precio
FROM Precios p JOIN Platillos pl ON p.id_platillo = pl.id_platillo;
GO

-- Creamos una vista de Precios de Salsa para consultar
CREATE VIEW PreciosHoySalsas AS
WITH pivot_data AS
(
SELECT tamanio, nombre_salsa, dbo.PrecioActualSalsa(nombre_salsa, tamanio) precio 
FROM PresentacionSalsas
)
SELECT nombre_salsa, [1 lt], [1 Kg], [30 mg]
FROM pivot_data
PIVOT
(   MIN([precio]) 
    FOR [tamanio] IN ([1 lt], [1 Kg], [30 mg]) 
)AS p;
GO

SELECT TRIM(CONCAT(STR(numero_sucursal), '@DEFAULT')) FROM Sucursales;

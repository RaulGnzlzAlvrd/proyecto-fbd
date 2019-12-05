USE TaqueroMucho;

-- Este Trigger sirve para que el cliente DEFAULT se añada de manera automática al crear una sucursal
CREATE TRIGGER Cliente_Default ON Sucursales
AFTER INSERT AS
BEGIN
SET NOCOUNT ON;
DECLARE @suc int;
SELECT @suc = s.numero_sucursal FROM Sucursales s JOIN Inserted i ON s.numero_sucursal = i.numero_sucursal;
insert into Clientes(correo_electronico, nombre, apellido_paterno, apellido_materno, numero_sucursal) values(CONCAT(STR(@suc), '@DEFAULT'), 'DEFAULT', 'DEFAULT', 'DEFAULT', @suc);
END;

-- Este trigger añade automáticamente la promoción que corresponde al día y al producto de un pedido si es que aplica.
CREATE TRIGGER PromoPedido ON PlatillosPedido
AFTER INSERT AS
BEGIN
SET NOCOUNT ON;
DECLARE @dia int;
DECLARE @promo int;
DECLARE @ped int;
SELECT @ped = p.numero_ticket FROM Inserted i JOIN Pedidos p ON p.numero_ticket = i.numero_ticket;
IF NOT EXISTS (SELECT * FROM PromocionesPedido WHERE numero_ticket = @ped)
BEGIN
	SELECT @dia = DAY(p.fecha) FROM Pedidos p WHERE p.numero_ticket = @ped;
	SELECT @promo = pr.id_promocion FROM Promociones pr WHERE pr.dia = @dia;
	IF @dia is NOT NULL AND @promo IS NOT NULL
		BEGIN
		INSERT into PromocionesPedido values(@ped, @promo);
		END;
END;
END;

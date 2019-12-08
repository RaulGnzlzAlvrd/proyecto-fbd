USE Master;

-- Creación de la Base de Datos
-- Si la base existe, la vamos a desechar, creamos la base desde cero.
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'TaqueroMucho')
BEGIN
DROP DATABASE TaqueroMucho
END;
GO
--Creamos la base
CREATE DATABASE TaqueroMucho
ON PRIMARY
(
NAME = 'TaqueroMucho',
FILENAME = '/fbd/fundamentos/TaqueroMucho.mdf',
SIZE = 5MB,
MAXSIZE = UNLIMITED,
FILEGROWTH = 100%
)
LOG ON
(
NAME = 'TaqueroMucho_Log',
FILENAME = '/fbd/fundamentos/TaqueroMucho_Log.ldf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB
);
GO
PRINT N'Base de datos creada correctamente';

-- Creación de las tablas de la base de datos
SET DATEFORMAT dmy;
USE TaqueroMucho;

-- Creación de la tabla sucursales
CREATE TABLE [Sucursales] (
  [numero_sucursal] int IDENTITY (1, 1) NOT NULL,
  [calle] nvarchar(30) NOT NULL,
  [numero] int NOT NULL,
  [ciudad] nvarchar(50) NOT NULL,
  [estado] nvarchar(30) NOT NULL,
  CONSTRAINT "PK_Sucursales" PRIMARY KEY CLUSTERED(
    [numero_sucursal]
  )
);

-- Índices para la tabla sucursales
CREATE INDEX "EstadoSucursal" ON [Sucursales]([estado]) 

-- Creación de la tabla Clientes
CREATE TABLE [Clientes] (
  [correo_electronico] nvarchar(50) NOT NULL,
  [nombre] nvarchar(30) NOT NULL DEFAULT 'CLIENTE_DEFAULT',
  [apellido_paterno] nvarchar(30) NOT NULL DEFAULT 'CLIENTE_DEFAULT',
  [apellido_materno] nvarchar(30) NOT NULL DEFAULT 'CLIENTE_DEFAULT',
  [puntos] int NULL,
  [calle] nvarchar(30) NULL,
  [numero] int NULL,
  [estado] nvarchar(30) NULL,
  [ciudad] nvarchar(50) NULL,
  [telefono] nvarchar(14) NULL,
  [numero_sucursal] int NOT NULL,
  CONSTRAINT "PK_Clientes" PRIMARY KEY CLUSTERED(
    [correo_electronico]
  ),
  CONSTRAINT "FK_Clientes" FOREIGN KEY(
    [numero_sucursal]
  )REFERENCES [Sucursales](
    [numero_sucursal]
  ) ON DELETE CASCADE
);

-- Índices para la tabla Clientes
CREATE INDEX "ApellidoCliente" ON [Clientes]([apellido_paterno])
CREATE INDEX "SucursalCliente" ON [Clientes]([numero_sucursal])

-- Creación de la Tabla Empleados
CREATE TABLE [Empleados] (
  [rfc] nchar(13) NOT NULL,
  [nombre] nvarchar(30) NOT NULL,
  [apellido_paterno] nvarchar(30) NOT NULL,
  [apellido_materno] nvarchar(30) NOT NULL,
  [curp] nchar(18) NOT NULL,
  [tipo_empleado] nvarchar(30) NOT NULL,
  [tipo_sangre] nvarchar(3) NOT NULL,
  [fecha_nacimiento] date NOT NULL,
  [calle] nvarchar(30) NOT NULL,
  [numero] int NOT NULL,
  [estado] nvarchar(30) NOT NULL,
  [ciudad] nvarchar(50) NOT NULL,
  [cuenta_bancaria] nvarchar(30) NOT NULL,
  [numero_seguro] nvarchar(30) NOT NULL,
  [tipo_transporte] nvarchar(20) NULL,
  [licencia] nvarchar(20) NULL,
  [numero_sucursal] int NOT NULL,
  [salario] money NOT NULL,
  [bonos] money NULL,
  [fecha_contratacion] datetime NOT NULL,
  CONSTRAINT "PK_Empleados" PRIMARY KEY CLUSTERED(
    [rfc]
  ),
  CONSTRAINT "FK_Empleados_Sucursal" FOREIGN KEY(
    [numero_sucursal]
  )REFERENCES [Sucursales](
    [numero_sucursal]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_Empleados_Tipo" CHECK(
    [tipo_empleado] = 'parrillero' OR 
    [tipo_empleado] = 'taquero' OR
    [tipo_empleado] = 'mesero' OR
    [tipo_empleado] = 'cajero' OR
    [tipo_empleado] = 'tortillero' OR
    [tipo_empleado] = 'repartidor'
  ),
  CONSTRAINT "CK_Empleados_Repartidores" CHECK (
    NOT ([tipo_empleado] = 'repartidor' AND
         [tipo_transporte] = NULL)
  ),
  CONSTRAINT "CK_Empleados_Salario" CHECK (
    [salario] > 0
  ),
  CONSTRAINT "CK_Empleados_Edad" CHECK (
    FLOOR(DATEDIFF(DAY, [fecha_nacimiento], GETDATE())/365.25) >= 18
  ),
  CONSTRAINT "CK_Empleados_Contratacion" CHECK (
    [fecha_contratacion] <= GETDATE()
  ),
  CONSTRAINT "CK_Licencia" CHECK (
    NOT ([tipo_transporte] = 'Motocicleta' AND [licencia] = NULL)
  )
);

-- Creación de Índices para la tabla Empleados
CREATE INDEX "Empleados_Apellido" ON [Empleados]([apellido_paterno])
CREATE INDEX "Empleados_Sucursal" ON [Empleados]([numero_sucursal])

-- Creación de la tabla vendedores
CREATE TABLE [Vendedores] (
  [rfc] nchar(12) NOT NULL,
  [nombre] nvarchar(30) NOT NULL,
  [telefono] nvarchar(14) NOT NULL,
  CONSTRAINT "PK_Vendedores" PRIMARY KEY CLUSTERED(
    [rfc]
  )
);

-- Creación de la tabla MateriaPrima
CREATE TABLE [MateriaPrima] (
  [id_articulo] int IDENTITY(1, 1) NOT NULL,
  [nombre] nvarchar(30) NOT NULL,
  [tipo] nvarchar(20) NOT NULL,
  CONSTRAINT "PK_MateriaPrima" PRIMARY KEY CLUSTERED(
    [id_articulo]
  ),
  CONSTRAINT "CK_MateriaPrima" CHECK(
    [tipo] = 'ingrediente' OR [tipo] = 'mobiliario'
  )
);

-- Creación de Índices para MateriaPrima
CREATE INDEX "NombreArticulo" ON [MateriaPrima]([nombre])


CREATE TABLE [Inventario] (
  [id_articulo] int NOT NULL,
  [numero_sucursal] int NOT NULL,
  [fecha_compra] datetime NOT NULL,
  [precio_unitario] money NOT NULL,
  [cantidad] int NOT NULL,
  [fecha_caducidad] datetime NULL,
  [rfc_provedor] nchar(12) NOT NULL,
  CONSTRAINT "PK_Inventario" PRIMARY KEY CLUSTERED(
    [id_articulo],
    [numero_sucursal],
    [fecha_compra]
  ),
  CONSTRAINT "FK_Inventario_MateriaPrima" FOREIGN KEY(
    [id_articulo]
  )REFERENCES [MateriaPrima](
    [id_articulo]
  ) ON DELETE NO ACTION,
  CONSTRAINT "FK_Inventario_Sucursal" FOREIGN KEY(
    [numero_sucursal]
  ) REFERENCES [Sucursales](
    [numero_sucursal]
  ) ON DELETE CASCADE,
  CONSTRAINT "FK_Inventario_Vendedores" FOREIGN KEY (
    [rfc_provedor]
  ) REFERENCES [Vendedores](
    [rfc]
  ) ON DELETE NO ACTION,
  CONSTRAINT "CK_Inventario_Compra" CHECK (
    [fecha_compra] <= GETDATE()
  ),
  CONSTRAINT "CK_Inventario_Caducidad" CHECK (
    NOT ([fecha_caducidad] is NOT NULL 
    AND [fecha_caducidad] <= GETDATE())
  )
);

-- Creación de Índices para Inventario
CREATE INDEX "Compra_Inventario" ON [Inventario]([fecha_compra])

CREATE INDEX "Caducidad_Invenario" ON [Inventario]([fecha_caducidad])

-- Creación de la Tabla Tipo
CREATE TABLE [Tipo] (
  [id_tipo] int IDENTITY(1,1) NOT NULL,
  [nombre] nvarchar(40) NOT NULL,
  CONSTRAINT "PK_Tipo" PRIMARY KEY CLUSTERED (
    [id_tipo]
  )
);

-- Creación de la tabla Platillos
CREATE TABLE [Platillos] (
  [id_platillo] int IDENTITY(1, 1) NOT NULL,
  [id_tipo] int NOT NULL,
  [nombre] nvarchar(50) NOT NULL
  CONSTRAINT "PK_Platillo" PRIMARY KEY CLUSTERED(
    [id_platillo]
  ),
  CONSTRAINT "FK_PlatilloTipo" FOREIGN KEY (
    [id_tipo]
  ) REFERENCES [Tipo](
    [id_tipo]
  ) ON DELETE NO ACTION
);

-- Creación de Índices para la tabla Platillos
CREATE INDEX "Tipo_platillo" ON [Platillos]([id_tipo])

CREATE INDEX "nombre_platillo" ON [Platillos]([nombre])

-- Creación de la tabla IngredientesPlatillo
CREATE TABLE [IngredientesPlatillo] (
  [id_platillo] int NOT NULL,
  [id_articulo] int NOT NULL,
  [cantidad] float NULL,
  CONSTRAINT "PK_IngredientesPlatillo" PRIMARY KEY (
    [id_platillo],
    [id_articulo]
  ),
  CONSTRAINT "FK_IngredientesPlatillo_Ingredientes" FOREIGN KEY (
    [id_articulo]
  ) REFERENCES [MateriaPrima] (
    [id_articulo]
  ) ON DELETE NO ACTION,
  CONSTRAINT "FK_IngredientesPlatillo_Platillo" FOREIGN KEY (
    [id_platillo]
  )REFERENCES [Platillos] (
    [id_platillo]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_IngredientesPlatillo_Cantidad" CHECK (
    NOT ([cantidad] is NOT NULL AND [cantidad] < 0)
  )
);

-- Creación de índices para IngredientesPlatillo
CREATE INDEX "Platillo_IngredientesPlatillo" ON [IngredientesPlatillo]([id_platillo])

-- Creación de la tabla Salsas
CREATE TABLE [Salsas] (
  [nombre_salsa] nvarchar(20) NOT NULL,
  [picor] nvarchar(20) NOT NULL
  CONSTRAINT "PK_Salsas" PRIMARY KEY CLUSTERED(
    [nombre_salsa]
  ),
  CONSTRAINT "CK_Salsas_Picor" CHECK(
    [picor] = 'dulce' OR
    [picor] = 'bajo' OR
    [picor] = 'medio' OR
    [picor] = 'alto' OR
    [picor] = 'extremo'
  )
);

-- Creación de la tabla IngredientesSalsa
CREATE TABLE [IngredientesSalsa] (
  [nombre_salsa] nvarchar(20) NOT NULL,
  [id_articulo] int NOT NULL,
  [cantidad] float NULL,
  CONSTRAINT "PK_IngredientesSalsa" PRIMARY KEY (
    [nombre_salsa],
    [id_articulo]
  ),
  CONSTRAINT "FK_IngredientesSalsa_Ingredientes" FOREIGN KEY (
    [id_articulo]
  ) REFERENCES [MateriaPrima] (
    [id_articulo]
  ) ON DELETE NO ACTION,
  CONSTRAINT "FK_IngredientesSalsa_Salsas" FOREIGN KEY (
    [nombre_salsa]
  )REFERENCES [Salsas] (
    [nombre_salsa]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_IngredientesSalsa_Cantidad" CHECK (
    NOT ([cantidad] is NOT NULL AND [cantidad] < 0)
  )
);

-- Creación de Índices para IngredientesSalsa
CREATE INDEX "Salsa_IngredientesSalsa" ON [IngredientesSalsa]([nombre_salsa])

-- Creación de la tabla Precios
CREATE TABLE [Precios] (
  [id_platillo] int NOT NULL,
  [fecha] datetime NOT NULL,
  [precio] money NOT NULL,
  CONSTRAINT "PK_Precios" PRIMARY KEY (
    [id_platillo], 
    [fecha]
  ),
  CONSTRAINT "FK_Precios" FOREIGN KEY (
    [id_platillo]
  ) REFERENCES [Platillos] (
    [id_platillo]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_Precios_Precio" CHECK (
    [precio] >= 0
  ),
  CONSTRAINT "CK_Precios_Fecha" CHECK (
    [fecha] <= GETDATE()
  )
);

-- Creación de índices para la tabla Precios
CREATE INDEX "Fecha_Precios" ON [Precios]([fecha])

CREATE INDEX "Platillo_Precios" ON [Precios]([id_platillo])

-- Creación de la tabla Recomendaciones
CREATE TABLE [Recomendaciones] (
  [id_platillo] int NOT NULL,
  [nombre_salsa] nvarchar(20) NOT NULL,
  CONSTRAINT "PK_Recomendaciones" PRIMARY KEY (
    [id_platillo], 
    [nombre_salsa]
  ),
  CONSTRAINT "FK_Recomendaciones_Platillos" FOREIGN KEY (
    [id_platillo]
  ) REFERENCES [Platillos] (
    [id_platillo]
  ) ON DELETE CASCADE,
  CONSTRAINT "FK_Precios_Salsas" FOREIGN KEY (
    [nombre_salsa]
  ) REFERENCES [Salsas] (
    [nombre_salsa]
  ) ON DELETE CASCADE 
);

-- Creación de Índices para la tabla Recomendaciones
CREATE INDEX "Platillo_Recomendaciones" ON [Recomendaciones]([id_platillo])

-- Creación de la tabla PresentacionSalsas
CREATE TABLE [PresentacionSalsas] (
  [nombre_salsa] nvarchar(20) NOT NULL,
  [tamanio] nvarchar(10) NOT NULL,
  CONSTRAINT "PK_PresentacionesSalsa" PRIMARY KEY (
    [nombre_salsa], 
    [tamanio]
  ),
  CONSTRAINT "FK_PresentacionesSalsa" FOREIGN KEY (
    [nombre_salsa]
  ) REFERENCES [Salsas] (
    [nombre_salsa]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_PresentacionesSalsa" CHECK (
    [tamanio] = '1 lt' OR [tamanio] = '30 mg' OR [tamanio] = '1/2 Kg'
  )
);

-- Creación de la Tabla Precios Salsas
CREATE TABLE [PreciosSalsas] (
  [nombre_salsa] nvarchar(20) NOT NULL,
  [tamanio] nvarchar(10) NOT NULL,
  [fecha] date NOT NULL,
  [precio] money NOT NULL,
  CONSTRAINT "PK_PreciosSalsas" PRIMARY KEY (
    [nombre_salsa], 
    [tamanio],
    [fecha]
  ),
  CONSTRAINT "FK_PreciosSalsas_Presentaciones" FOREIGN KEY (
    [nombre_salsa],
    [tamanio]
  ) REFERENCES [PresentacionSalsas] (
    [nombre_salsa],
    [tamanio]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_PreciosSalsa" CHECK (
    [precio] >= 0
  )
);

-- Creación de índices para la tabla PreciosSalsas
CREATE INDEX "Fecha_PreciosSalsas" ON [PreciosSalsas]([fecha])

CREATE INDEX "nombre_PreciosSalsas" ON [PreciosSalsas]([nombre_salsa])

-- Creación de la tabla Pedidos
CREATE TABLE [Pedidos] (
  [numero_ticket] int IDENTITY(1, 1) NOT NULL,
  [numero_sucursal] int NOT NULL,
  [metodo_pago] nvarchar(10) NOT NULL,
  [no_mesa] int NULL,
  [fecha] datetime NOT NULL,
  [correo_cliente] nvarchar(50) NOT NULL,
  CONSTRAINT "PK_Pedidos" PRIMARY KEY (
    [numero_ticket]
  ),
  CONSTRAINT "FK_Pedidos_Sucursal" FOREIGN KEY (
    [numero_sucursal]
  ) REFERENCES [Sucursales] (
    [numero_sucursal]
  ) ON DELETE CASCADE,
  CONSTRAINT "FK_Pedidos_Cliente" FOREIGN KEY (
    [correo_cliente]
  ) REFERENCES [Clientes] (
    [correo_electronico]
  ) ON DELETE NO ACTION,
  CONSTRAINT "CK_fechaPedido" CHECK (
    [fecha] <= GETDATE()
  ),
  CONSTRAINT "CK_pagoPedido" CHECK (
    [metodo_pago] = 'Débito' OR
    [metodo_pago] = 'Crédito' OR
    [metodo_pago] = 'Puntos' OR
    [metodo_pago] = 'Efectivo'
  ),
  -- Este Check evita que haya casos donde un cliente no registrado pague con puntos; El correo de los default tiene como formato numero_sucursal@DEFAULT
  CONSTRAINT "CK_PuntosCliente" CHECK (
    NOT ([metodo_pago] = 'Puntos' AND [correo_cliente] LIKE '%@DEFAULT')
  )
);

-- Creación de la tabla Promociones
CREATE TABLE [Promociones] (
  [id_promocion] int IDENTITY(1, 1) NOT NULL,
  [nombre] nvarchar(50) NOT NULL,
  [tipo_descuento] nvarchar(30) NOT NULL,
  [dia] int NOT NULL UNIQUE,
  [tipo_producto] int NOT NULL,
  CONSTRAINT "PK_Promociones" PRIMARY KEY (
    [id_promocion]
  ),
  CONSTRAINT "FK_Promociones_Tipo" FOREIGN KEY (
    [tipo_producto]
  ) REFERENCES [Tipo] (
    [id_tipo]
  ) ON DELETE CASCADE,
  -- Sólo permitimos cierto tipo de descuento
  CONSTRAINT "CK_Promociones_Tipo_Desc" CHECK (
    [tipo_descuento] = '2x1' OR 
    [tipo_descuento] = 'Todo lo que puedas comer' OR
    ISNUMERIC([tipo_descuento]) = 1
  )
);

-- Creación de Índices para la tabla Promociones
CREATE INDEX "Dia_Promocion" ON [Promociones]([dia])
CREATE INDEX "Tipo_Promocion" ON [Promociones]([tipo_descuento])

-- Creación de la tabla PlatillosPedido
CREATE TABLE [PlatillosPedido] (
  [numero_ticket] int NOT NULL,
  [id_platillo] int NOT NULL,
  [cantidad] int NOT NULL,
  CONSTRAINT "PK_PlatillosPedido" PRIMARY KEY CLUSTERED (
    [numero_ticket], 
    [id_platillo]
  ),
  CONSTRAINT "FK_PlatillosPedido_Pedidos" FOREIGN KEY (
    [numero_ticket]
  ) REFERENCES [Pedidos] (
    [numero_ticket]
  ) ON DELETE CASCADE,
  CONSTRAINT "FK_PlatillosPedido_Platillos" FOREIGN KEY (
    [id_platillo]
  ) REFERENCES [Platillos] (
    [id_platillo]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_PlatillosPedido_Cantidad" CHECK (
    [cantidad] > 0
  )
);

-- Creación de Índices para PlatillosPedido
CREATE INDEX "Pedido_PlatillosPedido" ON [PlatillosPedido]([numero_ticket])

-- Creación de la tabla SalsasPedido
CREATE TABLE [SalsasPedido] (
  [numero_ticket] int NOT NULL,
  [nombre_salsa] nvarchar(20) NOT NULL,
  [tamanio] nvarchar(10) NOT NULL,
  [cantidad] int NOT NULL,
  CONSTRAINT "PK_SalsasPedido" PRIMARY KEY (
    [numero_ticket], 
    [nombre_salsa],
    [tamanio]
  ),
  CONSTRAINT "FK_SalsasPedido_Pedidos" FOREIGN KEY (
    [numero_ticket]
  ) REFERENCES [Pedidos] (
    [numero_ticket]
  ) ON DELETE CASCADE,
  CONSTRAINT "FK_SalsasPedido_Salsas" FOREIGN KEY (
    [nombre_salsa],
    [tamanio]
  ) REFERENCES [PresentacionSalsas] (
    [nombre_salsa],
    [tamanio]
  ) ON DELETE CASCADE,
  CONSTRAINT "CK_PedidosSalsas_Cantidad" CHECK (
    [cantidad] > 0
  )
);

-- Creación de los índices para la tabla SalsasPedido
CREATE INDEX "Pedido_SalsasPedido" ON [SalsasPedido]([numero_ticket])

-- Creación de la tabla PromocionesPedido
CREATE TABLE [PromocionesPedido] (
  [numero_ticket] int NOT NULL UNIQUE,
  [id_promocion] int NOT NULL,
  CONSTRAINT "PK_PromocionesPedido" PRIMARY KEY (
    [numero_ticket], 
    [id_promocion]
  ),
  CONSTRAINT "FK_PromocionesPedido_Pedidos" FOREIGN KEY (
    [numero_ticket]
  ) REFERENCES [Pedidos] (
    [numero_ticket]
  ) ON DELETE CASCADE,
  CONSTRAINT "FK_PromocionesPedido_Promociones" FOREIGN KEY (
    [id_promocion]
  ) REFERENCES [Promociones] (
    [id_promocion]
  ) ON DELETE CASCADE
);


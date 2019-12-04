USE Master;

-- Creación de la Base de Datos
-- Si la base existe, la vamos a desechar, creamos la base desde cero.
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = 'TaqueroMucho')
BEGIN
DROP DATABASE TaqueroMucho
END;
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
PRINT N'Base de datos creada correctamente';

-- Creación de las tablas de la base de datos
SET DATEFORMAT dmy;
USE TaqueroMucho;

CREATE TABLE [Sucrusales] (
  [numero_sucursal] int IDENTITY (1, 1) NOT NULL,
  [calle] nvarchar(30) NOT NULL,
  [numero] int NOT NULL,
  [ciudad] nvarchar(30) NOT NULL,
  [estado] nvarchar(30) NOT NULL,
  CONSTRAINT "PK_Sucursales" PRIMARY KEY CLUSTERED(
    [numero_sucursal]
  )
);

CREATE TABLE [Clientes] (
  [correo] nvarchar(30) NOT NULL,
  [nombre] nvarchar(30) NOT NULL DEFAULT 'CLIENTE_DEFAULT',
  [apellido_paterno] nvarchar(30) NOT NULL DEFAULT 'CLIENTE_DEFAULT',
  [apellido_materno] nvarchar(30) NOT NULL DEFAULT 'CLIENTE_DEFAULT',
  [puntos] int NULL,
  [calle] nvarchar(30) NULL,
  [numero] int NULL,
  [estado] nvarchar(30) NULL,
  [ciudad] nvarchar(30) NULL,
  [telefono] nvarchar(14) NULL,
  [numero_sucursal] int NOT NULL,
  CONSTRAINT "PK_Clientes" PRIMARY KEY CLUSTERED(
    [correo]
  ),
  CONSTRAINT "FK_Clientes" FOREIGN KEY(
    [numero_sucursal]
  )REFERENCES [Sucrusales](
    [numero_sucursal]
  )
);

CREATE TABLE [Empleados] (
  [rfc] nchar(13) NOT NULL,
  [nombre] nvarchar(30) NOT NULL,
  [apellido_paterno] nvarchar(30) NOT NULL,
  [apellido_materno] nvarchar(30) NOT NULL,
  [curp] nchar(18) NOT NULL,
  [tipo_sangre] nchar(2) NOT NULL,
  [fecha_nacimiento] date NOT NULL,
  [calle] nvarchar(30) NOT NULL,
  [numero] int NOT NULL,
  [estado] nvarchar(30) NOT NULL,
  [ciudad] nvarchar(30) NOT NULL,
  [cuenta_bancaria] nvarchar(30) NOT NULL,
  [numero_seguro] integer NOT NULL,
  [tipo_transporte] nvarchar(20) NULL,
  [licencia] nvarchar(20) NULL,
  CONSTRAINT "PK_Empleados" PRIMARY KEY CLUSTERED(
    [rfc]
  )
);

CREATE TABLE [EmpleadosSucursal] (
  [rfc] nchar(13) NOT NULL,
  [numero_sucursal] int NOT NULL,
  [salario] money NOT NULL,
  [tipo_empleado] nvarchar(30) NOT NULL,
  [bonos] money NULL,
  [fecha_contratacion] datetime NOT NULL,
  CONSTRAINT "PK_EmpleadosSucursal" PRIMARY KEY CLUSTERED(
    [rfc], 
    [numero_sucursal]
  ),
  CONSTRAINT "FK_EmpleadosSucursal_Empleados" FOREIGN KEY(
    [rfc]
  )REFERENCES [Empleados](
    [rfc]
  ),
  CONSTRAINT "FK_EmpleadosSucursal_Sucursal" FOREIGN KEY(
    [numero_sucursal]
  )REFERENCES [Sucrusales](
    [numero_sucursal]
  ),
  CONSTRAINT "CK_EmpleadosSucursal_Tipo" CHECK(
    [tipo_empleado] = 'parrillero' OR 
    [tipo_empleado] = 'taquero' OR
    [tipo_empleado] = 'mesero' OR
    [tipo_empleado] = 'cajero' OR
    [tipo_empleado] = 'tortillero' OR
    [tipo_empleado] = 'repartidor'
  ),
);

CREATE TABLE [Vendedores] (
  [rfc] nchar(12) NOT NULL,
  [nombre] nvarchar(30) NOT NULL,
  [telefono] nvarchar(14) NOT NULL,
  CONSTRAINT "PK_Vendedores" PRIMARY KEY CLUSTERED(
    [rfc]
  )
);

CREATE TABLE [MateriaPrima] (
  [id_articulo] int IDENTITY(1, 1) NOT NULL,
  [nombre] nvarchar(30) NOT NULL,
  [tipo] nvarchar(10) NOT NULL,
  CONSTRAINT "PK_MateriaPrima" PRIMARY KEY CLUSTERED(
    [id_articulo]
  ),
  CONSTRAINT "CK_MateriaPrima" CHECK(
    [tipo] = 'ingrediente' OR [tipo] = 'mobiliario'
  )
);

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
  ),
  CONSTRAINT "FK_Inventario_Sucursal" FOREIGN KEY(
    [numero_sucursal]
  ) REFERENCES [Sucrusales](
    [numero_sucursal]
  ),
  CONSTRAINT "FK_Inventario_Vendedores" FOREIGN KEY (
    [rfc_provedor]
  ) REFERENCES [Vendedores](
    [rfc]
  ),
  CONSTRAINT "CK_Inventario_Caducidad" CHECK (
    NOT ([fecha_caducidad] is NOT NULL 
    AND [fecha_caducidad] <= GETDATE())
  )
);

CREATE TABLE [Tipo] (
  [id_tipo] int IDENTITY(1,1) NOT NULL,
  [nombre] nvarchar(20) NOT NULL,
  CONSTRAINT "PK_Tipo" PRIMARY KEY CLUSTERED (
    [id_tipo]
  )
);

CREATE TABLE [Platillos] (
  [id_platillo] int IDENTITY(1, 1) NOT NULL,
  [id_tipo] int NOT NULL,
  [nombre] nvarchar(40) NOT NULL
  CONSTRAINT "PK_Platillo" PRIMARY KEY CLUSTERED(
    [id_platillo]
  ),
  CONSTRAINT "FK_PlatilloTipo" FOREIGN KEY (
    [id_tipo]
  ) REFERENCES [Tipo](
    [id_tipo]
  )
);

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
  ),
  CONSTRAINT "FK_IngredientesPlatillo_Platillo" FOREIGN KEY (
    [id_platillo]
  )REFERENCES [Platillos] (
    [id_platillo]
  ),
  CONSTRAINT "CK_IngredientesPlatillo_Cantidad" CHECK (
    NOT ([cantidad] is NOT NULL AND [cantidad] < 0)
  )
);


CREATE TABLE [Salsas] (
  [nombre_salsa] nvarchar(20) NOT NULL,
  [picor] nvarchar(20) NOT NULL
  CONSTRAINT "PK_Salsas" PRIMARY KEY(
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
  ),
  CONSTRAINT "FK_IngredientesSalsa_Salsas" FOREIGN KEY (
    [nombre_salsa]
  )REFERENCES [Salsas] (
    [nombre_salsa]
  ),
  CONSTRAINT "CK_IngredientesSalsa_Cantidad" CHECK (
    NOT ([cantidad] is NOT NULL AND [cantidad] < 0)
  )
);

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
  ),
  CONSTRAINT "CK_Precios" CHECK (
    [precio] >= 0
  )
);

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
  ),
  CONSTRAINT "FK_Precios_Salsas" FOREIGN KEY (
    [nombre_salsa]
  ) REFERENCES [Salsas] (
    [nombre_salsa]
  )   
);

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
  ),
  CONSTRAINT "CK_PresentacionesSalsa" CHECK (
    [tamanio] = '1 lt' OR [tamanio] = '30 mg' OR [tamanio] = '1 Kg'
  )
);

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
  ),
  CONSTRAINT "CK_PreciosSalsa" CHECK (
    [precio] >= 0
  )
);

CREATE TABLE [Pedidos] (
  [numero_ticket] int IDENTITY(1, 1) NOT NULL,
  [numero_sucursal] int NOT NULL,
  [metodo_pago] nvarchar(10) NOT NULL,
  [no_mesa] int NULL,
  [fecha] datetime NOT NULL,
  [correo_cliente] nvarchar(30) NOT NULL
  CONSTRAINT "PK_Pedidos" PRIMARY KEY (
    [numero_ticket]
  ),
  CONSTRAINT "FK_Pedidos_Sucursal" FOREIGN KEY (
    [numero_sucursal]
  ) REFERENCES [Sucrusales] (
    [numero_sucursal]
  ),
  CONSTRAINT "FK_Pedidos_Cliente" FOREIGN KEY (
    [correo_cliente]
  ) REFERENCES [Clientes] (
    [correo]
  ),
);

CREATE TABLE [Promociones] (
  [id_promocion] int IDENTITY(1, 1) NOT NULL,
  [tipo_descuento] nvarchar(30) NOT NULL,
  [dia] int NOT NULL,
  [tipo_producto] int NOT NULL,
  CONSTRAINT "PK_Promociones" PRIMARY KEY (
    [id_promocion]
  ),
  CONSTRAINT "FK_Promociones_Tipo" FOREIGN KEY (
    [tipo_producto]
  ) REFERENCES [Tipo] (
    [id_tipo]
  )
);

CREATE TABLE [PlatillosPedido] (
  [numero_ticket] int NOT NULL,
  [id_platillo] int NOT NULL,
  CONSTRAINT "PK_PlatillosPedido" PRIMARY KEY (
    [numero_ticket], 
    [id_platillo]
  ),
  CONSTRAINT "FK_PlatillosPedido_Pedidos" FOREIGN KEY (
    [numero_ticket]
  ) REFERENCES [Pedidos] (
    [numero_ticket]
  ),
  CONSTRAINT "FK_PlatillosPedido_Platillos" FOREIGN KEY (
    [id_platillo]
  ) REFERENCES [Platillos] (
    [id_platillo]
  )
);

CREATE TABLE [SalsasPedido] (
  [numero_ticket] int NOT NULL,
  [nombre_salsa] nvarchar(20) NOT NULL,
  [tamanio] nvarchar(10) NOT NULL,
  CONSTRAINT "PK_SalsasPedido" PRIMARY KEY (
    [numero_ticket], 
    [nombre_salsa],
    [tamanio]
  ),
  CONSTRAINT "FK_SalsasPedido_Pedidos" FOREIGN KEY (
    [numero_ticket]
  ) REFERENCES [Pedidos] (
    [numero_ticket]
  ),
  CONSTRAINT "FK_SalsasPedido_Salsas" FOREIGN KEY (
    [nombre_salsa],
    [tamanio]
  ) REFERENCES [PresentacionSalsas] (
    [nombre_salsa],
    [tamanio]
  )
);

CREATE TABLE [PromocionesPedido] (
  [numero_ticket] int NOT NULL,
  [id_promocion] int NOT NULL,
  CONSTRAINT "PK_PromocionesPedido" PRIMARY KEY (
    [numero_ticket], 
    [id_promocion]
  ),
  CONSTRAINT "FK_PromocionesPedido_Pedidos" FOREIGN KEY (
    [numero_ticket]
  ) REFERENCES [Pedidos] (
    [numero_ticket]
  ),
  CONSTRAINT "FK_PromocionesPedido_Promociones" FOREIGN KEY (
    [id_promocion]
  ) REFERENCES [Promociones] (
    [id_promocion]
  )
);

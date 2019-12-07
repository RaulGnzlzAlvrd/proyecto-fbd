# Política de Llaves Mantenimiento de Llaves Foráneas

Todas nuestras llaves foráneas caen en atributos donde no es posible tener NULL como entrada, por lo que la política de
SET NULL queda descartada en todos los casos.

En general, vamos a adoptar la política de cascada, pues vamos a suponer que sí queremos poder borrar valores sin error, por ejemplo, cuando se borre una sucursal por cuestiones de ganancias. 

Hay un par de excepciones, y estas son las siguientes: 

-- Las llaves foráneas que vienen de la tabla Tipo. Esta la vamos a considerar como una tabla bastante estática (pues los tipos de platillos no cambian constantemente), y para evitar que con la cascada perdamos platillos que tenemos guardados, en este caso vamos a adoptar la política NO ACTION. 

-- Consideramos lo mismo con las llaves foráneas que hagan referencia a MateriaPrima, pues los ingredientes tampoco cambian de manera frecuente y podríamos perder información si usamos CASCADE.

-- Lo mismo ocurrirá con los proveedores, querremos seguir guardando la información del inventario que compramos antes, por lo que la mejor política para las llaves foráneas que apuntan hacia Vendedores (sólo Inventario tiene una) también adoptará la política NO ACTION.

-- Por último, la llave foránea de Clientes a Pedidos debe estar en NO ACTION, pues al ponerla en CASCADE se pueden ocasionar ciclos o múltiples caminos de Cascada.

-- 1. Listar todos los pedidos y el cliente asociado.
SELECT Pedidos.id AS pedido_id, Pedidos.fecha, Pedidos.total, Clientes.nombre AS cliente
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id;

-- 2. Mostrar la ubicación de cada cliente en sus pedidos.
SELECT Pedidos.id AS pedido_id, Clientes.nombre AS cliente, Ubicaciones.direccion, Ubicaciones.codigo_postal
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id AND Ubicaciones.entidad_tipo = 'Cliente';

-- 3. Listar productos junto con el proveedor y tipo de producto.
SELECT Productos.nombre AS producto, Productos.precio, Proveedores.nombre AS proveedor, TiposProductos.tipo_nombre AS categoria
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;

-- 4. Consultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
SELECT DISTINCT Empleados.nombre
FROM Empleados
INNER JOIN Pedidos ON Empleados.id = Pedidos.idEmpleado
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
INNER JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id AND Ubicaciones.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ON Ubicaciones.ciudad_id = Ciudad.id
WHERE Ciudad.nombre = 'Madrid';

-- 5. Consultar los 5 productos más vendidos.
SELECT Productos.nombre, SUM(DetallesPedido.cantidad) AS cantidad_vendida
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
GROUP BY Productos.id
ORDER BY cantidad_vendida DESC
LIMIT 5;

-- 6. Obtener la cantidad total de pedidos por cliente y ciudad.
SELECT Clientes.nombre, Ciudad.nombre AS ciudad, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id AND Ubicaciones.entidad_tipo = 'Cliente'
LEFT JOIN Ciudad ON Ubicaciones.ciudad_id = Ciudad.id
GROUP BY Clientes.id, Ciudad.id;

-- 7. Listar clientes y proveedores en la misma ciudad.
SELECT Clientes.nombre AS cliente, Proveedores.nombre AS proveedor, Ciudad.nombre AS ciudad
FROM Clientes
INNER JOIN Ubicaciones U1 ON Clientes.id = U1.entidad_id AND U1.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ON U1.ciudad_id = Ciudad.id
INNER JOIN Ubicaciones U2 ON Ciudad.id = U2.ciudad_id
INNER JOIN Proveedores ON U2.entidad_id = Proveedores.id AND U2.entidad_tipo = 'Proveedor';

-- 8. Mostrar el total de ventas agrupado por tipo de producto.
SELECT TiposProductos.tipo_nombre, SUM(DetallesPedido.cantidad * DetallesPedido.precio) AS total_ventas
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id
GROUP BY TiposProductos.id;

-- 9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
SELECT DISTINCT Empleados.nombre
FROM Empleados
INNER JOIN Pedidos ON Empleados.id = Pedidos.idEmpleado
INNER JOIN DetallesPedido ON Pedidos.id = DetallesPedido.pedido_id
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
WHERE Proveedores.nombre = 'Proveedor A'; -- Cambiar por el proveedor deseado

-- 10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
SELECT Proveedores.nombre, SUM(DetallesPedido.cantidad * DetallesPedido.precio) AS total_ingresos
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
GROUP BY Proveedores.id;

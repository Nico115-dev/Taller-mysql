-- 1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN
SELECT Pedidos.id, Pedidos.fecha, Pedidos.total, Clientes.nombre AS cliente
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id;

-- 2. Listar los productos y proveedores que los suministran con INNER JOIN
SELECT Productos.nombre AS producto, Productos.precio, Proveedores.nombre AS proveedor
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id;

-- 3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN
SELECT Pedidos.id AS pedido_id, Pedidos.fecha, Clientes.nombre AS cliente, 
       Ubicaciones.direccion, Ubicaciones.codigo_postal
FROM Pedidos
LEFT JOIN Clientes ON Pedidos.cliente_id = Clientes.id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id 
AND Ubicaciones.entidad_tipo = 'Cliente';

-- 4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos (LEFT JOIN)
SELECT Empleados.nombre, Pedidos.id AS pedido_id, Pedidos.fecha
FROM Empleados
LEFT JOIN Pedidos ON Empleados.id = Pedidos.idEmpleado;

-- 5. Obtener el tipo de producto y los productos asociados con INNER JOIN
SELECT TiposProductos.tipo_nombre, Productos.nombre AS producto
FROM Productos
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;

-- 6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id;

-- 7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos
SELECT Pedidos.id AS pedido_id, Pedidos.fecha, Empleados.nombre AS empleado
FROM Pedidos
INNER JOIN Empleados ON Pedidos.idEmpleado = Empleados.id;

-- 8. Mostrar productos que no han sido pedidos (RIGHT JOIN)
SELECT Productos.nombre AS producto
FROM Productos
LEFT JOIN DetallesPedido ON Productos.id = DetallesPedido.producto_id
WHERE DetallesPedido.id IS NULL;

-- 9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos, 
       Ubicaciones.direccion, Ubicaciones.codigo_postal
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id 
AND Ubicaciones.entidad_tipo = 'Cliente'
GROUP BY Clientes.id, Ubicaciones.direccion, Ubicaciones.codigo_postal;

-- 10. Unir Proveedores, Productos y TiposProductos para un listado completo de inventario
SELECT Productos.nombre AS producto, Productos.precio, 
       Proveedores.nombre AS proveedor, TiposProductos.tipo_nombre AS categoria
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;

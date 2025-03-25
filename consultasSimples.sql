-- 1. Seleccionar todos los productos con precio mayor a $50
SELECT * FROM Productos WHERE precio > 50;

-- 2. Consultar clientes registrados en una ciudad específica (ejemplo: 'París')
SELECT Clientes.* 
FROM Clientes
JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id
WHERE Ubicaciones.entidad_tipo = 'Cliente' AND Ubicaciones.ciudad_id = 
      (SELECT id FROM Ciudad WHERE nombre = 'París');

-- 3. Mostrar empleados contratados en los últimos 2 años
SELECT * FROM DatosEmpleados 
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 4. Seleccionar proveedores que suministran más de 5 productos
SELECT Proveedores.nombre, COUNT(Productos.id) AS total_productos
FROM Proveedores
JOIN Productos ON Proveedores.id = Productos.proveedor_id
GROUP BY Proveedores.id
HAVING total_productos > 5;

-- 5. Listar clientes que no tienen dirección registrada en Ubicaciones
SELECT Clientes.* 
FROM Clientes
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id 
AND Ubicaciones.entidad_tipo = 'Cliente'
WHERE Ubicaciones.id IS NULL;

-- 6. Calcular el total de ventas por cada cliente
SELECT Clientes.nombre, SUM(Pedidos.total) AS total_compras
FROM Clientes
JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id;

-- 7. Mostrar el salario promedio de los empleados
SELECT AVG(salario) AS salario_promedio FROM DatosEmpleados;

-- 8. Consultar el tipo de productos disponibles en TiposProductos
SELECT tipo_nombre, descripcion FROM TiposProductos;

-- 9. Seleccionar los 3 productos más caros
SELECT * FROM Productos ORDER BY precio DESC LIMIT 3;

-- 10. Consultar el cliente con el mayor número de pedidos
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id
ORDER BY total_pedidos DESC
LIMIT 1;

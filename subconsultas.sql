-- 1. Consultar el producto más caro en cada categoría.
SELECT p.tipo_id, p.nombre, p.precio
FROM Productos p
WHERE p.precio = (
    SELECT MAX(precio) FROM Productos WHERE tipo_id = p.tipo_id
);

-- 2. Encontrar el cliente con mayor total en pedidos.
SELECT c.nombre, SUM(p.total) AS total_compras
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
ORDER BY total_compras DESC
LIMIT 1;

-- 3. Listar empleados que ganan más que el salario promedio.
SELECT e.nombre, d.salario
FROM Empleados e
JOIN DatosEmpleados d ON e.id = d.idEmpleado
WHERE d.salario > (SELECT AVG(salario) FROM DatosEmpleados);

-- 4. Consultar productos que han sido pedidos más de 5 veces.
SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
FROM Productos p
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY p.id
HAVING total_vendido > 5;

-- 5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.
SELECT * FROM Pedidos
WHERE total > (SELECT AVG(total) FROM Pedidos);

-- 6. Seleccionar los 3 proveedores con más productos.
SELECT pr.nombre, COUNT(p.id) AS total_productos
FROM Proveedores pr
JOIN Productos p ON pr.id = p.proveedor_id
GROUP BY pr.id
ORDER BY total_productos DESC
LIMIT 3;

-- 7. Consultar productos con precio superior al promedio en su tipo.
SELECT p.nombre, p.precio, p.tipo_id
FROM Productos p
WHERE p.precio > (
    SELECT AVG(precio) FROM Productos WHERE tipo_id = p.tipo_id
);

-- 8. Mostrar clientes que han realizado más pedidos que la media.
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
HAVING total_pedidos > (SELECT AVG(cantidad_pedidos) FROM (SELECT COUNT(id) AS cantidad_pedidos FROM Pedidos GROUP BY cliente_id) AS subquery);

-- 9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.
SELECT nombre, precio FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);

-- 10. Mostrar empleados cuyo salario es menor al promedio del departamento.
SELECT e.nombre, d.salario, d.idPuesto
FROM Empleados e
JOIN DatosEmpleados d ON e.id = d.idEmpleado
WHERE d.salario < (
    SELECT AVG(salario) FROM DatosEmpleados WHERE idPuesto = d.idPuesto
);

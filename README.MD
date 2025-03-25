# Consultas SQL con JOIN y Consultas Simples

Este documento contiene una serie de consultas SQL utilizando diferentes tipos de JOIN para obtener información combinada de múltiples tablas.

## Consultas con JOIN

### 1. Obtener la lista de todos los pedidos con los nombres de clientes usando INNER JOIN
```sql
SELECT Pedidos.id, Pedidos.fecha, Pedidos.total, Clientes.nombre AS cliente
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id;
```

### 2. Listar los productos y proveedores que los suministran con INNER JOIN
```sql
SELECT Productos.nombre AS producto, Productos.precio, Proveedores.nombre AS proveedor
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id;
```

### 3. Mostrar los pedidos y las ubicaciones de los clientes con LEFT JOIN
```sql
SELECT Pedidos.id AS pedido_id, Pedidos.fecha, Clientes.nombre AS cliente, 
       Ubicaciones.direccion, Ubicaciones.codigo_postal
FROM Pedidos
LEFT JOIN Clientes ON Pedidos.cliente_id = Clientes.id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id 
AND Ubicaciones.entidad_tipo = 'Cliente';
```

### 4. Consultar los empleados que han registrado pedidos, incluyendo empleados sin pedidos (LEFT JOIN)
```sql
SELECT Empleados.nombre, Pedidos.id AS pedido_id, Pedidos.fecha
FROM Empleados
LEFT JOIN Pedidos ON Empleados.id = Pedidos.idEmpleado;
```

### 5. Obtener el tipo de producto y los productos asociados con INNER JOIN
```sql
SELECT TiposProductos.tipo_nombre, Productos.nombre AS producto
FROM Productos
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;
```

### 6. Listar todos los clientes y el número de pedidos realizados con COUNT y GROUP BY
```sql
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id;
```

### 7. Combinar Pedidos y Empleados para mostrar qué empleados gestionaron pedidos específicos
```sql
SELECT Pedidos.id AS pedido_id, Pedidos.fecha, Empleados.nombre AS empleado
FROM Pedidos
INNER JOIN Empleados ON Pedidos.idEmpleado = Empleados.id;
```

### 8. Mostrar productos que no han sido pedidos (LEFT JOIN con filtro de NULL)
```sql
SELECT Productos.nombre AS producto
FROM Productos
LEFT JOIN DetallesPedido ON Productos.id = DetallesPedido.producto_id
WHERE DetallesPedido.id IS NULL;
```

### 9. Mostrar el total de pedidos y ubicación de clientes usando múltiples JOIN
```sql
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos, 
       Ubicaciones.direccion, Ubicaciones.codigo_postal
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id 
AND Ubicaciones.entidad_tipo = 'Cliente'
GROUP BY Clientes.id, Ubicaciones.direccion, Ubicaciones.codigo_postal;
```

### 10. Unir Proveedores, Productos y TiposProductos para un listado completo de inventario
```sql
SELECT Productos.nombre AS producto, Productos.precio, 
       Proveedores.nombre AS proveedor, TiposProductos.tipo_nombre AS categoria
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;
```

## Consultas Simples

### 1. Seleccionar todos los productos con precio mayor a $50
```sql
SELECT * FROM Productos WHERE precio > 50;
```

### 2. Consultar clientes registrados en una ciudad específica (ejemplo: 'París')
```sql
SELECT Clientes.* 
FROM Clientes
JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id
WHERE Ubicaciones.entidad_tipo = 'Cliente' AND Ubicaciones.ciudad_id = 
      (SELECT id FROM Ciudad WHERE nombre = 'París');
```

### 3. Mostrar empleados contratados en los últimos 2 años
```sql
SELECT * FROM DatosEmpleados 
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
```

### 4. Seleccionar proveedores que suministran más de 5 productos
```sql
SELECT Proveedores.nombre, COUNT(Productos.id) AS total_productos
FROM Proveedores
JOIN Productos ON Proveedores.id = Productos.proveedor_id
GROUP BY Proveedores.id
HAVING total_productos > 5;
```

### 5. Listar clientes que no tienen dirección registrada en Ubicaciones
```sql
SELECT Clientes.* 
FROM Clientes
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id 
AND Ubicaciones.entidad_tipo = 'Cliente'
WHERE Ubicaciones.id IS NULL;
```

### 6. Calcular el total de ventas por cada cliente
```sql
SELECT Clientes.nombre, SUM(Pedidos.total) AS total_compras
FROM Clientes
JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id;
```

### 7. Mostrar el salario promedio de los empleados
```sql
SELECT AVG(salario) AS salario_promedio FROM DatosEmpleados;
```

### 8. Consultar el tipo de productos disponibles en TiposProductos
```sql
SELECT tipo_nombre, descripcion FROM TiposProductos;
```

### 9. Seleccionar los 3 productos más caros
```sql
SELECT * FROM Productos ORDER BY precio DESC LIMIT 3;
```

### 10. Consultar el cliente con el mayor número de pedidos
```sql
SELECT Clientes.nombre, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id
ORDER BY total_pedidos DESC
LIMIT 1;
```

## Consultas Multitabla

### 1. Listar todos los pedidos y el cliente asociado.
```sql
SELECT Pedidos.id AS pedido_id, Pedidos.fecha, Pedidos.total, Clientes.nombre AS cliente
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id;
```

### 2. Mostrar la ubicación de cada cliente en sus pedidos.
```sql
SELECT Pedidos.id AS pedido_id, Clientes.nombre AS cliente, Ubicaciones.direccion, Ubicaciones.codigo_postal
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id AND Ubicaciones.entidad_tipo = 'Cliente';
```

### 3. Listar productos junto con el proveedor y tipo de producto.
```sql
SELECT Productos.nombre AS producto, Productos.precio, Proveedores.nombre AS proveedor, TiposProductos.tipo_nombre AS categoria
FROM Productos
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id;
```

### 4. Consultar todos los empleados que gestionan pedidos de clientes en una ciudad específica.
```sql
SELECT DISTINCT Empleados.nombre
FROM Empleados
INNER JOIN Pedidos ON Empleados.id = Pedidos.idEmpleado
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
INNER JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id AND Ubicaciones.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ON Ubicaciones.ciudad_id = Ciudad.id
WHERE Ciudad.nombre = 'Madrid';
```

### 5. Consultar los 5 productos más vendidos.
```sql
SELECT Productos.nombre, SUM(DetallesPedido.cantidad) AS cantidad_vendida
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
GROUP BY Productos.id
ORDER BY cantidad_vendida DESC
LIMIT 5;
```

### 6. Obtener la cantidad total de pedidos por cliente y ciudad.
```sql
SELECT Clientes.nombre, Ciudad.nombre AS ciudad, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
LEFT JOIN Ubicaciones ON Clientes.id = Ubicaciones.entidad_id AND Ubicaciones.entidad_tipo = 'Cliente'
LEFT JOIN Ciudad ON Ubicaciones.ciudad_id = Ciudad.id
GROUP BY Clientes.id, Ciudad.id;
```

### 7. Listar clientes y proveedores en la misma ciudad.
```sql
SELECT Clientes.nombre AS cliente, Proveedores.nombre AS proveedor, Ciudad.nombre AS ciudad
FROM Clientes
INNER JOIN Ubicaciones U1 ON Clientes.id = U1.entidad_id AND U1.entidad_tipo = 'Cliente'
INNER JOIN Ciudad ON U1.ciudad_id = Ciudad.id
INNER JOIN Ubicaciones U2 ON Ciudad.id = U2.ciudad_id
INNER JOIN Proveedores ON U2.entidad_id = Proveedores.id AND U2.entidad_tipo = 'Proveedor';
```

### 8. Mostrar el total de ventas agrupado por tipo de producto.
```sql
SELECT TiposProductos.tipo_nombre, SUM(DetallesPedido.cantidad * DetallesPedido.precio) AS total_ventas
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN TiposProductos ON Productos.tipo_id = TiposProductos.id
GROUP BY TiposProductos.id;
```

### 9. Listar empleados que gestionan pedidos de productos de un proveedor específico.
```sql
SELECT DISTINCT Empleados.nombre
FROM Empleados
INNER JOIN Pedidos ON Empleados.id = Pedidos.idEmpleado
INNER JOIN DetallesPedido ON Pedidos.id = DetallesPedido.pedido_id
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
WHERE Proveedores.nombre = 'Proveedor A';
```

### 10. Obtener el ingreso total de cada proveedor a partir de los productos vendidos.
```sql
SELECT Proveedores.nombre, SUM(DetallesPedido.cantidad * DetallesPedido.precio) AS total_ingresos
FROM DetallesPedido
INNER JOIN Productos ON DetallesPedido.producto_id = Productos.id
INNER JOIN Proveedores ON Productos.proveedor_id = Proveedores.id
GROUP BY Proveedores.id;
```

# Subconsultas

## 1. Consultar el producto más caro en cada categoría.
```sql
SELECT p.tipo_id, p.nombre, p.precio
FROM Productos p
WHERE p.precio = (
    SELECT MAX(precio) FROM Productos WHERE tipo_id = p.tipo_id
);
```

## 2. Encontrar el cliente con mayor total en pedidos.
```sql
SELECT c.nombre, SUM(p.total) AS total_compras
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
ORDER BY total_compras DESC
LIMIT 1;
```

## 3. Listar empleados que ganan más que el salario promedio.
```sql
SELECT e.nombre, d.salario
FROM Empleados e
JOIN DatosEmpleados d ON e.id = d.idEmpleado
WHERE d.salario > (SELECT AVG(salario) FROM DatosEmpleados);
```

## 4. Consultar productos que han sido pedidos más de 5 veces.
```sql
SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
FROM Productos p
JOIN DetallesPedido dp ON p.id = dp.producto_id
GROUP BY p.id
HAVING total_vendido > 5;
```

## 5. Listar pedidos cuyo total es mayor al promedio de todos los pedidos.
```sql
SELECT * FROM Pedidos
WHERE total > (SELECT AVG(total) FROM Pedidos);
```

## 6. Seleccionar los 3 proveedores con más productos.
```sql
SELECT pr.nombre, COUNT(p.id) AS total_productos
FROM Proveedores pr
JOIN Productos p ON pr.id = p.proveedor_id
GROUP BY pr.id
ORDER BY total_productos DESC
LIMIT 3;
```

## 7. Consultar productos con precio superior al promedio en su tipo.
```sql
SELECT p.nombre, p.precio, p.tipo_id
FROM Productos p
WHERE p.precio > (
    SELECT AVG(precio) FROM Productos WHERE tipo_id = p.tipo_id
);
```

## 8. Mostrar clientes que han realizado más pedidos que la media.
```sql
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM Clientes c
JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id
HAVING total_pedidos > (SELECT AVG(cantidad_pedidos) FROM (SELECT COUNT(id) AS cantidad_pedidos FROM Pedidos GROUP BY cliente_id) AS subquery);
```

## 9. Encontrar productos cuyo precio es mayor que el promedio de todos los productos.
```sql
SELECT nombre, precio FROM Productos
WHERE precio > (SELECT AVG(precio) FROM Productos);
```

## 10. Mostrar empleados cuyo salario es menor al promedio del departamento.
```sql
SELECT e.nombre, d.salario, d.idPuesto
FROM Empleados e
JOIN DatosEmpleados d ON e.id = d.idEmpleado
WHERE d.salario < (
    SELECT AVG(salario) FROM DatosEmpleados WHERE idPuesto = d.idPuesto
);
```

# Procedimientos Almacenados en MySQL

## 1. Procedimiento para actualizar el precio de todos los productos de un proveedor
```sql
DELIMITER //
CREATE PROCEDURE ActualizarPrecioProveedor(IN proveedorID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 + porcentaje / 100)
    WHERE proveedor_id = proveedorID;
END //
DELIMITER ;
CALL ActualizarPrecioProveedor(1, 10);
```

## 2. Procedimiento que devuelve la dirección de un cliente por ID
```sql
DELIMITER //
CREATE PROCEDURE ObtenerDireccionCliente(IN clienteID INT)
BEGIN
    SELECT direccion FROM Ubicaciones
    WHERE entidad_id = clienteID AND entidad_tipo = 'Cliente'
    LIMIT 1;
END //
DELIMITER ;
CALL ObtenerDireccionCliente(3);
```

## 3. Procedimiento para registrar un pedido nuevo y sus detalles
```sql
DELIMITER //
CREATE PROCEDURE RegistrarPedido(IN clienteID INT, IN fechaPedido DATE, IN total DECIMAL(10,2))
BEGIN
    INSERT INTO Pedidos (cliente_id, fecha, total)
    VALUES (clienteID, fechaPedido, total);
END //
DELIMITER ;
CALL RegistrarPedido(2, CURDATE(), 500.00);
```

## 4. Procedimiento para calcular el total de ventas de un cliente
```sql
DELIMITER //
CREATE PROCEDURE TotalVentasCliente(IN clienteID INT)
BEGIN
    SELECT SUM(total) AS TotalVentas FROM Pedidos WHERE cliente_id = clienteID;
END //
DELIMITER ;
CALL TotalVentasCliente(1);
```

## 5. Procedimiento para obtener los empleados por puesto
```sql
DELIMITER //
CREATE PROCEDURE ObtenerEmpleadosPorPuesto(IN puestoID INT)
BEGIN
    SELECT e.nombre 
    FROM Empleados e
    JOIN DatosEmpleados d ON e.id = d.idEmpleado
    WHERE d.idPuesto = puestoID;
END //
DELIMITER ;
CALL ObtenerEmpleadosPorPuesto(2);
```

## 6. Procedimiento para actualizar el salario de empleados por puesto
```sql
DELIMITER //
CREATE PROCEDURE ActualizarSalarioPuesto(IN puestoID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE DatosEmpleados
    SET salario = salario * (1 + porcentaje / 100)
    WHERE idPuesto = puestoID;
END //
DELIMITER ;
CALL ActualizarSalarioPuesto(3, 5);
```

## 7. Procedimiento para listar pedidos entre dos fechas
```sql
DELIMITER //
CREATE PROCEDURE ListarPedidosFechas(IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    SELECT * FROM Pedidos 
    WHERE fecha BETWEEN fechaInicio AND fechaFin;
END //
DELIMITER ;
CALL ListarPedidosFechas('2024-01-01', '2024-03-31');
```

## 8. Procedimiento para aplicar un descuento a productos de una categoría
```sql
DELIMITER //
CREATE PROCEDURE AplicarDescuentoCategoria(IN categoriaID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 - porcentaje / 100)
    WHERE tipo_id = categoriaID;
END //
DELIMITER ;
CALL AplicarDescuentoCategoria(2, 15);
```

## 9. Procedimiento para listar proveedores de un tipo de producto
```sql
DELIMITER //
CREATE PROCEDURE ListarProveedoresPorTipo(IN tipoID INT)
BEGIN
    SELECT DISTINCT pr.nombre
    FROM Proveedores pr
    JOIN Productos p ON pr.id = p.proveedor_id
    WHERE p.tipo_id = tipoID;
END //
DELIMITER ;
CALL ListarProveedoresPorTipo(4);
```

## 10. Procedimiento que devuelve el pedido de mayor valor
```sql
DELIMITER //
CREATE PROCEDURE PedidoMayorValor()
BEGIN
    SELECT * FROM Pedidos 
    ORDER BY total DESC 
    LIMIT 1;
END //
DELIMITER ;
CALL PedidoMayorValor();

# Funciones Definidas por el Usuario en MySQL

## 1. Función para calcular días transcurridos desde una fecha dada
```sql
DELIMITER //
CREATE FUNCTION DiasTranscurridos(fecha DATE) RETURNS INT DETERMINISTIC
BEGIN
    RETURN DATEDIFF(CURDATE(), fecha);
END;
//
DELIMITER ;
SELECT DiasTranscurridos('2024-01-01') AS DiasPasados;
```

## 2. Función para calcular el total con impuesto (ejemplo: 16% de IVA)
```sql
DELIMITER //
CREATE FUNCTION TotalConImpuesto(monto DECIMAL(10,2), tasa DECIMAL(5,2)) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN monto + (monto * tasa / 100);
END;
//
DELIMITER ;
SELECT TotalConImpuesto(100, 16) AS TotalConIVA;
```

## 3. Función para contar el total de pedidos de un cliente
```sql
DELIMITER //
CREATE FUNCTION TotalPedidosCliente(cliente_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Pedidos WHERE cliente_id = cliente_id;
    RETURN total;
END;
//
DELIMITER ;
SELECT TotalPedidosCliente(3) AS TotalPedidos;
```

## 4. Función para calcular el precio con descuento de un producto
```sql
DELIMITER //
CREATE FUNCTION PrecioConDescuento(producto_id INT, descuento DECIMAL(5,2)) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10,2);
    SELECT precio INTO precio FROM Productos WHERE id = producto_id;
    RETURN precio - (precio * descuento / 100);
END;
//
DELIMITER ;
SELECT PrecioConDescuento(2, 10) AS PrecioFinal;
```

## 5. Función para verificar si un cliente tiene dirección registrada
```sql
DELIMITER //
CREATE FUNCTION ClienteTieneDireccion(cliente_id INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM Ubicaciones WHERE entidad_id = cliente_id AND entidad_tipo = 'Cliente';
    RETURN existe > 0;
END;
//
DELIMITER ;
SELECT ClienteTieneDireccion(1) AS TieneDireccion;
```

## 6. Función para calcular el salario anual de un empleado
```sql
DELIMITER //
CREATE FUNCTION SalarioAnual(empleado_id INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE salario DECIMAL(10,2);
    SELECT salario INTO salario FROM DatosEmpleados WHERE idEmpleado = empleado_id;
    RETURN salario * 12;
END;
//
DELIMITER ;
SELECT SalarioAnual(4) AS SalarioAnual;
```

## 7. Función para calcular el total de ventas de un tipo de producto
```sql
DELIMITER //
CREATE FUNCTION TotalVentasPorTipo(tipo_id INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(dp.precio * dp.cantidad) INTO total
    FROM DetallesPedido dp
    JOIN Productos p ON dp.producto_id = p.id
    WHERE p.tipo_id = tipo_id;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT TotalVentasPorTipo(3) AS TotalVentas;
```

## 8. Función para obtener el nombre de un cliente por ID
```sql
DELIMITER //
CREATE FUNCTION NombreCliente(cliente_id INT) RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(100);
    SELECT nombre INTO nombre FROM Clientes WHERE id = cliente_id;
    RETURN nombre;
END;
//
DELIMITER ;
SELECT NombreCliente(5) AS NombreCliente;
```

## 9. Función para obtener el total de un pedido por ID
```sql
DELIMITER //
CREATE FUNCTION TotalPedido(pedido_id INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT total INTO total FROM Pedidos WHERE id = pedido_id;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;
SELECT TotalPedido(2) AS TotalPedido;
```

## 10. Función para verificar si un producto está en inventario
```sql
DELIMITER //
CREATE FUNCTION ProductoEnInventario(producto_id INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM Productos WHERE id = producto_id;
    RETURN existe > 0;
END;
//
DELIMITER;
SELECT ProductoEnInventario(3) AS EnInventario;
```

# Triggers en MySQL

Este documento contiene una colección de triggers en MySQL para gestionar diferentes operaciones y restricciones en la base de datos.

## Lista de Triggers

### 1. Registrar en HistorialSalarios cada cambio de salario de empleados
```sql
DELIMITER //
CREATE TRIGGER trg_HistorialSalarios
AFTER UPDATE ON DatosEmpleados
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO HistorialSalarios (empleado_id, salario_anterior, salario_nuevo, fecha_cambio)
        VALUES (OLD.idEmpleado, OLD.salario, NEW.salario, CURRENT_TIMESTAMP);
    END IF;
END //
DELIMITER ;
```

### 2. Evitar borrar productos con pedidos activos
```sql
DELIMITER //
CREATE TRIGGER trg_PreventDeleteProductos
BEFORE DELETE ON Productos
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM DetallesPedido WHERE producto_id = OLD.id) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar un producto con pedidos activos';
    END IF;
END //
DELIMITER ;
```

### 3. Registrar en HistorialPedidos cada actualización en Pedidos
```sql
DELIMITER //
CREATE TRIGGER trg_HistorialPedidos
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fechaCambio, tipoCambio)
    VALUES (OLD.id, CURRENT_TIMESTAMP, 'Actualización');
END //
DELIMITER ;
```

### 4. Actualizar el inventario al registrar un pedido
```sql
DELIMITER //
CREATE TRIGGER trg_UpdateInventory
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET stock = stock - NEW.cantidad
    WHERE id = NEW.producto_id;
END //
DELIMITER ;
```

### 5. Evitar actualizaciones de precio a menos de $1
```sql
DELIMITER //
CREATE TRIGGER trg_PreventLowPrice
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio no puede ser menor a $1';
    END IF;
END //
DELIMITER ;
```

### 6. Registrar la fecha de creación de un pedido en HistorialPedidos
```sql
DELIMITER //
CREATE TRIGGER trg_CrearHistorialPedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fechaCambio, tipoCambio)
    VALUES (NEW.id, CURRENT_TIMESTAMP, 'Creación');
END //
DELIMITER ;
```

### 7. Mantener el precio total de cada pedido en Pedidos
```sql
DELIMITER //
CREATE TRIGGER trg_UpdateTotalPedido
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET total = (SELECT SUM(precio * cantidad) FROM DetallesPedido WHERE pedido_id = NEW.pedido_id)
    WHERE id = NEW.pedido_id;
END //
DELIMITER ;
```

### 8. Validar que UbicacionCliente no esté vacío al crear un cliente
```sql
DELIMITER //
CREATE TRIGGER trg_ValidateUbicacionCliente
BEFORE INSERT ON Ubicaciones
FOR EACH ROW
BEGIN
    IF NEW.direccion IS NULL OR NEW.direccion = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La dirección no puede estar vacía';
    END IF;
END //
DELIMITER ;
```

### 9. Registrar en LogActividades cada modificación en Proveedores
```sql
DELIMITER //
CREATE TRIGGER trg_LogProveedores
AFTER UPDATE ON Proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (tabla_afectada, id_registro, fecha_modificacion, descripcion)
    VALUES ('Proveedores', OLD.id, CURRENT_TIMESTAMP, 'Proveedor actualizado');
END //
DELIMITER ;
```

### 10. Registrar en HistorialContratos cada cambio en Empleados
```sql
DELIMITER //
CREATE TRIGGER trg_HistorialContratos
AFTER UPDATE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialContratos (empleado_id, fechaCambio, detalle)
    VALUES (OLD.id, CURRENT_TIMESTAMP, 'Cambio en datos del empleado');
END //
DELIMITER ;
```


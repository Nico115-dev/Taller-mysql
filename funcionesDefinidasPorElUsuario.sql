-- 1. Función para calcular días transcurridos desde una fecha dada
DELIMITER //
CREATE FUNCTION DiasTranscurridos(fecha DATE) RETURNS INT DETERMINISTIC
BEGIN
    RETURN DATEDIFF(CURDATE(), fecha);
END;
//
DELIMITER ;
SELECT DiasTranscurridos('2024-01-01') AS DiasPasados;

-- 2. Función para calcular el total con impuesto (ejemplo: 16% de IVA)
DELIMITER //
CREATE FUNCTION TotalConImpuesto(monto DECIMAL(10,2), tasa DECIMAL(5,2)) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    RETURN monto + (monto * tasa / 100);
END;
//
DELIMITER ;
SELECT TotalConImpuesto(100, 16) AS TotalConIVA;

-- 3. Función para contar el total de pedidos de un cliente
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

-- 4. Función para calcular el precio con descuento de un producto
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

-- 5. Función para verificar si un cliente tiene dirección registrada
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

-- 6. Función para calcular el salario anual de un empleado
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

-- 7. Función para calcular el total de ventas de un tipo de producto
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

-- 8. Función para obtener el nombre de un cliente por ID
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

-- 9. Función para obtener el total de un pedido por ID
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

-- 10. Función para verificar si un producto está en inventario
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
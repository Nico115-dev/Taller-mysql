-- 1. Procedimiento para actualizar el precio de todos los productos de un proveedor.
DELIMITER //
CREATE PROCEDURE ActualizarPrecioProveedor(IN proveedorID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 + porcentaje / 100)
    WHERE proveedor_id = proveedorID;
END //
DELIMITER ;
CALL ActualizarPrecioProveedor(1, 10);

-- 2. Procedimiento que devuelve la dirección de un cliente por ID.
DELIMITER //
CREATE PROCEDURE ObtenerDireccionCliente(IN clienteID INT)
BEGIN
    SELECT direccion FROM Ubicaciones
    WHERE entidad_id = clienteID AND entidad_tipo = 'Cliente'
    LIMIT 1;
END //
DELIMITER ;
CALL ObtenerDireccionCliente(3);

-- 3. Procedimiento para registrar un pedido nuevo y sus detalles.
DELIMITER //
CREATE PROCEDURE RegistrarPedido(IN clienteID INT, IN fechaPedido DATE, IN total DECIMAL(10,2))
BEGIN
    INSERT INTO Pedidos (cliente_id, fecha, total)
    VALUES (clienteID, fechaPedido, total);
END //
DELIMITER ;
CALL RegistrarPedido(2, CURDATE(), 500.00);

-- 4. Procedimiento para calcular el total de ventas de un cliente.
DELIMITER //
CREATE PROCEDURE TotalVentasCliente(IN clienteID INT)
BEGIN
    SELECT SUM(total) AS TotalVentas FROM Pedidos WHERE cliente_id = clienteID;
END //
DELIMITER ;
CALL TotalVentasCliente(1);

-- 5. Procedimiento para obtener los empleados por puesto.
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

-- 6. Procedimiento para actualizar el salario de empleados por puesto.
DELIMITER //
CREATE PROCEDURE ActualizarSalarioPuesto(IN puestoID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE DatosEmpleados
    SET salario = salario * (1 + porcentaje / 100)
    WHERE idPuesto = puestoID;
END //
DELIMITER ;
CALL ActualizarSalarioPuesto(3, 5);

-- 7. Procedimiento para listar pedidos entre dos fechas.
DELIMITER //
CREATE PROCEDURE ListarPedidosFechas(IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    SELECT * FROM Pedidos 
    WHERE fecha BETWEEN fechaInicio AND fechaFin;
END //
DELIMITER ;
CALL ListarPedidosFechas('2024-01-01', '2024-03-31');

-- 8. Procedimiento para aplicar un descuento a productos de una categoría.
DELIMITER //
CREATE PROCEDURE AplicarDescuentoCategoria(IN categoriaID INT, IN porcentaje DECIMAL(5,2))
BEGIN
    UPDATE Productos
    SET precio = precio * (1 - porcentaje / 100)
    WHERE tipo_id = categoriaID;
END //
DELIMITER ;
CALL AplicarDescuentoCategoria(2, 15);

-- 9. Procedimiento para listar proveedores de un tipo de producto.
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

-- 10. Procedimiento que devuelve el pedido de mayor valor.
DELIMITER //
CREATE PROCEDURE PedidoMayorValor()
BEGIN
    SELECT * FROM Pedidos 
    ORDER BY total DESC 
    LIMIT 1;
END //
DELIMITER ;
CALL PedidoMayorValor();
-- 1. Registrar en HistorialSalarios cada cambio de salario de empleados
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

-- 2. Evitar borrar productos con pedidos activos
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

-- 3. Registrar en HistorialPedidos cada actualización en Pedidos
DELIMITER //
CREATE TRIGGER trg_HistorialPedidos
AFTER UPDATE ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fechaCambio, tipoCambio)
    VALUES (OLD.id, CURRENT_TIMESTAMP, 'Actualización');
END //
DELIMITER ;

-- 4. Actualizar el inventario al registrar un pedido
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

-- 5. Evitar actualizaciones de precio a menos de $1
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

-- 6. Registrar la fecha de creación de un pedido en HistorialPedidos
DELIMITER //
CREATE TRIGGER trg_CrearHistorialPedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialPedidos (pedido_id, fechaCambio, tipoCambio)
    VALUES (NEW.id, CURRENT_TIMESTAMP, 'Creación');
END //
DELIMITER ;

-- 7. Mantener el precio total de cada pedido en Pedidos
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

-- 8. Validar que UbicacionCliente no esté vacío al crear un cliente
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

-- 9. Registrar en LogActividades cada modificación en Proveedores
DELIMITER //
CREATE TRIGGER trg_LogProveedores
AFTER UPDATE ON Proveedores
FOR EACH ROW
BEGIN
    INSERT INTO LogActividades (tabla_afectada, id_registro, fecha_modificacion, descripcion)
    VALUES ('Proveedores', OLD.id, CURRENT_TIMESTAMP, 'Proveedor actualizado');
END //
DELIMITER ;

-- 10. Registrar en HistorialContratos cada cambio en Empleados
DELIMITER //
CREATE TRIGGER trg_HistorialContratos
AFTER UPDATE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialContratos (empleado_id, fechaCambio, detalle)
    VALUES (OLD.id, CURRENT_TIMESTAMP, 'Cambio en datos del empleado');
END //
DELIMITER ;

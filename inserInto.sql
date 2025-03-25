-- 1. Insertar en la tabla `Pais`
INSERT INTO Pais (nombre) VALUES 
('Brasil'),
('Canadá'),
('Francia'),
('Italia'),
('Alemania');

-- 2. Insertar en la tabla `Estado`
INSERT INTO Estado (nombre, pais_id) VALUES 
('São Paulo', 1),
('Ontario', 2),
('Île-de-France', 3),
('Lombardía', 4),
('Baviera', 5);

-- 3. Insertar en la tabla `Ciudad`
INSERT INTO Ciudad (nombre, estado_id) VALUES 
('São Paulo', 1),
('Toronto', 2),
('París', 3),
('Milán', 4),
('Múnich', 5);

-- 4. Insertar en la tabla `Clientes`
INSERT INTO Clientes (nombre, email) VALUES 
('Roberto Silva', 'roberto.silva@email.com'),
('Emily Smith', 'emily.smith@email.com'),
('Jean Dupont', 'jean.dupont@email.com'),
('Giovanni Rossi', 'giovanni.rossi@email.com'),
('Hans Müller', 'hans.muller@email.com');

-- 5. Insertar en la tabla `Telefonos`
INSERT INTO Telefonos (cliente_id, telefono) VALUES 
(1, '444-1234'),
(1, '444-5678'),
(2, '444-2345'),
(3, '444-3456'),
(4, '444-4567');

-- 6. Insertar en la tabla `Ubicaciones`
INSERT INTO Ubicaciones (entidad_id, entidad_tipo, ciudad_id, direccion, codigo_postal) VALUES 
(1, 'Cliente', 1, 'Avenida Paulista 500', '01310'),
(2, 'Cliente', 2, 'Bay Street 789', 'M5J2S1'),
(3, 'Cliente', 3, 'Rue de Rivoli 123', '75001'),
(4, 'Cliente', 4, 'Via Montenapoleone 25', '20121'),
(5, 'Cliente', 5, 'Marienplatz 15', '80331');

-- 7. Insertar en la tabla `Empleados`
INSERT INTO Empleados (nombre) VALUES 
('Lucas Costa'),
('Sophie Tremblay'),
('Antoine Lefevre'),
('Matteo Romano'),
('Stefan Beck');

-- 8. Insertar en la tabla `Puestos`
INSERT INTO Puestos (descripcion) VALUES 
('Gerente General'),
('Coordinador de Logística'),
('Analista de Recursos Humanos'),
('Especialista en Publicidad'),
('Recepcionista');

-- 9. Insertar en la tabla `DatosEmpleados`
INSERT INTO DatosEmpleados (idEmpleado, idPuesto, salario, fecha_contratacion) VALUES 
(1, 1, 5000.00, '2022-04-10'),
(2, 2, 2800.00, '2021-07-05'),
(3, 3, 3200.00, '2020-11-15'),
(4, 4, 4100.00, '2019-02-20'),
(5, 5, 2200.00, '2023-06-30');

-- 10. Insertar en la tabla `Proveedores`
INSERT INTO Proveedores (nombre) VALUES 
('Distribuidor X'),
('Importaciones Globales'),
('Tech Solutions'),
('Moda Europea'),
('Muebles Premium');

-- 11. Insertar en la tabla `EmpleadoProveedor`
INSERT INTO EmpleadoProveedor (empleado_id, proveedor_id, fecha_relacion) VALUES 
(1, 3, '2021-05-15'),
(2, 4, '2023-01-10'),
(3, 2, '2022-03-18'),
(4, 1, '2020-09-22'),
(5, 5, '2023-02-14');

-- 12. Insertar en la tabla `TiposProductos`
INSERT INTO TiposProductos (tipo_nombre, descripcion, parent_id) VALUES 
('Computadoras', 'Laptops, PC de escritorio y accesorios', NULL),
('Calzado', 'Zapatos, sandalias y botas', NULL),
('Joyería', 'Anillos, collares y pulseras', 2),
('Electrodomésticos', 'Productos para el hogar como refrigeradores y microondas', NULL),
('Bebidas', 'Jugos, refrescos y bebidas alcohólicas', NULL);

-- 13. Insertar en la tabla `Productos`
INSERT INTO Productos (nombre, precio, proveedor_id, tipo_id) VALUES 
('MacBook Air', 1200.00, 1, 1),
('Zapatos de cuero', 80.00, 2, 2),
('Reloj de oro', 250.00, 3, 3),
('Refrigerador Samsung', 600.00, 4, 4),
('Cerveza Artesanal', 12.00, 5, 5);

-- 14. Insertar en la tabla `Pedidos`
INSERT INTO Pedidos (cliente_id, fecha, total) VALUES 
(1, '2023-09-12', 1320.00),
(2, '2023-10-08', 980.00),
(3, '2023-11-23', 520.00),
(4, '2023-12-05', 170.00),
(5, '2024-01-18', 310.00);

-- 15. Insertar en la tabla `DetallesPedido`
INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio) VALUES 
(1, 1, 1, 1200.00),
(1, 3, 1, 250.00),
(2, 2, 2, 80.00),
(3, 4, 1, 600.00),
(4, 5, 2, 12.00);

-- 16. Insertar en la tabla `HistorialPedidos`
INSERT INTO HistorialPedidos (fechaCambio, tipoCambio) VALUES 
('2023-09-13', 1),
('2023-10-09', 2),
('2023-11-24', 1),
('2023-12-06', 3),
('2024-01-19', 1);

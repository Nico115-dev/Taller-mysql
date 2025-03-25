CREATE DATABASE vtaszfs;
USE vtaszfs;

CREATE TABLE Clientes (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
email VARCHAR(85) UNIQUE NOT NULL
);

CREATE TABLE Telefonos(
id INT PRIMARY KEY auto_increment,
cliente_id INT NOT NULL,
telefono varchar(20)
);

CREATE TABLE Ubicaciones (
id INT PRIMARY KEY AUTO_INCREMENT,
entidad_id INT NOT NULL,
entidad_tipo VARCHAR(50) NOT NULL, -- Puede ser 'Cliente', 'Empleado', etc.
ciudad_id INT NOT NULL,
direccion VARCHAR(200) NOT NULL,
codigo_postal VARCHAR(10) NOT NULL,
FOREIGN KEY (ciudad_id) REFERENCES Ciudad(id) ON DELETE CASCADE
);
CREATE TABLE Pais (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE Estado (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
pais_id INT NOT NULL,
FOREIGN KEY (pais_id) REFERENCES Pais(id) ON DELETE CASCADE
);
CREATE TABLE Ciudad (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
estado_id INT NOT NULL,
FOREIGN KEY (estado_id) REFERENCES Estado(id) ON DELETE CASCADE
);
create table HistorialPedidos(
id INT PRIMARY KEY auto_increment,
fechaCambio Date,
tipoCambio int
);
CREATE TABLE Empleados (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(45)
);
CREATE TABLE Puestos(
idPuesto INT NOT NULL AUTO_INCREMENT,
descripcion varchar (200),
PRIMARY KEY (idPuesto)
);
CREATE TABLE DatosEmpleados(
idEmpleado INT NOT NULL,
idPuesto INT NOT NULL,
salario DECIMAL(10, 2),
fecha_contratacion DATE,
PRIMARY KEY (idEmpleado, idPuesto),
FOREIGN KEY (idPuesto) REFERENCES Puestos(idPuesto)
);
CREATE TABLE Proveedores (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(80)
);
CREATE TABLE EmpleadoProveedor (
empleado_id INT NOT NULL,
proveedor_id INT NOT NULL,
fecha_relacion DATE NOT NULL,
PRIMARY KEY (empleado_id, proveedor_id),
FOREIGN KEY (empleado_id) REFERENCES Empleados(id) ON DELETE CASCADE,
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE
);
CREATE TABLE ContactoProveedores(
id INT auto_increment NOT NULL,
proveedor_id INT NOT NULL,
contacto VARCHAR(75),
telefono VARCHAR(20),
direccion VARCHAR(200),
PRIMARY KEY(id),
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
);
CREATE TABLE TiposProductos (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo_nombre VARCHAR(80),
descripcion TEXT,
parent_id INT NULL,   
FOREIGN KEY (parent_id) REFERENCES TiposProductos(id) ON DELETE CASCADE
);
CREATE TABLE Productos (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(80),
precio DECIMAL(10, 2),
proveedor_id INT,
tipo_id INT,
FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id) ON DELETE CASCADE,
FOREIGN KEY (tipo_id) REFERENCES TiposProductos(id) ON DELETE CASCADE
);
CREATE TABLE Pedidos (
id INT PRIMARY KEY AUTO_INCREMENT,
cliente_id INT,
fecha DATE,
total DECIMAL(10, 2),
FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
CREATE TABLE DetallesPedido (
id INT PRIMARY KEY AUTO_INCREMENT,
pedido_id INT,
producto_id INT,
cantidad INT,
precio DECIMAL(10, 2),
FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

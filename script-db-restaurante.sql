
DROP DATABASE if exists restaurante; -- en caso de que la base de datos exista, la elimina
CREATE DATABASE restaurante; -- crea la base de datos 

USE restaurante; -- selecciona la base de datos con la que vamos a trabajar

-- creamos las tablas de la base de datos restaurante

CREATE TABLE clientes ( 
	id_clientes INT NOT NULL PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL, 
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(45),
    fecha_nacimiento datetime
);
    
CREATE TABLE mesas (
	id_mesas INT auto_increment NOT NULL PRIMARY KEY,
    capacidad_pax INT,
    estado_mesas VARCHAR (50), -- indica si la mesa está libre, ocupada o sucia.
    ubicacion VARCHAR (50)
);

CREATE TABLE reservas (
	id_reservas INT NOT NULL auto_increment PRIMARY KEY,
	hora TIME NOT NULL,
    fecha DATE NOT NULL,
    cantidad_pax VARCHAR(50),
    id_mesas INT, 
    id_clientes INT,
    foreign key (id_mesas) references mesas (id_mesas),
    foreign key (id_clientes) references clientes (id_clientes)
);

CREATE TABLE comandas (
	id_comandas INT NOT NULL PRIMARY KEY,
    hora TIME NOT NULL,
    fecha DATE NOT NULL,
    detalle TEXT NOT NULL,
    observaciones TEXT, -- indica pedidos especiales de clientes, como el punto de una carne, alergias, menú vegano, sin tacc, etc.
    id_clientes INT,
    id_mesas INT,
    FOREIGN KEY (id_clientes) REFERENCES clientes (id_clientes),
    FOREIGN KEY (id_mesas) REFERENCES mesas (id_mesas)
);

CREATE TABLE facturas_clientes (
	id_facturas INT NOT NULL auto_increment PRIMARY KEY,
    monto_total INT NOT NULL,
    detalle TEXT NOT NULL,
    id_clientes INT,
    id_comandas INT, 
    FOREIGN KEY (id_clientes) REFERENCES clientes (id_clientes),
    FOREIGN KEY (id_comandas) REFERENCES comandas (id_comandas)
);

CREATE TABLE encuestas_satisfaccion (
	id_encuestas INT auto_increment primary key,
    comentarios TEXT,
    fecha DATE,
    hora TIME, 
    id_clientes INT,
    FOREIGN KEY (id_clientes) REFERENCES clientes (id_clientes)
);

CREATE TABLE menu (
	id_menu INT auto_increment PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100),
    precio INT,
    tipo VARCHAR (50), -- indica si el menú es apto vegano, vegetariano, sin tacc, etc.
    tiempo_elaboracion TIME,
    id_comandas INT,
    FOREIGN KEY (id_comandas) REFERENCES comandas (id_comandas)
);

CREATE TABLE platos(
	id_platos INT auto_increment NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR (100),
    categoria VARCHAR (50),
    tiempo_preparacion TIME,
    disponible TINYINT, -- indica disponibilidad en el menú
    id_menu INT,
    FOREIGN KEY (id_menu) REFERENCES menu (id_menu)
);

CREATE TABLE proveedores (
	id_proveedores INT not null auto_increment PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL,
    telefono VARCHAR (15) NOT NULL,
    direccion VARCHAR (50)
);

CREATE TABLE pedidos_proveedores(
	id_pedidos_proveedores INT not null auto_increment PRIMARY KEY,
    detalle TEXT NOT NULL,
    fecha DATE NOT NULL,
    id_proveedores INT,
    FOREIGN KEY (id_proveedores) REFERENCES proveedores (id_proveedores)
);

CREATE TABLE facturas_proveedores(
	id_facturas_proveedores INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    detalle TEXT,
    fecha DATE,
    monto INT,
    id_proveedores INT,
	id_pedidos_proveedores INT,
    FOREIGN KEY (id_proveedores) REFERENCES proveedores(id_proveedores),
    FOREIGN KEY (id_pedidos_proveedores) REFERENCES pedidos_proveedores (id_pedidos_proveedores)
); 

CREATE TABLE empleados (
	id_empleados INT auto_increment NOT NULL PRIMARY KEY,
    nombre VARCHAR (50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    tipo_documento VARCHAR(15) NOT NULL,
    numero_documento INT NOT NULL,
    direccion VARCHAR (100),
    email VARCHAR (50),
    telefono VARCHAR (15),
    fecha_contratacion DATE NOT NULL,
    puesto VARCHAR (50) NOT NULL,
    alergias TEXT
);

CREATE TABLE turnos_empleados (
	id_turnos INT auto_increment NOT NULL PRIMARY KEY,
    tipo VARCHAR (50), -- indica si es turno de mañana o tarde
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    puesto VARCHAR (50) NOT NULL,
    observaciones VARCHAR (50), 
    id_empleados INT,
    FOREIGN KEY (id_empleados) REFERENCES empleados (id_empleados)
);


CREATE TABLE empleados_despedidos (
	id_empleados_despedidos INT NOT NULL auto_increment PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    fecha_despido DATE NOT NULL,
    motivo_despido TEXT NOT NULL,
    puesto VARCHAR(45),
    id_empleados INT,
    FOREIGN KEY (id_empleados) REFERENCES empleados (id_empleados)
);
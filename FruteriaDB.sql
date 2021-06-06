CREATE DATABASE FruteriaDB

USE FruteriaDB
 
CREATE TABLE clientes(
	Id_Ce VARCHAR(5) PRIMARY KEY NOT NULL,
	Nom_Ce VARCHAR(50) NOT NULL,
	Telefono VARCHAR(10) NOT NULL,
	Correo VARCHAR(70) NOT NULL,
	Direccion VARCHAR(50) NOT NULL
)

CREATE TABLE proveedores(
	Id_Prov VARCHAR(5) PRIMARY KEY NOT NULL,
	Nom_Prov VARCHAR(50) NOT NULL,
	Contacto VARCHAR(10) NOT NULL,
	RFC VARCHAR (13) NOT NULL
)

CREATE TABLE productos(
	Id_Prod VARCHAR(5) PRIMARY KEY NOT NULL,
	NomProd VARCHAR(30) NOT NULL,
	Precio DECIMAL(5,2) NOT NULL CHECK(Precio > 0.0),
	Existencia INT NOT NULL,
	Stock INT NOT NULL
)

CREATE TABLE ventas_detalladas(
	Id_Ven VARCHAR(5) PRIMARY KEY NOT NULL,
	Id_Ce VARCHAR(5) NOT NULL,
	dayV int,
	monthV int,
	yearV int,
	Total_Ven DECIMAL(6,2)  CHECK(Total_Ven > 0.0),
	FOREIGN KEY(Id_Ce) REFERENCES CLIENTES(Id_Ce)
)
CREATE TABLE ventas(
	Id_Ven VARCHAR(5) NOT NULL,
	Id_Prod VARCHAR(5) NOT NULL,
	Cantidad DECIMAL(5,2) NOT NULL CHECK(Cantidad>0.0),
	Subtotal_Ven DECIMAL(6,2) CHECK(Subtotal_Ven>0.0),
	FOREIGN KEY(Id_Prod) REFERENCES PRODUCTOS(Id_Prod),
	FOREIGN KEY(Id_Ven) REFERENCES VENTAS_DETALLADAS(Id_Ven),
	PRIMARY KEY(Id_Ven,Id_Prod)
)

CREATE TABLE compras_detalladas(
	Id_Com VARCHAR(5) NOT NULL PRIMARY KEY,
	Id_Prov VARCHAR(5) NOT NULL,
	dayC int,
	monthC int,
	yearC int,
	Total_Com DECIMAL(6,2) CHECK(Total_Com > 0.0),
	FOREIGN KEY(Id_Prov) REFERENCES PROVEEDORES(Id_Prov)
)

CREATE TABLE compras(
	Id_Com VARCHAR(5) NOT NULL,
	Id_Prod VARCHAR(5) NOT NULL,
	Unidades INT,
	Subtotal_Com DECIMAL(6,2) CHECK(Subtotal_Com>0.0),
	FOREIGN KEY(Id_Prod) REFERENCES PRODUCTOS(Id_Prod),
	FOREIGN KEY(Id_Com) REFERENCES COMPRAS_DETALLADAS(Id_Com),
	PRIMARY KEY (Id_Com,Id_Prod)
)

CREATE LOGIN usuarioCC
WITH PASSWORD = 'MyPassword',
DEFAULT_DATABASE = FruteriaDB,
CHECK_POLICY = OFF,
CHECK_EXPIRATION = OFF ;

alter authorization on database::FruteriaDB to usuarioCC
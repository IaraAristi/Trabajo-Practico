Use master
go
IF NOT EXISTS ( SELECT name FROM master.dbo.sysdatabases WHERE name =
'Com2900G17')
BEGIN
CREATE DATABASE Com2900G17
COLLATE Latin1_General_CI_AI;
END
go
use Com2900G17
go
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name =
'ddbba')
BEGIN
EXEC('CREATE SCHEMA ddbba')
END
GO
-------------------------------------------
--tabla inscripcion
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'Inscripcion')
BEGIN
CREATE TABLE ddbba.Inscripcion (
    idInscripcion INT  IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    hora TIME,
);
END
GO

/*ALTER TABLE ddbba.Socio
ALTER COLUMN email VARCHAR(50) NULL;

ALTER TABLE ddbba.Socio
ALTER COLUMN telFijo CHAR(10) NULL;

ALTER TABLE ddbba.Socio
ALTER COLUMN saldoPendiente DECIMAL(8,2) NULL;

ALTER TABLE ddbba.Socio
ALTER COLUMN saldoAFavor DECIMAL(8,2) NULL;

ALTER TABLE ddbba.Socio
ALTER COLUMN estado CHAR(1) NULL;

ALTER TABLE ddbba.Socio
ALTER COLUMN telObraSoc VARCHAR(40) NULL;

ALTER TABLE ddbba.Socio
ALTER COLUMN dni CHAR(9) NULL;

ALTER TABLE ddbba.Socio
ALTER COLUMN telEmergencia CHAR(10) NULL

ALTER TABLE ddbba.Socio
ALTER COLUMN nombreObraSoc VARCHAR(40) NULL

ALTER TABLE ddbba.Socio
ALTER COLUMN numeroObraSoc VARCHAR(20) NULL

ALTER TABLE ddbba.Socio
ALTER COLUMN telObraSoc CHAR(30) NULL*/

--tabla
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'Socio')
BEGIN
CREATE TABLE ddbba.Socio (
    ID_socio INT  IDENTITY(1,1) PRIMARY KEY,
    nroSocio char(7),
    dni char(8),
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    telFijo CHAR(10) null,
    telEmergencia CHAR(10),
    email VARCHAR(50) null,
    fechaNac DATE,
	nombreObraSoc varchar(40),
	numeroObraSoc varchar(20),
	telObraSoc varchar(25),
    saldoAFavor DECIMAL(8,2) null,
	saldoPendiente DECIMAL(8,2) null,
    estado CHAR(1) CHECK (estado = 'A' OR estado = 'I') null
);
END
GO

--tabla categoria de socio
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'CatSocio')
BEGIN
CREATE TABLE ddbba.CatSocio (
    codCategoria INT IDENTITY(1,1) PRIMARY KEY,
    nombreCategoria VARCHAR(10),
    edadDesde INT,
    edadHasta INT
);
END
GO

--Tabla Costo Ingreso Pileta
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'IngresoPiletaDiario')
BEGIN 
CREATE TABLE ddbba.costoIngresoPileta(
	CodCostoIngreso INT IDENTITY(1,1) PRIMARY KEY,
	edad char(1) CHECK (edad = 'A' OR edad = 'M'), -- Edad Adulto o Menor
	precioSocio DECIMAL(10,2),
	precioInvitado DECIMAL(10,2),
	vigencia DATE
	);
END 
GO

--Tabla ingreso pileta diario 
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'IngresoPiletaDiario')
BEGIN 
CREATE TABLE ddbba.IngresoPiletaDiario(
	codIngreso INT IDENTITY(1,1) PRIMARY KEY,
	fecha DATE,
	hora TIME,
	ID_socio INT,
	CodCostoIngreso INT,
	persona char(1) CHECK (persona = 'S' OR persona = 'I'), -- Socio o Invitado
	FOREIGN KEY (ID_socio) REFERENCES ddbba.Socio(ID_socio),
	FOREIGN KEY (CodCostoIngreso) REFERENCES ddbba.costoIngresoPileta(CodCostoIngreso),
	);
END
GO 

--tabla categoria de socio
DROP TABLE IF EXISTS ddbba.CatSocio;
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'CatSocio')
BEGIN
CREATE TABLE ddbba.CatSocio (
    codCategoria INT IDENTITY(1,1) PRIMARY KEY,
    nombreCategoria VARCHAR(10),
    edadDesde INT,
    edadHasta INT
);
END
GO

--tabla invitado
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'Invitado')
BEGIN
CREATE TABLE ddbba.Invitado(
	codInvitado INT IDENTITY(1,1) PRIMARY KEY,
	codIngreso INT,
	nombre VARCHAR(30),
	apellido VARCHAR(30),
	fechaNac DATE,
	dni char(8),
	direccion varchar(50),
	email varchar(50),
	FOREIGN KEY(codIngreso) REFERENCES ddbba.IngresoPiletaDiario(codIngreso)
	);
END 
GO

--Tabla factura Invitado
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'FacturaInvitado')
BEGIN
CREATE TABLE ddbba.FacturaInvitado(
	codFactura INT IDENTITY(1,1) PRIMARY KEY,
	codInvitado INT,
	fechaEmision DATE,
	horaEmision TIME,
	totalNeto DECIMAL(10,2),
	FOREIGN KEY (codInvitado) REFERENCES ddbba.Invitado(codInvitado)
	-- foreign de pago factura
	);
END
GO

--Tabla Pago a cuenta
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'PagoaCuenta')
BEGIN
CREATE TABLE ddbba.PagoaCuenta(
	codPagoCuenta INT IDENTITY(1,1) PRIMARY KEY,
	codIngreso INT,
	ID_socio INT,
	fecha DATE,
	hora TIME,
	monto DECIMAL(10,2),
	motivo VARCHAR(50),
	FOREIGN KEY (codIngreso) REFERENCES ddbba.IngresoPiletaDiario(codIngreso),
	FOREIGN KEY (ID_socio) REFERENCES ddbba.Socio(ID_socio)
	);
END 
GO

--tabla actividad deportiva
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'actDeportiva')
BEGIN
CREATE TABLE ddbba.actDeportiva (
    codActividad INT IDENTITY(1,1) PRIMARY KEY,
    nombreActividad VARCHAR(15),
    profesor varchar(30)
);
END
GO

--tabla presentismo
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'Presentismo')
BEGIN
CREATE TABLE ddbba.Presentismo (
    codPresentismo INT IDENTITY(1,1) PRIMARY KEY,
    fecha date,
	presentismo char(1),
	socio int,
	act int,
	foreign key (socio) references ddbba.Socio(ID_socio),
	foreign key (act) references ddbba.actDeportiva(codActividad)
);
END
GO

--tabla grupo familiar
DROP TABLE IF EXISTS ddbba.GrupoFamiliar;
GO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'GrupoFamiliar')
BEGIN
CREATE TABLE ddbba.GrupoFamiliar (
    codGrupo INT IDENTITY(1,1) PRIMARY KEY,
    socioMenor INT,
	responsableACargo INT,
    CONSTRAINT FK_GrupoFamiliar_socioMenor FOREIGN KEY (socioMenor) REFERENCES ddbba.Socio(ID_socio),
	CONSTRAINT FK_GrupoFamiliar_responsable FOREIGN KEY (responsableACargo) REFERENCES ddbba.Socio(ID_socio),
);
END
GO

--tabla reembolso
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA =
'ddbba' AND TABLE_NAME =
'Reembolso')
BEGIN
CREATE TABLE ddbba.Reembolso (
    codReembolso INT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    monto DECIMAL(8,2),
    motivo VARCHAR(50),
	ID_socio INT,
	CONSTRAINT FK_reembolso_socio FOREIGN KEY (ID_socio) REFERENCES ddbba.Reembolso(ID_socio),
);
END
GO







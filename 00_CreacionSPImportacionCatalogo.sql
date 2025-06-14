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

--tabla socio
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
    telFijo CHAR(10),
    telEmergencia CHAR(10),
    email VARCHAR(50),
    fechaNac DATE,
    saldoAFavor DECIMAL(8,2),
	saldoPendiente DECIMAL(8,2),
    estado CHAR(1)
);
END
GO


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
    telFijo CHAR(10),
    telEmergencia CHAR(10),
    email VARCHAR(50),
    fechaNac DATE,
	nombreObraSoc varchar(40),
	numeroObraSoc varchar(20),
	telObraSoc varchar(25),
    saldoAFavor DECIMAL(8,2),
	saldoPendiente DECIMAL(8,2),
    estado CHAR(1) CHECK (estado = 'A' OR estado = 'I')
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








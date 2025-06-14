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
DROP TABLE IF EXISTS ddbba.Socio;
GO
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

--
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
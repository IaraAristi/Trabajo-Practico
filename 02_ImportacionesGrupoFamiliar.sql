-- tabla temporal
IF OBJECT_ID('tempdb..#socio_gf') IS NOT NULL
    DROP TABLE #socio_gf;
CREATE TABLE #socio_gf (
    [Nro de Socio] VARCHAR(50),
    [Nro de socio RP] VARCHAR(50),
    [Nombre] VARCHAR(100),
    [ apellido] VARCHAR(100),
    [ DNI] VARCHAR(20),
    [ email personal] VARCHAR(150),
    [ fecha de nacimiento] VARCHAR(30),
    [ teléfono de contacto] VARCHAR(30),
    [ teléfono de contacto emergencia] VARCHAR(30),
    [ Nombre de la obra social o prepaga] VARCHAR(100),
    [nro. de socio obra social/prepaga ] VARCHAR(50),
    [teléfono de contacto de emergencia ] VARCHAR(50)
);


-- importación csv socio rp
BULK INSERT #socio_gf
FROM 'C:\Users\tomas\OneDrive\Escritorio\Trabajo-Practico-master\Datos socios GF.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);

-- limpieza e inserción en tabla orifinal socio
INSERT INTO ddbba.Socio (
    nroSocio,
    dni,
    nombre,
    apellido,
    telFijo,
    telEmergencia,
    email,
    fechaNac,
    nombreObraSoc,
    numeroObraSoc,
    telObraSoc
)
SELECT
    LTRIM(RTRIM([Nro de Socio])),
    LTRIM(RTRIM([ DNI])),
    LTRIM(RTRIM([Nombre])),
    LTRIM(RTRIM([ apellido])),
    LTRIM(RTRIM([ teléfono de contacto])),
    LTRIM(RTRIM([ teléfono de contacto emergencia])),
    LTRIM(RTRIM([ email personal])),
    TRY_CAST(LTRIM(RTRIM([ fecha de nacimiento])) AS DATE),
    LTRIM(RTRIM([ Nombre de la obra social o prepaga])),
    LTRIM(RTRIM([nro. de socio obra social/prepaga ])),
    LTRIM(RTRIM([teléfono de contacto de emergencia ]))
FROM #socio_gf;

select * from ddbba.Socio



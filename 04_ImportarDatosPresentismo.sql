INSERT INTO ddbba.actDeportiva (nombreActividad) VALUES
('Futsal'),
('Vóley'),
('Taekwondo'),
('Baile artístico'),
('Natación'),
('Ajedrez');
-------------------------------------------------
IF OBJECT_ID('tempdb..#presentismo_temp') IS NOT NULL
    DROP TABLE #presentismo_temp;

CREATE TABLE #presentismo_temp (
    [Nro de Socio] VARCHAR(10),
    [Actividad] VARCHAR(50),
    [fecha de asistencia] DATE,
    [Asistencia] VARCHAR(10),
    [Profesor] VARCHAR(50)
);

BULK INSERT #presentismo_temp
FROM 'C:\Users\tomas\OneDrive\Escritorio\Trabajo-Practico-master\Presentismo.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001'
);

INSERT INTO ddbba.Presentismo (
    fecha,
    presentismo,
    socio,
    act,
    profesor
)
SELECT
    temp.[fecha de asistencia],
    LEFT (temp.Asistencia,1), --limita a q sea solo 1 caracter
    s.ID_socio,
    a.codActividad,
    temp.Profesor
FROM #presentismo_temp temp
JOIN ddbba.Socio s
    ON LTRIM(RTRIM(temp.[Nro de Socio])) COLLATE Modern_Spanish_CI_AS 
	= LTRIM(RTRIM(s.nroSocio))
JOIN ddbba.actDeportiva a
    ON LTRIM(RTRIM(temp.Actividad)) COLLATE Modern_Spanish_CI_AS 
	= LTRIM(RTRIM(a.nombreActividad));


select * FROM ddbba.actDeportiva
select * FROM ddbba.Presentismo
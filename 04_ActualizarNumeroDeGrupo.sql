--Asignacion de numero de grupo por grupo familiar
USE Com2900G17
GO

CREATE OR ALTER PROCEDURE ddbba.ActualizarNumeroDeGrupo
AS
BEGIN
    SET NOCOUNT ON;

    -- CTE para generar n�mero de grupo por cada socioResponsable
    WITH CTE_Grupos AS (
        SELECT 
            idRelacion,
            DENSE_RANK() OVER (ORDER BY responsableACargo) AS nroGrupoNuevo
        FROM ddbba.GrupoFamiliar
    )
    UPDATE gf
    SET nroGrupo = cte.nroGrupoNuevo
    FROM ddbba.GrupoFamiliar gf
    JOIN CTE_Grupos cte ON gf.idRelacion = cte.idRelacion;

    PRINT 'Actualizaci�n de n�mero de grupo completada correctamente.';
END;

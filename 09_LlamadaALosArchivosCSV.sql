--LLAMADA A LOS ARCHIVOS

--archivo Responsables a cargo
EXEC ddbba.sp_ImportarSociosRP
    @RutaArchivo = 'C:\Users\Diego\Desktop\LOS DOMINGUEZ\Luana Unlam\Bdda\Trabajo-Practico-master\Trabajo-Practico-master\Responsables a cargo.csv';

SELECT * FROM ddbba.Socio

--archivo socios menores

EXEC ddbba.sp_InsertarSociosMenores 
    @rutaArchivo = 'C:\Users\Diego\Desktop\LOS DOMINGUEZ\Luana Unlam\Bdda\Trabajo-Practico-master\Trabajo-Practico-master\Grupo familiar.csv';

SELECT * FROM ddbba.Socio

--archivo RP de grupo familiar
EXEC ddbba.sp_InsertarSociosMenores 
    @rutaArchivo = 'C:\Users\Diego\Desktop\LOS DOMINGUEZ\Luana Unlam\Bdda\Trabajo-Practico-master\Trabajo-Practico-master\Grupo familiar.csv';


SELECT * FROM ddbba.GrupoFamiliar

--archivo actividad deportiva


EXEC ddbba.SP_InsertarActividades
    @rutaArchivo = 'C:\Users\Diego\Desktop\LOS DOMINGUEZ\Luana Unlam\Bdda\Trabajo-Practico-master\Trabajo-Practico-master\Actividad deportiva.csv';


SELECT * FROM ddbba.actDeportiva

--archivo presentismo


EXEC ddbba.sp_cargar_presentismo
    @rutaArchivo = 'C:\Users\Diego\Desktop\LOS DOMINGUEZ\Luana Unlam\Bdda\Trabajo-Practico-master\Trabajo-Practico-master\Presentismo.csv';

SELECT * FROM ddbba.Presentismo


--archivo categoria de socio

EXEC ddbba.InsertarCatSocio
    @rutaArchivo = 'C:\Users\Diego\Desktop\LOS DOMINGUEZ\Luana Unlam\Bdda\Trabajo-Practico-master\Trabajo-Practico-master\Categoria de socio.csv';


SELECT * FROM ddbba.CatSocio
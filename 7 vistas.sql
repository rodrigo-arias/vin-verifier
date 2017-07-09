USE BD_VEHICULOS;
GO
-- CREATE VIEW
CREATE VIEW VehiculosFabricacionExportacion
AS
  (SELECT auxTable.vin, auxTable.paisFabricacion, COUNT(auxTable.vin) AS 'vehiculosExportados'
   FROM (SELECT V.vin, P.nomPais as 'paisFabricacion', E.desEnvio AS 'destEnvio'
	       FROM Envios E, Carga C, Vehiculos V, Paises P
	       WHERE E.idEnvio = C.idEnvio AND C.vin = V.vin AND V.codPais = P.codPais AND E.desEnvio <> V.codPais) auxTable
   GROUP BY auxTable.vin, auxTable.paisFabricacion)
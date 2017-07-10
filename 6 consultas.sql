USE BD_VEHICULOS;
GO
--------------------------------------------------------------------------------------------------------
-- QUERY A
SELECT MAX(pesoEnvio) AS  'Máximo Peso del Período', MIN(pesoEnvio) AS 'Mínimo Peso del Período', MAX(fchEnvio) AS 'Mayor Fecha del Período', MIN(fchEnvio) AS 'Menor Fecha del Período'
FROM Envios
WHERE YEAR(fchEnvio) IN (2015,2016)
--------------------------------------------------------------------------------------------------------
-- QUERY B
SELECT F.nomFab AS 'Nombre del Fabricante', COUNT(nomFab) AS 'Vehiculos Enviados', SUM(V.peso) AS 'Peso Total en 2016'
FROM Fabricantes F, Vehiculos V, Carga C, Envios E
WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND YEAR(E.fchEnvio) = 2016
GROUP BY F.nomFab
ORDER BY SUM(V.peso) DESC
--------------------------------------------------------------------------------------------------------
-- QUERY C
SET DATEFORMAT DMY
SELECT nomPais 'Nombre de País', (SELECT COUNT(desEnvio)
                                  FROM Envios
                                  WHERE Paises.codPais = Envios.desEnvio AND Envios.fchEnvio BETWEEN '01/01/2016' AND '20/01/2016'
                                  GROUP BY desEnvio) AS 'Cant. de Envíos',
                                 (SELECT MAX(Envios.fchEnvio)
                                  FROM Envios
                                  WHERE Paises.codPais = Envios.desEnvio AND Envios.fchEnvio BETWEEN '01/01/2016' AND '20/01/2016') AS 'Última Fecha Envío'
FROM Paises
--------------------------------------------------------------------------------------------------------
-- QUERY E
SELECT V.*
FROM Vehiculos V, Carga C, Envios E
WHERE V.vin = C.vin AND C.idEnvio  = E.idEnvio AND E.fchEnvio = (SELECT MAX(fchEnvio)
                                                                 FROM Envios)
--------------------------------------------------------------------------------------------------------
-- QUERY F
SET DATEFORMAT DMY
SELECT F.*
FROM Fabricantes F
WHERE F.codFab NOT IN (SELECT F.codFab
				               FROM Vehiculos V, Carga C, Envios E
				               WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND E.fchEnvio BETWEEN '01/01/2016' AND '30/06/2016')
AND F.codFab IN (SELECT F.codFab
                FROM Vehiculos V, Carga C, Envios E
                WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND YEAR(E.fchEnvio) = '2017')
AND F.codFab IN (SELECT F.codFab
               FROM Vehiculos V, Carga C, Envios E, Paises P
               WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND P.codPais = E.desEnvio AND E.nomPais = 'Holanda')
--------------------------------------------------------------------------------------------------------
 -- QUERY G
 SELECT V.vin, V.modelo, V.color, V.peso, V.caracteristicas, V.codPais, V.codFab, MAX(E.fchEnvio) AS 'fechaUlt.Envío', F.nomFab
 FROM Fabricantes F, Vehiculos V, Carga C, Envios E
 WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND
 V.vin IN (SELECT V.vin
           WHERE V.peso < 2300)
 GROUP BY V.vin, V.modelo, V.color, V.peso, V.caracteristicas, V.codPais, V.codFab, F.nomFab
--------------------------------------------------------------------------------------------------------
-- QUERY D
-- ******************** INCOMPLETO ********************
SELECT *
FROM Fabricantes
WHERE codFab IN (SELECT F.codFab
                 FROM Fabricantes F, Vehiculos V, Carga C, Envios E
                 WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio
                 GROUP BY F.codFab, E.idEnvio
                 HAVING COUNT(C.vin) > 500) AND
  codFab NOT IN (SELECT F.codFab
                 FROM Fabricantes F, Vehiculos V, Carga C, Envios E
                 WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio
                 GROUP BY F.codFab, E.idEnvio
                 HAVING COUNT(C.vin) < 100)

-- ******************** INCOMPLETO ********************
--------------------------------------------------------------------------------------------------------
-- QUERY H
UPDATE Vehiculos
SET peso = peso - peso * 0.05
WHERE vin NOT IN (SELECT V.vin
                  FROM Vehiculos V, Carga C, Envios E
                  WHERE V.vin = C.vin AND C.idEnvio = E.idEnvio AND YEAR(fchEnvio) >= dbo.fnAnioVehiculo(V.vin) + 1)
--------------------------------------------------------------------------------------------------------
-- QUERY I
SELECT Fabricantes.*
FROM Fabricantes, Plantas, Paises
WHERE Fabricantes.codFab = Plantas.codFab AND Plantas.codPais = Paises.codPais AND Paises.nomPais = 'Japón' AND
Fabricantes.codFab IN (SELECT F.codFab
					   FROM Fabricantes F, Vehiculos V, Carga C, Envios E
					   WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND YEAR(E.fchEnvio) = 2016
					   GROUP BY F.codFab, MONTH(E.fchEnvio)
					   HAVING COUNT(C.vin) > 100) AND
Fabricantes.codFab IN (SELECT F.codFab
					   FROM Fabricantes F, Vehiculos V, Carga C, Envios E
					   WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND YEAR(E.fchEnvio) = 2016
					   GROUP BY F.codFab, MONTH(E.fchEnvio)
					   HAVING COUNT(C.vin) < 20)
--------------------------------------------------------------------------------------------------------

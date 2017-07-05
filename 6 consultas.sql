USE BD_VEHICULOS;
GO

-- QUERY A
SELECT MAX(pesoEnvio) AS  'Máximo Peso del Año', MIN(pesoEnvio) AS 'Mínimo Peso del Año', MIN(FORMAT(fchEnvio, 'dd/MM/yy')) AS 'Primera Fecha del Año', MAX(FORMAT(fchEnvio, 'dd/MM/yy')) AS 'Última Fecha del Año'
FROM Envios
WHERE YEAR(fchEnvio) IN (2015, 2016)

-- QUERY B
SELECT F.nomFab AS 'Nombre del Fabricante', COUNT(nomFab) AS 'Vehiculos Enviados', SUM(V.peso) AS 'Peso Total Envios 2016'
FROM Fabricantes F, Vehiculos V, Carga C, Envios E
WHERE F.codFab = V.codFab AND V.vin = C.vin AND E.idEnvio = C.idEnvio AND YEAR(E.fchEnvio) = 2016
GROUP BY F.nomFab
ORDER BY SUM(V.peso) DESC

-- QUERY C
-- MOSTRAR NOMBRE DE TODOS LOS PAISES / CANTIDAD DE ENVIOS EN ENERO / ULTIMA FECHA DE ENVIO EN ENERO
SET DATEFORMAT DMY
SELECT P.nomPais AS 'Nombre de País', COUNT(*) AS 'Cant. de Envíos', MAX(FORMAT(E.fchEnvio, 'dd/MM/yy')) AS 'Última Fecha Envío'
FROM Paises P, Envios E
WHERE P.codPais = E.desEnvio AND E.fchEnvio BETWEEN '01/01/2016' AND '20/01/2016'
GROUP BY P.nomPais;

-- QUERY D
--

-- QUERY E
--(Aclaración: se agregó el )
SELECT V.*, E.fchEnvio
FROM Vehiculos V INNER JOIN Carga C
ON V.vin = C.vin INNER JOIN Envios E
ON C.idEnvio  = E.idEnvio
WHERE E.fchEnvio = (SELECT MAX(E1.fchEnvio)
					FROM Envios E1
					)

-- QUERY F
--Incompleto. Dudas con la parte del país.--
SELECT V.*, E.fchEnvio
FROM Fabricantes F INNER JOIN Vehiculos V
ON F.codFab = V.codFab INNER JOIN Carga C
ON V.vin  = C.vin INNER JOIN Envios E
ON C.idEnvio = E.idEnvio
WHERE NOT EXISTS (SELECT *
				  FROM Envios E1
				  WHERE E.fchEnvio BETWEEN '20160101' AND '20160630'
				  )
	  AND EXISTS
				 (SELECT *
				  FROM Envios E2
				  WHERE YEAR(E2.fchEnvio) = '2017'
				  )
	  AND EXISTS (SELECT *
				  FROM Envios E3 INNER JOIN Paises P ON E3.desEnvio = P.codPais
				  WHERE P.nomPais = 'Holanda'
				  )


-- QUERY G
--Duda con Group By. Obliga a poner todos los atributos.
SELECT V.vin, V.modelo, V.color, V.peso, V.caracteristicas, V.codPais AS 'Cod. País', V.codFab AS 'Cod. Fabri.',  F.nomFab AS 'Nomb. Fabricante', (E.fchEnvio)
FROM Vehiculos V INNER JOIN Carga C
ON V.vin = C.vin INNER JOIN Envios E
ON C.idEnvio  = E.idEnvio INNER JOIN Fabricantes F
ON V.codFab = F.codFab
WHERE V.vin IN (SELECT V1.vin
			   FROM Vehiculos V1
			   WHERE V1.peso < 2300
			   )
GROUP BY V.vin, V.modelo, V.color, V.peso, V.caracteristicas, V.codPais, V.codFab,  F.nomFab, (E.fchEnvio)


-- QUERY H
--UPDATE Vehiculos SET peso = peso - peso * 0.05
--WHERE

-- QUERY I

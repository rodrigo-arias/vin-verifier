--------------------------------------------------------------------------------------------------------
-- FUNCTION A
USE BD_VEHICULOS;
GO
-- CREATE AUX TABLE
CREATE TABLE ValorLetra(
  letra character(1) NOT NULL,
  valor int NOT NULL,
  CONSTRAINT pk_valorLetra PRIMARY KEY (letra),
  CONSTRAINT ck_valorLetra_letra CHECK (letra NOT LIKE '%I%' AND letra NOT LIKE '%O%' AND letra NOT LIKE '%Q%'))
GO
-- INSERT VALUES
INSERT INTO ValorLetra VALUES
  ('A',1),
  ('B',2),
  ('C',3),
  ('D',4),
  ('E',5),
  ('F',6),
  ('G',7),
  ('H',8),
  ('J',1),
  ('K',2),
  ('L',3),
  ('M',4),
  ('N',5),
  ('P',7),
  ('R',9),
  ('S',2),
  ('T',3),
  ('U',4),
  ('V',5),
  ('W',6),
  ('X',7),
  ('Y',8),
  ('Z',9)
GO
-- CREATE FUNCTION
CREATE FUNCTION fnValorLetra (@letra character(1))
RETURNS int
AS BEGIN
	DECLARE	@valor int

	SELECT @valor = valor FROM ValorLetra WHERE letra = @letra;
	RETURN @valor;
END
-- CREATE AUX TABLE
CREATE TABLE FactorMultiplicador(
  posicion int NOT NULL,
  multiplicador int NOT NULL,
  CONSTRAINT pk_factorMultiplicador PRIMARY KEY (posicion),
  CONSTRAINT ck_actorMultiplicador_posicion CHECK (posicion IN (1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17)))
GO
-- INSERT VALUES
INSERT INTO FactorMultiplicador VALUES
  (1,8),
  (2,7),
  (3,6),
  (4,5),
  (5,4),
  (6,3),
  (7,2),
  (8,10),
  (10,9),
  (11,8),
  (12,7),
  (13,6),
  (14,5),
  (15,4),
  (16,3),
  (17,2)
GO
-- CREATE FUNCTION
CREATE FUNCTION fnFactorMultiplicador (@posicion int)
RETURNS int
AS BEGIN
	DECLARE	@factor int

	SELECT @factor = multiplicador FROM FactorMultiplicador WHERE posicion = @posicion;
	RETURN @factor;
END
-- CREATE FUNCTION
CREATE FUNCTION fnValidarVin (@vin character(17))
RETURNS character(17)
AS BEGIN
	DECLARE
  @subtotal int,
  @resto int,
  @pos int,
  @verificador char(1),
  @char char(1),
  @valorLetra int,
  @multiplicador int,
  @retorno varchar(17)

  SET @subtotal = 0
  SET @verificador = Substring(@vin, 9, 1)
  SET @pos = 1

  WHILE  @pos <= LEN (@vin)
  	BEGIN
  		SELECT @char = Substring(@vin, @pos, 1)

  		IF (ISNUMERIC(@char) = 1)
  			BEGIN
  				SET @valorLetra = @char
  			END
  		ELSE
  			BEGIN
  				EXEC @valorLetra = dbo.fnValorLetra @char
  			END
  		IF (@pos !=9)
  			BEGIN
  				EXEC @multiplicador = dbo.fnFactorMultiplicador @pos
  				SET @subtotal = @subtotal + @valorLetra * @multiplicador
  			END
  		SET @pos = @pos + 1
  	END

  SET @resto = @subtotal % 11

  DECLARE @aux char(1)
  SET @aux = CONVERT(char(1), @resto)

  IF(@aux = @verificador)
  	BEGIN
  		SET @retorno = 'OK'
  	END
  ELSE
  	BEGIN
  		SET @retorno = STUFF(@vin, 9, 1, @resto);
  	END

  RETURN @retorno
END
--------------------------------------------------------------------------------------------------------
-- FUNCTION B
USE BD_VEHICULOS
GO
-- CREATE AUX TABLE
CREATE TABLE AnioModelo(
  anio numeric(4) NOT NULL,
  valor character(1) NOT NULL,
  CONSTRAINT pk_anioModelo PRIMARY KEY (anio),
  CONSTRAINT ck_anioModelo_valor CHECK (valor NOT LIKE '%I%' AND valor NOT LIKE '%Ñ%' AND valor NOT LIKE '%O%' AND valor NOT LIKE '%Q%' AND valor NOT LIKE '%U%' AND valor NOT LIKE '%Z%'))
GO
-- INSERT VALUES
INSERT INTO AnioModelo VALUES
  ('1980','A'),
  ('1981','B'),
  ('1982','C'),
  ('1983','D'),
  ('1984','E'),
  ('1985','F'),
  ('1986','G'),
  ('1987','H'),
  ('1988','J'),
  ('1989','K'),
  ('1990','L'),
  ('1991','M'),
  ('1992','N'),
  ('1993','P'),
  ('1994','R'),
  ('1995','S'),
  ('1996','T'),
  ('1997','V'),
  ('1998','W'),
  ('1999','X'),
  ('2000','Y'),
  ('2001','1'),
  ('2002','2'),
  ('2003','3'),
  ('2004','4'),
  ('2005','5'),
  ('2006','6'),
  ('2007','7'),
  ('2008','8'),
  ('2009','9'),
  ('2010','A'),
  ('2011','B'),
  ('2012','C'),
  ('2013','D'),
  ('2014','E'),
  ('2015','F'),
  ('2016','G'),
  ('2017','H'),
  ('2018','J'),
  ('2019','K'),
  ('2020','L'),
  ('2021','M'),
  ('2022','N'),
  ('2023','P'),
  ('2024','R'),
  ('2025','S'),
  ('2026','T'),
  ('2027','V'),
  ('2028','W'),
  ('2029','X'),
  ('2030','Y'),
  ('2031','1'),
  ('2032','2'),
  ('2033','3'),
  ('2034','4'),
  ('2035','5'),
  ('2036','6'),
  ('2037','7'),
  ('2038','8'),
  ('2039','9')
GO
-- CREATE FUNCTION
CREATE FUNCTION fnAnioVehiculo (@vin character(17))
RETURNS int
AS BEGIN
	DECLARE	@anio int, @caracter char(1)

	SELECT @caracter = SUBSTRING(@vin, 10, 1)
	SELECT @anio = anio FROM AnioModelo WHERE valor = @caracter;
	RETURN @anio;
END
--------------------------------------------------------------------------------------------------------
-- FUNCTION C
USE BD_VEHICULOS
GO
-- CREATE FUNCTION
CREATE FUNCTION fnVehiculosMayorDestino(@desde datetime, @hasta datetime)
RETURNS int
AS BEGIN
	 DECLARE @cant int;

   SELECT TOP 1 @cant = COUNT(V.vin)
   FROM Vehiculos V, Carga C, Envios E, Paises P
   WHERE V.vin = C.vin AND C.idEnvio = E.idEnvio AND E.desEnvio = P.codPais AND E.fchEnvio BETWEEN @desde AND @hasta
   GROUP BY P.nomPais
   ORDER BY COUNT(v.vin) DESC

	 RETURN @cant;
END
--------------------------------------------------------------------------------------------------------
-- FUNCTION D
USE BD_VEHICULOS
GO
-- CREATE PROCEDURE
CREATE PROCEDURE spDestinosLocales
@desde datetime,
@hasta datetime
AS
DECLARE
@local nvarchar(5)

SELECT @local = nomPais FROM Paises WHERE codPais = '#'

IF(@local IS NULL)
  BEGIN
    INSERT INTO Paises VALUES ('#', 'LOCAL')
  END

UPDATE Envios
SET desEnvio = '#'
WHERE idEnvio IN (SELECT E.idEnvio
                  FROM Envios E, Carga C, Vehiculos V
                  WHERE E.idEnvio = C.idEnvio AND C.vin = V.vin AND V.codPais = E.desEnvio AND fchEnvio BETWEEN @desde AND @hasta)
--------------------------------------------------------------------------------------------------------
-- FUNCTION E
USE BD_VEHICULOS
GO
-- CREATE FUNCTION
CREATE FUNCTION fnPaisMenosEnvios(@desde datetime, @hasta datetime)
RETURNS varchar(30)
AS BEGIN
	 DECLARE @pais varchar(30);

	 SELECT TOP 1 @pais = p.nomPais
   FROM Vehiculos V, Carga C, Envios E, Paises P
   WHERE V.vin = C.vin AND C.idEnvio = E.idEnvio AND E.desEnvio = P.codPais AND E.fchEnvio BETWEEN @desde AND @hasta
   GROUP BY P.nomPais
   ORDER BY COUNT(v.vin) ASC

	 RETURN @pais;
END
--------------------------------------------------------------------------------------------------------
-- FUNCTION F
USE BD_VEHICULOS
GO
-- CREATE PROCEDURE
CREATE PROCEDURE spPlantasModelosFabricante
@fabricante character(2),
@plantas int output,
@modelos int output
AS
SELECT @plantas = COUNT(P.codPlan)
FROM Fabricantes F, Plantas P
WHERE F.codFab = P.codFab AND F.codFab = @fabricante

SELECT @modelos = COUNT(V.modelo)
FROM Fabricantes F, Vehiculos V
WHERE F.codFab = V.codFab AND F.codFab = @fabricante

RETURN
--------------------------------------------------------------------------------------------------------

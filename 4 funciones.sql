USE BD_VEHICULOS;
GO
--------------------------------------------------------------------------------------------------------
-- FUNCTION A

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
CREATE FUNCTION fn_valor_letra (@letra character(1))
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
CREATE FUNCTION fn_factor_multiplicador (@posicion int)
RETURNS int
AS BEGIN
	DECLARE	@factor int

	SELECT @factor = multiplicador FROM FactorMultiplicador WHERE posicion = @posicion;
	RETURN @factor;
END
-- CREATE FUNCTION
CREATE FUNCTION fn_validar_vin (@vin character(17))
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
  				EXEC @valorLetra = dbo.fn_valor_letra @char
  			END
  		IF (@pos !=9)
  			BEGIN
  				EXEC @multiplicador = dbo.fn_factor_multiplicador @pos
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
CREATE FUNCTION fn_anio_vehiculo (@vin character(17))
RETURNS int
AS BEGIN
	DECLARE	@anio int, @caracter char(1)

	SELECT @caracter = SUBSTRING(@vin, 10, 1)
	SELECT @anio = anio FROM AnioModelo WHERE valor = @caracter;
	RETURN @anio;
END
--------------------------------------------------------------------------------------------------------
-- FUNCTION C
go
CREATE FUNCTION FN_MayorCantVehicDePais(@fecha1 DATE, @fecha2 DATE)
RETURNS INT
AS
BEGIN
	 DECLARE @cant INT;

     SELECT @cant = COUNT(V.vin)
	 FROM Vehiculos V INNER JOIN Carga C
	 ON V.vin = C.vin INNER JOIN Envios E
	 ON C.idEnvio  = E.idEnvio INNER JOIN Paises P
	 ON E.desEnvio = P.codPais
	 WHERE E.fchEnvio BETWEEN @fecha1 AND @fecha2
	 GROUP BY P.codPais
	 HAVING COUNT(V.vin) >= ALL (SELECT COUNT(V.vin)
								 FROM Vehiculos V INNER JOIN Carga C
								 ON V.vin = C.vin INNER JOIN Envios E
								 ON C.idEnvio  = E.idEnvio INNER JOIN Paises P
								 ON E.desEnvio = P.codPais
								 GROUP BY P.nomPais
								 )

	 RETURN @cant;
END;

--****************************************
--EJECUCI�N DE "FN_MayorCantVehicDePais"
--****************************************
go
Declare @fecha1 DATE
Set @fecha1 = '2013/05/06'

Declare @fecha2 DATE
Set @fecha2 = '2018/06/07'

DECLARE @retorno INT
EXEC @retorno = dbo.FN_MayorCantVehicDePais @fecha1, @fecha2;

PRINT 'La mayor cantidad de veh�culos que recibi� un pa�s entre la fecha ' + convert(varchar(10), @fecha1)  + ' y ' +  convert(varchar(10), @fecha2) + ' es: ' + convert(varchar(10), @retorno);

--------------------------------------------------------------------------------------------------------
-- FUNCTION D

--------------------------------------------------------------------------------------------------------
-- FUNCTION E

--E)
--PENDIENTE ==> SOLUCIONAR PARA QUE ENVIE VARIOS RESULTADOS.
go
CREATE FUNCTION FN_PaisConMenosEnvios(@fecha1 DATE, @fecha2 DATE)
RETURNS VARCHAR(30)
AS
BEGIN
	 DECLARE @pais VARCHAR(1500);

	 SELECT @pais = COALESCE(@pais,' ') + P.nomPais + ' ; '
	 FROM Vehiculos V INNER JOIN Carga C
	 ON V.vin = C.vin INNER JOIN Envios E
	 ON C.idEnvio  = E.idEnvio INNER JOIN Paises P
	 ON E.desEnvio = P.codPais
	 WHERE E.fchEnvio BETWEEN @fecha1 AND @fecha2
	 GROUP BY  P.nomPais
	 HAVING COUNT(V.vin) <= ALL (SELECT COUNT(V.vin)
								 FROM Vehiculos V INNER JOIN Carga C
								 ON V.vin = C.vin INNER JOIN Envios E
								 ON C.idEnvio  = E.idEnvio INNER JOIN Paises P
								 ON E.desEnvio = P.codPais
								 GROUP BY P.nomPais)

	 RETURN @pais;
END;

--****************************************
--EJECUCI�N DE "FN_PaisQueRecibioMasVehic"
--****************************************
go
Declare @fecha1 DATE
Set @fecha1 = '2013/05/06'

Declare @fecha2 DATE
Set @fecha2 = '2018/06/07'

DECLARE @retorno VARCHAR(1500);

eXEC @retorno = dbo.FN_PaisConMenosEnvios @fecha1, @fecha2;

PRINT 'El pa�s al cual se hizo menos cantidad de envios entre la fecha ' + convert(varchar(10), @fecha1)  + ' y ' +  convert(varchar(10), @fecha2) + ' es: ' + convert(varchar(1500), @retorno);

--------------------------------------------------------------------------------------------------------
-- FUNCTION F

--F)
--FALTA MEJORAR. MUESTRA LAS DOS COLUMNAS IGUALES.
go
CREATE PROCEDURE SP_cantPlantasYvehic @codFabricante CHARACTER(2), @cantPlantas INT OUTPUT, @cantModVehic INT OUTPUT
AS
BEGIN
	SELECT COUNT(V.vin), COUNT(P.codPlan)
	FROM Fabricantes F INNER JOIN Plantas P
	ON F.codFab = P.codFab INNER JOIN Vehiculos V
	ON F.codFab = V.codFab
	WHERE	F.codFab = @codFabricante
END
--------------------------------------------------------------------------------------------------------

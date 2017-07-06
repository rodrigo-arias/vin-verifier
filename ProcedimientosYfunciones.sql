USE BD_VEHICULOS;

--****************************************
--           EJERCICIO 4 - A
--****************************************

go
CREATE FUNCTION FN_ValoresLetras(@caracter CHAR(1)) RETURNS CHAR(17)
AS
BEGIN  
	DECLARE @valorLetra int;

	IF(@caracter = 'A')
		SET @valorLetra = 1;
	ELSE IF(@caracter = 'B')
		SET @valorLetra = 2;
	ELSE IF(@caracter = 'C')
		SET @valorLetra = 3;
	ELSE IF(@caracter = 'D')
		SET @valorLetra = 4;
	ELSE IF(@caracter = 'E')
		SET @valorLetra = 5;
	ELSE IF(@caracter = 'F')
		SET @valorLetra = 6;
	ELSE IF(@caracter = 'G')
		SET @valorLetra = 7;
	ELSE IF(@caracter = 'H')
		SET @valorLetra = 8;	
	ELSE IF(@caracter = 'J')
		SET @valorLetra = 1;
	ELSE IF(@caracter = 'K')
		SET @valorLetra = 2;
	ELSE IF(@caracter = 'L')
		SET @valorLetra = 3;
	ELSE IF(@caracter = 'M')
		SET @valorLetra = 4;
	ELSE IF(@caracter = 'N')
		SET @valorLetra = 5;
	ELSE IF(@caracter = 'P')
		SET @valorLetra = 7;
	ELSE IF(@caracter = 'R')
		SET @valorLetra = 9;
	ELSE IF(@caracter = 'S')
		SET @valorLetra = 2;
	ELSE IF(@caracter = 'T')
		SET @valorLetra = 3;
	ELSE IF(@caracter = 'U')
		SET @valorLetra = 4;
	ELSE IF(@caracter = 'V')
		SET @valorLetra = 5;
	ELSE IF(@caracter = 'W')
		SET @valorLetra = 6;
	ELSE IF(@caracter = 'X')
		SET @valorLetra = 7;
	ELSE IF(@caracter = 'Y')
		SET @valorLetra = 8;
	ELSE IF(@caracter = 'Z')
		SET @valorLetra = 9;
	ELSE IF(@caracter = '0')
		SET @valorLetra = 0;
	ELSE IF(@caracter = '1')
		SET @valorLetra = 1;
	ELSE IF(@caracter = '2')
		SET @valorLetra = 2;
	ELSE IF(@caracter = '3')
		SET @valorLetra = 3;
	ELSE IF(@caracter = '4')
		SET @valorLetra = 4;
	ELSE IF(@caracter = '5')
		SET @valorLetra = 5;
	ELSE IF(@caracter = '6')
		SET @valorLetra = 6;
	ELSE IF(@caracter = '7')
		SET @valorLetra = 7;
	ELSE IF(@caracter = '8')
		SET @valorLetra = 8;
	ELSE IF(@caracter = '9')
		SET @valorLetra = 9;

	return @valorLetra;
END;

--DROP FUNCTION dbo.FN_ValoresLetras;

go
CREATE FUNCTION FN_VerificarVin (@vin CHAR(17)) RETURNS CHAR(17)
AS
BEGIN  
	DECLARE @caracter CHAR(1);	
	DECLARE @pos INT;	
	DECLARE @valorLetra INT
	DECLARE @producto INT;	
	DECLARE @sumaProductos INT;
	DECLARE @resto INT;
	DECLARE @retorno VARCHAR(17);
	DECLARE @verificador CHAR(1);	
	DECLARE @char1 CHAR(1);
	DECLARE @char2 CHAR(1);
	DECLARE @char3 CHAR(1);
	DECLARE @char4 CHAR(1);
	DECLARE @char5 CHAR(1);
	DECLARE @char6 CHAR(1);
	DECLARE @char7 CHAR(1);
	DECLARE @char8 CHAR(1);
	DECLARE @char9 CHAR(1);
	DECLARE @char10 CHAR(1);
	DECLARE @char11 CHAR(1);
	DECLARE @char12 CHAR(1);
	DECLARE @char13 CHAR(1);
	DECLARE @char14 CHAR(1);
	DECLARE @char15 CHAR(1);
	DECLARE @char16 CHAR(1);
	DECLARE @char17 CHAR(1);

	SET @pos = 1;
	SET @sumaProductos = 0;
	

	WHILE  @pos <=LEN (@vin)
	BEGIN
		SET @caracter = Substring(@vin, @pos, 1);
		EXEC @valorLetra = dbo.FN_ValoresLetras @caracter;

		IF(@pos = 1)	
			BEGIN		
				SET @producto = @valorLetra * 8; SET @char1 = @caracter;
			END
		ELSE IF(@pos = 2)
			BEGIN
				SET @producto = @valorLetra * 7;
				SET @char2 = @caracter;
			END
		ELSE IF(@pos = 3)
			BEGIN
				SET @producto = @valorLetra * 6;
				SET @char3 = @caracter;
			END
		ELSE IF(@pos = 4)
			BEGIN
				SET @producto = @valorLetra * 5;
				SET @char4 = @caracter;
			END
		ELSE IF(@pos = 5)
			BEGIN
				SET @producto = @valorLetra * 4;
				SET @char5 = @caracter;
			END
		ELSE IF(@pos = 6)
			BEGIN
				SET @producto = @valorLetra * 3;
				SET @char6 = @caracter;
			END
		ELSE IF(@pos = 7)
			BEGIN
				SET @producto = @valorLetra * 2;
				SET @char7 = @caracter;
			END
		ELSE IF(@pos = 8)
			BEGIN
				SET @producto = @valorLetra * 10;
				SET @char8 = @caracter;
			END
		ELSE IF(@pos = 9)
			SET @verificador = @caracter;					
		ELSE IF(@pos = 10)
			BEGIN
				SET @producto = @valorLetra * 9;
				SET @char10 = @caracter;
			END
		ELSE IF(@pos = 11)
			BEGIN
				SET @producto = @valorLetra * 8;
				SET @char11 = @caracter;
			END
		ELSE IF(@pos = 12)
			BEGIN
				SET @producto = @valorLetra * 7;
				SET @char12 = @caracter;
			END
		ELSE IF(@pos = 13)
			BEGIN
				SET @producto = @valorLetra * 6;
				SET @char13 = @caracter;
			END
		ELSE IF(@pos = 14)
			BEGIN
				SET @producto = @valorLetra * 5;
				SET @char14 = @caracter;
			END
		ELSE IF(@pos = 15)
			BEGIN
				SET @producto = @valorLetra * 4;
				SET @char15 = @caracter;
			END
		ELSE IF(@pos = 16)
			BEGIN
				SET @producto = @valorLetra * 3;
				SET @char16 = @caracter;
			END
		ELSE IF(@pos = 17)
			BEGIN
				SET @producto = @valorLetra * 2;
				SET @char17 = @caracter;
			END
			
		SET @pos=@pos+1;

		IF(@pos != 9)
			SET @sumaProductos = @sumaProductos + @producto;

	END
		
	SET @resto = @sumaProductos % 11;

	IF(@resto = 10)
		BEGIN
			DECLARE @aux CHAR(1);
			SET @aux =  CONVERT(CHAR(1), @resto);
			IF(@verificador = 'X')
				SET @retorno = 'OK';
			ELSE
				SET @retorno = @char1 + @char2 + @char3 + @char4 + @char5 + @char6 + @char7 + @char8 + 'X' + @char10 + @char11 + @char12 + @char13 + @char14 + @char15 + @char16 + @char17;
		END;
	ELSE
		IF(@verificador = CONVERT(CHAR(1), @resto))
			SET @retorno = 'OK';
		ELSE
			SET @retorno = @char1 + @char2 + @char3 + @char4 + @char5 + @char6 + @char7 + @char8 + @resto + @char10 + @char11 + @char12 + @char13 + @char14 + @char15 + @char16 + @char17;
			

	RETURN @retorno;

END;


--DROP FUNCTION dbo.FN_verificarVin;


--****************************************
--    EJECUCIÓN DE "FN_verificarVin"
--****************************************
go
Declare @vin VARCHAR(17)
DECLARE @retorno VARCHAR(17)

Set @vin = '1M8GDM9AXKP042788'

EXEC @retorno = dbo.FN_verificarVin @vin;
                        
PRINT @retorno;


--##################################################################################################################


--****************************************
--           EJERCICIO 4 - B
--****************************************


CREATE FUNCTION FN_AnioVehiculo (@vin CHAR(17)) RETURNS INT
AS
BEGIN  
	DECLARE @caracter CHAR(1);
	DECLARE @anio INT;
	DECLARE @pos INT;	
	SET @pos = 1;

	WHILE  @pos <=LEN (@vin)
	BEGIN		
		SET @caracter = Substring(@vin, @pos, 1);

		IF(@pos = 9)
			If(@caracter = 'A')
				SET @anio = 1980;
	

		SET @pos=@pos+1;
	END
	RETURN @anio;
END







--##################################################################################################################


--****************************************
--           EJERCICIO 4 - c
--****************************************

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
--EJECUCIÓN DE "FN_MayorCantVehicDePais"
--****************************************
go
Declare @fecha1 DATE
Set @fecha1 = '2013/05/06'

Declare @fecha2 DATE
Set @fecha2 = '2018/06/07'

DECLARE @retorno INT
EXEC @retorno = dbo.FN_MayorCantVehicDePais @fecha1, @fecha2;
                        
PRINT 'La mayor cantidad de vehículos que recibió un país entre la fecha ' + convert(varchar(10), @fecha1)  + ' y ' +  convert(varchar(10), @fecha2) + ' es: ' + convert(varchar(10), @retorno);


--##################################################################################################################

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
--EJECUCIÓN DE "FN_PaisQueRecibioMasVehic"
--****************************************
go
Declare @fecha1 DATE
Set @fecha1 = '2013/05/06'

Declare @fecha2 DATE
Set @fecha2 = '2018/06/07'

DECLARE @retorno VARCHAR(1500);

eXEC @retorno = dbo.FN_PaisConMenosEnvios @fecha1, @fecha2;

PRINT 'El país al cual se hizo menos cantidad de envios entre la fecha ' + convert(varchar(10), @fecha1)  + ' y ' +  convert(varchar(10), @fecha2) + ' es: ' + convert(varchar(1500), @retorno);

--##################################################################################################################


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


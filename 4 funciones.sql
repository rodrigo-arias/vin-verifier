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
CREATE FUNCTION fn_AnioVehiculo (@vin character(17))
RETURNS int
AS BEGIN
	DECLARE	@anio int, @caracter char(1)

	SELECT @caracter = SUBSTRING(@vin, 10, 1)
	SELECT @anio = anio FROM AnioModelo WHERE valor = @caracter;

	RETURN @anio;
END

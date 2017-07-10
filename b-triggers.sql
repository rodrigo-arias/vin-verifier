--------------------------------------------------------------------------------------------------------
-- DISPARADORES
--------------------------------------------------------------------------------------------------------
-- TRIGGER A
USE BD_VEHICULOS;
GO
-- CREATE TRIGGER
CREATE TRIGGER trIngresarVehiculo
  ON Vehiculos
  INSTEAD OF INSERT
AS
BEGIN
  DECLARE
  @vin character(17),
  @modelo varchar(30),
  @color varchar(20),
  @peso numeric(12,2),
  @caracteristicas varchar(100),
  @codPais character(1),
  @codFab character(2),
  @valido character(17)

  SELECT @vin = vin, @modelo = modelo, @color = color, @peso = peso, @caracteristicas = caracteristicas, @codPais = codPais, @codFab = codFab
  FROM Inserted

  EXEC @valido = dbo.fnValidarVin @vin

  IF @valido = 'OK'
  BEGIN
     INSERT INTO Vehiculos VALUES
       (@vin,@modelo,@color,@peso,@caracteristicas,@codPais,@codFab)
  END
  ELSE
    PRINT 'VIN incorrecto, no sé procesó la línea. Su VIN correcto podría ser ' + @valido + '.'
END
GO
--------------------------------------------------------------------------------------------------------
-- TRIGGER B
-- CREATE TRIGGER
CREATE TRIGGER trIngresarCarga
  ON Carga
  INSTEAD OF INSERT
AS
BEGIN
  DECLARE
  @idEnvio numeric(6),
  @idCarga numeric(6),
  @vin character(17),
  @pesoCarga numeric(12,2)

  SELECT @idEnvio = idEnvio, @idCarga = idCarga, @vin = vin
  FROM Inserted

  SELECT @pesoCarga = peso * 1.05
  FROM Vehiculos
  WHERE vin = @vin

  INSERT INTO Carga VALUES
    (@idEnvio, @idCarga, @vin, @pesoCarga)

    IF EXISTS (SELECT *
               FROM Carga
               WHERE idEnvio = @idEnvio AND idCarga = @idCarga)
    BEGIN
      UPDATE Envios
      SET pesoEnvio = pesoEnvio + @pesoCarga
      WHERE idEnvio = @idEnvio
    END
END
GO
--------------------------------------------------------------------------------------------------------
-- TRIGGER C
-- CREATE TRIGGER
CREATE TRIGGER trIngresarEnvio
  ON Envios
  INSTEAD OF INSERT
AS
BEGIN
  DECLARE
  @fchEnvio datetime,
	@pesoEnvio numeric(12,2),
	@oriEnvio character(1),
	@desEnvio character(1)

  SELECT @fchEnvio = fchEnvio, @pesoEnvio = pesoEnvio, @oriEnvio = oriEnvio, @desEnvio = desEnvio
  FROM Inserted

  IF @oriEnvio != @desEnvio
  BEGIN
     INSERT INTO Envios VALUES
       (@fchEnvio, @pesoEnvio, @oriEnvio, @desEnvio)
  END
  ELSE
    PRINT 'El país de origen no puede ser igual al país de destino (' + @oriEnvio + '). No sé procesó la línea.'
END
GO
--------------------------------------------------------------------------------------------------------
-- TRIGGER D
-- CREATE TRIGGER
CREATE TRIGGER trBorrarEnvios
  ON Envios
  INSTEAD OF DELETE
AS
BEGIN
  DELETE
  FROM Carga
  WHERE idEnvio IN (SELECT idEnvio
                    FROM deleted)

  DELETE
  FROM Envios
  WHERE idEnvio IN (SELECT idEnvio
	                  FROM deleted)
END
GO
--------------------------------------------------------------------------------------------------------
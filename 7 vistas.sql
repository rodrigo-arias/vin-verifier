USE BD_VEHICULOS;
GO
-- CREATE VIEW
CREATE VIEW FabricacionVechiculosEnviados
	SELECT ci, nombre, sueldo, fchpago
	FROM 	empleados, sueldos
	WHERE YEAR(fchnac) < 1969 AND
	EMPLEADOS.ci = SUELDOS.ci AND
	SUELDOS.cobrados = 'S' AND
	SUELDOS.fchpagos = GATEDATE()
USE BD_VEHICULOS;
GO
-- INDEX PLANTAS
CREATE INDEX idx_Plantas_codFab ON Plantas(codFab);
CREATE INDEX idx_Plantas_codPais ON Plantas(codPais);
GO
-- INDEX VEHÍCULOS
CREATE INDEX idx_Vehiculos_codPais ON Vehiculos(codPais);
CREATE INDEX idx_Vehiculos_codFab ON Vehiculos(codFab);
GO
-- INDEX FABRICANTES
CREATE INDEX idx_Vehiculos_codFab ON Fabricantes(codFab);
GO
-- INDEX ENVIOS
CREATE INDEX idx_Envios_oriEnvio ON Envios(oriEnvio);
CREATE INDEX idx_Envios_desEnvio ON Envios(desEnvio);
CREATE INDEX idx_Envios_fchEnvio ON Envios(fchEnvio);
GO
-- INDEX CARGA
CREATE INDEX idx_Carga_idEnvio ON Carga(idEnvio);
CREATE INDEX idx_Carga_vin ON Carga(vin);
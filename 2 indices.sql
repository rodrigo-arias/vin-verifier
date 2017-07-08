USE BD_VEHICULOS;
GO
-- INDEX PLANTAS
CREATE INDEX idx_plantas_codFab ON Plantas(codFab);
CREATE INDEX idx_plantas_codPais ON Plantas(codPais);
GO
-- INDEX VEHÍCULOS
CREATE INDEX idx_vehiculos_codPais ON Vehiculos(codPais);
CREATE INDEX idx_vehiculos_codFab ON Vehiculos(codFab);
GO
-- INDEX FABRICANTES
CREATE INDEX idx_vehiculos_codFab ON Fabricantes(codFab);
GO
-- INDEX ENVIOS
CREATE INDEX idx_envios_oriEnvio ON Envios(oriEnvio);
CREATE INDEX idx_envios_desEnvio ON Envios(desEnvio);
CREATE INDEX idx_envios_fchEnvio ON Envios(fchEnvio);
GO
-- INDEX CARGA
CREATE INDEX idx_carga_idEnvio ON Carga(idEnvio);
CREATE INDEX idx_carga_vin ON Carga(vin);
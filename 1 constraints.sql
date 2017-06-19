USE BD_VEHICULOS;
GO
-- TABLE PAÍSES
ALTER TABLE Paises
ADD CONSTRAINT pk_paises PRIMARY KEY (codPais),
    CONSTRAINT uk_paises_nomPais UNIQUE(nomPais);
GO
-- TABLE FABRICANTES
ALTER TABLE Fabricantes
ADD cantEmp int NOT NULL,
    CONSTRAINT pk_fabricantes PRIMARY KEY (codFab),
    CONSTRAINT uk_fabricantes_mailFab UNIQUE (mailFab),
    CONSTRAINT ck_fabricantes_cantEmp CHECK (cantEmp > 0);
GO
-- TABLE VEHÍCULOS
ALTER TABLE Vehiculos
ADD CONSTRAINT pk_vehiculos PRIMARY KEY (vin),
	CONSTRAINT ck_vehiculos_vin CHECK (vin NOT LIKE '%I%' AND vin NOT LIKE '%O%' AND vin NOT LIKE '%Q%' AND vin NOT LIKE '%Ñ%'),
	FOREIGN KEY (codPais) REFERENCES Paises(codPais),
	FOREIGN KEY (codFab) REFERENCES Fabricantes(codFab)
GO
-- TABLE PLANTAS
ALTER TABLE Plantas
ADD CONSTRAINT pk_plantas PRIMARY KEY (codPlan, codFab),
    FOREIGN KEY (codFab) REFERENCES Fabricantes(codFab),
    FOREIGN KEY (codPais) REFERENCES Paises(codPais),
    CONSTRAINT uk_plantas_mailPlan UNIQUE (mailPlan);
GO
-- TABLE ENVÍOS
ALTER TABLE Envios
ADD CONSTRAINT pk_envios PRIMARY KEY (idEnvio),
    FOREIGN KEY (oriEnvio) REFERENCES Paises(codPais),
    FOREIGN KEY (desEnvio) REFERENCES Paises(codPais);
GO
--TABLE CARGA
ALTER TABLE Carga
ADD cantUds int NOT NULL,
    CONSTRAINT pk_carga PRIMARY KEY (idEnvio, idCarga),
    FOREIGN KEY (idEnvio) REFERENCES Envios(idEnvio),
    FOREIGN KEY (vin) REFERENCES Vehiculos(vin);
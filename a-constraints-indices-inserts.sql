--------------------------------------------------------------------------------------------------------
-- RESTRICCIONES DE INTREGRIDAD
--------------------------------------------------------------------------------------------------------
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
ADD CONSTRAINT pk_carga PRIMARY KEY (idEnvio, idCarga),
    FOREIGN KEY (idEnvio) REFERENCES Envios(idEnvio),
    FOREIGN KEY (vin) REFERENCES Vehiculos(vin);
--------------------------------------------------------------------------------------------------------
-- INDICES
--------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------
-- DATOS DE PRUEBA
--------------------------------------------------------------------------------------------------------
USE BD_VEHICULOS;
GO
SET DATEFORMAT DMY
-- INSERT PAISES
INSERT INTO Paises VALUES
('W', 'Alemania'),
('8', 'Argentina'),
('6', 'Australia'),
('B', 'Belgica'),
('9', 'Brasil'),
('2', 'Canada'),
('4', 'Chile'),
('L', 'China'),
('K', 'Corea del Sur'),
('C', 'Croacia'),
('V', 'España'),
('1', 'Estados Unidos'),
('D', 'Dinamarca'),
('G', 'Finlandia'),
('F', 'Francia'),
('E', 'Hungria'),
('M', 'India'),
('S', 'Inglaterra'),
('Z', 'Italia'),
('J', 'Japón'),
('3', 'Mexico'),
('H', 'Holanda'),
('7', 'Nueva Zelanda'),
('N', 'Polonia'),
('P', 'Portugal'),
('X', 'Rusia'),
('A', 'Sudafrica'),
('Y', 'Suecia'),
('T', 'Suiza'),
('R', 'Tailandia'),
('5', 'Uruguay');
GO
-- INSERT FABRICANTES
INSERT INTO Fabricantes VALUES
('MB', 'Mercedes-Benz', 'Bremen, Alemania', 'info@mercedesbenz', 260000),
('BM', 'BMW', 'Munich, Alemania', 'info@bmw', 71000),
('PO', 'Porsche', 'Stuttgart, Alemania', 'info@porsche', 19000),
('FE', 'Ferrari S.p.A.', 'Maranello, Italia', 'info@ferrari', 3000),
('AU', 'Audi', 'Zwickau, Alemania', 'info@audi', 58000),
('AM', 'Aston Martin', 'Londres, Inglaterra', 'info@astonmartin', 1850),
('TO', 'Toyota', 'Tokyo, Japón', 'info@toyota', 32689),
('MA', 'Maserati', 'Bolonia, Italia', 'info@maserati', 714),
('RR', 'Rolls-Royce', 'Mánchester, Inglaterra', 'info@rollsroyce', 743),
('TM', 'Tesla Motors', 'California, Estados Unidos', 'info@teslamotors', 14000),
('LX', 'Lexus', 'Nagoya, Aichi, Japón', 'info@lexus', 300),
('BU', 'Bugatti', 'Molsheim, Francia', 'info@bugatti', 975),
('VW', 'Volkswagen Group', 'Berlín, Alemania', 'info@volkswagen', 572800),
('BE', 'Bentley Motors Limited', 'Londres, Inglaterra', 'info@bentleymotors', 4000),
('HO', 'Honda', 'Hamamatsu, Japón', 'info@honda', 181876),
('VO', 'Volvo Cars', 'Gotemburgo, Suecia', 'info@volvocars', 22112),
('FO', 'Ford', 'Míchigan, Estados Unidos', 'info@ford', 198000),
('SU', 'Subaru', 'Shinjuku-ku, Japón', 'info@subaru', 11998),
('MC', 'McLaren Automotive', 'Woking, Inglaterra', 'info@mcLaren', 500),
('NI', 'Nissan Motor Co., Ltd.', 'Yokohama, Japón', 'info@nissanmotor', 186336),
('AR', 'Alfa Romeo', 'Milán, Italia', 'info@alfaromeo', 19000),
('KO', 'Koenigsegg', 'Estocolmo, Suecia', 'info@koenigsegg', 50),
('JA', 'Jaguar Cars', 'Coventry, Inglaterra', 'info@jaguarcars', 10000),
('PA', 'Pagani', 'San Cesario sul Panaro, Italia', 'info@pagani', 21000),
('CH', 'Chevrolet', 'Detroit, Estados Unidos', 'info@chevrolet', 219000),
('LR', 'Land Rover', 'West Midlands, Inglaterra', 'info@landrover', 10000),
('LA', 'Lamborghini', 'SantAgata Bolognese, Italia', 'info@lamborghini', 867),
('CA', 'Cadillac', 'Detroit, Estados Unidos', 'info@cadillac', 500),
('LO', 'Lotus Cars', 'Norfolk, Inglaterra', 'info@lotuscars', 2000),
('MS', 'Mitsubishi', 'Tokyo, Japón', 'info@mitsubishi', 350000),
('JE', 'Jeep', 'Ohio, Estados Unidos', 'info@jeep', 2000),
('MG', 'MG Cars', 'Oxford, Inglaterra', 'info@mgcards', 540),
('LI', 'Lincoln Motor Company', 'Míchigan, Inglaterra', 'info@lincolnmotorcompany', 1500),
('FI', 'Fiat S.p.A.', 'Turin, Italia', 'info@fiatspa', 77817),
('HY', 'Hyundai', 'Seúl, Corea del Sur', 'info@hyundai', 75000),
('PT', 'Pontiac', 'Míchigan, Estados Unidos', 'info@pontiac', 400),
('SA', 'Saab Automobile AB', 'Trollhättan, Suecia', 'info@saabautomobile', 3200),
('GM', 'GMC', 'Míchigan, Estados Unidos', 'info@gmc', 55000),
('SK', 'Skoda Auto Slovakia', 'Boleslav, Republica Checa', 'info@skodaautoslovakia', 35000),
('MI', 'Mini', 'Oxford, Inglaterra', 'info@mini', 400),
('SZ', 'Suzuki Motor Corporation', 'Shizuoka, Japón', 'info@suzukimotor', 45000),
('CY', 'Chrysler', 'Míchigan, Estados Unidos', 'info@chrysler', 2000),
('DG', 'Dodge', 'Gilching, Alemania', 'info@dodge', 2000),
('CI', 'Citroen', 'Paris, Francia', 'info@citroen', 13900),
('OP', 'Opel', 'Russelsheim am Main, Alemania', 'info@opel', 32158),
('PE', 'Peugeot', 'Sochaux, Francia', 'info@peugeot', 198210),
('PL', 'Plymouth', 'Míchigan, Estados Unidos', 'info@plymouth', 1500),
('RT', 'Renault', 'Billancourt, Francia', 'info@renault', 122615),
('MZ', 'Mazda', 'Hiroshima, Japón', 'info@mazda', 46398),
('ST', 'Seat', 'Barcelona, España', 'info@seat', 11458);
GO
-- INSERT VEHICULOS
INSERT INTO Vehiculos VALUES ('19XFA16869E003306', 'Nissan Versa', 'Amarilo Indio', 1035, '106 Cv a 5,600 rpm, gasolina 5 s., manual', 'J', 'NI')
INSERT INTO Vehiculos VALUES ('1G4HR54K544271535', 'Chevrolet Aveo', 'Gris Plata', 1100, '100 Cv, gasolina 6 s., automático', '1', 'CH')
INSERT INTO Vehiculos VALUES ('1GKFC06289R108826', 'Volkswagen Vento', 'Amarillo Arena', 1437, '75 Cv, gasolina 5 s., manual', 'W', 'VW')
INSERT INTO Vehiculos VALUES ('1GTGK24K2ME538465', 'Volkswagen Jetta', 'Azul Cobalto', 2310, '170 Cv, gasolina 7 s., secuencial automático', 'W', 'VW')
INSERT INTO Vehiculos VALUES ('JF1GJAS610FH05933', 'Chevrolet Spark', 'Verde Oliva', 965, '68 Cv, gasolina 5 s., manual', '1', 'CH')
INSERT INTO Vehiculos VALUES ('1GCEG25N30F711092', 'Nissan Tsuru', 'Verde Xanadu', 1059, '2.0 L 16V y 140 Cv, gasolina 5 s., manual,', 'J', 'NI')
INSERT INTO Vehiculos VALUES ('LHJPCHL015B005929', 'Nissan March', 'Rojo Carmín', 1047, '1.6 16v Extra Full, automática 4 velocidades', 'J', 'NI')
INSERT INTO Vehiculos VALUES ('1HD1FFW135Y637140', 'Chevrolet Sonic', 'Verde Veronés', 1085, 'Motor 1,6 litros, 115 a 6.000 (HP-CV/rpm)', '1', 'CH')
INSERT INTO Vehiculos VALUES ('4UZAASBW02CK70115', 'Nissan Sentra', 'Gris Plata', 1665, 'S 2.0 16V CVT (Flex)', 'J', 'NI')
INSERT INTO Vehiculos VALUES ('1FTCA15U8RZA00994', 'Nissan X-Trail', 'Negro Classic', 1575, '1.6 dCi de 130 Cv, transmision cvt, ', 'J', 'NI')
INSERT INTO Vehiculos VALUES ('1FMYU22E5WUA30961', 'Chevrolet Trax', 'Rojo Escarlata', 1926, '130 Cv, gasolina 6 s., manual', '1', 'CH')
INSERT INTO Vehiculos VALUES ('4JGBF2FB4AA566018', 'Nissan Tiida', 'Blanco', 1170, '1.6 litros de 110 CV (HR16DE)', 'J', 'NI')
INSERT INTO Vehiculos VALUES ('JTHDL1EF2B5010450', 'Honda CR-V', 'Verde Cazador', 2400, '155 Cv, gasolina 6 s., manual', 'J', 'HO')
INSERT INTO Vehiculos VALUES ('1M2K193C0PM039279', 'Volkswagen Golf', 'Azul de Prusia', 1464, '85 Cv, gasolina 5 s., manual', 'W', 'VW')
INSERT INTO Vehiculos VALUES ('2FTDF15H7HCA68059', 'Hyundai Accent', 'Gris Plata', 1035, '97 Cv, gasolina 5 s., manual', 'K', 'HY')
INSERT INTO Vehiculos VALUES ('3B3BD31K9HT797556', 'Dodge Attitude', 'Lavanda', 1040, '170 Cv, gasolina 5 s., manual', 'W', 'DG')
INSERT INTO Vehiculos VALUES ('JTMZF4DV80AD03527', 'Honda HR-V', 'Blanco', 1324, '130 Cv, gasolina 6 s., manual', 'J', 'HO')
INSERT INTO Vehiculos VALUES ('JS2RA62S075380854', 'Nissan Frontier', 'Negro Classic', 2740, '190 Cv, diesel 6 s., manual', 'J', 'NI')
INSERT INTO Vehiculos VALUES ('5FNRL38725B575243', 'Renault Duster', 'Blanco Marfil', 1273, '120 Cv, gasolina 6 s.,', 'F', 'RT')
INSERT INTO Vehiculos VALUES ('1ZVHT88S807536133', 'Toyota Hilux', 'Rojo Borgoña', 2450, '144 Cv, diesel 5 s., manual', 'J', 'TO')
INSERT INTO Vehiculos VALUES ('3NPDH4AE6FH620516', 'Dodge Viper', 'Gris Plata', 1490, 'Motor V10 8.4L de 645 HP con transmisión manual', '1', 'DG')
GO
-- INSERT PLANTAS
INSERT INTO Plantas VALUES
(139495, 'BM', 'Starba', 'Berlin, Alemania', 'info@starba.com', 'W'),
(139496, 'BM', 'Lower', 'Berlin, Alemania', 'info@lower.com', 'W'),
(902778, 'MC', 'Torport', 'Rio de Janeiro, Brazil', 'info@torport.com', '9'),
(654911, 'AU', 'Resaic', 'Bologna, Italia', 'info@resaic.com', 'Z'),
(136342, 'NI', 'Aluzukanc', 'Tokyo, Japón', 'info@aluzukanc.com', 'J'),
(055123, 'LA', 'Syscir', 'Amsterdam, Holanda', 'info@syscir.com', 'H'),
(624332, 'KO', 'Bran', 'Estocolmo, Suecia', 'info@bran.com', 'Y'),
(602645, 'MS', 'Genrgyen', 'Dongguan, China', 'info@genrgyen.com', 'L'),
(668272, 'LO', 'Liverver', 'Ahmedabad, India', 'info@liverver.com', 'M'),
(116700, 'SU', 'Texplects', 'Boston, Estados Unidos', 'info@texplects.com', '1'),
(156941, 'MG', 'Eleyce', 'Madrid, España', 'info@eleyce.com', 'V'),
(985640, 'HY', 'Teler', 'Paris, Francia', 'info@teler.com', 'F'),
(685093, 'GM', 'Budwil', 'Cape Town, Sudafrica', 'info@budwil.com', 'A'),
(834357, 'SA', 'Fortz', 'Tokyo, Japón', 'info@fortz.com', 'J'),
(395118, 'PL', 'Phinsi', 'Shenyang, China', 'info@phinsi.com', 'L'),
(004335, 'DG', 'Inpub', 'Londres, Inglaterra', 'info@inpub.com', 'S'),
(804964, 'CY', 'Fresc', 'Pune, India', 'info@fresc.com', 'M'),
(405929, 'FI', 'Falm', 'Copenhague, Dinamarca', 'info@falm.com', 'D'),
(848931, 'MZ', 'Soupsong', 'Yokohama, Japón', 'info@soupsong.com', 'J'),
(461165, 'ST', 'Scouston', 'Sion, Suiza', 'info@scouston.com', 'T'),
(159148, 'SZ', 'Swischita', 'Shenyang, China', 'info@swischita.com', 'L');
GO
-- INSERT ENVIOS
INSERT INTO Envios VALUES ('03/06/14',0,'1','W')
INSERT INTO Envios VALUES ('05/01/15',0,'J','1')
INSERT INTO Envios VALUES ('07/06/15',0,'K','3')
INSERT INTO Envios VALUES ('22/08/15',0,'W','H')
INSERT INTO Envios VALUES ('29/12/15',0,'1','L')
INSERT INTO Envios VALUES ('04/01/16',0,'J','P')
INSERT INTO Envios VALUES ('06/01/16',0,'W','L')
INSERT INTO Envios VALUES ('11/01/16',0,'W','M')
INSERT INTO Envios VALUES ('17/01/16',0,'W','L')
INSERT INTO Envios VALUES ('20/01/16',0,'W','9')
INSERT INTO Envios VALUES ('07/06/16',0,'W','8')
INSERT INTO Envios VALUES ('22/08/16',0,'1','L')
INSERT INTO Envios VALUES ('30/12/16',0,'F','5')
INSERT INTO Envios VALUES ('11/06/17',0,'K','L')
GO
-- INSERT CARGA
INSERT INTO Carga VALUES (1,1,'19XFA16869E003306',1086.75)
INSERT INTO Carga VALUES (2,1,'1G4HR54K544271535',1155.00)
INSERT INTO Carga VALUES (2,2,'1GKFC06289R108826',1508.85)
INSERT INTO Carga VALUES (3,1,'JF1GJAS610FH05933',1013.25)
INSERT INTO Carga VALUES (4,1,'1GCEG25N30F711092',1111.95)
INSERT INTO Carga VALUES (5,1,'LHJPCHL015B005929',1099.35)
INSERT INTO Carga VALUES (1,2,'4UZAASBW02CK70115',1748.25)
INSERT INTO Carga VALUES (6,1,'1FTCA15U8RZA00994',1653.75)
INSERT INTO Carga VALUES (7,1,'4JGBF2FB4AA566018',1228.50)
INSERT INTO Carga VALUES (8,1,'4JGBF2FB4AA566018',1228.50)
INSERT INTO Carga VALUES (9,1,'4JGBF2FB4AA566018',1228.50)
INSERT INTO Carga VALUES (10,1,'4JGBF2FB4AA566018',1228.50)
INSERT INTO Carga VALUES (11,1,'4JGBF2FB4AA566018',1228.50)
INSERT INTO Carga VALUES (12,1,'JTHDL1EF2B5010450',2520.00)
INSERT INTO Carga VALUES (6,2,'1M2K193C0PM039279',1537.20)
INSERT INTO Carga VALUES (6,3,'2FTDF15H7HCA68059',1086.75)
INSERT INTO Carga VALUES (13,1,'JTMZF4DV80AD03527',1390.20)
INSERT INTO Carga VALUES (14,1,'JS2RA62S075380854',2877.00)
INSERT INTO Carga VALUES (14,2,'JS2RA62S075380854',2572.50)
GO
----------------------------------------------------------------------------
-- INVALID DATA FOR TEST
INSERT INTO Paises VALUES
('T', 'Uzbekistán'), -- REPEATED PRIMARY KEY
('U', 'Uruguay') -- COUNTRY NOT UNIQUE
INSERT INTO Fabricantes VALUES
('FF', 'Ferrari', 'Maranello, Italia', 'info@ferrari', 29500), -- EMAIL NOT UNIQUE
('LF', 'Lifan Industry Group', 'Chongqing, China', 'info@lifan', 0) -- NO EMPLOYEES
INSERT INTO Vehiculos VALUES
('1M2K193C0PI039279', 'Volkswagen Vento', 'Negro Classic', 1437, '2.5R, gasolina 5 s., manual', 'W', 'VW'), -- VIN CONTAIN 'I'
('1HFSC47L48A711588', 'Chevrolet Corsa', 'Blano Marfil', 948, '92 Cv, gasolina 5 s., manual', 'U', 'FF') -- INVALID FOREIGN KEY
INSERT INTO Plantas VALUES
(453448, 'SE', 'Sevel', 'Montevideo, Uruguay', 'info@sevel.com', 'U'), -- INVALID FOREIGN KEY
(453448, 'SE', 'Sevel', 'Montevideo, Uruguay', 'info@bran.com', 'U') -- EMAIL NOT UNIQUE
INSERT INTO Envios VALUES
('04/07/14',171900,'U','L') -- INVALID FOREIGN KEY
INSERT INTO Carga VALUES
(22, 30, '1GKFC06289R108826',1508.85) -- INVALID FOREIGN KEY
--------------------------------------------------------------------------------------------------------
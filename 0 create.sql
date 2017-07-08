-- CREATE BD
CREATE DATABASE BD_VEHICULOS
GO
USE BD_VEHICULOS
GO
-- CREATE TABLES
CREATE TABLE Paises(
  codPais character(1) NOT NULL,
  nomPais varchar(30) NOT NULL)
GO
CREATE TABLE Fabricantes(
  codFab character(2) NOT NULL,
  nomFab varchar(30) NOT NULL,
	dirFab varchar(30) NOT NULL,
	mailFab varchar(50))
GO
CREATE TABLE Plantas(
  codPlan numeric(6) NOT NULL,
  codFab character(2) NOT NULL,
	nomPlan varchar(30) NOT NULL,
	dirPlan varchar(30) NOT NULL,
	mailPlan varchar(50),
	codPais character(1) NOT NULL)
GO
CREATE TABLE Vehiculos(
  vin character(17) NOT NULL,
  modelo varchar(30) NOT NULL,
	color varchar(20) NOT NULL,
	peso numeric(12,2),
	caracteristicas varchar(100),
	codPais character(1) NOT NULL,
	codFab character(2) NOT NULL)
GO
CREATE TABLE Envios(
  idEnvio numeric(6) identity(1,1) NOT NULL,
  fchEnvio datetime,
	pesoEnvio numeric(12,2),
	oriEnvio character(1) NOT NULL,
	desEnvio character(1) NOT NULL)
GO
CREATE TABLE Carga(
  idEnvio numeric(6) NOT NULL,
  idCarga numeric(6) NOT NULL,
	vin character(17) NOT NULL,
	pesoCarga numeric(12,2))
GO
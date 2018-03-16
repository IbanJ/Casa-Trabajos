CREATE SCHEMA bco
GO

CREATE TABLE [bco].[titulares](
	[idTitular] [int] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[limiteRiesgo] [money] NOT NULL,
 CONSTRAINT [PK_titulares] PRIMARY KEY CLUSTERED 
(
	[idTitular] ASC
))
GO

CREATE TABLE [bco].[Prestamos](
	[idPrestamo] [int] NOT NULL,
	[idTitular] [int] NOT NULL,
	[importe] [money] NOT NULL,
	[vencimiento] [date] NOT NULL,
 CONSTRAINT [PK_Prestamos] PRIMARY KEY CLUSTERED 
(
	[idPrestamo] ASC
))
GO

ALTER TABLE [bco].[Prestamos]  WITH CHECK 
   ADD  CONSTRAINT [FK_Prestamos_titulares] 
      FOREIGN KEY([idTitular])
      REFERENCES [bco].[titulares] ([idTitular])
GO



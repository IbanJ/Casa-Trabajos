USE [ASIR_IgnacioGonzalo]
GO

create schema bancos
go

CREATE TABLE [bancos].[Cuentas](
	[codigoCuenta] [smallint] NOT NULL,
	[titular] [varchar](30) NULL,
	[saldo] [smallmoney] NULL,
 CONSTRAINT [PK_Cuentas] PRIMARY KEY CLUSTERED 
(
	[codigoCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [bancos].[Movimientos]    Script Date: 15/12/2017 19:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bancos].[Movimientos](
	[numMovimiento] [int] IDENTITY(1,1) NOT NULL,
	[cuentaOrigen] [smallint] NULL,
	[cuentaDestino] [smallint] NULL,
	[importe] [smallmoney] NULL,
 CONSTRAINT [PK_Movimientos] PRIMARY KEY CLUSTERED 
(
	[numMovimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [bancos].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_CuentaDestino] FOREIGN KEY([cuentaDestino])
REFERENCES [bancos].[Cuentas] ([codigoCuenta])
GO
ALTER TABLE [bancos].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_CuentaDestino]
GO
ALTER TABLE [bancos].[Movimientos]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_CuentaOrigen] FOREIGN KEY([cuentaOrigen])
REFERENCES [bancos].[Cuentas] ([codigoCuenta])
GO
ALTER TABLE [bancos].[Movimientos] CHECK CONSTRAINT [FK_Movimientos_CuentaOrigen]
GO

USE [ASIR_ibanjuarros]
GO
/****** Object:  Schema [med]    Script Date: 08/01/2018 19:21:49 ******/
CREATE SCHEMA [med]
GO
/****** Object:  Table [med].[Enfermedades]    Script Date: 08/01/2018 19:21:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [med].[Enfermedades](
	[codEnfermedad] [tinyint] NOT NULL,
	[descripcion] [varchar](80) NULL,
	[gravedad] [tinyint] NULL,
 CONSTRAINT [PK_Enfermedades] PRIMARY KEY CLUSTERED 
(
	[codEnfermedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [med].[PacEnf]    Script Date: 08/01/2018 19:21:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [med].[PacEnf](
	[codPaciente] [smallint] NOT NULL,
	[codEnfermedad] [tinyint] NOT NULL,
	[FechaRegistro] [date] NULL,
 CONSTRAINT [PK_PacEnf] PRIMARY KEY CLUSTERED 
(
	[codPaciente] ASC,
	[codEnfermedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [med].[Pacientes]    Script Date: 08/01/2018 19:21:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [med].[Pacientes](
	[codPaciente] [smallint] NOT NULL,
	[nombre] [varchar](20) NULL,
	[apellido] [varchar](25) NULL,
	[fechaNacimiento] [date] NULL,
	[fechaFallecimiento] [date] NULL,
 CONSTRAINT [PK_Pacientes] PRIMARY KEY CLUSTERED 
(
	[codPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [med].[Enfermedades] ([codEnfermedad], [descripcion], [gravedad]) VALUES (1, N'Gripe asiática', 2)
INSERT [med].[Enfermedades] ([codEnfermedad], [descripcion], [gravedad]) VALUES (2, N'Gripe común', 1)
INSERT [med].[Enfermedades] ([codEnfermedad], [descripcion], [gravedad]) VALUES (3, N'Tuberculosis', 2)
INSERT [med].[Enfermedades] ([codEnfermedad], [descripcion], [gravedad]) VALUES (4, N'Cáncer de Páncreas', 3)
INSERT [med].[Enfermedades] ([codEnfermedad], [descripcion], [gravedad]) VALUES (5, N'Cáncer de pulmón', 3)
INSERT [med].[Pacientes] ([codPaciente], [nombre], [apellido], [fechaNacimiento], [fechaFallecimiento]) VALUES (1, N'Casildo', N'Hernandez', CAST(N'1945-04-04' AS Date), NULL)
INSERT [med].[Pacientes] ([codPaciente], [nombre], [apellido], [fechaNacimiento], [fechaFallecimiento]) VALUES (2, N'Remigia', N'Rocalda', CAST(N'1956-03-31' AS Date), NULL)
INSERT [med].[Pacientes] ([codPaciente], [nombre], [apellido], [fechaNacimiento], [fechaFallecimiento]) VALUES (3, N'Ruperto', N'Calleja', CAST(N'1970-07-12' AS Date), NULL)
ALTER TABLE [med].[PacEnf]  WITH CHECK ADD  CONSTRAINT [FK_PacEnf_Enfermedades] FOREIGN KEY([codEnfermedad])
REFERENCES [med].[Enfermedades] ([codEnfermedad])
GO
ALTER TABLE [med].[PacEnf] CHECK CONSTRAINT [FK_PacEnf_Enfermedades]
GO
ALTER TABLE [med].[PacEnf]  WITH CHECK ADD  CONSTRAINT [FK_PacEnf_Pacientes] FOREIGN KEY([codPaciente])
REFERENCES [med].[Pacientes] ([codPaciente])
GO
ALTER TABLE [med].[PacEnf] CHECK CONSTRAINT [FK_PacEnf_Pacientes]
GO

/***************************************************Utilización de nombres completamente cualificados para llamar a procedimientos almacenados.Por ejemplo, si queremos ejecutar un procedimiento almacenado extendidodesde cualquier base de datos que no sea master, debemos indicar el hecho de que el procedimiento reside allí.Este procedimiento lista todas las unidades y espacios disponibles.****************************************************/USE AdventureWorks
GO

EXEC master..xp_fixeddrives
GO


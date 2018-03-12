--Creamos un dispositivo de copia de seguridad para TestDB
EXEC master.dbo.sp_addumpdevice  
@devtype = N'disk', 
@logicalname = N'TestDBcopiaseg', 
@physicalname = 'C:\Users\Administrador\Documents\Joomla\SQL SERVER 2008\copia de seguridad\copia_TestDB.bak'
GO
BACKUP DATABASE TESTDB
TO TestDBcopiaseg
GO


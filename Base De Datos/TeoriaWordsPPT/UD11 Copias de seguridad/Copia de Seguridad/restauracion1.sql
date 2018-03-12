--Con esto conseguimos que una base de datos a la que queriamos cambiar la ubicación del log a otra unidad de disco.
--Mediante la restauración de una copia de seguridad
--BACKUP DATABASE AdventureWorks TO AWcopiaseg;
 RESTORE FILELISTONLY FROM AWcopiaseg;
  RESTORE DATABASE TestDB FROM AWcopiaseg 
  WITH MOVE 'AdventureWorks_Data' 
  TO 'C:\Users\Administrador\Documents\Joomla\SQL SERVER 2008\copia de seguridad\testdb.mdf', 
  MOVE 'AdventureWorks_Log'
   TO 'C:\Users\Administrador\Documents\Joomla\SQL SERVER 2008\copia de seguridad\testdb.ldf'; 
GO


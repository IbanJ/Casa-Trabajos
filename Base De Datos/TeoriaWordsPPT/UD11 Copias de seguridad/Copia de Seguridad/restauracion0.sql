RESTORE DATABASE AdventureWorks 
FROM AWcopiaseg 
WITH NORECOVERY, 
MOVE 'AdventureWorks_Data' 
TO 'C:\Program Files\Microsoft SQL Server\MSSQL10.PRUEBAS\MSSQL\DATA\NewAdvWorks.mdf', 
MOVE 'AdventureWorks_Log'
 TO 'D:\NewAdvWorks.ldf' 
 RESTORE LOG AdventureWorks FROM AWcopiaseg 
 WITH RECOVERY

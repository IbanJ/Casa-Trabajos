BACKUP DATABASE TESTDB
   FILEGROUP = 'Primary'
  
   TO TestDBcopiaseg
   WITH DIFFERENTIAL
GO
BACKUP DATABASE TESTDB
   FILEGROUP = 'UNO'
  
   TO TestDBcopiaseg
   WITH DIFFERENTIAL
GO
BACKUP DATABASE TESTDB
   FILEGROUP = 'DOS'
  
   TO TestDBcopiaseg
   WITH DIFFERENTIAL
GO
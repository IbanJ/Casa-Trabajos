USE TestDB
GO
ALTER DATABASE [TestDB]
ADD FILEGROUP [UNO]
GO
ALTER DATABASE [TestDB]
ADD FILE
( NAME = UNODATA,
FILENAME = 'C:\Users\Administrador\Documents\Joomla\SQL SERVER 2008\copia de seguridad\UNO.NDF',
SIZE = 5MB)
TO FILEGROUP [UNO]
GO
--Now, create a testing table on the filegroup.
CREATE TABLE dbo.t1 (
id INT , v CHAR(1000) DEFAULT 'bbbb',
) ON [UNO]
GO
ALTER DATABASE [TestDB]
ADD FILEGROUP [DOS]
GO
ALTER DATABASE [TestDB]
ADD FILE
( NAME = DOSDATA,
FILENAME = 'C:\Users\Administrador\Documents\Joomla\SQL SERVER 2008\copia de seguridad\DOS.NDF',
SIZE = 5MB)
TO FILEGROUP [DOS]
GO
--Now, create a testing table on the filegroup.
CREATE TABLE dbo.t2 (
id INT , v CHAR(1000) DEFAULT 'bbbb',
) ON [DOS]
GO
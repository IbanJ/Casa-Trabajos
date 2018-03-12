Insert into dbo.t1 values(1,'ggg')
Insert into dbo.t1 values(2,'ggu')
Insert into dbo.t1 values(3,'gug')
EXEC master.dbo.sp_addumpdevice  @devtype = N'disk', @logicalname = N'AWcopiaseg_log', @physicalname = N'D:\AWcopiaseg\copia_AWlog.bak'
GO
Backup log Adventureworks TO AWcopiaseg_log
GO
Insert into dbo.t1 values(4,'ggg')
Insert into dbo.t1 values(5,'ggu')
Insert into dbo.t1 values(6,'gug')

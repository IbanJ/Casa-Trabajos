declare @esquema as varchar(50)
declare  @tabla as varchar(100)

declare @comando as nvarchar(200),
        @numfiLAS AS integer
declare micursor cursor for
 select table_schema, table_name from INFORMATION_SCHEMA.TABLES
     WHERE table_type = 'BASE TABLE'

create table #tempo2 (id int identity(1,1) not null, num  int)

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tempo]')
--     AND type in (N'U'))
        --drop table tempo
create table tempo (tabla varchar(100), num int)

open micursor
fetch  micursor into @esquema,@tabla
while @@FETCH_STATUS = 0
begin
	set @comando = 'select COUNT(*) from '
	set @comando = @comando +  rtrim(@esquema) + '.['  + rtrim(@tabla) + ']'
	print @comando
    
	insert into #tempo2 exec (@comando)
	set @numfilas=(select top 1 num  from #tempo2 order by id desc)
	insert into tempo (tabla,num) values (rtrim(@esquema)+ '.' + rtrim(@tabla), @numfilas)
	fetch  micursor into @esquema,@tabla
end
deallocate micursor

-- ver los resultados
select * from tempo
order by tabla asc



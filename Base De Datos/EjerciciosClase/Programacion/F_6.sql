-- Crear una funcion que reciba como parametros dos fechas:
-- la funcion controlara que 
-- la primera sea <= que la segunda
-- esta funcion nos devolvera cada fecha 
-- con el numero de pedidos con el importe.
alter function F_6 (
	@p_fecha1 date,
	@p_fecha2 date				
					)

returns @datos table  (Fecha date,
					NumPedidos smallint, 
					Importe money)

as

begin
	if @p_fecha1>=@p_fecha2
	BEGIN
		insert into @datos (Fecha, NumPedidos, Importe)
			values ('11/09/2001', -1, -1)
	END
	else
	begin
		insert into @datos (Fecha, NumPedidos, Importe)
			select OrderDate, COUNT(*) as NumPedidos, sum(TotalDue) as importe
			from AdventureWorks2014.Sales.SalesOrderHeader as Ped
			where OrderDate between @p_fecha1 and @p_fecha2
			group by OrderDate
			order by OrderDate desc
	end
	return
end
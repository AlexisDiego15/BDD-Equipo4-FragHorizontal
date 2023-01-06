----------------------------------------------------
--[DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW
--[DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW
--[DESKTOP-A5SBAIV].salesAW

use salesAW
go
------------------------------------------------------
	/*1. Determinar el total de las ventas de los productos con la categoría que
	se provea de argumento de entrada en la consulta, para cada uno de los 
	territorios registrados en la base de datos.*/		
		
		/*
			No fue necesario realizar la transacción, ya que es una consulta
			y no se alteran los datos de ninguna tabla.
		*/
		drop procedure if exists sp_uno
		go

		create procedure sp_uno
			@cat int
		AS
		BEGIN
		SET NOCOUNT ON;
		declare @instancia1 SYSNAME = '[DESKTOP-A5SBAIV].salesAW'
		declare @instancia2 SYSNAME = '[DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW'
		declare @instancia3 SYSNAME = '[DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW'

		DECLARE @strSql1 nvarchar(1500)
			set @strSql1 = 'select soh.TerritoryID as Territorio, sum(t.LineTotal) as Total_Venta
			from '+@instancia1+'.Sales.SalesOrderHeader soh
			inner join
			(
				select salesorderid, productid, orderqty, linetotal
				from '+@instancia1+'.Sales.SalesOrderDetail sod
				where ProductID in 
				(
					select productid
					from '+@instancia2+'.Production.Product
					where ProductSubcategoryID in
					(
					select ProductSubcategoryID
					from '+@instancia2+'.Production.ProductSubcategory
					where ProductCategoryID in 
						(
						select ProductCategoryID
						from '+@instancia2+'.Production.ProductCategory
						where ProductCategoryID = @cat 
						) 
					)
				)
			) as t
			on soh.SalesOrderID = t.SalesOrderID
			group by soh.TerritoryID
			order by soh.TerritoryID'
			
			if (select count(*) from  [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductCategory where ProductCategoryID = @cat) = 1
			begin
				execute sp_executesql @strSql1, N'@cat int', @cat
			end
			else
			begin
				print 'No se encontro la categora'
			end
	  end
	  go

	  --exec sp_uno 5
	  --go
	 

-------------------------------------------------------------------
	/*2.Determinar el producto más solicitado para la región 
	(atributo group de salesterritory) “Noth America” y en que
	territorio de la región tiene mayor demanda.*/
	 
	 
		/*
			No se realiza transaccion, ya que es una consulta
			y no se alteran los datos de ninguna tabla.
		*/
	drop procedure if exists sp_dos
		go

		create procedure sp_dos
		AS
		BEGIN
		SET NOCOUNT ON;
				
		declare @instancia1 SYSNAME = '[DESKTOP-A5SBAIV].salesAW'
		declare @instancia2 SYSNAME = '[DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW'
		declare @instancia3 SYSNAME = '[DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW'

		DECLARE @strSql2 nvarchar(1500)
			set @strSql2 = 'select top (1) Q.ProductID as ID, Q.Name as Nombre, Q.cantidad as CantidadTotal, 
					W.TerritoryID as IDTerritorio, W.NombreTerritorio as NTerritorio, W.cantidadpt as CantidadTerritorio
					 from (
						 select a.ProductID, b.Name, c.TerritoryID, d.Name as NombreTerritorio, count(*) cantidadpt
						 from '+@instancia1+'.Sales.SalesOrderDetail a
						 inner join '+@instancia1+'.Sales.SalesOrderHeader c
						 on a.SalesOrderID = c.SalesOrderID
						 inner join '+@instancia2+'.Production.Product b 
						 on a.ProductID = b.ProductID
						 inner join '+@instancia1+'.Sales.SalesTerritory d 
						 on c.TerritoryID = d.TerritoryID
					 where d.TerritoryID between 1 and 6
						 group by a.ProductID, c.TerritoryID, b.Name, d.Name
					 ) as W
					 inner join (
						 select T.ProductID, T.Name, count(*) cantidad
						 from (select a.ProductID, b.Name, c.TerritoryID
							from '+@instancia1+'.Sales.SalesOrderDetail a
						 inner join '+@instancia1+'.Sales.SalesOrderHeader c
						 on a.SalesOrderID = c.SalesOrderID
						 inner join '+@instancia2+'.Production.Product b 
						 on a.ProductID = b.ProductID
						 where c.TerritoryID between 1 and 6 ) as T
						 group by ProductID, Name
					 ) as Q
					 on W.Name = Q.Name and W.ProductID = Q.ProductID
					 order by CantidadTotal desc, CantidadTerritorio desc'
			   
	  execute sp_executesql @strSql2
	  end
	  go

	 --exec sp_dos
	 --go
	 	
	 
	 -----------------------------------------------------------
	/*3.Actualizar el stock disponible en un 5% de los productos de
	la categoría que se provea como argumento de entrada en una 
	localidad que se provea como entrada en la instrucción de actualización	*/

	/*Transaccion implementada debido a que implica actualizar datos de una tabla*/

		drop procedure if exists sp_tres
		go

		create procedure sp_tres
			@cat int,
			@loc int
		AS
		BEGIN
		SET NOCOUNT ON;
		DECLARE @RegistrosAfectados INTEGER

		declare @instancia2 SYSNAME = '[DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW'

		DECLARE @strSql1 nvarchar(1000)
			set @strSql1 = 'update d
				set d.Quantity = (d.Quantity*1.05)
				from
				'+@instancia2+'.Production.ProductInventory d
				inner join '+@instancia2+'.Production.Product a
				on a.ProductID = d.ProductID
				inner join '+@instancia2+'.Production.ProductSubcategory b
				on a.ProductSubcategoryID = b.ProductSubcategoryID
				inner join '+@instancia2+'.Production.ProductCategory c
				on c.ProductCategoryID = b.ProductCategoryID
				inner join '+@instancia2+'.Production.Location e
				on e.LocationID = d.LocationID
				where c.ProductCategoryID=@cat and d.LocationID=@loc
				'
			
			if (select count(*) from  [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductCategory where ProductCategoryID = @cat) = 1
			begin
				if (select count(*) from  [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Location where LocationID = @loc) = 1
				begin	
					SET XACT_ABORT ON
					BEGIN TRAN
						BEGIN TRY
							execute sp_executesql @strSql1, N'@cat int, @loc int', @cat, @loc
							SELECT @RegistrosAfectados = @@ROWCOUNT  
							SELECT @RegistrosAfectados as ProductosAumentados
							COMMIT TRAN
						END TRY
						BEGIN CATCH
							ROLLBACK TRAN
						END CATCH 	
				end
				else
				begin
					print 'Locacion no encontrada'
					SELECT '0 (no se encontro la localidad)' as ProductosAumentados

				end
			end
			else
			begin
				print 'Categoria no encontrada'
				SELECT '0 (no se encontro la categoria)' as ProductosAumentados
			end		
	  end
	  go

	  --exec sp_tres 3, 5454
	  --go

	  --Vista:
	  
	  drop view if exists vw_tres
	  go
	  create view vw_tres as 
			select a.ProductID as IDProd, a.Name as NProd, b.ProductCategoryID as IDCat,
			c.Name as Categoria, floor(d.Quantity) as Cantidad, 
			d.LocationID as IDLoc, e.Name as NLoc
			from
			[DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Product a
			inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductSubcategory b
			on a.ProductSubcategoryID = b.ProductSubcategoryID
			inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductCategory c
			on c.ProductCategoryID = b.ProductCategoryID
			inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductInventory d
			on a.ProductID = d.ProductID
			inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Location e
			on e.LocationID = d.LocationID
		go

--------------------------------------------------------------------------

		/*4.Determinar si hay clientes que realizan ordenes
		en territorios diferentes al que se encuentran.*/

		/*Se determina no usar transacciones ya que es una consulta
			de datos y no se alteran datos*/
    	drop procedure if exists sp_cuatro
		go

		create procedure sp_cuatro
		AS
		BEGIN
		SET NOCOUNT ON;
		DECLARE @RegistrosAfectados INTEGER

		DECLARE @strSql4 nvarchar(500)
			set @strSql4 = 'select a.SalesOrderID as orden, a.TerritoryID as territorio_orden,
							a.SalesPersonID as cliente, b.TerritoryID as territorio_cliente
					from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader a
					inner join [DESKTOP-A5SBAIV].salesAW.Sales.Customer b
					on a.CustomerID = b.CustomerID
					where a.TerritoryID != b.TerritoryID'
			
				execute sp_executesql @strSql4
				SELECT @RegistrosAfectados = @@ROWCOUNT  
				SELECT @RegistrosAfectados as ClientesTD
	  end
	  go

	  --exec sp_cuatro
	  --go



	  -----------------------------------------------------------------------------
	  	/*5.Actualizar la cantidad de productos de una orden que se 
		provea como argumento en la instrucción de actualización*/
		
		/*Se implementa transaccion ya que existe una actulizacion
			en los datos de una tabla*/
		drop procedure if exists sp_cinco
		go

		create procedure sp_cinco
			@cantidad int,
			@producto int,
			@orden int
		AS
		BEGIN
		SET NOCOUNT ON;
		DECLARE @RegistrosAfectados INTEGER

		DECLARE @strSql5 nvarchar(500)
			set @strSql5 = 'update [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail 
				set OrderQty = @cantidad
				from
				[DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail 
				where SalesOrderID = @orden and ProductID = @producto'
			
	if (select count(*) from  [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail where SalesOrderID = @orden) > 0
			begin
				if (select count(*) from  [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail where ProductID = @producto) > 0
				begin	
					SET XACT_ABORT ON
					BEGIN TRAN
						BEGIN TRY
							execute sp_executesql @strSql5, N'@cantidad int, @producto int, @orden int', 
												@cantidad, @producto, @orden
							SELECT @RegistrosAfectados = @@ROWCOUNT  
							SELECT @RegistrosAfectados as ProductosAumentados
							COMMIT TRAN
						END TRY
						BEGIN CATCH
							ROLLBACK TRAN
						END CATCH 	
				end
				else
				begin
					SELECT '0 (no se encontro el producto)' as ProductosAumentados

				end
			end
			else
			begin
				SELECT '0 (no se encontro la orden)' as ProductosAumentados
			end		
	  end
	  go

	  
	 -- exec sp_cinco 5, 776, 43659
	  --go

	  --Vista:
	  drop view if exists vw_cinco
	  go
	  create view vw_cinco as
	  select s.SalesOrderID as Orden, s.ProductID as IDProd, s.OrderQty as Cantidad, p.Name as Nombre
	  from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail s
	  inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Product p
	  on p.ProductID = s.ProductID
	  go

	  select * from vw_cinco
	  -----------------------------------------------------------------------------------------------------
	   /*6. Actualizar el método de envío de una orden que se reciba 
			como argumento en la instrucción de actualización.*/
	   
	   /*Se implementa transaccion ya que existe una actulizacion
			en los datos de una tabla*/
	    drop procedure if exists sp_seis
		go
		create procedure sp_seis
			@metodo int,
			@orden int
		AS
		BEGIN
		SET NOCOUNT ON;
		DECLARE @RegistrosAfectados INTEGER

		DECLARE @strSql6 nvarchar(500)
			set @strSql6 = 'update [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader
				set	ShipMethodID = @metodo
				from
				[DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader 
				where SalesOrderID = @orden'
			
				
if (select count(*) from  [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader where SalesOrderID = @orden) > 0
			begin
				if (select count(*) from  [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader where ShipMethodID = @metodo) > 0
				begin	
					SET XACT_ABORT ON
					BEGIN TRAN
						BEGIN TRY
							execute sp_executesql @strSql6, N'@metodo int, @orden int', @metodo, @orden
							SELECT @RegistrosAfectados = @@ROWCOUNT  
							SELECT @RegistrosAfectados as MetodosCambiados
							COMMIT TRAN
						END TRY
						BEGIN CATCH
							ROLLBACK TRAN
						END CATCH 	
				end
				else
				begin
					SELECT '0 (No hay un metodo asi)' as MetodosCambiados

				end
			end
			else
			begin
				SELECT '0 (No se encontro la orden)' as MetodosCambiados
			end		
	  end
	  go


	  --exec sp_seis 5, 43659
	  --go

	  --Vista:
	  drop view if exists vw_seis
	  go
	  create view vw_seis as
	  select s.SalesOrderID as IDOrden, s.ShipMethodID as IDMetodo, m.Name as Metodo
	  from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader s
	  inner join [DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW.Purchasing.ShipMethod m
	  on s.ShipMethodID=m.ShipMethodID
	  go


	  ------------------------------------------------------------------------------------------------
	 	/*7.Actualizar el correo electrónico de una cliente que
			se reciba como argumento en la instrucción de actualización*/	

			/*Se implementa transacción, ya que se actualiza la informacion*/
			
		drop procedure if exists sp_siete
		go
		create procedure sp_siete
			@emailnuevo nvarchar(50),
			@emailanterior nvarchar(50)
		AS
		BEGIN
		SET NOCOUNT ON;
		DECLARE @RegistrosAfectados INTEGER

		DECLARE @strSql7 nvarchar(900)
			set @strSql7 ='
				update e
				set e.EmailAddress = @emailnuevo
				from openquery ([DESKTOP-A5SBAIV\SQLSERVERTRES],
					''select BusinessEntityID, EmailAddress
					from [DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW.Person.EmailAddress'') e
				join openquery ([DESKTOP-A5SBAIV\SQLSERVERTRES],
					''select FirstName, LastName, PersonType, BusinessEntityID
					from [DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW.Person.Person'') p
				on e.BusinessEntityID = p.BusinessEntityID	
				where p.PersonType = ''IN'' and e.EmailAddress = @emailanterior' 
			
				
			
if (select count(*) from  [DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW.Person.EmailAddress where EmailAddress = @emailanterior) > 0
			begin
				SET XACT_ABORT ON
				BEGIN TRAN
					BEGIN TRY
						execute sp_executesql @strSql7, N'@emailnuevo nvarchar(50), @emailanterior nvarchar(50)', 
													@emailnuevo, @emailanterior
						SELECT @RegistrosAfectados = @@ROWCOUNT  
						SELECT @RegistrosAfectados as EmailCambiado
						COMMIT TRAN
					END TRY
					BEGIN CATCH
						ROLLBACK TRAN
					END CATCH 	
			end
			else
				begin
					SELECT '0 (No se encontro el email anterior)' as MetodosCambiados
				end		
	  end
	  go
  
	  --exec sp_siete 'redfoodiego@gmail.com', 'rebecca3@adventure-works.com'
	  --go

	  --Vista:
	  	drop view if exists vw_siete 
		go
		create view vw_siete as
		  select Correo, Nombre, Apellido from openquery ([DESKTOP-A5SBAIV\SQLSERVERTRES],
			'select e.EmailAddress as Correo, p.FirstName as Nombre, p.LastName as Apellido, p.PersonType
			from [DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW.Person.EmailAddress e
			inner join [DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW.Person.Person p
			on e.BusinessEntityID = p.BusinessEntityID
			where p.PersonType = ''IN''')
		go
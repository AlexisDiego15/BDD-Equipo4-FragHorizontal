	 	drop procedure if exists sp_uno
		go

		create procedure sp_uno
			@cat int
		AS
		BEGIN
		SET NOCOUNT ON;

		DECLARE @strSql1 nvarchar(1500)
			set @strSql1 = 'select soh.TerritoryID as Territorio, sum(t.LineTotal) as Total_Venta
			from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader soh
			inner join
			(
				select salesorderid, productid, orderqty, linetotal
				from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail sod
				where ProductID in 
				(
					select productid
					from [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Product
					where ProductSubcategoryID in
					(
					select ProductSubcategoryID
					from [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductSubcategory
					where ProductCategoryID in 
						(
						select ProductCategoryID
						from [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductCategory
						where ProductCategoryID = @cat 
						) 
					)
				)
			) as t
			on soh.SalesOrderID = t.SalesOrderID
			group by soh.TerritoryID
			order by soh.TerritoryID'
			   
	  execute sp_executesql @strSql1, N'@cat int', @cat
	  end
	  go

	  exec sp_uno 3
	  go
	 

	 -------------------------------------------------------------------

	 
	drop procedure if exists sp_dos
		go

		create procedure sp_dos
		AS
		BEGIN
		SET NOCOUNT ON;

		DECLARE @strSql2 nvarchar(1500)
			set @strSql2 = 'select top (1) Q.ProductID as ID, Q.Name as Nombre, Q.cantidad as CantidadTotal, 
					W.TerritoryID as IDTerritorio, W.NombreTerritorio as NTerritotio, W.cantidadpt as CantidadTerritorio
					 from (
						 select a.ProductID, b.Name, c.TerritoryID, d.Name as NombreTerritorio, count(*) cantidadpt
						 from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail a
						 inner join [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader c
						 on a.SalesOrderID = c.SalesOrderID
						 inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Product b 
						 on a.ProductID = b.ProductID
						 inner join [DESKTOP-A5SBAIV].salesAW.Sales.SalesTerritory d 
						 on c.TerritoryID = d.TerritoryID
						 where c.TerritoryID between 1 and 6
						 group by a.ProductID, c.TerritoryID, b.Name, d.Name
					 ) as W
					 inner join (
						 select T.ProductID, T.Name, count(*) cantidad
						 from (select a.ProductID, b.Name, c.TerritoryID
							from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail a
						 inner join [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader c
						 on a.SalesOrderID = c.SalesOrderID
						 inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Product b 
						 on a.ProductID = b.ProductID
						 where c.TerritoryID between 1 and 6 ) as T
						 group by ProductID, Name
					 ) as Q
					 on W.Name = Q.Name and W.ProductID = Q.ProductID
					 order by CantidadTotal desc, CantidadTerritorio desc'
			   
	  execute sp_executesql @strSql2
	  end
	  go

	  exec sp_dos
	
	 	
	 
	 -----------------------------------------------------------
	 drop view if exists vw_tres
	  go
	 create view vw_tres as 
			select a.ProductID, a.Name, b.ProductCategoryID, c.Name as Categoria,
				floor(d.Quantity) as Cantidad, d.LocationID, e.Name as Locacion
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

			

drop procedure if exists sp_tres
		go

		create procedure sp_tres
			@cat int,
			@loc int
		AS
		BEGIN
		SET NOCOUNT ON;
		DECLARE @RegistrosAfectados INTEGER

		DECLARE @strSql1 nvarchar(1000)
			set @strSql1 = 'update d
				set d.Quantity = (d.Quantity*1.05)
				from
				[DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductInventory d
				inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Product a
				on a.ProductID = d.ProductID
				inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductSubcategory b
				on a.ProductSubcategoryID = b.ProductSubcategoryID
				inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.ProductCategory c
				on c.ProductCategoryID = b.ProductCategoryID
				inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Location e
				on e.LocationID = d.LocationID
				where c.ProductCategoryID=@cat and d.LocationID=@loc
				'
			
				execute sp_executesql @strSql1, N'@cat int, @loc int', @cat, @loc
				SELECT @RegistrosAfectados = @@ROWCOUNT  
				SELECT @RegistrosAfectados as ProductosAumentados
			
	  end
	  go

	  exec sp_tres 4, 6
	  go

	  --------------------------------------------------------------------------
	  
	 drop procedure if exists sp_cuatro
		go

		create procedure sp_cuatro
		AS
		BEGIN
		SET NOCOUNT ON;
		DECLARE @RegistrosAfectados INTEGER

		DECLARE @strSql4 nvarchar(500)
			set @strSql4 = 'select a.SalesOrderID, a.TerritoryID, a.SalesPersonID, b.TerritoryID
					from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader a
					inner join [DESKTOP-A5SBAIV].salesAW.Sales.Customer b
					on a.CustomerID = b.CustomerID
					where a.TerritoryID != b.TerritoryID'
			
				execute sp_executesql @strSql4
				SELECT @RegistrosAfectados = @@ROWCOUNT  
				SELECT @RegistrosAfectados as ClientesTD
	  end
	  go

	  exec sp_cuatro
	  go



	  -----------------------------------------------------------------------------
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
			
				execute sp_executesql @strSql5, N'@cantidad int, @producto int, @orden int', 
												@cantidad, @producto, @orden
				SELECT @RegistrosAfectados = @@ROWCOUNT  
				SELECT @RegistrosAfectados as ProductosAumentados
	  end
	  go

	  exec sp_cinco 5, 776, 43659
	  go

	  drop view if exists vw_cinco
	  go
	  create view vw_cinco as
	  select s.SalesOrderID, s.ProductID, s.OrderQty, p.Name
	  from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderDetail s
	  inner join [DESKTOP-A5SBAIV\SQLSERVERDOS].productionAW.Production.Product p
	  on p.ProductID = s.ProductID
	  go

	  -----------------------------------------------------------------------------------------------------
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
			
				execute sp_executesql @strSql6, N'@metodo int, @orden int', @metodo, @orden
				SELECT @RegistrosAfectados = @@ROWCOUNT  
				SELECT @RegistrosAfectados as MetodosCambiados
	  end
	  go

	  exec sp_seis 3, 43659
	  go

	  drop view if exists vw_seis
	  go
	  create view vw_seis as
	  select s.SalesOrderID, s.ShipMethodID, m.Name
	  from [DESKTOP-A5SBAIV].salesAW.Sales.SalesOrderHeader s
	  inner join [DESKTOP-A5SBAIV\SQLSERVERTRES].otrosAW.Purchasing.ShipMethod m
	  on s.ShipMethodID=m.ShipMethodID
	  go

	  ------------------------------------------------------------------------------------------------
	 			 	
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
			
				execute sp_executesql @strSql7, N'@emailnuevo nvarchar(50), @emailanterior nvarchar(50)', 
													@emailnuevo, @emailanterior
				SELECT @RegistrosAfectados = @@ROWCOUNT  
				SELECT @RegistrosAfectados as EmailCambiado
	  end
	  go
  
	  exec sp_siete 'redfoodiego@gmail.com', 'rebecca3@adventure-works.com'
	  go

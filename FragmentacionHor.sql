	 	drop procedure if exists sp_uno
		go

		create procedure sp_uno
			@cat int
		AS
		BEGIN
		SET NOCOUNT ON;

		DECLARE @strSql1 nvarchar(1000)
			set @strSql1 = 'select soh.TerritoryID, sum(t.LineTotal) as Total_Venta
			from AdventureWorks2019.Sales.SalesOrderHeader soh
			inner join
			(
				select salesorderid, productid, orderqty, linetotal
				from AdventureWorks2019.Sales.SalesOrderDetail sod
				where ProductID in 
				(
					select productid
					from AdventureWorks2019.Production.Product
					where ProductSubcategoryID in
					(
					select ProductSubcategoryID
					from AdventureWorks2019.Production.ProductSubcategory
					where ProductCategoryID in 
						(
						select ProductCategoryID
						from AdventureWorks2019.Production.ProductCategory
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

	  exec sp_uno 4
	  go
	 

	 -------------------------------------------------------------------


	 	drop procedure if exists sp_dos
		go

		create procedure sp_dos
		AS
		BEGIN
		SET NOCOUNT ON;

		DECLARE @strSql2 nvarchar(1500)
			set @strSql2 = 'select top (1) Q.ProductID, Q.Name, Q.cantidad as CantidadTotal, 
					W.TerritoryID, W.NombreTerritorio, W.cantidadpt as CantidadTerritorio
					 from (
						 select a.ProductID, b.Name, c.TerritoryID, d.Name as NombreTerritorio, count(*) cantidadpt
						 from AdventureWorks2019.Sales.SalesOrderDetail a
						 inner join AdventureWorks2019.Sales.SalesOrderHeader c
						 on a.SalesOrderID = c.SalesOrderID
						 inner join AdventureWorks2019.Production.Product b 
						 on a.ProductID = b.ProductID
						 inner join AdventureWorks2019.Sales.SalesTerritory d 
						 on c.TerritoryID = d.TerritoryID
						 where c.TerritoryID between 1 and 6
						 group by a.ProductID, c.TerritoryID, b.Name, d.Name
					 ) as W
					 inner join (
						 select T.ProductID, T.Name, count(*) cantidad
						 from (select a.ProductID, b.Name, c.TerritoryID
							from AdventureWorks2019.Sales.SalesOrderDetail a
						 inner join AdventureWorks2019.Sales.SalesOrderHeader c
						 on a.SalesOrderID = c.SalesOrderID
						 inner join AdventureWorks2019.Production.Product b 
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
	 /*create view tres as*/ 
			select a.ProductID, a.Name, b.ProductCategoryID, c.Name as Categoria,
				floor(d.Quantity) as Cantidad, d.LocationID, e.Name as Locacion
			from
			AdventureWorks2019.Production.Product a
			inner join AdventureWorks2019.Production.ProductSubcategory b
			on a.ProductSubcategoryID = b.ProductSubcategoryID
			inner join AdventureWorks2019.Production.ProductCategory c
			on c.ProductCategoryID = b.ProductCategoryID
			inner join AdventureWorks2019.Production.ProductInventory d
			on a.ProductID = d.ProductID
			inner join AdventureWorks2019.Production.Location e
			on e.LocationID = d.LocationID


	 	drop procedure if exists sp_tres
		go

		create procedure sp_tres
			@cat int,
			@loc int
		AS
		BEGIN
		SET NOCOUNT ON;

		DECLARE @strSql1 nvarchar(1000)
			set @strSql1 = 'update d
				set d.Quantity = (d.Quantity*1.05)
				from
				AdventureWorks2019.Production.ProductInventory d
				inner join AdventureWorks2019.Production.Product a
				on a.ProductID = d.ProductID
				inner join AdventureWorks2019.Production.ProductSubcategory b
				on a.ProductSubcategoryID = b.ProductSubcategoryID
				inner join AdventureWorks2019.Production.ProductCategory c
				on c.ProductCategoryID = b.ProductCategoryID
				inner join AdventureWorks2019.Production.Location e
				on e.LocationID = d.LocationID
				where c.ProductCategoryID=@cat and d.LocationID=@loc'
			   
	  execute sp_executesql @strSql1, N'@cat int, @loc int', @cat, @loc
	  end
	  go

	  exec sp_tres 4, 7
	  go
	  --------------------------------------------------------------------------

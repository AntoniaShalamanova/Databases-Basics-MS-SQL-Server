SELECT Id
		,ProductName
		,DATEPART(QUARTER, OrderDate) AS Quarter
		,MONTH(OrderDate) AS Month
		,YEAR(OrderDate) AS Year
		,DAY(OrderDate) AS Day
FROM Orders
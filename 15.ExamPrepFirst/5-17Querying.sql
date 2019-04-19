--5
SELECT Id, FirstName
FROM Employees
WHERE Salary > 6500
ORDER BY FirstName, Id

--6
SELECT FirstName + ' ' + LastName AS [Full Name], Phone
FROM Employees
WHERE Phone LIKE '3%'
ORDER BY FirstName, Phone

--7
SELECT e.FirstName, e.LastName, COUNT(*) AS Count
FROM Employees AS e
JOIN Orders AS o ON e.Id = o.EmployeeId
GROUP BY e.Id, e.FirstName, e.LastName
ORDER BY Count DESC, e.FirstName

--8
SELECT e.FirstName, 
	e.LastName, 
	AVG(DATEDIFF(HOUR, s.CheckIn, s.CheckOut)) AS [Work hours]
FROM Employees AS e
JOIN Shifts AS s ON e.Id = s.EmployeeId
GROUP BY e.Id, e.FirstName, e.LastName
HAVING AVG(DATEDIFF(HOUR, s.CheckIn, s.CheckOut)) > 7
ORDER BY [Work hours] DESC, e.Id

--9
SELECT TOP(1) oi.OrderId, SUM(oi.Quantity * i.Price) AS TotalPrice
FROM OrderItems AS oi
JOIN Items AS i ON oi.ItemId = i.Id
GROUP BY oi.OrderId
ORDER BY TotalPrice DESC

--10
SELECT TOP(10) oi.OrderId, MAX(i.Price) AS ExpensivePrice, MIN(i.Price) AS CheapPrice
FROM OrderItems AS oi
JOIN Items AS i ON oi.ItemId = i.Id
GROUP BY oi.OrderId
ORDER BY ExpensivePrice DESC, oi.OrderId

--11
SELECT DISTINCT e.Id, e.FirstName, e.LastName
FROM Employees AS e
JOIN Orders AS o ON e.Id = o.EmployeeId
ORDER BY e.Id

--12
SELECT DISTINCT e.Id, e.FirstName + ' ' + e.LastName AS [Full Name]
FROM Employees AS e
JOIN Shifts AS s ON e.Id = s.EmployeeId
WHERE DATEDIFF(HOUR, s.CheckIn, s.CheckOut) < 4
ORDER BY e.Id

--13
SELECT TOP(10) e.FirstName + ' ' + e.LastName AS [Full Name]
				,SUM(oi.Quantity * i.Price) AS TotalPrice
				,SUM(oi.Quantity) AS Items
FROM Employees AS  e
JOIN Orders AS o ON e.Id = o.EmployeeId
JOIN OrderItems AS oi ON o.Id = oi.OrderId
JOIN Items AS i ON oi.ItemId = i.Id
WHERE o.[DateTime] < '2018-06-15'
GROUP BY  e.FirstName, e.LastName
ORDER BY TotalPrice DESC, Items DESC

--14
SELECT e.FirstName + ' ' + e.LastName AS [Full Name]
		,DATENAME(WEEKDAY, s.CheckIn)
FROM Employees AS e
LEFT JOIN Orders AS o ON e.Id = o.EmployeeId
JOIN Shifts AS s ON e.Id = s.EmployeeId
WHERE DATEDIFF(HOUR, s.CheckIn, s.CheckOut) > 12 AND o.Id IS NULL
ORDER BY e.Id

--15
SELECT t.[Full Name]
		,DATEDIFF(HOUR, s.CheckIn, s.CheckOut) AS WorkHours 
		,t.TotalSum
FROM(
	SELECT o.Id AS OrderId
			,o.[DateTime] AS [DateTime]
			,e.Id AS EmployeeId
			,e.FirstName + ' ' + e.LastName AS [Full Name]
			,SUM(oi.Quantity * i.Price) AS TotalSum
			,ROW_NUMBER() OVER (PARTITION BY e.Id ORDER BY SUM(oi.Quantity * i.Price) DESC) AS RowNumer
	FROM Employees AS e
	JOIN Orders AS o ON e.Id = o.EmployeeId
	JOIN OrderItems AS oi ON o.Id = oi.OrderId
	JOIN Items AS i ON oi.ItemId = i.Id
	GROUP BY  o.Id, e.FirstName, e.LastName, e.Id, o.[DateTime]) AS t
JOIN Shifts AS s ON t.EmployeeId = s.EmployeeId
WHERE t.RowNumer = 1 AND t.[DateTime] BETWEEN s.CheckIn AND s.CheckOut
ORDER BY t.[Full Name], WorkHours DESC, t.TotalSum DESC

--16
SELECT DATEPART(DAY, o.[DateTime]) AS [Day]
		,FORMAT(AVG(oi.Quantity * i.Price), 'N2') AS [Total profit]
FROM Orders AS o
JOIN OrderItems AS oi ON o.Id = oi.OrderId
JOIN Items AS i ON oi.ItemId = i.Id
GROUP BY DATEPART(DAY, o.[DateTime])
ORDER BY [Day]

--17
SELECT i.[Name] AS Item
		,c.[Name] AS Category
		,SUM(oi.Quantity) AS [Count]
		,SUM(oi.Quantity * i.Price) AS [TotalPrice]
FROM Items AS i
JOIN Categories AS c ON i.CategoryId = c.Id
LEFT JOIN OrderItems AS oi ON i.Id = oi.ItemId
GROUP BY i.[Name], c.[Name]
ORDER BY TotalPrice DESC, [Count] DESC
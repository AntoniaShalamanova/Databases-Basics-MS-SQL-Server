--1
SELECT FirstName, LastName
FROM Employees
WHERE FirstName LIKE 'SA%'

--2
SELECT FirstName, LastName
FROM Employees
WHERE LastName LIKE '%EI%'

--3
SELECT FirstName
FROM Employees
WHERE DepartmentID IN(3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005

--4
SELECT FirstName, LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--5
SELECT [Name]
FROM Towns
WHERE LEN([Name]) IN(5, 6)
ORDER BY [Name]

--6
SELECT *
FROM Towns
WHERE [Name] LIKE '[MKBE]%' 
ORDER BY [Name]

--7
SELECT *
FROM Towns
WHERE [Name] NOT LIKE '[RBD]%' 
ORDER BY [Name]
GO

--8
CREATE VIEW V_EmployeesHiredAfter2000  AS
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) > 2000
GO

SELECT * FROM V_EmployeesHiredAfter2000

--9
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName) = 5

--10
SELECT EmployeeID
		,FirstName
		,LastName
		,Salary
		,DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

--11
SELECT * 
	FROM (SELECT EmployeeID
					,FirstName
					,LastName
					,Salary
					,DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
			FROM Employees
			WHERE Salary BETWEEN 10000 AND 50000) 
	AS MySpecialTable 
WHERE [Rank] = 2
ORDER BY Salary DESC
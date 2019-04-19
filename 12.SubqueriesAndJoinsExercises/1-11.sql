--1
SELECT TOP(5) 
	e.EmployeeID
	,e.JobTitle
	,e.AddressID
	,a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
ORDER BY e.AddressID 

--4
SELECT TOP(5) 
	e.EmployeeID
	,e.FirstName
	,e.Salary
	,d.[Name]
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
WHERE Salary > 15000
ORDER BY e.DepartmentID

--5
SELECT TOP(3)
	e.EmployeeID
	,e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

--5*
SELECT TOP(3)
	EmployeeID
	,FirstName
FROM Employees
WHERE EmployeeID NOT IN(
	SELECT EmployeeID
	FROM EmployeesProjects)
ORDER BY EmployeeID

--7
SELECT TOP(5)
	e.EmployeeID
	,e.FirstName
	,p.[Name]
FROM Employees AS e
JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--8 CASE
SELECT
	e.EmployeeID
	,e.FirstName
	,CASE
     WHEN YEAR(p.StartDate) >= 2005 THEN NULL
	 ELSE p.[Name]
	 END AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

--8 IIF
SELECT
	e.EmployeeID
	,e.FirstName
	,IIF(YEAR(p.StartDate) >= 2005, NULL, p.[Name]) AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

--9
SELECT
	e.EmployeeID
	,e.FirstName
	,e.ManagerID
	,m.FirstName
FROM Employees AS e
JOIN Employees AS m ON e.ManagerID = m.EmployeeID
WHERE e.ManagerID IN(3, 7)
ORDER BY e.EmployeeID
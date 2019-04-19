--Departments Total Salaries
SELECT DepartmentID
		,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--STRING_AGG
SELECT TownID
		,STRING_AGG(AddressText, ' / ')
FROM Addresses
GROUP BY TownID

--HAVING AND WHERE
SELECT DepartmentID
		,SUM(Salary) AS TotalSalary
FROM Employees
WHERE DepartmentID IN(1, 5, 7, 11)
GROUP BY DepartmentID
HAVING SUM(Salary) >= 200000
ORDER BY DepartmentID

--Pivot Table
SELECT 'Average salary' AS DepartmentID,
		[1], [5], [7], [11] 
FROM 
	(SeLECT DepartmentID
			,Salary 
	FROM Employees) AS SourceTable
PIVOT
(
	AVG(Salary)
	FOR DepartmentID IN ([1], [5], [7], [11])
) AS PivotTable
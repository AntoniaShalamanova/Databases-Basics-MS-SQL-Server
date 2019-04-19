SELECT TOP(50) 
	e.EmployeeID 
	,CONCAT_WS(' ', e.FirstName, e.LastName) AS EmployeeName
	,CONCAT_WS(' ', m.FirstName, m.LastName) AS ManagerName
	,d.[Name] as DepartmentName
FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
LEFT JOIN Employees AS m ON e.ManagerID = m.EmployeeID
ORDER BY e.EmployeeID
SELECT 
	MIN(t.avgs) AS MinAverageSalary
FROM 
	(SELECT AVG(Salary) AS avgs
	FROM Employees
	GROUP BY DepartmentID) AS t

--*
SELECT TOP(1) AVG(Salary) AS MinAverageSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY MIN(Salary)
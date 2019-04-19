--13
SELECT DepartmentID
		,SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--14
SELECT DepartmentID
		,MIN(Salary) AS MinimumSalary
FROM Employees
WHERE DepartmentID IN(2, 5, 7) AND HireDate > '2000-01-01'
GROUP BY DepartmentID

--15
SELECT * INTO NewTable
FROM Employees
WHERE Salary > 30000

DELETE
FROM NewTable
WHERE ManagerID = 42

UPDATE NewTable
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentID
		,AVG(Salary) AS AverageSalary
FROM NewTable
GROUP BY DepartmentID

--16
SELECT DepartmentID
		,MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17
SELECT COUNT(*) AS [Count]
FROM Employees
WHERE ManagerID IS NULL

--18
SELECT srt.DepartmentID
		,srt.Salary
FROM
(
	SELECT DepartmentID
			,Salary
			,DENSE_RANK() 
				OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
	FROM Employees) AS srt
WHERE srt.SalaryRank = 3
GROUP BY srt.DepartmentID, srt.Salary

--19
SELECT TOP(10) FirstName
		,LastName
		,DepartmentID
FROM Employees AS T
WHERE Salary > (SELECT AVG(Salary)
				FROM Employees
				WHERE DepartmentID = T.DepartmentID)
ORDER BY DepartmentID
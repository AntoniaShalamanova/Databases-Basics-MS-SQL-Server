CREATE TABLE Deleted_Employees
(
	EmployeeId INT PRIMARY KEY IDENTITY, 
	FirstName VARCHAR(50), 
	LastName VARCHAR(50), 
	MiddleName VARCHAR(50), 
	JobTitle VARCHAR(50), 
	DepartmentId INT, 
	Salary MONEY
)
GO

CREATE TRIGGER tr_DeletedEmployees ON Employees FOR DELETE
AS
	INSERT INTO Deleted_Employees
	SELECT FirstName, LastName, MiddleName, JobTitle, DepartmentId, Salary
	FROM deleted

SELECT *
FROM Deleted_Employees

DELETE FROM EmployeesProjects
WHERE EmployeeID = 5

DELETE FROM Employees
WHERE EmployeeID = 5
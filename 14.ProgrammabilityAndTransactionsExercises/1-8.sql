--1
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000

EXEC usp_GetEmployeesSalaryAbove35000
GO

--2
CREATE PROC usp_GetEmployeesSalaryAboveNumber 
	@SalaryNumber DECIMAL(18,4)
AS
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @SalaryNumber

EXEC usp_GetEmployeesSalaryAboveNumber 48100
GO

--3
CREATE PROC usp_GetTownsStartingWith
	@String VARCHAR(MAX)
AS
	SELECT [Name] AS Town
	FROM Towns
	WHERE [Name] LIKE @String + '%'

EXEC usp_GetTownsStartingWith 'b'
GO 

--4
CREATE PROC usp_GetEmployeesFromTown 
	@InputTown VARCHAR(MAX)
AS
	SELECT e.FirstName, e.LastName
	FROM Employees AS e
	JOIN Addresses AS a ON e.AddressID = a.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	WHERE t.[Name] = @InputTown

EXEC usp_GetEmployeesFromTown  'Sofia'
GO

--6
CREATE PROC usp_EmployeesBySalaryLevel
	@Level VARCHAR(MAX)
AS
	SELECT FirstName, LastName
	FROM Employees
	WHERE  dbo.ufn_GetSalaryLevel(Salary) = @Level

EXEC usp_EmployeesBySalaryLevel 'High'
GO

--7
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX)) 
RETURNS BIT AS
BEGIN
	DECLARE @count INT = 1

	WHILE(@count <= LEN(@word))
	BEGIN
		DECLARE @currentLetter CHAR(1) = SUBSTRING(@word, @count, 1)
		DECLARE @charIndex INT = CHARINDEX(@currentLetter, @setOfLetters)

		IF(@charIndex = 0)
		BEGIN
			RETURN 0
		END

		SET @count += 1
	END

	RETURN 1
END
GO

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')
GO

--8
--ALTER TABLE Departments SET ManagerId column NULL
--DELETE FROM EmployeesProjects
--UPDATE Departments SET ManagerId = NULL
--DELETE FROM Employees WHERE DepartmentId = @id
--DELETE FROM Departments WHERE Id = @id

CREATE PROC usp_DeleteEmployeesFromDepartment
	@depId INT
AS
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL

	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN(SELECT EmployeeID 
						FROM Employees
						WHERE DepartmentID = @depId)

	UPDATE Departments
	SET ManagerID = NULL
	WHERE DepartmentID = @depId

	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN(SELECT EmployeeID
						FROM Employees
						WHERE DepartmentID = @depId)

	DELETE FROM Employees
	WHERE DepartmentID = @depId

	DELETE FROM Departments
	WHERE DepartmentID = @depId

	SELECT COUNT(*)
	FROM Employees
	WHERE DepartmentID = @depId

EXEC usp_DeleteEmployeesFromDepartment 1
GO
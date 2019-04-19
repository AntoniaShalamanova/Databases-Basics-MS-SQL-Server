CREATE PROC usp_AssignProject 
	@EmployeeId INT, @ProjectId INT
AS
	DECLARE @maxProjectsNumber INT = 3

	BEGIN TRANSACTION
		INSERT INTO EmployeesProjects(EmployeeID, ProjectID) 
		VALUES (@EmployeeId, @ProjectId)

		IF((SELECT COUNT(*) 
			FROM Employees 
			WHERE EmployeeID = @EmployeeId) = 0 OR
			(SELECT COUNT(*) 
			FROM Projects 
			WHERE ProjectID = @ProjectId) = 0)
		BEGIN
			RAISERROR('Id does not exist!', 16, 1)
			ROLLBACK
			RETURN
		END

		DECLARE @currentProjectsNumber INT = (SELECT COUNT(*) 
											FROM EmployeesProjects 
											WHERE EmployeeID = @EmployeeId)

		IF(@currentProjectsNumber > @maxProjectsNumber)
		BEGIN
			RAISERROR('The employee has too many projects!', 16, 2)
			ROLLBACK
			RETURN
		END

	COMMIT

EXEC usp_AssignProject 2, 6
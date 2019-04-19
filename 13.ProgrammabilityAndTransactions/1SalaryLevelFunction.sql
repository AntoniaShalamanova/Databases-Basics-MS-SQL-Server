 CREATE FUNCTION ufn_GetSalaryLevel(@Salary MONEY)
 RETURNS VARCHAR(10)
 AS
 BEGIN
	DECLARE @salaryLevel VARCHAR(10)

	IF(@Salary < 30000)
	BEGIN
		SET @salaryLevel = 'Low'
	END
	ELSE IF(@Salary <= 50000)
	BEGIN
		SET @salaryLevel = 'Average'
	END
	ELSE
	BEGIN
		SET @salaryLevel = 'High'
	END

	RETURN @salaryLevel
 END

 SELECT FirstName, LastName, Salary, dbo.ufn_GetSalaryLevel(Salary)
 FROM Employees
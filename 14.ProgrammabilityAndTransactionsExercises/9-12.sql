--9
CREATE PROC usp_GetHoldersFullName
AS
SELECT FirstName + ' ' + LastName AS [Full Name]
FROM AccountHolders

EXEC usp_GetHoldersFullName
GO

--10
CREATE PROC usp_GetHoldersWithBalanceHigherThan
	@number DECIMAL(18, 4)
AS
	SELECT ah.FirstName, ah.LastName
	FROM AccountHolders AS ah
	JOIN Accounts AS a ON a.AccountHolderId = ah.Id
	GROUP BY ah.Id, ah.FirstName, ah.LastName
	HAVING SUM(a.Balance) > @number
	ORDER BY ah.FirstName, ah.LastName

EXEC usp_GetHoldersWithBalanceHigherThan 534534
GO

--11
CREATE FUNCTION ufn_CalculateFutureValue(@I DECIMAL(18, 4), @R FLOAT, @T INT)
RETURNS DECIMAL(18, 4) AS
BEGIN
	DECLARE @result DECIMAL(18, 4) = @I * (POWER((1 + @R), @T))

	RETURN @result
END
GO

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO

--12
CREATE PROC usp_CalculateFutureValueForAccount
	@AccountId INT, @InterestRate FLOAT, @Years INT = 5
AS
	SELECT a.Id
		,ah.FirstName
		,ah.LastName
		,a.Balance
		,dbo.ufn_CalculateFutureValue(a.Balance, @InterestRate, @Years) AS [Balance in 5 years]
	FROM Accounts AS a
	JOIN AccountHolders AS ah ON a.AccountHolderId = ah.Id
	WHERE a.Id = @AccountId

EXEC usp_CalculateFutureValueForAccount 1, 0.1
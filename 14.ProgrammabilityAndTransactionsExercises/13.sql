CREATE FUNCTION ufn_CashInUsersGames(@GameName NVARCHAR(50))
RETURNS TABLE AS
RETURN
(
	SELECT SUM(t.Cash) AS SumCash
	FROM(
		SELECT ROW_NUMBER() OVER(ORDER BY Cash DESC) AS RowCash
				,Cash
		FROM UsersGames AS ug
		JOIN Games AS g ON ug.GameId = g.Id
		WHERE g.[Name] = @GameName) AS t
	WHERE t.RowCash % 2 <> 0				
)
GO

SELECT * 
FROM dbo.ufn_CashInUsersGames('Love in a mist')
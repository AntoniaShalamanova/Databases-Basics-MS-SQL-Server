DECLARE @StamatId INT = (SELECT Id FROM Users WHERE Username = 'Stamat')
DECLARE @GameId INT = (SELECT Id FROM Games WHERE [Name] = 'Safflower')
DECLARE @UserGameId INT = (SELECT Id FROM UsersGames WHERE UserId = @StamatId 
													   AND GameId = @GameId)

DECLARE @StamatCash DECIMAL(15,2) = (SELECT Cash FROM UsersGames WHERE Id = @UserGameId)
DECLARE @ItemsTotalPrice DECIMAL(15,2) = (SELECT SUM(Price) FROM Items WHERE MinLevel IN(11, 12))

IF(@StamatCash - @ItemsTotalPrice >= 0)
BEGIN
	BEGIN TRANSACTION
		UPDATE UsersGames
		SET Cash -= @ItemsTotalPrice
		WHERE Id = @UserGameId

		INSERT INTO UserGameItems(ItemId, UserGameId)
		SELECT Id, @UserGameId FROM Items WHERE MinLevel IN(11, 12)

	COMMIT
END

SET @StamatCash = (SELECT Cash FROM UsersGames WHERE Id = @UserGameId)
SET @ItemsTotalPrice = (SELECT SUM(Price) FROM Items WHERE MinLevel BETWEEN 19 AND 21)

IF(@StamatCash - @ItemsTotalPrice >= 0)
BEGIN
	BEGIN TRANSACTION
		UPDATE UsersGames
		SET Cash -= @ItemsTotalPrice
		WHERE Id = @UserGameId

		INSERT INTO UserGameItems(ItemId, UserGameId)
		SELECT Id, @UserGameId FROM Items WHERE MinLevel BETWEEN 19 AND 21

	COMMIT
END

SELECT i.[Name]
FROM UserGameItems ugi
JOIN Items AS i ON ugi.ItemId = i.Id
WHERE ugi.UserGameId = 110
ORDER BY i.[Name]

SELECT *
FROM UsersGames
WHERE Id = @UserGameId

SELECT *
FROM UserGameItems
WHERE UserGameId = @UserGameId
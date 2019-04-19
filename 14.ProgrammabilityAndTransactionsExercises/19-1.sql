CREATE TRIGGER tr_RestrictedItems ON UserGameItems INSTEAD OF INSERT
AS
	DECLARE @itemId INT = (SELECT ItemId FROM inserted)	
	DECLARE @userGameId INT = (SELECT UserGameId FROM inserted)

	DECLARE @itemLevel INT = (SELECT MinLevel FROM Items WHERE Id = @itemId)	
	DECLARE @userGameLevel INT = (SELECT [Level] FROM UsersGames WHERE Id = @userGameId)

	IF(@userGameLevel < @itemLevel)
	BEGIN
		ROLLBACK
		RAISERROR('Insufficient user level!', 16, 1)
		RETURN
	END

	INSERT INTO UserGameItems(ItemId, UserGameId) VALUES
	(@itemId, @userGameId)
COMMIT

SELECT * 
FROM UserGameItems
WHERE UserGameId = 38 AND ItemId = 2

INSERT INTO UserGameItems(ItemId, UserGameId) VALUES
(2, 38)

SELECT * 
FROM UserGameItems
WHERE UserGameId = 38 AND ItemId = 14

INSERT INTO UserGameItems(ItemId, UserGameId) VALUES
(14, 38)
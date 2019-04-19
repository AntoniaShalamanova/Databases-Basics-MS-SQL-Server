CREATE TRIGGER tr_InsteadOfDeletingTrip ON Trips INSTEAD OF DELETE
AS
	UPDATE Trips
	SET CancelDate = GETDATE()
	WHERE Id IN(
				SELECT Id
				FROM deleted
				WHERE CancelDate IS NULL)


DELETE FROM Trips
WHERE Id IN (48, 49, 50)

DELETE FROM Trips
WHERE Id IN (1, 2, 3, 49)
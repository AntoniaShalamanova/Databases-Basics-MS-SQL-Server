CREATE PROC usp_ChangeJourneyPurpose(@JourneyId INT, @NewPurpose VARCHAR(11))
AS
	DECLARE @id INT = (SELECT Id FROM Journeys WHERE Id = @JourneyId)

	IF(@id IS NULL)
	BEGIN 
		RAISERROR('The journey does not exist!', 16, 1)
		RETURN
	END

	DECLARE @purpose VARCHAR(11) = (SELECT Purpose FROM Journeys WHERE Id = @JourneyId)

	IF(@purpose = @NewPurpose)
	BEGIN 
		RAISERROR('You cannot change the purpose!', 16, 2)
		RETURN
	END

	UPDATE Journeys
	SET Purpose = @NewPurpose
	WHERE Id = @JourneyId

EXEC usp_ChangeJourneyPurpose 1, 'Technical'
EXEC usp_ChangeJourneyPurpose 2, 'Educational'
EXEC usp_ChangeJourneyPurpose 196, 'Technical'
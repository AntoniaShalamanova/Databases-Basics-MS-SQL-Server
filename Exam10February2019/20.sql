CREATE TABLE DeletedJourneys
(
Id INT NOT NULL, 
JourneyStart DATETIME NOT NULL, 
JourneyEnd DATETIME NOT NULL, 
Purpose VARCHAR(11), 
DestinationSpaceportId INT NOT NULL, 
SpaceshipId INT NOT NULL
)
GO

CREATE TRIGGER tr_JourneysDelete ON Journeys FOR DELETE
AS
	INSERT INTO DeletedJourneys(Id, JourneyStart, JourneyEnd, Purpose, 
				DestinationSpaceportId, SpaceshipId) 
	(SELECT Id, JourneyStart, JourneyEnd, Purpose, DestinationSpaceportId, SpaceshipId FROM deleted)

DELETE FROM TravelCards
WHERE JourneyId =  2

DELETE FROM Journeys
WHERE Id =  2

SELECT * FROM DeletedJourneys
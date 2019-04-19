CREATE FUNCTION dbo.udf_GetColonistsCount(@PlanetName VARCHAR(30))
RETURNS INT
AS
BEGIN
	DECLARE @count INT = (
						 SELECT COUNT(c.Id)
						 FROM Colonists AS c
						 JOIN TravelCards AS tc ON c.Id = tc.ColonistId
						 JOIN Journeys AS j ON j.Id = tc.JourneyId
						 JOIN Spaceports AS sp ON j.DestinationSpaceportId = sp.Id
						 JOIN Planets AS p ON sp.PlanetId = p.Id
						 WHERE p.[Name] = @PlanetName)

	RETURN @count
END
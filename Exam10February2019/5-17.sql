--5
SELECT CardNumber, JobDuringJourney
FROM TravelCards
ORDER BY CardNumber

--6
SELECT Id, 
		FirstName + ' ' + LastName AS FullName,
		Ucn
FROM Colonists
ORDER BY FirstName, LastName, Id

--7
SELECT Id,
		FORMAT(JourneyStart, 'dd/MM/yyyy'),
		FORMAT(JourneyEnd, 'dd/MM/yyyy')
FROM Journeys
WHERE Purpose = 'Military'
ORDER BY JourneyStart

--8
SELECT c.Id, 
		c.FirstName + ' ' + c.LastName AS FullName
FROM Colonists AS c
JOIN TravelCards AS tc ON c.Id = tc.ColonistId
WHERE tc.JobDuringJourney = 'Pilot'
ORDER BY c.Id

--9
SELECT COUNT(*) AS Count
FROM Colonists AS c
JOIN TravelCards AS tc ON c.Id = tc.ColonistId
JOIN Journeys AS j ON tc.JourneyId = j.Id
WHERE j.Purpose = 'Technical'

--10
SELECT TOP(1) ss.[Name] AS SpaceshipName,
				sp.[Name] AS SpaceportName
FROM Spaceships AS ss
JOIN Journeys AS j ON ss.Id = j.SpaceshipId
JOIN Spaceports AS sp ON j.DestinationSpaceportId = sp.Id
ORDER BY ss.LightSpeedRate DESC

--11
SELECT ss.[Name], ss.Manufacturer
FROM Spaceships AS ss
JOIN Journeys AS j ON ss.Id = j.SpaceshipId
JOIN TravelCards AS tc ON j.Id = tc.JourneyId
JOIN Colonists AS c ON tc.ColonistId = c.Id
WHERE DATEDIFF(YEAR, c.BirthDate, '01/01/2019') < 30 AND tc.JobDuringJourney  = 'Pilot'
GROUP BY ss.Id, ss.[Name], ss.Manufacturer
ORDER BY ss.[Name]

--12
SELECT p.[Name], sp.[Name]
FROM Planets AS p
JOIN Spaceports AS sp ON p.Id = sp.PlanetId
JOIN Journeys AS j ON sp.Id = j.DestinationSpaceportId
WHERE j.Purpose = 'Educational'
ORDER BY sp.[Name] DESC

--13
SELECT p.[Name], COUNT(*) AS JourneysCount
FROM Spaceports AS sp
JOIN Journeys AS j ON sp.Id = j.DestinationSpaceportId
JOIN Planets AS p ON sp.PlanetId = p.Id
GROUP BY p.[Name]
ORDER BY JourneysCount DESC, p.[Name]

--14
SELECT TOP(1) j.Id,
			p.[Name],
			sp.[Name],
			j.Purpose
FROM Journeys AS j
JOIN Spaceports AS sp ON j.DestinationSpaceportId = sp.Id
JOIN Planets AS p ON sp.PlanetId = p.Id
ORDER BY DATEDIFF(SECOND, j.JourneyStart, j.JourneyEnd)

--15 
SELECT TOP(1) t.JourneyId, t.Job
FROM(SELECT j.Id AS JourneyId
			,tc.JobDuringJourney AS Job
			,DATEDIFF(MINUTE, JourneyStart, JourneyEnd) AS Diff
	 FROM Journeys AS j
	 JOIN TravelCards AS tc ON j.Id = tc.JourneyId) AS t
GROUP BY t.JourneyId, t.Job, t.Diff
ORDER BY t.Diff DESC, COUNT(t.Job)

--16
SELECT 
	 t.Job,
	 t.FullName,
	 t.JobRank
FROM (SELECT tc.JobDuringJourney AS Job,
	 c.FirstName + ' ' + c.LastName AS FullName,
	DENSE_RANK() OVER(PARTITION BY tc.JobDuringJourney ORDER BY c.BirthDate) AS JobRank
	FROM Colonists AS c
	JOIN TravelCards AS tc ON c.Id = tc.ColonistId
) AS t
WHERE t.JobRank = 2

--17
SELECT p.[Name],
		CASE 
			WHEN sp.PlanetId IS NULL THEN  0
			ELSE COUNT(*)
		 END AS [Count]
FROM Planets AS p
LEFT JOIN Spaceports AS sp ON p.Id = sp.PlanetId
GROUP BY sp.PlanetId, p.[Name]
ORDER BY [Count] DESC, p.[Name]
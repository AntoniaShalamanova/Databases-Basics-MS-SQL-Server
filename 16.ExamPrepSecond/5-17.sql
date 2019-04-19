--5
SELECT Id, [Name]
FROM Cities
WHERE CountryCode = 'BG'
ORDER BY [Name]

--6
SELECT FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS [Full Name],
		YEAR(BirthDate) AS BirthYear
FROM Accounts
WHERE YEAR(BirthDate) > 1991 
ORDER BY BirthYear DESC, FirstName

--7
SELECT a.FirstName
		,a.LastName
		,FORMAT(a.BirthDate, 'MM-dd-yyyy') AS BirthDate
		,c.[Name]
		,a.Email
FROM Accounts AS a
JOIN Cities AS c ON a.CityId = c.Id
WHERE Email LIKE 'E%'
ORDER BY c.[Name] DESC

--8
SELECT c.[Name]
		,IIF(h.CityId IS NULL, 0, COUNT(*)) AS Hotels
FROM Hotels AS h
RIGHT JOIN Cities AS c ON h.CityId = c.Id
GROUP BY c.[Name], h.CityId
ORDER BY Hotels DESC, c.[Name]

--9
SELECT  r.Id
		,r.Price
		,h.[Name]
		,c.[Name]
FROM Rooms r
JOIN Hotels AS h ON r.HotelId = h.Id
JOIN Cities AS c ON h.CityId = c.Id
WHERE [Type] = 'First Class'
ORDER BY r.Price DESC, r.Id

--10
SELECT a.Id
		,FirstName + ' ' + LastName AS [Full Name]
		,MAX(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS LongestTrip
		,MIN(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS ShortestTrip
FROM Accounts AS a
JOIN AccountsTrips AS act ON a.Id = act.AccountId
JOIN Trips AS t ON act.TripId = t.Id
WHERE a.MiddleName IS NULL AND t.CancelDate IS NULL
GROUP BY a.Id, a.FirstName, a.LastName
ORDER BY LongestTrip DESC, a.Id

--11
SELECT TOP(5) c.Id
		,c.[Name]
		,c.CountryCode
		,COUNT(a.Id) AS Accounts
FROM Cities AS c
JOIN Accounts AS a ON c.Id = a.CityId
GROUP BY c.Id, c.[Name], c.CountryCode
ORDER BY COUNT(a.Id) DESC

--12
SELECT a.Id
		,a.Email
		,c.[Name]
		,COUNT(t.Id) AS Trips
FROM Accounts AS a
JOIN AccountsTrips AS act ON a.Id = act.AccountId
JOIN Trips AS t ON act.TripId = t.Id
JOIN Rooms AS r ON t.RoomId = r.Id
JOIN Hotels AS h ON r.HotelId = h.Id
JOIN Cities AS c ON h.CityId = c.Id
WHERE a.CityId = h.CityId
GROUP BY a.Id, a.Email, c.[Name]
ORDER BY Trips DESC, a.Id

--13
SELECT TOP(10) c.Id
		,c.[Name]
		,SUM(h.BaseRate) + SUM(r.Price) AS [Total Revenue]
		,COUNT(t.Id) Trips
FROM Cities AS c
JOIN Hotels AS h ON c.Id = h.CityId
JOIN Rooms AS r ON h.Id = r.HotelId
JOIN Trips AS t ON r.Id = t.RoomId
WHERE YEAR(t.BookDate) = 2016
GROUP BY c.Id, c.[Name]
ORDER BY [Total Revenue] DESC, Trips DESC

--14 X
--Find all trips’ revenue (hotel base rate + room price). If a trip is canceled, its revenue is always 0. Extract the trip’s ID, the hotel’s name, the room type and the revenue.
--Order the results by Room type, then by the Trip ID

SELECT t.Id
		,h.[Name]
		,r.[Type]
		,IIF(t.CancelDate IS NOT NULL, 0, h.BaseRate + r.Price) AS Revenue
FROM Trips AS t
JOIN Rooms AS r ON t.RoomId = r.Id
JOIN Hotels AS h ON r.HotelId = h.Id
GROUP BY t.Id, h.[Name], r.[Type], t.CancelDate, h.BaseRate, r.Price
ORDER BY r.[Type], t.Id

--15

--16

--17
SELECT t.Id AS TripId
		,a.FirstName + ' ' + ISNULL(a.MiddleName + ' ', '') + a.LastName AS [Full Name]
		,(SELECT [Name] FROM Cities WHERE Id = a.CityId) AS AccountCityId
		,(SELECT [Name] FROM Cities WHERE Id = h.CityId) AS HotelCityId
		,IIF(t.CancelDate IS NOT NULL, 'Canceled', CAST(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate) AS VARCHAR(10)) + ' days') AS Duration
FROM Accounts AS a
JOIN Cities AS c ON a.CityId = c.Id
JOIN AccountsTrips AS act ON a.Id = act.AccountId
JOIN Trips AS t ON act.TripId = t.Id
JOIN Rooms AS r ON t.RoomId = r.Id
JOIN Hotels AS h ON r.HotelId = h.Id
ORDER BY [Full Name], t.Id
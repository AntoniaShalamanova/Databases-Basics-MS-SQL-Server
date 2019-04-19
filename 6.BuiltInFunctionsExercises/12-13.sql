--12
SELECT CountryName, IsoCode
FROM Countries
WHERE CountryName LIKE '%A%A%A%'
ORDER BY IsoCode
GO

--12*
SELECT CountryName, IsoCode
FROM Countries
WHERE LEN(CountryName) - LEN(REPLACE(CountryName, 'a', '')) >= 3
ORDER BY IsoCode
GO

--13
SELECT PeakName
		,RiverName
		,LOWER(PeakName) + LOWER(SUBSTRING(RiverName, 2, LEN(RiverName) - 1)) AS Mix
FROM Peaks, Rivers
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix

--12
SELECT 
	c.CountryCode
	,m.MountainRange
	,p.PeakName
	,p.Elevation
FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
JOIN Mountains AS m ON mc.MountainId = m.Id
JOIN Peaks AS p ON m.Id = p.MountainId
WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--13
SELECT 
	c.CountryCode
	,COUNT(*) AS MountainRanges
FROM Countries AS c
JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
WHERE c.CountryCode IN('US', 'RU', 'BG')
GROUP BY c.CountryCode

--14
SELECT TOP(5)
	c.CountryName
	,r.RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName

--15
WITH CTE_MostUsedCurrency(ContinentCode, CurrencyCode, CurrencyUsage, CurrencyRank) as
(
	SELECT ContinentCode
		,CurrencyCode
		,COUNT(CurrencyCode) AS CurrencyUsage
		,DENSE_RANK() OVER (PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC) AS CurrencyRank
	FROM Countries
	GROUP BY ContinentCode, CurrencyCode
	HAVING COUNT(CurrencyCode) > 1
)

SELECT ContinentCode, CurrencyCode, CurrencyUsage
FROM CTE_MostUsedCurrency
WHERE CurrencyRank = 1
ORDER BY ContinentCode

--16
SELECT COUNT(*) AS CountryCode
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
WHERE mc.MountainId IS NULL

--17
SELECT TOP(5) 
	c.CountryName
	,MAX(p.Elevation) AS HighestPeakElevation
	,MAX(r.Length) AS LongestRiverLength
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
LEFT JOIN Peaks AS p ON m.Id = p.MountainId
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, CountryName

--18
WITH CTE_MaxElevation(Country, [Highest Peak Name], [Highest Peak Elevation], Mountain, ElevationRank) AS
(
	SELECT
		c.CountryName AS Country
		,p.PeakName AS [Highest Peak Name]
		,p.Elevation AS [Highest Peak Elevation]
		,m.MountainRange AS Mountain
		,DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS ElevationRank
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
	LEFT JOIN Peaks AS p ON m.Id = p.MountainId
	GROUP BY c.CountryName, p.PeakName, p.Elevation, m.MountainRange
)

SELECT TOP(5)
	Country
	,ISNULL([Highest Peak Name], '(no highest peak)')
	,ISNULL([Highest Peak Elevation], 0)
	,ISNULL(Mountain, '(no mountain)')
FROM CTE_MaxElevation
WHERE ElevationRank = 1
ORDER BY Country, [Highest Peak Name]
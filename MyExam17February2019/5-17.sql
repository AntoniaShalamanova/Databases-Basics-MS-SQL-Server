--5
SELECT FirstName, LastName, Age 
FROM Students
WHERE Age >= 12
ORDER BY FirstName, LastName

--6
SELECT FirstName +  ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS [Full Name],
		[Address]
FROM Students
WHERE [Address] LIKE '%road%'
ORDER BY FirstName, LastName, [Address]

--7
SELECT FirstName, [Address], Phone
FROM Students
WHERE MiddleName IS NOT NULL AND Phone LIKE '42%'
ORDER BY FirstName

--8
SELECT s.FirstName, 
		s.LastName, 
		IIF(COUNT(st.TeacherId) = 1, 0, COUNT(st.TeacherId)) 
FROM Students AS s
LEFT JOIN StudentsTeachers AS st ON s.Id = st.StudentId
GROUP BY s.Id, s.FirstName, s.LastName
ORDER BY s.LastName

--9
SELECT t.FirstName + ' ' + t.LastName AS [Full Name],
		s.[Name] + '-' + CAST(s.Lessons AS nvarchar(20)) AS Subjects,
		COUNT(st.StudentId) AS Students
FROM Teachers AS t
JOIN Subjects AS s ON t.SubjectId = s.Id
JOIN StudentsTeachers AS st ON t.Id = st.TeacherId
GROUP BY t.Id, t.FirstName, t.LastName, s.[Name], s.Lessons
ORDER BY COUNT(st.StudentId) DESC, [Full Name], Subjects

--10
SELECT s.FirstName + ' ' + s.LastName AS [Full Name]
FROM Students AS s
LEFT JOIN StudentsExams AS se ON s.Id = se.StudentId
WHERE se.ExamId IS NULL
ORDER BY [Full Name]

--11
SELECT TOP(10) t.FirstName,
		t.LastName,
		COUNT(st.StudentId) AS Students
FROM Teachers AS t
JOIN StudentsTeachers AS st ON t.Id = st.TeacherId
GROUP BY st.TeacherId, t.FirstName, t.LastName
ORDER BY Students DESC, t.FirstName, t.LastName

--12
SELECT TOP(10) s.FirstName,
		s.LastName,
		CAST(AVG(se.Grade) AS DECIMAL(15, 2)) AS Grade
FROM Students AS s
JOIN StudentsExams AS se ON s.Id = se.StudentId
GROUP BY s.Id, s.FirstName, s.LastName
ORDER BY Grade DESC, s.FirstName, s.LastName

--13
SELECT FirstName, LastName, Grade
FROM(
SELECT s.FirstName, s.LastName
		,ss.Grade
		,ROW_NUMBER() OVER (PARTITION BY s.Id ORDER BY ss.Grade DESC) AS [GradeRank]
FROM Students AS s
JOIN StudentsSubjects AS ss ON s.Id = ss.StudentId
) AS t
WHERE [GradeRank] = 2
ORDER BY FirstName, LastName

--14
SELECT s.FirstName +  ' ' + ISNULL(s.MiddleName + ' ', '') + s.LastName AS [Full Name]
FROM Students AS s
LEFT JOIN StudentsSubjects AS ss ON s.Id = ss.StudentId
WHERE ss.SubjectId IS NULL
GROUP BY s.Id, s.FirstName , s.LastName, s.MiddleName
ORDER BY [Full Name]

--15
SELECT [Teacher Full Name], 
		[Subject Name],
		[Student Full Name],
		Grade
FROM(
SELECT t.FirstName + ' ' + t.LastName AS [Teacher Full Name],
		s.[Name] AS [Subject Name],
		stud.FirstName + ' ' + stud.LastName AS [Student Full Name],
		CAST(AVG(ss.Grade) AS DECIMAL(15,2)) AS Grade,
		ROW_NUMBER() OVER (PARTITION BY t.FirstName, t.LastName, s.[Name] ORDER BY AVG(ss.Grade) DESC) AS RowGrade
FROM Subjects AS s
JOIN Teachers AS t ON s.Id = t.SubjectId
JOIN StudentsTeachers AS st ON t.Id = st.TeacherId
JOIN Students AS stud ON st.StudentId = stud.Id
JOIN StudentsSubjects AS ss ON stud.Id = ss.StudentId
WHERE ss.SubjectId = t.SubjectId
GROUP BY t.Id, t.FirstName, t.LastName, s.[Name], stud.FirstName, stud.LastName) AS t
WHERE t.RowGrade = 1
ORDER BY [Subject Name] ASC, [Teacher Full Name] ASC, Grade DESC

--16
SELECT s.[Name],
		AVG(ss.Grade) AS [AverageGrade]
FROM Subjects AS s
JOIN StudentsSubjects AS ss ON s.Id = ss.SubjectId
GROUP BY s.Id, s.[Name]
ORDER BY s.Id

--17
SELECT CASE
		WHEN DATEPART(QUARTER, e.[Date]) IS NULL THEN 'TBA'
		WHEN DATEPART(QUARTER, e.[Date]) = 1 THEN 'Q1'
		WHEN DATEPART(QUARTER, e.[Date]) = 2 THEN 'Q2'
		WHEN DATEPART(QUARTER, e.[Date]) = 3 THEN 'Q3'
		WHEN DATEPART(QUARTER, e.[Date]) = 4 THEN 'Q4'
		END AS [Quarter],
		s.[Name],
		COUNT(se.StudentId) AS StudentsCount
FROM Exams AS e
JOIN Subjects AS s ON e.SubjectId = s.Id
JOIN StudentsExams AS se ON e.Id = se.ExamId
WHERE se.Grade >= 4
GROUP BY DATEPART(QUARTER, e.[Date]), s.[Name]
ORDER BY [Quarter], s.[Name]
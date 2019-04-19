CREATE FUNCTION udf_ExamGradesToUpdate(@studentId INT, @grade DECIMAL(15,2))
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @student INT = (SELECT Id FROM Students WHERE Id = @studentId)

	IF(@student IS NULL)
	BEGIN 
		RETURN 'The student with provided id does not exist in the school!'
	END

	IF(@grade > 6)
	BEGIN 
		RETURN 'Grade cannot be above 6.00!'
	END

	DECLARE @count INT = (SELECT COUNT(*)
							FROM StudentsExams 
							WHERE StudentId = @student AND Grade BETWEEN @grade AND @grade + 0.5)

	DECLARE @studentName VARCHAR(30) = (SELECT FirstName FROM Students WHERE Id = @student)

	RETURN 'You have to update ' + CAST(@count AS varchar(20)) + ' grades for the student ' + @studentName
END

SELECT dbo.udf_ExamGradesToUpdate(12, 6.20)
SELECT dbo.udf_ExamGradesToUpdate(121, 5.50)
SELECT dbo.udf_ExamGradesToUpdate(12, 5.50)
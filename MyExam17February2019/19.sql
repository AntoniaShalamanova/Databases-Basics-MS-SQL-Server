CREATE PROC usp_ExcludeFromSchool(@StudentId INT)
AS
BEGIN TRANSACTION
	DECLARE @student INT = (SELECT Id FROM Students WHERE Id = @StudentId)

	IF(@student IS NULL)
	BEGIN
		RAISERROR('This school has no student with the provided id!', 16, 1)
		RETURN
	END

	DELETE FROM StudentsExams
	WHERE StudentId = @student

	DELETE FROM StudentsSubjects
	WHERE StudentId = @student
	
	DELETE FROM StudentsTeachers
	WHERE StudentId = @student

	DELETE FROM Students
	WHERE Id = @student
COMMIT

EXEC usp_ExcludeFromSchool 1
SELECT COUNT(*) FROM Students

EXEC usp_ExcludeFromSchool 301

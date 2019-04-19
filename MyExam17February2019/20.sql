CREATE TABLE ExcludedStudents
(
	StudentId INT, 
	StudentName NVARCHAR(30)
)
GO

CREATE TRIGGER tr_DeletedStudents ON Students FOR DELETE
AS
	INSERT INTO ExcludedStudents
	SELECT Id, FirstName + ' ' + LastName FROM deleted


DELETE FROM StudentsExams
WHERE StudentId = 1

DELETE FROM StudentsTeachers
WHERE StudentId = 1

DELETE FROM StudentsSubjects
WHERE StudentId = 1

DELETE FROM Students
WHERE Id = 1

SELECT * FROM ExcludedStudents

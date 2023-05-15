--CREATE FUNCTION FullName
--(
--@firstName VARCHAR(255),
--@lastName VARCHAR(255)
--)
--RETURNS VARCHAR(510)
--AS
--BEGIN
-- RETURN (@firstName + ' ' + @lastName)
--END;

--SELECT dbo.FullName('Gizem','Ustahüseyin');

--DECLARE @FullName VARCHAR(255)
--SET @FullName = dbo.FullName('Gizem','Ustahüseyin')
--PRINT @FullName;

--CREATE FUNCTION CompletedSemesters
--(
--@registerYear INT,
--@currentYear INT
--)
--RETURNS INT
--AS
--BEGIN
-- RETURN ((@currentYear - @registerYear) * 2)
--END;

--SELECT dbo.CompletedSemesters(2016, 2022)

--DECLARE @regY INT
--SET @regY = (SELECT registerYear FROM Student WHERE StudentID = 1)
--SELECT dbo.CompletedSemesters(@regY, 2022)

--ALTER FUNCTION CalculateStudentPerformance
--(
--@studentID INT,
--@currentYear INT
--)
--RETURNS VARCHAR(255)
--AS
--BEGIN
-- DECLARE @completedSemesters INT;
-- DECLARE @gpa DECIMAL(3,2);
-- DECLARE @performance VARCHAR(255);
-- SELECT @completedSemesters=dbo.CompletedSemesters(RegisterYear, @currentYear), @gpa = GPA
-- FROM Student
-- WHERE StudentID = @studentID;
-- IF (@completedSemesters >= 8 AND @gpa >= 3.5)
-- SET @performance = 'Çok Ýyi';
-- ELSE IF (@completedSemesters >= 6 AND @gpa >= 3.0)
-- SET @performance = 'Ýyi';
-- ELSE IF (@completedSemesters >= 4 AND @gpa >= 2.5)
-- SET @performance = 'Orta';
-- ELSE
-- SET @performance = 'Vasat';
-- RETURN @performance
--END;

--select dbo.CalculateStudentPerformance(1,2023)
 
--CREATE TRIGGER ResitKontrol
--ON Student
--INSTEAD OF INSERT 
--AS
--BEGIN
--DECLARE @age INT;
--SELECT @age = AGE FROM inserted
--IF(@age <18)
--BEGIN
--RAISERROR('18 Yaþýndan küçük öðrenciler kayýt olamaz!',16,1);
--ROLLBACK TRANSACTION
--END
--ELSE
--BEGIN
--INSERT INTO Student (StudentID, FirstName, LastName, Age, GPA, Semester,
--Department, RegisterYear)
-- SELECT StudentID, FirstName, LastName, Age, GPA, Semester, Department,
--RegisterYear
--FROM inserted
--END
--END


--INSERT INTO Student (StudentID, FirstName, LastName, Age, GPA, Semester,
--Department, RegisterYear)
--VALUES (1, 'John', 'Doe', 16, 3.5, 2, 'Computer Science', 2022)

CREATE TRIGGER UpdateProcess

ON Student
AFTER UPDATE
AS
BEGIN
DECLARE @studentID INT;
DECLARE @semester INT;

SELECT @studentID = StudentID, @semester = Semester
FROM inserted;

IF (@semester = 0)
BEGIN

UPDATE Student
SET GPA = 0, TotalECTS = 0
WHERE StudentID = @studentID;
END
ENDUPDATE Student
SET Semester = 0
WHERE StudentID = 3
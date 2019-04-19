CREATE DATABASE SoftUni

CREATE TABLE Towns(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(20) NOT NULL
)

CREATE TABLE Addresses(
Id INT PRIMARY KEY IDENTITY,
AddressText VARCHAR(20) NOT NULL,
TownId INT FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(50) NOT NULL,
)

CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY,
FirstName VARCHAR(30),
MiddleName VARCHAR(30),
LastName VARCHAR(30),
JobTitle VARCHAR(30) NOT NULL,
DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
HireDate DATETIME NOT NULL,
Salary DECIMAL(15,2) NOT NULL,
AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

INSERT INTO Towns(Name) VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments(Name) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Employees(FirstName, JobTitle, DepartmentId, HireDate, Salary) 
VALUES
('Ivan Ivanov Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar Petrov Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria Petrova Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi Teziev Ivanov', 'CEO Sales', 2, '2007-12-09', 3000.00),
('Peter Pan Pan', 'Intern', 3, '2016-08-28', 599.88)

SELECT Name FROM Towns
ORDER BY Name

SELECT Name FROM Departments
ORDER BY Name

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

UPDATE Employees
SET Salary += Salary * 0.1
SELECT Salary FROM Employees
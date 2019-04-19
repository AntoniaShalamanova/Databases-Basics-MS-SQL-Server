CREATE DATABASE TableRelations

USE TableRelations

CREATE TABLE Persons
(
	PersonID INT PRIMARY KEY IDENTITY,	
	FirstName VARCHAR(15) NOT NULL,	
	Salary DECIMAL(15, 2),	
	PassportID CHAR(3) NOT NULL
)

CREATE TABLE Passports
(
	PassportID CHAR(3) PRIMARY KEY,	
	PassportNumber CHAR(8) NOT NULL
)

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_Passports 
	FOREIGN KEY(PassportID)
	REFERENCES Passports(PassportID)

ALTER TABLE Persons
ADD UNIQUE (PassportID)

ALTER TABLE Passports
ADD UNIQUE (PassportNumber)

INSERT INTO Passports VALUES
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2')

INSERT INTO Persons (FirstName, Salary, PassportID) VALUES
('Roberto', 43300.00, '102'),
('Tom', 56100.00, '103'),
('Yana', 60200.00, '101')
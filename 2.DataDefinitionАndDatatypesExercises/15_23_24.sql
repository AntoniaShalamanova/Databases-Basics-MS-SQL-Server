CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY, 
FirstName VARCHAR(20) NOT NULL, 
LastName VARCHAR(20) NOT NULL, 
Title VARCHAR(30), 
Notes VARCHAR(80)
)

INSERT INTO Employees(FirstName, LastName, Title, Notes) VALUES
('Ivan', 'Ivanov', NULL, NULL),
('Petar', 'Petrov', 'efwffw', NULL),
('Maria', 'Koleva', NULL, 'FWEFFERFE')

CREATE TABLE Customers(
AccountNumber INT PRIMARY KEY IDENTITY, 
FirstName VARCHAR(20) NOT NULL, 
LastName VARCHAR(20) NOT NULL, 
PhoneNumber CHAR(10) NOT NULL, 
EmergencyName VARCHAR(20), 
EmergencyNumber CHAR(10),
Notes VARCHAR(80)
)

INSERT INTO Customers(FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) VALUES
('Ivan', 'Ivanov', '0874276543', 'HGFDSX', NULL, 'HJTYHGFV'),
('Petar', 'Petrov', '0877765492', NULL, NULL, NULL),
('Maria', 'Koleva', '0877385987', 'FWEFFERFE', '0785987396', NULL)

CREATE TABLE RoomStatus(
RoomStatus VARCHAR(10) PRIMARY KEY, 
Notes VARCHAR(80)
)

INSERT INTO RoomStatus(RoomStatus, Notes) VALUES
('hgff', 'Ivanov'),
('kyujh', NULL),
('vvvv', 'Koleva')

CREATE TABLE RoomTypes(
RoomType VARCHAR(20) PRIMARY KEY, 
Notes VARCHAR(80)
)

INSERT INTO RoomTypes(RoomType, Notes) VALUES
('SMALL', 'Ivanov'),
('MEDIUM', NULL),
('LARGE', 'Koleva')

CREATE TABLE BedTypes(
BedType VARCHAR(20) PRIMARY KEY, 
Notes VARCHAR(80)
)

INSERT INTO BedTypes(BedType, Notes) VALUES
('SMALL', 'Ivanov'),
('MEDIUM', NULL),
('LARGE', 'Koleva')

CREATE TABLE Rooms(
RoomNumber INT PRIMARY KEY IDENTITY, 
RoomType VARCHAR(20) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL, 
BedType VARCHAR(20) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL, 
Rate SMALLINT, 
RoomStatus VARCHAR(10), 
Notes VARCHAR(80)
)

INSERT INTO Rooms(RoomType, BedType, Rate, RoomStatus, Notes) VALUES
('LARGE', 'SMALL', 65, 'HGFDSX', NULL),
('MEDIUM', 'LARGE', 100, 'HYJTYT', NULL),
('SMALL', 'MEDIUM', NULL, 'BCBCBC', '0785987396')

CREATE TABLE Payments(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
PaymentDate DATE NOT NULL,
AccountNumber VARCHAR(10) NOT NULL, 
FirstDateOccupied DATE NOT NULL, 
LastDateOccupied DATE NOT NULL, 
TotalDays INT NOT NULL, 
AmountCharged DECIMAL(15,2) NOT NULL, 
TaxRate DECIMAL(15,2) NOT NULL, 
TaxAmount DECIMAL(15,2) NOT NULL, 
PaymentTotal DECIMAL(15,2) NOT NULL, 
Notes VARCHAR(80)
)

INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal) VALUES
(2, '2013-05-30', '65756675', '2013-05-30', '2013-06-05', 5, 543.65, 65.65, 876.65, 543.65),
(3, '2014-06-09', '87654365', '2014-06-09', '2014-06-19', 10, 543.98, 7567.65, 4353.65, 756.00),
(1, '2015-07-23', '64575432', '2015-07-23', '2015-07-30', 7, 43.00, 766.65, 64.65, 645.65)

CREATE TABLE Occupancies(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
DateOccupied DATE NOT NULL, 
AccountNumber VARCHAR(10) NOT NULL, 
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL, 
RateApplied varchar(3), 
PhoneCharge varchar(3) NOT NULL, 
Notes VARCHAR(80)
)

INSERT INTO Occupancies(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge) VALUES
(2, '2013-05-30', '65756675', 3, NULL, 'YES'),
(3, '2014-06-09', '87654365', 2, NULL, 'NO'),
(1, '2015-07-23', '64575432', 1, NULL, 'YES')

UPDATE Payments
SET TaxRate -= TaxRate * 0.03
SELECT TaxRate FROM Payments

TRUNCATE TABLE Occupancies
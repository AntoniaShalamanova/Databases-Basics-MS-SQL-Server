CREATE DATABASE CarRental

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY, 
CategoryName VARCHAR(20) NOT NULL, 
DailyRate DECIMAL(15, 2), 
WeeklyRate DECIMAL(15, 2), 
MonthlyRate DECIMAL(15, 2), 
WeekendRate DECIMAL(15, 2)
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) VALUES
('GFD', 43.5, 34, 54.86, 765),
('JHF', NULL, 34, 56.7, 543.9),
('LKJ', 43.5, 76, 65, NULL)

CREATE TABLE Cars(
Id INT PRIMARY KEY IDENTITY,
PlateNumber VARCHAR(20) NOT NULL,
Manufacturer VARCHAR(20) NOT NULL, 
Model VARCHAR(20) NOT NULL, 
CarYear CHAR(4) NOT NULL, 
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL, 
Doors SMALLINT NOT NULL,
Picture VARBINARY(MAX),
Condition VARCHAR(20),
Available VARCHAR(3) CHECK (Available = 'NO' OR Available = 'YES') NOT NULL
)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) VALUES
('64564645', 'IUUYI', 'Renault', '2010', 3, 2, NULL, NULL, 'NO'),
('88567654', 'UTUTU', 'Hyundai', '1999', 1, 2, NULL, NULL, 'YES'),
('64564646', 'JGHHG', 'BMW', '2015', 2, 2, NULL, NULL, 'YES')

CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY, 
FirstName VARCHAR(20) NOT NULL, 
LastName VARCHAR(20) NOT NULL, 
Title VARCHAR(20), 
Notes VARCHAR(80), 
)

INSERT INTO Employees(FirstName, LastName, Title, Notes) VALUES
('Ivan', 'Stamov', 'hegfd', NULL),
('Sonia', 'Kaloianova', NULL, 'gsfdc'),
('Misho', 'Kolev', NULL, 'fcdsxz')

CREATE TABLE Customers(
Id INT PRIMARY KEY IDENTITY,
DriverLicenceNumber VARCHAR(20) NOT NULL, 
FullName VARCHAR(30) NOT NULL, 
[Address] VARCHAR(40) NOT NULL, 
City VARCHAR(20) NOT NULL, 
ZIPCode VARCHAR(10) NOT NULL,
Notes VARCHAR(80), 
)

INSERT INTO Customers(DriverLicenceNumber, FullName, [Address], City, ZIPCode, Notes) VALUES
('646363', 'Damian Valchev', 'hytjytt', 'Sofia', '65433', NULL),
('667656', 'Irina Cenova', 'jtykyjh', 'Plovdiv', '90000', NULL),
('989876', 'Plamen Ivanov', 'ktyggggr', 'Ruse', '74332', NULL)

CREATE TABLE RentalOrders(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
TankLevel DECIMAL(15, 2) NOT NULL,
KilometrageStart DECIMAL(15, 2) NOT NULL,
KilometrageEnd DECIMAL(15, 2) NOT NULL,
TotalKilometrage DECIMAL(15, 2) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalDays INT NOT NULL,
RateApplied VARCHAR(20),
TaxRate VARCHAR(20),
OrderStatus VARCHAR(20),
Notes VARCHAR(80)
)

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes) 
VALUES
(1, 2, 3, 64.64, 365.20, 76577.20, 86446.76, '2013-08-06', '2013-08-26', 10, NULL, NULL, NULL, NULL),
(2, 3, 1, 65.80, 856.00, 36645.20, 86767.54, '2017-01-08', '2017-01-18', 10, NULL, NULL, NULL, NULL),
(3, 1, 2, 87.98, 854.65, 76555.20, 98643.98, '2009-12-24', '2009-12-30', 6, NULL, NULL, NULL, NULL)
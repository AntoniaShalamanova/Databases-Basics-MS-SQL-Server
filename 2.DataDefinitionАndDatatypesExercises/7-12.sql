CREATE DATABASE People

CREATE TABLE People
(
Id INT IDENTITY(1, 1),
[Name] NVARCHAR(200) NOT NULL,
Picture VARBINARY(MAX) NULL,
Height DECIMAL(38,2) NULL,
[Weight] DECIMAL(38,2) NULL,
Gender CHAR(1) NOT NULL,
Birthdate DATE NOT NULL,
Biography NTEXT NULL
)

ALTER TABLE People
ADD CONSTRAINT PK_PersonId
PRIMARY KEY (Id)

ALTER TABLE People
ADD CONSTRAINT CH_Gender
CHECK (Gender = 'f' OR Gender = 'm')

INSERT INTO People([Name], Picture, Height, [Weight], Gender, Birthdate, Biography) VALUES
('Pesho', NULL, 1.80, 1.3, 'm', '1998-05-30', 'fweeee'),
('Misho', NULL, 1.5, 0.64, 'm', '1995-07-14', 'g5 b4trve'),
('Gosho', NULL, 1.85, 0.5989, 'm', '1989-06-12', NULL),
('Mara', NULL, 1.65, 2.79, 'f', '2000-01-05', 'kyuj'),
('Pena', NULL, 1.65, 0.43, 'f', '1990-03-13', 'FGRG')

CREATE TABLE Users
(
Id BIGINT IDENTITY(1, 1),
[Username] VARCHAR(30) NOT NULL UNIQUE,
[Password] VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(MAX) NULL,
LastLoginTime DATETIME NULL,
IsDeleted VARCHAR(5) NULL
)

ALTER TABLE Users
ADD CONSTRAINT PK_UserId
PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT CH_PictureSize
CHECK (DATALENGTH(ProfilePicture) <= 900000)

ALTER TABLE Users
ADD CONSTRAINT CH_IsDeleted
CHECK (IsDeleted = 'true' OR IsDeleted = 'false')

TRUNCATE TABLE Users

INSERT INTO Users([Username], [Password], ProfilePicture, LastLoginTime, IsDeleted) VALUES
('Pesho', 'fdsfsdf', NULL, '1998-05-30 12:43:10', 'true'),
('Misho', 'fwefefwe', NULL, '1995-07-14 12:43:10', 'false'),
('Gosho', 'fwefT', NULL, '1989-06-12 12:43:10', 'true'),
('Mara', 'fwefwfef', NULL, '2000-01-05 12:43:10', 'false'),
('Pena', 'fefYH', NULL, '2000-01-05 12:43:10', 'true')

ALTER TABLE Users
DROP CONSTRAINT PK_UserId

ALTER TABLE Users
ADD CONSTRAINT PK_IdUsername
PRIMARY KEY (Id, [Username])

ALTER TABLE Users
ADD CONSTRAINT CH_Password
CHECK (LEN([Password]) >= 5)

ALTER TABLE Users
ADD CONSTRAINT DF_LastLogin
DEFAULT(GETDATE()) FOR LastLoginTime

ALTER TABLE Users
DROP PK_IdUsername

ALTER TABLE Users
ADD CONSTRAINT PK_UserId
PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT CH_Username
CHECK (LEN(Username) > 3)
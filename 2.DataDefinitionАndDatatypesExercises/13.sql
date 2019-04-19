CREATE DATABASE Movies

CREATE TABLE Directors(
Id INT PRIMARY KEY IDENTITY, 
DirectorName VARCHAR(30) NOT NULL, 
Notes VARCHAR(80)
)

INSERT INTO Directors(DirectorName, Notes) VALUES
('Ivan', 'THRFDV'),
('Maria', 'htygfbb'),
('Pesho', NULL),
('Stamat', 'RHYRBGDFVC'),
('Kalin', NULL)

CREATE TABLE Genres(
Id INT PRIMARY KEY IDENTITY, 
GenreName VARCHAR(30) NOT NULL, 
Notes VARCHAR(80)
)

INSERT INTO Genres(GenreName, Notes) VALUES
('Action', 'MJJK,J'),
('Adventure', 'FGGRTY'),
('Comedy', NULL),
('Crime', 'KYUJ'),
('Drama', NULL)

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY, 
CategoryName VARCHAR(30) NOT NULL, 
Notes VARCHAR(80)
)

INSERT INTO Categories(CategoryName, Notes) VALUES
('Horror comedy', 'loikmuk'),
('Thrillers', 'ghbv'),
('Experimental film', NULL),
('Abstract animation', 'mghvb'),
('Magic realism', NULL)

--UPDATE Categories
--SET CategoryName = 'Magic realism'
--WHERE Id = 5

CREATE TABLE Movies(
Id INT PRIMARY KEY IDENTITY, 
Title VARCHAR(30) NOT NULL, 
DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
CopyrightYear CHAR(4) NOT NULL,
[Length] TIME NOT NULL,
GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Rating SMALLINT NOT NULL,
Notes VARCHAR(80)
)

INSERT INTO Movies(Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes) VALUES
('Avengers: Infinity War', 2, '2018', '01:54:08', 2, 5, 190, NULL),
('Bohemian Rhapsody', 4, '2017', '01:23:28', 2, 1, 23, NULL),
('Deadpool 2', 5, '2015', '02:03:08', 4, 2, 43, 'GSDCZX'),
('Fantastic Beasts', 3, '2013', '01:18:00', 5, 4, 543, NULL),
('Venom', 1, '1997', '02:57:08', 3, 3, 76, NULL)
CREATE TABLE Logs
(
LogId INT PRIMARY KEY IDENTITY, 
AccountId INT NOT NULL FOREIGN KEY REFERENCES Accounts(Id), 
OldSum MONEY NOT NULL, 
NewSum MONEY NOT NULL
)
GO

CREATE TRIGGER tr_BalanceUpdate ON Accounts FOR UPDATE
AS
	DECLARE @id	INT = (SELECT Id FROM deleted)
	DECLARE @oldSum DECIMAL(15,2) = (SELECT Balance FROM deleted)
	DECLARE @newSum DECIMAL(15,2) = (SELECT Balance FROM inserted)

	INSERT INTO Logs(AccountId, OldSum, NewSum) VALUES
	(@id, @oldSum, @newSum)
GO

UPDATE Accounts
SET Balance = 859
WHERE Id = 2
GO

SELECT * 
FROM Logs
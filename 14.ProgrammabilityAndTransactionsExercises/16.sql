CREATE PROC usp_DepositMoney(@AccountId INT, @MoneyAmount DECIMAL(15, 4)) 
AS
BEGIN TRANSACTION
	DECLARE @account INT = (SELECT Id FROM Accounts WHERE Id = @AccountId)

	IF(@account IS NULL)
	BEGIN
		ROLLBACK
		RAISERROR('Invalid account!', 16, 1)
		RETURN
	END

	IF(@MoneyAmount < 0)
	BEGIN
		ROLLBACK
		RAISERROR('Negative amount!', 16, 2)
		RETURN
	END

	UPDATE Accounts
	SET Balance += @MoneyAmount
	WHERE Id  = @AccountId

COMMIT

EXEC usp_DepositMoney 1, 10

SELECT * FROM Accounts
SELECT * FROM Logs
SELECT * FROM NotificationEmails

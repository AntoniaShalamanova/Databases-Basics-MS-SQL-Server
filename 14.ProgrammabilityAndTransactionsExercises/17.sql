CREATE PROC usp_WithdrawMoney(@AccountId INT, @MoneyAmount DECIMAL(15, 4)) 
AS
BEGIN TRANSACTION
	DECLARE @account INT = (SELECT Id FROM Accounts WHERE Id = @AccountId)
	DECLARE @accountBalance DECIMAL(15,4) = (SELECT Balance FROM Accounts WHERE Id = @AccountId)

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

	IF(@accountBalance - @MoneyAmount < 0)
	BEGIN
		ROLLBACK
		RAISERROR('Insufficient funds!', 16, 3)
		RETURN
	END

	UPDATE Accounts
	SET Balance -= @MoneyAmount
	WHERE Id  = @AccountId

COMMIT

EXEC usp_WithdrawMoney 1, 10

SELECT * FROM Accounts
SELECT * FROM Logs
SELECT * FROM NotificationEmails
CREATE PROC usp_WithdrawMoney 
	@AccountId INT, @MoneyAmount MONEY
AS
	BEGIN TRANSACTION
		UPDATE Accounts 
		SET Balance -= @MoneyAmount
		WHERE Id = @AccountId

		IF(@@ROWCOUNT <> 1)
		BEGIN
			RAISERROR('Invalid account!', 16, 1)
			ROLLBACK
			RETURN
		END

	COMMIT

SELECT *
FROM Accounts
WHERE Id = 1

EXEC usp_WithdrawMoney 1, 10
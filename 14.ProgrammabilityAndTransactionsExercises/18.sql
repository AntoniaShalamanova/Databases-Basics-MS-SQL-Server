CREATE PROC usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount DECIMAL(15,2))
AS
BEGIN TRANSACTION
	EXEC usp_WithdrawMoney @SenderId, @Amount
	
	EXEC usp_DepositMoney @ReceiverId, @Amount
COMMIT

EXEC usp_TransferMoney 1, 2, 144

SELECT * FROM Accounts WHERE Id IN(1, 2)
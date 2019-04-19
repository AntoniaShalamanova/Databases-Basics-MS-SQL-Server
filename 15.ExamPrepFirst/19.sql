CREATE PROC usp_CancelOrder(@InputOrderId INT, @CancelDate DATETIME)
AS
	DECLARE @orderId INT = (SELECT Id FROM Orders WHERE Id = @InputOrderId)

	IF(@orderId IS NULL)
	BEGIN
		RAISERROR('The order does not exist!', 16, 1)
		RETURN
	END

	DECLARE @orderDate DATETIME = (SELECT [DateTime] FROM Orders WHERE Id = @InputOrderId)

	IF(@CancelDate > @orderDate AND DATEDIFF(DAY, @orderDate, @CancelDate) > 3)
	BEGIN
		RAISERROR('You cannot cancel the order!', 16, 2)
		RETURN
	END

	DELETE FROM OrderItems
	WHERE OrderId = @orderId

	DELETE FROM Orders
	WHERE Id = @orderId
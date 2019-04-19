CREATE TABLE DeletedOrders
(
	OrderId INT, 
	ItemId INT, 
	ItemQuantity INT
)
GO

CREATE TRIGGER tr_DeleteOrders ON OrderItems FOR DELETE
AS
	INSERT INTO DeletedOrders
	SELECT OrderId, ItemId, Quantity FROM deleted


DELETE FROM OrderItems
WHERE OrderId = 5

DELETE FROM Orders
WHERE Id = 5 
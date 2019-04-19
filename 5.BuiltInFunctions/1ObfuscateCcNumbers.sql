CREATE VIEW v_PublicPaymentInfo AS
	SELECT CustomerID
			,FirstName
			,LastName
			,LEFT(PaymentNumber, 6) + REPLICATE('*', 10) AS [PaymentNumber]
	FROM Customers
GO

SELECT * FROM v_PublicPaymentInfo
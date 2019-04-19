CREATE FUNCTION udf_GetPromotedProducts(@CurrentDate DATE, 
	@StartDate DATE, @EndDate DATE, @Discount DECIMAL(15, 2), 
	@FirstItemId INT, @SecondItemId INT, @ThirdItemId INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @firstItemName NVARCHAR(30) = (SELECT [Name] FROM Items WHERE Id = @FirstItemId)
	DECLARE @secondItemName NVARCHAR(30) = (SELECT [Name] FROM Items WHERE Id = @SecondItemId)
	DECLARE @thirdItemName NVARCHAR(30) = (SELECT [Name] FROM Items WHERE Id = @ThirdItemId)

	IF(@firstItemName IS NULL OR @secondItemName IS NULL OR @thirdItemName IS NULL)
	BEGIN
		RETURN('One of the items does not exists!')
	END

	IF(@CurrentDate NOT BETWEEN @StartDate AND @EndDate)
	BEGIN
		RETURN('The current date is not within the promotion dates!')
	END

	DECLARE @firstItemPrice DECIMAL(15, 2) = (SELECT Price FROM Items WHERE Id = @FirstItemId)
	DECLARE @secondItemPrice DECIMAL(15, 2) = (SELECT Price FROM Items WHERE Id = @SecondItemId)
	DECLARE @thirdItemPrice DECIMAL(15, 2) = (SELECT Price FROM Items WHERE Id = @ThirdItemId)

	DECLARE @firstItemDiscount DECIMAL(15, 2) = @firstItemPrice - (@firstItemPrice * @Discount / 100) 
	DECLARE @secondItemDiscount DECIMAL(15, 2) = @secondItemPrice - (@secondItemPrice * @Discount / 100) 
	DECLARE @thirdItemDiscount DECIMAL(15, 2) = @thirdItemPrice - (@thirdItemPrice * @Discount / 100) 

	DECLARE @result NVARCHAR(MAX) = @firstItemName + ' price: ' + CAST(@firstItemDiscount AS VARCHAR(10)) + ' <-> ' +
									@secondItemName + ' price: ' + CAST(@secondItemDiscount AS VARCHAR(10)) + ' <-> ' + 
									@thirdItemName + ' price: ' + CAST(@thirdItemDiscount AS VARCHAR(10))

	RETURN @result
END
GO

SELECT dbo.udf_GetPromotedProducts('2018-08-02', '2018-08-01', '2018-08-03',13, 3,4,5)
SELECT dbo.udf_GetPromotedProducts('2018-08-01', '2018-08-02', '2018-08-03',13,5432433 ,4,5)
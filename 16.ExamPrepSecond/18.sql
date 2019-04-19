CREATE FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATE, @People INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @Room INT = (SELECT TOP(1) rid.RoomId
						FROM(
						SELECT r.Id AS RoomId
								,r.Price AS RoomPrice
						FROM Rooms AS r
						JOIN Trips AS t ON r.Id = t.RoomId
						WHERE HotelId = @HotelId 
								AND Beds > @People
								AND (@Date NOT BETWEEN t.ArrivalDate AND t.ReturnDate)
								AND t.CancelDate IS NULL
						) AS rid
						ORDER BY rid.RoomPrice DESC)

	IF(@Room IS NULL)
	BEGIN
		RETURN 'No rooms available'
	END
	
	DECLARE @RoomId VARCHAR(20) = CAST(@Room AS VARCHAR(20))
	DECLARE @RoomType VARCHAR(20) = (SELECT [Type] FROM Rooms WHERE Id = @Room)
	DECLARE @RoomBeds VARCHAR(20) = CAST((SELECT Beds FROM Rooms WHERE Id = @Room) AS VARCHAR(20))
	DECLARE @HotelBaseRate DECIMAL(15, 2) = (SELECT BaseRate FROM Hotels WHERE Id = @HotelId)
	DECLARE @RoomPrice DECIMAL(15, 2) = (SELECT Price FROM Rooms WHERE Id = @Room)
	DECLARE @TotalPrice VARCHAR(20) = CAST((@HotelBaseRate + @RoomPrice) * @People AS VARCHAR(20))

	RETURN 'Room ' + @RoomId + ': ' + @RoomType + ' (' + @RoomBeds + ' beds) - $' + @TotalPrice
END
GO

SELECT dbo.udf_GetAvailableRoom(112, '2011-12-17', 2)
SELECT dbo.udf_GetAvailableRoom(94, '2015-07-26', 3)
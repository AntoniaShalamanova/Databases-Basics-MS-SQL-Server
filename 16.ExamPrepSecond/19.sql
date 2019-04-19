CREATE PROC usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS
BEGIN TRANSACTION
	DECLARE @TargetRoomHotelID INT = (SELECT HotelId FROM Rooms WHERE Id = @TargetRoomId)
	DECLARE @TripHotelID INT = (SELECT r.HotelId 
								FROM Rooms AS r
								JOIN Trips AS t ON r.Id = t.RoomId 
								WHERE t.Id = @TripId)

	IF(@TargetRoomHotelID <> @TripHotelID)
	BEGIN
		RAISERROR('Target room is in another hotel!', 16, 1)
		RETURN
	END

	DECLARE @TargetRoomBeds INT = (SELECT Beds FROM Rooms WHERE Id = @TargetRoomId)
	DECLARE @TripAccounts INT = (SELECT COUNT(AccountId) 
								FROM AccountsTrips
								WHERE TripId = @TripId)

	IF(@TargetRoomBeds < @TripAccounts)
	BEGIN
		RAISERROR('Not enough beds in target room!', 16, 2)
		RETURN
	END

	UPDATE Trips
	SET RoomId = @TargetRoomId
	WHERE Id = @TripId
COMMIT

EXEC usp_SwitchRoom 10, 11
SELECT RoomId FROM Trips WHERE Id = 10

EXEC usp_SwitchRoom 10, 7

EXEC usp_SwitchRoom 10, 8
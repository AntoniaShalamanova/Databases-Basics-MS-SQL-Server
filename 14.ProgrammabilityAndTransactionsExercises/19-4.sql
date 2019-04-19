SELECT u.Username, g.[Name], ug.Cash, i.[Name]
FROM Users AS u
JOIN UsersGames AS ug ON u.Id = ug.UserId
JOIN Games AS g ON ug.GameId = g.Id
JOIN UserGameItems AS ugi ON ug.Id = ugi.UserGameId
JOIN Items AS i ON ugi.ItemId = i.Id
WHERE g.[Name] = 'Bali'
ORDER BY u.Username, i.[Name]
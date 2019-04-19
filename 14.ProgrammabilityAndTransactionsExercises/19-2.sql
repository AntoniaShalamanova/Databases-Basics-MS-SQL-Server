SELECT u.Username, ug.Cash, g.Id
FROM Users AS u
JOIN UsersGames AS ug ON u.Id = ug.UserId
JOIN Games AS g ON ug.GameId = g.Id
WHERE g.Id IN (SELECT Id FROM Games WHERE [Name] = 'Bali') AND 
	  u.Id IN (SELECT Id FROM Users WHERE Username IN 
	  ('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos'))

UPDATE UsersGames
SET Cash += 50000 
WHERE GameId IN (SELECT Id FROM Games WHERE [Name] = 'Bali') AND 
	  UserId IN (SELECT Id FROM Users WHERE Username IN 
	  ('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid', 'monoxidecos'))
SELECT CEILING(
		CAST(
		CEILING(
		CAST(Quantity AS FLOAT) / BoxCapacity) AS FLOAT) / PalletCapacity) 
		AS [Number of pallets]
FROM Products
/* 14.3 Open Requests */

UPDATE Requests
SET Status = 'Closed'
WHERE Requests.AptID IN 
(
	SELECT Apartments.AptID 
	FROM Apartments INNER JOIN Buildings ON Apartments.BuildingID = Buildings.BuildingID 
	WHERE Buildings.BuildingName = 'Building #11'
);
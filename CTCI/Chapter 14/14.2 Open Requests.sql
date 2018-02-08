/* 14.1 Open Requests */

SELECT Buildings.BuildingID, Buildings.BuildingName, count(Requests.RequestID) as Count
FROM Buildings LEFT JOIN Apartments ON Buildings.BuildingID = Apartments.BuildingID
LEFT JOIN Requests ON Apartments.AptID = Requests.AptID
GROUP BY Buildings.BuildingID;
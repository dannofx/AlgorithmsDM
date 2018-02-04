/* 14.1 Multiple apartments */

SELECT Tenants.TenantID, Tenants.TenantName, COUNT(AptTenants.AptID) AS Count 
FROM AptTenants INNER JOIN Tenants ON AptTenants.TenantID = Tenants.TenantID
GROUP BY AptTenants.TenantID 
HAVING Count > 1;
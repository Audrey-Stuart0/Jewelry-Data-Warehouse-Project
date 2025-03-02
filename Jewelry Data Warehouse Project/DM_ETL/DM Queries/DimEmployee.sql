SELECT DISTINCT
    Employee_ID AS Employee_BK,
    Employee_LastName AS Employee_LastName,
    Employee_FirstName AS Employee_FirstName,    
    Employee_Region AS Employee_Region,        
    Employee_State AS Employee_State,                
    Employee_TenureLength AS Employee_TenureLength,
    Employee_PhoneNumber AS Employee_PhoneNumber,        
    Employee_Position AS Employee_Position
FROM
    MoonGlimJewelry.dbo.Employee
WHERE
    Employee_ID IS NOT NULL;

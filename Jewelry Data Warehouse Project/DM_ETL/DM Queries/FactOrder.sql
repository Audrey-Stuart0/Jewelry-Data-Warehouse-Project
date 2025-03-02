SELECT
    o.Order_ID AS Order_ID,
    dimodate.Date_SK AS Order_Date,
    dimp.Product_SK,
    dimc.Customer_SK,
    dime.Employee_SK,
    p.Product_UnitPrice AS UnitPrice,
    p.Product_UnitCost AS UnitCost,
    o.Order_Quantity AS Quantity,
    p.Product_UnitPrice * o.Order_Quantity AS Revenue,
    p.Product_UnitCost * o.Order_Quantity AS Cost,
    (o.Order_Quantity * p.Product_UnitPrice) - (o.Order_Quantity * p.Product_UnitCost) AS Profit
FROM
    MoonGlimJewelry.dbo.[ORDER] o
LEFT JOIN
    MoonGlimJewelry.dbo.PRODUCT p ON o.Product_ID = p.Product_ID
LEFT JOIN
    MoonGlimJewelryDM.dbo.DimProduct dimp ON dimp.Product_BK = p.Product_ID
LEFT JOIN
    MoonGlimJewelry.dbo.CUSTOMER c ON o.Customer_ID = c.Customer_ID
LEFT JOIN
    MoonGlimJewelryDM.dbo.DimCustomer dimc ON dimc.Customer_BK = c.Customer_ID
LEFT JOIN
    MoonGlimJewelry.dbo.EMPLOYEE e ON o.Employee_ID = e.Employee_ID
LEFT JOIN
    MoonGlimJewelryDM.dbo.DimEmployee dime ON dime.Employee_BK = e.Employee_ID
LEFT JOIN
    MoonGlimJewelryDM.dbo.DimDate dimodate ON dimodate.[Date] = o.Order_Date
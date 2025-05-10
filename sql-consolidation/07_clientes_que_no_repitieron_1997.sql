WITH compras1996 AS (
	SELECT DISTINCT
		o.customerID AS ID_Cliente,
		c.customerName AS Nombre_Cliente
	FROM Orders o
	INNER JOIN Customers c ON o.CustomerID = c.CustomerID
	WHERE YEAR(o.OrderDate) = 1996
),
compras1997 AS (
	SELECT DISTINCT
		o.customerID AS ID_Cliente
	FROM Orders o
	WHERE YEAR(o.OrderDate) = 1997
)

SELECT
	c96.ID_Cliente AS Cliente_ID,
	c96.Nombre_Cliente AS Nombre_Cliente
FROM compras1996 c96
LEFT JOIN compras1997 c97 ON c96.ID_Cliente = c97.ID_Cliente
WHERE c97.ID_Cliente IS NULL

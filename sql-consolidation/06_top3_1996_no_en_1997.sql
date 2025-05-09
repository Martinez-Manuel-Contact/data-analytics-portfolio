WITH productos_1996 AS (
	SELECT 
		p.productID AS ID_Producto,
		p.productName AS Nombre_Producto,
		SUM(od.quantity) AS Cantidad_1996,
		RANK() OVER(ORDER BY SUM(od.quantity) DESC) AS Ranking_1996
	FROM Orders o
	INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
	INNER JOIN Products p ON od.productID = p.productID
	WHERE YEAR(o.orderDate) = 1996
	GROUP BY p.productID, p.productName
),
productos_1997 AS (
	SELECT 
		p.productID AS ID_Producto,
		RANK() OVER(ORDER BY SUM(od.quantity) DESC) AS Ranking_1997
	FROM Orders o
	INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
	INNER JOIN Products p ON od.productID = p.productID
	WHERE YEAR(o.orderDate) = 1997
	GROUP BY p.productID
)

SELECT 
	p96.ID_Producto,
	p96.Nombre_Producto,
	p96.Cantidad_1996,
	p96.Ranking_1996
FROM productos_1996 p96
LEFT JOIN productos_1997 p97 ON p96.ID_Producto = p97.ID_Producto AND p97.Ranking_1997 <= 3
WHERE p96.Ranking_1996 <= 3 AND p97.ID_Producto IS NULL

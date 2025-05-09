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
),
top_1996 AS (
	SELECT * FROM productos_1996 WHERE Ranking_1996 <= 3
),
top_1997 AS (
	SELECT * FROM productos_1997 WHERE Ranking_1997 <= 3
)

SELECT 
	t96.ID_Producto,
	t96.Nombre_Producto,
	t96.Cantidad_1996,
	t96.Ranking_1996
FROM top_1996 t96
LEFT JOIN top_1997 t97 ON t96.ID_Producto = t97.ID_Producto
WHERE t97.ID_Producto IS NULL

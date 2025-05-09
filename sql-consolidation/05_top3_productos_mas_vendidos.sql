WITH ventas_por_producto AS (
	SELECT 
		p.productID AS ID_Producto,
		p.productName AS Nombre_Producto,
		SUM(od.quantity) AS Cantidad_Vendida,
		RANK() OVER(ORDER BY SUM(od.quantity) DESC) AS Ranking
	FROM OrderDetails od
	INNER JOIN Products p ON od.productID = p.productID
	GROUP BY p.productID, p.productName
)

SELECT 
	ID_Producto,
	Nombre_Producto,
	Cantidad_Vendida,
	Ranking
FROM ventas_por_producto
WHERE Ranking <= 3

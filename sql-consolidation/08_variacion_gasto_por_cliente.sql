WITH gastos AS (
	SELECT 
		o.customerID AS ID_Cliente,
		c.customerName AS Nombre_Cliente,
		CAST(o.orderDate AS DATE) AS Fecha_Orden,
		SUM(od.quantity * p.price) AS Total_Gastado
	FROM Orders o 
	INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
	INNER JOIN Products p ON od.ProductID = p.ProductID
	INNER JOIN Customers c ON o.CustomerID = c.CustomerID
	GROUP BY o.customerID, c.customerName, o.orderDate
),
gastoAnterior AS (
	SELECT 
		g.ID_Cliente,
		g.Nombre_Cliente,
		g.Fecha_Orden,
		g.Total_Gastado,
		LAG(g.Total_Gastado) OVER(
			PARTITION BY g.ID_Cliente
			ORDER BY g.Fecha_Orden
		) AS Gasto_Anterior
	FROM gastos g
)

SELECT 
	*,
	Total_Gastado - Gasto_Anterior AS Diferencia,
	CASE
		WHEN Gasto_Anterior IS NULL THEN 'Primera compra'
		WHEN Total_Gastado > Gasto_Anterior THEN 'AUMENTO'
		WHEN Total_Gastado < Gasto_Anterior THEN 'DISMINUYÓ'
		ELSE 'MANTIENE'
	END AS Comparacion
FROM gastoAnterior

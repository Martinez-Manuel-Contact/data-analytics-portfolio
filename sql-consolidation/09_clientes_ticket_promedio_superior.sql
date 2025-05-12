WITH Gastos AS (
	SELECT 
		o.customerID AS ID_Cliente,
		c.customerName AS Nombre_Cliente,
		SUM(od.quantity * p.price) AS Total_Gastado,
		COUNT(o.OrderID) AS Cantidad_Ordenes
	FROM Orders o
	INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
	INNER JOIN Products p ON od.ProductID = p.ProductID
	INNER JOIN Customers c ON o.CustomerID = c.CustomerID
	GROUP BY o.customerID, c.customerName
),
promedioCliente AS (
	SELECT 
		g.ID_Cliente,
		g.Nombre_Cliente,
		g.Total_Gastado / g.Cantidad_Ordenes AS Ticket_Promedio_Personal
	FROM Gastos g
),
promedioGeneral AS (
	SELECT 
		SUM(Total_Gastado) / SUM(Cantidad_Ordenes) AS Ticket_Promedio_General
	FROM Gastos
)

SELECT 
	pc.Nombre_Cliente,
	pc.Ticket_Promedio_Personal,
	pg.Ticket_Promedio_General
FROM promedioCliente pc
CROSS JOIN promedioGeneral pg
WHERE pc.Ticket_Promedio_Personal > pg.Ticket_Promedio_General

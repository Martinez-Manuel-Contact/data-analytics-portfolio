-- OBJETIVO:
-- Clasificar a los clientes según la cantidad total de órdenes realizadas.

SELECT
	o.customerID AS ID_Cliente,
	c.customerName AS Nombre_Cliente,
	COUNT(o.OrderID) AS Total_Ordenes,
	CASE 
		WHEN COUNT(o.OrderID) > 10 THEN 'ALTO'
		WHEN COUNT(o.OrderID) >= 5 THEN 'MEDIO'
		ELSE 'BAJO'
	END AS Nivel_Cliente
FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.customerID, c.customerName

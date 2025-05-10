SELECT
	o.customerID AS ID_Cliente,
	c.customerName AS Nombre_Cliente,
	SUM(od.quantity * p.price) AS Total_Gastado
FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.customerID, c.customerName

WITH ranking1997 AS (
    SELECT
        od.productID AS ID_Producto,
        p.productName AS Nombre_Producto,
        SUM(od.quantity) AS Cantidad_Vendida_1997,
        RANK() OVER(
            ORDER BY SUM(od.quantity) DESC
        ) AS Ranking_Productos
    FROM OrderDetails od 
    INNER JOIN Products p ON od.ProductID = p.ProductID
    INNER JOIN Orders o ON od.OrderID = o.OrderID
    WHERE YEAR(o.orderDate) = 1997
    GROUP BY od.productID, p.productName
),
clientesPorProducto AS (
    SELECT
        o.customerID AS ID_Cliente,
        c.customerName AS Nombre_Cliente,
        od.productID AS ID_Producto,
        SUM(od.quantity) AS Cantidad_Por_Producto,
        ROW_NUMBER() OVER(
            PARTITION BY od.productID
            ORDER BY SUM(od.quantity) DESC
        ) AS Ranking_Clientes
    FROM Orders o 
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY o.customerID, c.customerName, od.productID 
)

SELECT 
    r97.ID_Producto,
    r97.Nombre_Producto,
    r97.Cantidad_Vendida_1997,
    (SELECT    
        cpp.Nombre_Cliente
     FROM clientesPorProducto cpp
     WHERE r97.ID_Producto = cpp.ID_Producto AND cpp.Ranking_Clientes = 1
    ) AS Cliente_Mas_Comprador
FROM ranking1997 r97;

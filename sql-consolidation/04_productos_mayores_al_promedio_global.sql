SELECT
	p.productName AS Nombre_Producto,
	p.price AS Precio_Producto,
	(SELECT AVG(price) FROM Products) AS Promedio_Global
FROM Products p 
WHERE p.price > (SELECT AVG(price) FROM Products)

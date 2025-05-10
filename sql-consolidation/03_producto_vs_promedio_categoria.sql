SELECT
	p.productName AS Nombre_Producto,
	p.price AS Precio,
	c.categoryName AS Categoria,
	(
		SELECT AVG(p2.price)
		FROM Products p2
		WHERE p2.CategoryID = p.CategoryID
	) AS Promedio_Categoria,
	CASE 
		WHEN p.price > (
			SELECT AVG(p2.price)
			FROM Products p2
			WHERE p2.CategoryID = p.CategoryID
		) THEN 'Superior al promedio'
		WHEN p.price < (
			SELECT AVG(p2.price)
			FROM Products p2
			WHERE p2.CategoryID = p.CategoryID
		) THEN 'Inferior al promedio'
		ELSE 'Igual al promedio'
	END AS Comparacion
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID

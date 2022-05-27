-- Año: 2022
-- Grupo Nro: 08
-- Integrantes: Faciano Enzo Nicolás, Nóblega Caro Esteban Leonel
-- Tema: Veterinaria
-- Nombre del Esquema: LBD2022G08VETNET
-- Plataforma: Windows 10 Pro - Versión: 21H2
-- Motor y Versión: MySQL 8.0.22
-- GitHub Repositorio: LBD2022G08
-- GitHub Usuarios: enzofac, estebannoblega

USE `LBD2022G08VETNET` ;

-- agregado de datos 
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (5,48692059,'2020-07-19 16:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (5,48692060,'2020-07-22 16:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (5,48692061,'2020-07-23 16:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (5,48692062,'2020-08-09 16:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (5,48692063,'2020-08-11 16:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (5,48692064,'2020-09-20 16:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta) VALUES (12,48692065),(12,48692066),(12,48692067),(12,48692068),(12,48692069);
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (15,48692070,'2021-08-20 16:42:06'),(15,48692071,'2021-08-30 10:42:06'),(15,48692072,default);
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692020,'2018-02-21 11:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692021,'2018-05-29 10:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692022,'2019-12-19 16:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692023,'2019-04-03 18:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692024,'2019-09-09 21:22:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692025,'2020-11-01 10:02:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692026,'2020-11-19 11:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692027,'2021-01-15 19:52:16');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692028,'2018-02-19 17:42:06');
INSERT INTO Ventas (idUsuario, NumeroVenta, fechaVenta) VALUES (6,48692029,'2019-10-22 18:42:06');
select * from ventas;


INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (41,5,2,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (41,5,5,1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (41,5,4,2,400);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (42,5,2,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (43,5,2,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (44,5,1,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (44,5,2,1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (44,5,4,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (45,5,3,1,6600);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (46,5,2,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (46,5,1,1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (46,5,3,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (47,12,1,2,300),(47,12,2,3,300),(48,12,1,2,300),(49,12,3,2,300),(49,12,5,5,300),(50,12,1,4,300),(51,12,3,5,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (52,15,2,3,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (52,15,3,3,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (53,15,1,1,300),(53,15,2,4,300),(53,15,5,3,300),(54,15,1,1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (57,6,2,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (57,6,5,1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (57,6,4,2,400);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (58,6,2,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (58,6,4,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (59,6,1,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (59,6,2,1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (59,6,4,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (60,6,3,1,6600);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (61,6,2,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (61,6,1,1,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (61,6,3,2,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (62,6,1,2,300),(62,6,2,3,300),(63,6,1,2,300),(64,6,3,2,300),(65,6,5,5,300),(65,6,1,4,300),(65,6,3,5,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (66,6,2,3,300);
INSERT INTO LineasVenta (idVenta, idUsuario, idArticulo, cantidad, precioUnitario) VALUES (66,6,3,3,300);



-- CONSULTAS
-- 1. DADO UN USUARIO LISTAR TODAS SUS VENTAS ENTRE UN RANGO DE FECHAS
SELECT Usuarios.Usuario, Ventas.NumeroVenta AS `Numero de Venta`,date(Ventas.FechaVenta) AS Fecha,
LineasVenta.Cantidad*PrecioUnitario `Total por Venta` FROM 
Usuarios INNER JOIN Ventas ON Usuarios.IdUsuario=Ventas.IdUsuario
INNER JOIN LineasVenta ON Ventas.IdVenta = LineasVenta.IdVenta AND Ventas.IdUsuario = LineasVenta.IdUsuario
WHERE Usuarios.Usuario = 'SoyBataman' AND date(FechaVenta) BETWEEN "2017-01-01" and "2023-01-01"
ORDER BY Ventas.FechaVenta;
/* Criterios:
	- Usamos un INNER JOIN porque debemos mostrar los elemntos que pertenecen a ambos conjuntos, es decir, los usuarios que tienen ventas.
*/
-- 2. Realizar un listado de cantidad de artículos agrupados por categoría.
SELECT Categorias.categoria, 
COUNT(LineasCompra.Cantidad) AS 'Cantidad de Articulos'
FROM Categorias LEFT JOIN Articulos
ON Categorias.IdCategoria = Articulos.IdCategoria
INNER JOIN LineasCompra 
ON Articulos.IdArticulo = LineasCompra.IdArticulo
GROUP BY Categorias.categoria
ORDER BY Categorias.categoria DESC;

SELECT Categorias.idCategoria, Categorias.categoria, Articulos.idArticulo,
COUNT(Articulos.idArticulo) AS 'Cantidad de Articulos'
FROM Categorias LEFT JOIN Articulos
ON Categorias.idCategoria = Articulos.idCategoria
GROUP BY Categorias.idCategoria, Categorias.categoria
ORDER BY Categorias.categoria;

-- 3. REALIZAR UN LISTADO DE LOS DATOS DE VENTAS CON SUS RESPECTIVOS ARTICULOS, CANTIDADES Y PRECIO TOTAL DE CADA LINEA
SELECT Usuarios.Usuario, date(Ventas.FechaVenta),NumeroVenta AS `Numero de Venta`,Articulos.Articulo
, LineasVenta.Cantidad, LineasVenta.PrecioUnitario*Articulos.Ganancia*LineasVenta.Cantidad AS `Precio Total`FROM
	Usuarios INNER JOIN Ventas ON Usuarios.IdUsuario = Ventas.IdUsuario
    INNER JOIN LineasVenta ON Ventas.IdVenta=LineasVenta.IdVenta AND Ventas.IdUsuario = LineasVenta.IdUsuario
    INNER JOIN Articulos ON LineasVenta.IdArticulo = Articulos.IdArticulo
    ORDER BY date(ventas.FechaVenta),ventas.numeroventa DESC;
    
-- 4. Dado un rango de fechas, mostrar día a día el total de ventas realizadas. El formato deberá ser: Fecha, Total de ventas.
SELECT Date(Ventas.fechaVenta) AS 'Fecha', COUNT(Ventas.IdVenta) AS 'Total de ventas'
FROM Ventas
WHERE (Ventas.fechaVenta BETWEEN "2015-01-01" AND "2019-05-12") -- valores que se deberían ingresar
GROUP BY Date(Ventas.fechaVenta)
ORDER BY Ventas.fechaVenta;
-- Date() devuelve la fecha solamente sin tener en cuenta la hora


-- 5. HACER UN RANKING CON LOS 10 CLIENTES CON MAS ARTICULOS VENDIDOS EN UN RANGO DE FECHAS.
SELECT Usuario,Usuarios.Nombre,Usuarios.Apellido,  sum(Cantidad) CompraTotal from
	Usuarios INNER JOIN Ventas ON Usuarios.IdUsuario=Ventas.IdUsuario
    JOIN LineasVenta ON Ventas.IdVenta = LineasVenta.IdVenta
    JOIN Articulos ON LineasVenta.IdArticulo = Articulos.IdArticulo
    WHERE DATE(fechaventa) BETWEEN "2018-01-20" AND "2023-12-20"-- year(fechaventa) between 2019 and 2022
    GROUP BY usuario
    ORDER BY compratotal,usuario,usuarios.nombre,usuarios.apellido
    LIMIT 10;
    
-- 6. Hacer un ranking con los 10 clientes con más importe vendido en un rango de fechas.
SELECT Usuarios.idUsuario, Usuarios.usuario, Usuarios.nombre, Usuarios.apellido, 
LineasVenta.cantidad*LineasVenta.precioUnitario*Articulos.ganancia importe
FROM 
Usuarios JOIN Ventas ON Usuarios.IdUsuario = Ventas.IdUsuario
JOIN LineasVenta ON Ventas.IdVenta = LineasVenta.IdVenta
JOIN Articulos ON LineasVenta.IdArticulo = Articulos.IdArticulo
WHERE (Ventas.fechaVenta BETWEEN "2015-01-01" AND current_timestamp()) -- valores que se deberían ingresar
GROUP BY Usuarios.idUsuario, Usuarios.usuario, Usuarios.nombre, Usuarios.apellido
-- ,importe
ORDER BY importe DESC
LIMIT 10;    

-- 7. HACER UN RANKING CON LOS 10 ARTICULOS CON MAS VENTAS (POR CANTIDAD). MOSTRAR EL NOMBRE DEL PRODUCTO Y EL TOTAL DE VENTAS.
SELECT Articulo, sum(Cantidad) `Cantidad Vendida` FROM
	Articulos JOIN LineasVenta ON Articulos.IdArticulo=LineasVenta.IdArticulo
    JOIN Ventas ON LineasVenta.IdVenta=Ventas.IdVenta
    GROUP BY Articulo -- no tiene sentido hacer WITH ROLLUP xq "no sabemos" cuantos articulos diferentes vendidos tenemos, si tenemos 11 entonce en la fila 12 recien aparece el resultado de rollup
    ORDER BY sum(Cantidad) DESC
    LIMIT 10;
    
-- 8. CREAR UNA VISTA CON LA FUNCIONALIDAD DEL APARTADO3
CREATE VIEW V_DetalleVentas (NumeroVenta, Articulos, Cantidades, PrecioTotal)
AS
		SELECT NumeroVenta, Articulo, Cantidad, PrecioUnitario*Ganancia*Cantidad PrecioTotal FROM
		Ventas JOIN LineasVenta ON Ventas.IdVenta=LineasVenta.IdVenta
		JOIN Articulos ON LineasVenta.IdArticulo=Articulos.IdArticulo
		ORDER BY ventas.FechaVenta DESC;
        
SELECT * FROM V_DetalleVentas;
    
-- 9. CREAR UNA COPIA DE LA TABLA VENTAS, LLAMADA VentasJSON, QUE TENGA UNA COLUMNA DEL TIPO JSON PARA GUARDAR LAS LINEAS DE VENTA. LLENAR LA TABLA CON LOS 
-- MISMOS DATOS DEL TP1 Y RESOLVER LA CONSULTA 3

CREATE TABLE VentasJSON LIKE Ventas;
ALTER TABLE VentasJSON ADD COLUMN LineasVenta JSON NOT NULL;
-- SELECT * FROM VentasJSON;

INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) VALUES (2,48692039,'2021-07-19 16:42:06','[
		{"IdArticulo":"2","Cantidad": "1","Precio":"300"},
        {"IdArticulo": "5","Cantidad": "2","Precio": "319.99"}
	]');
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) VALUES (2,48692040,'2021-05-27 18:00:35',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","10","Cantidad","2","Precio","900"),
        JSON_OBJECT("IdArticulo","11","Cantidad","2","Precio","900")
    )
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (6,48692041,'2021-05-27 18:30:35',	JSON_ARRAY(JSON_OBJECT("IdArticulo","4","Cantidad","2","Precio","7775.66")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (7,48692042,'2021-02-16 00:18:47',JSON_ARRAY(JSON_OBJECT("IdArticulo","12","Cantidad","2","Precio","700.69")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (2,48692043,'2021-05-27 18:00:35',JSON_ARRAY(JSON_OBJECT("IdArticulo","6","Cantidad","1","Precio","450.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (14,48692044,'2020-05-05 13:49:46',JSON_ARRAY(JSON_OBJECT("IdArticulo","6","Cantidad","1","Precio","450.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (16,48692045,'2022-02-14 03:40:46',JSON_ARRAY(JSON_OBJECT("IdArticulo","6","Cantidad","1","Precio","450.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (16,48692046,'2021-08-04 23:48:16',JSON_ARRAY(JSON_OBJECT("IdArticulo","7","Cantidad","1","Precio","1150.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (17,48692047,'2022-08-08 18:46:21',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","1","Cantidad","1","Precio","500"),
        JSON_OBJECT("IdArticulo","2","Cantidad","1","Precio","300"),
        JSON_OBJECT("IdArticulo","3","Cantidad","1","Precio","450.5"),
        JSON_OBJECT("IdArticulo","4","Cantidad","2","Precio","775.66"),
        JSON_OBJECT("IdArticulo","5","Cantidad","2","Precio","319.99"),
        JSON_OBJECT("IdArticulo","6","Cantidad","1","Precio","450.99"),
        JSON_OBJECT("IdArticulo","7","Cantidad","1","Precio","1150.99"),
        JSON_OBJECT("IdArticulo","8","Cantidad","1","Precio","2050.99"),
        JSON_OBJECT("IdArticulo","10","Cantidad","2","Precio","1350.29"),
        JSON_OBJECT("IdArticulo","11","Cantidad","1","Precio","650.99"),
        JSON_OBJECT("IdArticulo","12","Cantidad","1","Precio","650.99")
    )
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (17,48692048,'2022-11-12 03:41:23',JSON_ARRAY(JSON_OBJECT("IdArticulo","4","Cantidad","1","Precio","475.66")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (16,48692049,'2022-12-02 23:42:31',JSON_ARRAY(JSON_OBJECT("IdArticulo","4","Cantidad","3","Precio","1275.42")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (10,48692050,'2022-10-03 18:21:30',JSON_ARRAY(JSON_OBJECT("IdArticulo","4","Cantidad","1","Precio","475.66")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (14,48692051,'2022-01-20 15:50:02',JSON_ARRAY(JSON_OBJECT("IdArticulo","6","Cantidad","2","Precio","1001")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (18,48692052,'2022-11-19 01:08:07',JSON_ARRAY(JSON_OBJECT("IdArticulo","6","Cantidad","1","Precio","450")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (18,48692053,'2021-06-30 15:24:25',JSON_ARRAY(JSON_OBJECT("IdArticulo","6","Cantidad","2","Precio","1001")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (17,48692054,'2022-12-13 15:30:37',JSON_ARRAY(JSON_OBJECT("IdArticulo","12","Cantidad","1","Precio","650.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (17,48692055,'2022-05-27 21:15:36',JSON_ARRAY(JSON_OBJECT("IdArticulo","12","Cantidad","1","Precio","710.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (6,48692056,'2020-01-11 11:41:18',JSON_ARRAY(JSON_OBJECT("IdArticulo","12","Cantidad","1","Precio","650.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (6,48692057,'2020-10-04 07:43:26',JSON_ARRAY(JSON_OBJECT("IdArticulo","11","Cantidad","1","Precio","650.99")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (5,48692059,'2020-07-19 16:42:06',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","2","Cantidad","2","Precio","300"),
        JSON_OBJECT("IdArticulo","4","Cantidad","2","Precio","400"),
        JSON_OBJECT("IdArticulo","5","Cantidad","1","Precio","300")
    )
);

INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (5,48692060,'2020-07-22 16:42:06',JSON_ARRAY(JSON_OBJECT("IdArticulo","2","Cantidad","2","Precio","300")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (5,48692061,'2020-07-23 16:42:06',JSON_ARRAY(JSON_OBJECT("IdArticulo","2","Cantidad","2","Precio","300")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (5,48692062,'2020-08-09 16:42:06',JSON_ARRAY(
        JSON_OBJECT("IdArticulo","1","Cantidad","2","Precio","300"),
        JSON_OBJECT("IdArticulo","2","Cantidad","1","Precio","300"),
        JSON_OBJECT("IdArticulo","4","Cantidad","2","Precio","300"))
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (5,48692063,'2020-08-11 16:42:06',JSON_ARRAY(JSON_OBJECT("IdArticulo","3","Cantidad","1","Precio","6600")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (5,48692064,'2020-09-20 16:42:06',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","1","Cantidad","1","Precio","300"),
        JSON_OBJECT("IdArticulo","2","Cantidad","2","Precio","300"),
        JSON_OBJECT("IdArticulo","3","Cantidad","2","Precio","300")
    )
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (12,48692065,'2022-05-15 22:23:37',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","1","Cantidad","2","Precio","300"),
        JSON_OBJECT("IdArticulo","2","Cantidad","3","Precio","300")
    )
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (12,48692066,'2022-05-15 22:23:37',JSON_ARRAY(JSON_OBJECT("IdArticulo","1","Cantidad","2","Precio","300")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (12,48692067,'2022-05-15 22:23:37',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","3","Cantidad","2","Precio","300"),
        JSON_OBJECT("IdArticulo","5","Cantidad","5","Precio","300")
    )
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (12,48692068,'2022-05-15 22:23:37',JSON_ARRAY(JSON_OBJECT("IdArticulo","1","Cantidad","4","Precio","300")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (12,48692069,'2022-05-15 22:23:37',JSON_ARRAY(JSON_OBJECT("IdArticulo","3","Cantidad","5","Precio","300")));
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (15,48692070,'2021-08-20 16:42:06',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","2","Cantidad","3","Precio","300"),
        JSON_OBJECT("IdArticulo","3","Cantidad","3","Precio","300")
    )
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (15,48692071,'2021-08-30 10:42:06',JSON_ARRAY(
		JSON_OBJECT("IdArticulo","1","Cantidad","1","Precio","300"),
        JSON_OBJECT("IdArticulo","2","Cantidad","4","Precio","300"),
        JSON_OBJECT("IdArticulo","5","Cantidad","3","Precio","300")
    )
);
INSERT INTO VentasJSON (IdUsuario,NumeroVenta,FechaVenta,LineasVenta) 
VALUES (15,48692072,'2022-05-15 22:26:16',JSON_ARRAY(JSON_OBJECT("IdArticulo","1","Cantidad","1","Precio","300")));


/*RESUELVO LA CONSULTA DEL APARTADO 3*/

SELECT `Numero de Venta`,Articulos.Articulo,TablaJSONconVenta.Cantidad,
TablaJSONconVenta.Precio*TablaJSONconVenta.Cantidad*Articulos.Ganancia AS `Precio Total` 
FROM articulos JOIN ((SELECT VentasJSON.NumeroVenta AS `Numero de Venta`,VentasJSON.FechaVenta,tablaJSON.* FROM
ventasJSON,  
JSON_TABLE(LineasVenta, '$[*]' COLUMNS (
		IdArticulo int path '$.IdArticulo',
        Cantidad int path '$.Cantidad',
        Precio float path '$.Precio'
    )
) AS tablaJSON)) as TablaJSONconVenta on TablaJSONconVenta.IdArticulo = articulos.IdArticulo 
ORDER BY TablaJSONconVenta.FechaVenta DESC;
    
-- 10. Realizar una vista que considere importante para su modelo. También dejar escrito el enunciado de la misma.

-- Crear una VISTA que muestre los articulos comprados, datos de las compras (cantidad, total de compras), 
-- y si los articulos fueron vendidos, datos de tales ventas (cantidad, total de ventas) para mostrar un BALANCE

DROP VIEW IF EXISTS V_Balance;
CREATE VIEW V_Balance (Articulo, CantidadComprada, TotalCompra, CantidadVendida, TotalVenta, Balance)
AS
	SELECT TablaCompras.articulo as Articulo,TablaCompras.cantidad as `Cantidad Comprada`,TablaCompras.gasto as `Total de Compra`,
		TablaVentas.cantidad as `Cantidad Vendida` ,TablaVentas.recaudacion as `Total de Venta`,(TablaVentas.recaudacion - TablaCompras.gasto) as Balance 
		FROM (
			(SELECT Articulos.Articulo as articulo,sum(lineasventa.Cantidad) as cantidad, 
			sum(LineasVenta.PrecioUnitario*LineasVenta.Cantidad*Articulos.Ganancia) as recaudacion FROM
				articulos join lineasventa on articulos.IdArticulo=lineasventa.IdArticulo
			group by articulo order by articulo) TablaVentas 
		right join 
			(SELECT Articulos.Articulo as articulo,sum(lineascompra.cantidad) as cantidad,
			sum(LineasCompra.PrecioUnitario*LineasCompra.Cantidad) as gasto FROM
				articulos join LineasCompra on articulos.IdArticulo=LineasCompra.IdArticulo
			group by articulo order by articulo) TablaCompras 
		ON TablaVentas.articulo = TablaCompras.articulo);
SELECT * FROM V_Balance;

/*
-- una vista que muestre los articulos comprados a un determinado proveedor 
select articulos.articulo,proveedores.razonsocial,lineascompra.Cantidad,lineascompra.Cantidad*lineascompra.PrecioUnitario as PrecioCompra from
	articulos join lineascompra on articulos.idarticulo=lineascompra.IdArticulo
    join proveedores on lineascompra.idproveedor=proveedores.idproveedor 
    order by articulos.articulo;
    
-- una vista que muestra la cantidad total de cada articulo con el precio total de compra
select articulos.articulo,sum(lineascompra.Cantidad) as 'Cantidad total',
sum(lineascompra.Cantidad*lineascompra.PrecioUnitario) as PrecioCompra from
	articulos join lineascompra on articulos.idarticulo=lineascompra.IdArticulo
    join proveedores on lineascompra.idproveedor=proveedores.idproveedor 
    GROUP BY articulos.articulo
    order by articulos.articulo;
*/

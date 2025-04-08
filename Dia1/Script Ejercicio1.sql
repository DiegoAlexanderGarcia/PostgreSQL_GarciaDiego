-- Database: claseT2

-- DROP DATABASE IF EXISTS "claseT2";

CREATE DATABASE "claseT2"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'es-CO'
    LC_CTYPE = 'es-CO'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE fabricante (
	codigo BIGINT PRIMARY KEY NOT NULL,
	nombre VARCHAR(25) NOT NULL
);

CREATE TABLE producto(
	codigo BIGINT PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	precio NUMERIC(12,2) NOT NULL,
	codigo_fabricante INT REFERENCES fabricante(codigo)
);

INSERT INTO fabricante (codigo, nombre) VALUES
(1, 'Asus'),
(2, 'Lenovo'),
(3, 'Hewlett-Packard'),
(4, 'Samsung'),
(5, 'Seagate'),
(6, 'Crucial'),
(7, 'Gigabyte'),
(8, 'Huawei'),
(9, 'Xiaomi');

INSERT INTO producto (codigo, nombre, precio, codigo_fabricante) VALUES
(1, 'Disco duro SATA3 1TB', 86.99, 5),
(2, 'Memoria RAM DDR4 8GB', 120.00, 6),
(3, 'Disco SSD 1 TB', 150.99, 4),
(4, 'GeForce GTX 1050Ti', 185.00, 7),
(5, 'GeForce GTX 1080 Xtreme', 755.00, 6),
(6, 'Monitor 24 LED Full HD', 202.00, 1),
(7, 'Monitor 27 LED Full HD', 245.99, 1),
(8, 'Portátil Yoga 520', 559.00, 2),
(9, 'Portátil Ideapad 320', 444.00, 2),
(10, 'Impresora HP Deskjet 3720', 59.99, 3),
(11, 'Impresora HP Laserjet Pro M26nw', 180.00, 3);

-- 1.nombre de todos los productos
SELECT nombre FROM producto

-- 2.listar nombre y precio de los productos
SELECT nombre, precio FROM producto

-- 3.columnas de la tabla de productos
SELECT * FROM producto

-- 4.listar producto con el precio en euro y dolares 
SELECT nombre, precio, precio * 1.09 AS precio_USD FROM producto

-- 5.listar nombre de producto, euro, dolares
SELECT nombre AS "Nombre de producto", precio AS Euro, precio * 1.09 AS Dolares FROM producto

-- 6.listar los nombre y precios de los productos combirtiendo los nombres a mayusculas
SELECT UPPER(nombre), precio FROM producto

-- 7.listar los nombre y precios de los productos combirtiendo los nombres a minuscula
SELECT LOWER(nombre), precio FROM producto

-- 8.listar los nombre de los fabricantes en una columna y en otra las dos primeras letras del nombre en mayuscula 
SELECT nombre, UPPER(SUBSTRING(nombre FROM 1 FOR 2)) FROM fabricante

-- 9.listar nombre y precio, redondear el precio de los productos
SELECT nombre, ROUND(precio) FROM producto

-- 10.listar nombre y precuio truncado
SELECT nombre, TRUNC(precio) FROM producto

-- 11.listar ID frabricantes con productos en tabla producto
SELECT codigo_fabricante FROM producto

-- 12.listar ID fabricantes eliminando duplicados
SELECT DISTINCT codigo_fabricante FROM producto

-- 13.lsitar nombres de fabricantes de forma asendente
SELECT nombre FROM fabricante ORDER BY nombre asc

-- 14.listar nombre de fabricantes de forma desendente
SELECT nombre FROM fabricante ORDER BY nombre DESC

-- 15.listar nombre en forma ascendente y precio de forma desendente
SELECT nombre, precio FROM producto ORDER BY nombre asc, precio DESC

-- 16.lista con los 5 primero fabricantes
SELECT nombre FROM fabricante LIMIT 5

-- 17.devolver una lista desde la cuarta fila asta dos filas
SELECT * FROM fabricante OFFSET 3 limit 2

-- 18.listar nombre y precio producto mas barato(oreder by, limit)
SELECT nombre, precio FROM producto ORDER BY precio asc LIMIT 1

-- 19.listar nombre y precio producto mas caro(oreder by, limit)
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1

-- 20.listar los productos del fabricante ID 2
SELECT nombre, precio FROM producto WHERE codigo_fabricante = 2

-- 21.productos monores o iguales a 120 Euros
SELECT nombre, precio FROM producto WHERE precio <= 120

-- 22.productos mayores o iguales a 400 Euros
SELECT nombre, precio FROM producto WHERE precio >= 400

-- 23.productos menores a 400 Euros
SELECT nombre, precio FROM producto WHERE precio < 400

-- 24.precio entre 80 y 300 sin betweem
SELECT * FROM producto WHERE precio >= 80 AND precio <= 300

-- 25.con between
SELECT * FROM producto WHERE precio BETWEEN 80 AND 300

-- 26.todos los productos del fabricante ID 6 con precio mayor que 200
SELECT * FROM producto WHERE precio >200 AND codigo_fabricante = 6

-- 27.listar productos del fabricante ID 1,3 o 5 sin usar in
SELECT * FROM producto WHERE codigo_fabricante = 1 or codigo_fabricante = 3 or codigo_fabricante = 5

-- 28.con operador IN
SELECT * FROM producto WHERE codigo_fabricante in (1, 3, 5)

-- 29.listar nombre y precio en centimos(multiplicar por 100 el precio)
SELECT nombre, precio, precio * 100 AS Centimos FROM producto

-- 30.listar nombres de fabricantes que empiezan por s
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%'

-- 31.listar nombres de fabricantes que terminan en e
SELECT nombre FROM fabricante WHERE nombre LIKE '%e'

-- 32.listar nombre que contengan w
SELECT nombre FROM fabricante WHERE nombre ILIKE '%w%'

-- 33.listar nombres de 4 caracteres
SELECT nombre FROM fabricante WHERE LENGTH(nombre) = 4

-- 34.listar producto que su nombre contenga portatil
SELECT nombre FROM producto WHERE nombre ILIKE '%Portátil%'

-- 35.listar producto que contenga en su nombre monitor y que su precio sea menor a 215
SELECT nombre FROM producto WHERE nombre ILIKE '%Monitor%' and precio < 215

-- 36.listar el nombre de forma ascendente y precio descendente
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC

-- Consultas multitabla (Composición interna)
-- 1.listar con nombre producto precio y nombre fabricante
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto 
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo

-- 2.listar nombre y precio del producto con el nombre del fabricante en orden alfabetico
SELECT producto.nombre, producto.nombre,fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC

-- 3.id, nombre de producto y id, nombre del fabricante 
SELECT Producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo

-- 4.nombre del producto, precio mas barato y el nombre del fabricante 
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio ASC LIMIT 1

-- 5. mas caro
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio DESC LIMIT 1

-- 6.listar los productos del fabricante LEnovo
SELECT producto.nombre, producto.precio FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo'

-- 7.listar los productos del fabricante Crucial con precio mayor a 200
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' and producto.precio >= 200

SELECT * FROM fabricante

-- 8.listado de todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate sin IN
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' or fabricante.nombre = 'Hewlett-Packard' or fabricante.nombre = 'Seagate'

-- 9.utilizando IN
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate')

-- 10.nombre y precio de los productos del fabricante con el nombre que empiese por e
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e'

-- 11.nombre y precio de los productos del fabricante cuyo nombre contenga w
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre ILIKE '%w%'

-- 12.precio del producto ordenado de forma descendente y nombre del fabricante ordenado de forma ascendente de los productos mayores o iguales a 180 
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto
JOIN fabricante on producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180 
ORDER BY producto.precio DESC, fabricante.nombre ASC

-- 13.lista de fabricantes que tiene productos en producto
SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM fabricante
JOIN producto on producto.codigo_fabricante = fabricante.codigo
-- ===========================================
-- PROYECTO: Análisis de Ventas — SQL + Power BI
-- Autor: Facundo Mazzieri
-- ===========================================


-- 1) CREACIÓN DE LA TABLA
CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    fecha DATE,
    producto VARCHAR(100),
    categoria VARCHAR(100),
    cantidad INT,
    precio_unitario NUMERIC(10,2)
);


-- 2) IMPORTAR CSV (ruta genérica)
COPY ventas(id_venta, fecha, producto, categoria, cantidad, precio_unitario)
FROM 'ruta/al/archivo/ventas.csv'
DELIMITER ';'
CSV HEADER;


-- 3) PREVISUALIZAR 10 REGISTROS
SELECT * FROM ventas LIMIT 10;


-- 4) AÑADIR COLUMNA TOTAL_VENTA
ALTER TABLE ventas
ADD COLUMN total_venta NUMERIC(10,2);


-- 5) CALCULAR EL TOTAL POR VENTA
UPDATE ventas
SET total_venta = cantidad * precio_unitario;


-- 6) ANÁLISIS EXPLORATORIO (EDA)
-- Categoría más vendida
SELECT categoria, SUM(cantidad) AS total_cant
FROM ventas
GROUP BY categoria
ORDER BY total_cant DESC;


-- Producto más rentable
SELECT producto, SUM(total_venta) AS total_generado
FROM ventas
GROUP BY producto
ORDER BY total_generado DESC;


-- Facturación mensual
SELECT DATE_TRUNC('month', fecha) AS mes,
       SUM(total_venta) AS facturacion
FROM ventas
GROUP BY mes
ORDER BY mes;


-- Ticket promedio
SELECT AVG(total_venta) AS ticket_promedio
FROM ventas;


-- Productos estrella (mayor cantidad vendida)
SELECT producto, SUM(cantidad) AS cantidad_total
FROM ventas
GROUP BY producto
ORDER BY cantidad_total DESC;

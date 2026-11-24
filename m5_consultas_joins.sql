-- ====================================================================
-- Archivo: m5_consultas_joins.sql
-- Base de datos: Ventas_Tech_DB
-- Propósito: Consultas con INNER JOIN, LEFT JOIN y UNION ALL para construir la vista base de Power BI y responder a CRM y Producto.
-- ====================================================================

USE Ventas_Tech_DB;
GO

-- ====================================================================
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: Combinar ventas con clientes, productos, categorías y territorios en una única tabla enriquecida.
-- ====================================================================
SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.segmento,
    c.ciudad,
    t.region,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c
 ON v.id_cliente = c.id_cliente
INNER JOIN territorios t
 ON c.id_territorio = t.id_territorio
INNER JOIN productos p
 ON v.id_producto = p.id_producto
INNER JOIN categorias cat
 ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta ASC, v.id_venta ASC;
GO
  
-- Hallazgo: Consolidación de 10 transacciones de un total $6.444,00 cruzadas por segmento de cliente, región y categoría ( se puede filtrar y agrupar luego en Power BI).


-- ====================================================================
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: Identificar clientes registrados que aún no realizaron ninguna compra para que CRM haga campañas de conversión.
-- ====================================================================
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
 ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
GO
  
-- Hallazgo: 0 clientes sin ventas (los 5 clientes que están registrados ya compraron al menos 2 veces), lo que indica a CRM que hay una conversión del 100% sobre la base actual.


-- ====================================================================
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: Detectar artículos del catálogo sin movimiento comercial para que el área de Producto evalúe promociones o depuración.
-- ====================================================================
  
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat
 ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v
 ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
GO

  
-- Hallazgo: 0 productos sin ventas (los 6 artículos del catálogo registran operaciones), confirmando a Producto que no hay stock sin movimiento y sin rotación.


-- ====================================================================
-- Consulta 4: Consolidado por canal / período (UNION ALL)
-- Propósito: Unir dos bloques de ventas generando una columna literal de origen ('1ra Quincena Marzo' vs '2da Quincena Marzo') con UNION ALL para no perder filas duplicadas y totalizar.
-- ====================================================================
  
SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, (cantidad * precio_unitario) AS total,
        CAST('1ra Quincena Marzo' AS VARCHAR(25)) AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'
    UNION ALL
    SELECT fecha_venta, (cantidad * precio_unitario) AS total,
        CAST('2da Quincena Marzo' AS VARCHAR(25)) AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10') AS consolidado
GROUP BY canal
ORDER BY total_canal DESC;
GO

-- Hallazgo: La 1ra Quincena de Marzo facturó $3.620,00 frente a $2.824,00 de la 2da Quincena, concentrando el 56,2% de los ingresos del período.


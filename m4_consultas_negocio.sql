-- ====================================================================
-- Base de datos: Ventas_Tech_DB
-- Descripción: Extrayendo métricas clave con SQL

-- ====================================================================


USE Ventas_Tech_DB;
GO
-- ========================================================================================================================================
-- Consulta 1 — Resumen ejecutivo mensual: Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
-- ========================================================================================================================================

SELECT 
    FORMAT(fecha_venta, 'yyyy-MM') AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG((cantidad * precio_unitario)) AS ticket_promedio
FROM 
    ventas
GROUP BY 
    FORMAT(fecha_venta, 'yyyy-MM')
ORDER BY 
    mes ASC;
    GO

-- ============================================================================================================================================================================================
-- Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) y el total generado. Usá GROUP BY id_producto, ORDER BY y TOP 5.
-- ============================================================================================================================================================================================

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
GO

-- ============================================================================================================================================================================================
-- Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.
-- ============================================================================================================================================================================================

SELECT id_cliente,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;
GO

-- ===========================================================================================================================================================================================================================================
-- Consulta 4 — Productos por encima/por debajo del promedio Total facturado por id_producto, con una columna adicional que etiquete con CASE WHEN si ese producto quedó 'Por encima' o 'Por debajo' del promedio de facturación por producto. 
-- ===========================================================================================================================================================================================================================================

WITH FacturacionPorProducto AS (    
 SELECT id_producto,
  SUM(cantidad * precio_unitario) AS total_generado
 FROM ventas
 GROUP BY id_producto
),
PromedioGeneral AS (
 SELECT 
  AVG(CAST(total_generado AS DECIMAL(12,2))) AS promedio_facturacion
 FROM FacturacionPorProducto
)
SELECT f.id_producto,f.total_generado,p.promedio_facturacion,
 CASE WHEN f.total_generado >= p.promedio_facturacion 
 THEN 'Por encima'
 ELSE 'Por debajo'
 END AS clasificacion
FROM FacturacionPorProducto f
CROSS JOIN 
    PromedioGeneral p
ORDER BY f.total_generado DESC;
GO

-- ====================================================================
-- HALLAZGOS DEL ANÁLISIS DE DATOS
-- ====================================================================

-- 1. El producto 1 (Laptop Pro 15) concentra el mayor porcentaje de la facturación total del trimestre por su alto valor unitario ($1200.00).
-- 2. Los accesorios de menor costo (como el Mouse Inalámbrico) registran un alto volumen de unidades vendidas, pero menor impacto en el total facturado.
-- 3. Existen clientes que realizaron más de una compra en el período (recurrentes), lo que evidencia oportunidades para análisis de retención.

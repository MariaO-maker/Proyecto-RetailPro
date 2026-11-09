# RetailPro - Consultas de Negocio y Análisis Comercial 

## Contexto del Proyecto
El equipo comercial de RetailPro requiere respuestas rápidas y métricas concretas de cara a la reunión de planificación del próximo lunes. En lugar de revisar registros masivos o filas individuales de la base de datos, este módulo implementa consultas analíticas enfocadas en extraer resúmenes ejecutivos, rankings de productos, identificación de clientes recurrentes y segmentación de rendimiento por encima o por debajo del promedio.

## Descripción del Repositorio y Base de Datos
- **Base de Datos:** `Ventas_Tech_DB` (creada bajo los estándares del modelo dimensional).
- **Modelo:** Cumple con la Tercera Forma Normal (3NF), integrando tablas maestras de dimensiones (categorias, clientes, productos) y una tabla de hechos transaccional (ventas).
- **Archivo de Consultas:** m4_consultas_negocio.sql, el cual concentra las soluciones analíticas requeridas por la dirección comercial utilizando exclusivamente la tabla de hechos y funciones de agregación en SQL Server.

## Estructura y Contenido de las Consultas SQL (m4_consultas_negocio.sql)

El script implementa las siguientes directivas de negocio:

1. **Resumen Ejecutivo Mensual:** Agrupación cronológica que calcula el total facturado (cantidad * precio_unitario), el volumen de pedidos y el ticket promedio por período.
2. **Ranking Top 5 de Productos:** Identificación de los 5 productos con mayor facturación generada y sus unidades totales vendidas mediante TOP 5 y ORDER BY.
3. **Clientes Recurrentes:** Segmentación de clientes que registran más de una compra histórica en el sistema utilizando la cláusula de filtrado avanzado HAVING COUNT(*) > 1.
4. **Análisis de Rendimiento con CTE (WITH):** Clasificación avanzada mediante una subconsulta estructurada y un CASE WHEN para etiquetar dinámicamente si cada producto se encuentra **'Por encima'** o **'Por debajo'** del promedio global de facturación a nivel de producto.
5. **Bloque de Cierre con Hallazgos:** Conclusiones estratégicas y métricas clave interpretadas a partir de la ejecución de los datos.

## Motor y Ejecución
- **Motor Utilizado:** Microsoft SQL Server (Compatible con SSMS y Azure Data Studio).
- **Instrucciones:** Abrir el archivo m4_consultas_negocio.sql en el entorno de SQL Server Management Studio (SSMS), seleccionarlo dentro del contexto de la base de datos Ventas_Tech_DB y presionar **F5** para ejecutar todo el bloque analítico de forma secuencial.

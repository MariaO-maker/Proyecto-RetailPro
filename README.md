# Ventas Tech DB

## Descripción del Proyecto
Este repositorio contiene el script estructurado en SQL Server para la creación, configuración e inserción de datos de un modelo dimensional orientado a un sistema de gestión de ventas tecnológicas (Ventas_Tech_DB). El modelo cumple 3NF e incluye tablas maestras de dimensiones (categorias, clientes, productos) y una tabla de hechos (ventas) con sus respectivas restricciones e integridad referencial.

## Motor de Base de Datos Utilizado
- **Microsoft SQL Server** (Compatible con SQL Server Management Studio - SSMS y Azure Data Studio).

## Pasos para ejecutar el script en SSMS
1. Abrir **SQL Server Management Studio (SSMS)** e iniciar sesión en tu servidor de base de datos local o remoto.
2. Hacer clic en el botón **New Query** (Nueva consulta) en la barra de herramientas superior.
3. Copiar y pegar todo el contenido del archivo `ventas_tech_db.sql` dentro del editor de consultas.
4. Hacer clic en **Execute** (Ejecutar) o presionar la tecla **F5**.
5. Revisar la pestaña de resultados para verificar que las consultas de validación devuelvan de manera correcta las filas esperadas (4 en categorías, 5 en clientes, 6 en productos y 10 en ventas).

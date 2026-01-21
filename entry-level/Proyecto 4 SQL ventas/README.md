# Proyecto 4 — Análisis de Ventas (SQL + Power BI)

##  Descripción General
Este proyecto analiza las ventas de enero y febrero de 2025 utilizando una base de datos creada en **PostgreSQL**, consultas SQL para obtener KPIs y análisis, y un dashboard final desarrollado en **Power BI**.

El objetivo principal es entender:
- La categoría más vendida
- El producto más rentable
- El mes con mayor facturación
- El ticket promedio
- Los productos estrella
- La evolución del total vendido por mes

Los datos fueron inicialmente cargados desde un archivo Excel → importados a SQL → transformados → visualizados en Power BI.

---

##  Objetivos del Proyecto
- Crear una tabla SQL y cargar datos desde un archivo CSV de ventas.
- Calcular métricas clave mediante consultas SQL.
- Transformar y validar los datos (limpieza básica).
- Exportar los resultados y construir un dashboard claro y profesional.
- Identificar patrones, productos destacados y tendencias por mes.

---

##  Herramientas Utilizadas
### **SQL / PostgreSQL**
- Creación de tablas
- Inserción de datos desde CSV
- Consultas con:
  - `SUM()`
  - `AVG()`
  - `GROUP BY`
  - `ORDER BY`
  - `DATE_TRUNC()`
- Cálculo de:
  - Ticket promedio
  - Facturación por mes
  - Producto más rentable

### **Power BI**
- KPI de facturación
- Gráficos de barras y columnas
- Segmentadores por mes y categoría
- Producto estrella por cantidad
- Comparación de ventas entre enero y febrero

---

##  Principales Insights
- **Categoría más vendida:** Tecnología  
- **Producto más rentable:** Monitor 24’’  
- **Mes con mayor facturación:** Enero
- **Ticket promedio:** ~$32.580  
- **Productos estrella:** Remera Oversize, Mousepad XL y  Mouse Gamer 

---

##  Archivos Incluidos
Dentro de esta carpeta encontrarás:

- `ventas.xlsx` → Dataset original  
- `proyecto_sql_ventas.sql` → Consultas SQL utilizadas  
- `proyecto 4.pbix` → Dashboard en Power BI  
- `Proyecto 4.pdf` → PDF del reporte  
- `README.md` → Este archivo  

---

##  Conclusiones
- Tecnología supera ampliamente a Indumentaria, tanto en facturación como en rentabilidad.  
- La presencia de productos de alto valor (monitores) impacta fuerte en el total mensual.  
- El ticket promedio se mantiene estable entre enero y febrero.  
- Los productos estrella surgen principalmente por volumen de unidades vendidas.  
- Un panel de Power BI permite visualizar rápidamente estos insights para la toma de decisiones.

---

##  Contacto
**Facundo Mazzieri**  
📧 facundodantemazz@gmail.com  
Córdoba, Argentina


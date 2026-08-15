# 🪙 Crypto Volatility & Market Pipeline (End-to-End Data Project)

![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=Databricks&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![PySpark](https://img.shields.io/badge/PySpark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![PowerBI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

 Pipeline End-to-End de Ingeniería y Analítica de Datos que ingiere cotizaciones de criptomonedas en tiempo real desde la API de CoinGecko, procesa la información en **Databricks** bajo la **Medallion Architecture (Bronze, Silver, Gold)** y genera métricas financieras de volatilidad consumidas en **Power BI**.

---

## 📐 Arquitectura de Datos

<img width="1402" height="673" alt="image" src="https://github.com/user-attachments/assets/b7a6dbb9-4862-40ac-8f9a-6cf1a1f22279" />

🎯 Objetivos del Proyecto
Ingesta Automatizada: Consumir el top 20 de criptomonedas por capitalización de mercado usando Python.

Medallion Architecture: Diseñar un flujo modular y escalable para almacenar datos estructurados y no estructurados en Databricks.

Métricas de Volatilidad: Calcular variaciones porcentuales de 24 horas y categorizar activos por nivel de riesgo (Alta, Moderada y Baja Volatilidad).

Visualización de Alto Impacto: Diseñar un dashboard interactivo en Power BI aplicando principios de UI/UX, formato condicional y matriz de riesgo/retorno.

🧰 Stack Tecnológico
Lenguajes: Python 3.x, SQL.

Procesamiento & Data Lakehouse: Databricks, PySpark, Delta Lake.

API: CoinGecko Public API (JSON).

Business Intelligence: Power BI Desktop.

Modelo de Datos: Esquema estrella y vistas agregadas para analítica.

Paso a Paso e Implementación
# Ejemplo del snippet de ingesta
import requests, json
from datetime import datetime

URL = "[https://api.coingecko.com/api/v3/coins/markets](https://api.coingecko.com/api/v3/coins/markets)"
PARAMS = {"vs_currency": "usd", "order": "market_cap_desc", "per_page": 20, "page": 1}

response = requests.get(URL, params=PARAMS)
# Almacenamiento en workspace.crypto_db.bronze_crypto_raw

2. Capa Silver (Limpieza y Estructuración)Mediante Spark SQL se aplican funciones from_json y explode para desestructurar los registros JSON, casteando precios, volúmenes y timestamps a tipos de datos numéricos y precisos.

3. Capa Gold (Métricas de Negocio)Creación de vistas agregadas que clasifican la volatilidad intradía y consolidan KPIs globales de mercado:Métricas activas: Capitalización total, volumen operado en 24h, variación porcentual promedio y rango de volatilidad $(High - Low) / Low$.

📊 Dashboard en Power BI
El reporte está diseñado con una paleta de colores financieros personalizada (Berkeley Blue, Imperial Red, Celadon Blue) y cuenta con:

Tarjetas KPI: Métricas globales en tiempo real.

Scatter Plot (Riesgo vs. Retorno): Distribución de capitalización de mercado frente a la variación porcentual.

Gráfico de Dona: Proporción de activos según su categoría de volatilidad.

Tabla Financiera: Cotizaciones detalladas con formato condicional (Rojo para caídas, Verde/Azul para incrementos).

<img width="1154" height="649" alt="image" src="https://github.com/user-attachments/assets/817ede31-6a85-40c3-915f-1a888ea9b248" />

👤 Autor
Desarrollador: Maximiliano Agustin Ríos Sueldo

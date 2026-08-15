# 🪙 Crypto Volatility & Market Pipeline (End-to-End Data Project)

![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=Databricks&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![PySpark](https://img.shields.io/badge/PySpark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![PowerBI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

 Pipeline End-to-End de Ingeniería y Analítica de Datos que ingiere cotizaciones de criptomonedas en tiempo real desde la API de CoinGecko, procesa la información en **Databricks** bajo la **Medallion Architecture (Bronze, Silver, Gold)** y genera métricas financieras de volatilidad consumidas en **Power BI**.

---

## 📐 Arquitectura de Datos

```text
[ CoinGecko API ] 
       │
       ▼ (Python / Requests)
┌──────────────┐
│  Capa BRONZE │  -> Datos crudos almacenados en formato Delta (`bronze_crypto_raw`)
└──────┬───────┘
       │
       ▼ (PySpark / SQL - Parsing de JSON & Casting)
┌──────────────┐
│  Capa SILVER │  -> Tablas limpias y estructuradas (`silver_crypto_prices`)
└──────┬───────┘
       │
       ▼ (SQL Aggregations & Logic)
┌──────────────┐
│   Capa GOLD  │  -> Vistas de KPIs y categorización de riesgo (`gold_crypto_volatility_summary`)
└──────┬───────┘
       │
       ▼ (Databricks Partner / Direct Connector)
  [ Power BI ] ──> Dashboard Financiero & Matriz de Riesgo/Retorno
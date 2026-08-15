%sql
-- 1. Vista de Resumen y Volatilidad por Criptomoneda
CREATE OR REPLACE VIEW workspace.crypto_db.gold_crypto_volatility_summary AS
SELECT
  coin_id,
  symbol,
  coin_name,
  current_price_usd,
  price_change_pct_24h,
  -- Cálculo de volatilidad intradía basada en el rango High/Low
  ROUND((high_24h_usd - low_24h_usd) / NULLIF(low_24h_usd, 0) * 100, 2) AS intraday_volatility_pct,
  -- Categorización de riesgo
  CASE 
    WHEN ABS(price_change_pct_24h) >= 5.0 THEN 'Alta Volatilidad'
    WHEN ABS(price_change_pct_24h) BETWEEN 2.0 AND 4.99 THEN 'Volatilidad Moderada'
    ELSE 'Baja Volatilidad'
  END AS volatility_category,
  market_cap_usd,
  total_volume_usd,
  last_updated_at,
  ingestion_timestamp
FROM workspace.crypto_db.silver_crypto_prices;

-- 2. Vista de KPIs Generales de Mercado
CREATE OR REPLACE VIEW workspace.crypto_db.gold_market_kpis AS
SELECT
  COUNT(DISTINCT coin_id) AS total_coins_monitored,
  SUM(market_cap_usd) AS total_market_cap_usd,
  SUM(total_volume_usd) AS total_volume_24h_usd,
  ROUND(AVG(price_change_pct_24h), 2) AS avg_24h_change_pct,
  MAX(ingestion_timestamp) AS data_last_refreshed_at
FROM workspace.crypto_db.silver_crypto_prices;

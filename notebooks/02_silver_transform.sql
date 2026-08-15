%sql
CREATE OR REPLACE TABLE workspace.crypto_db.silver_crypto_prices AS
WITH parsed_data AS (
  SELECT 
    ingestion_timestamp,
    explode(
      from_json(
        raw_json, 
        'ARRAY<STRUCT<
          id: STRING, 
          symbol: STRING, 
          name: STRING, 
          current_price: DOUBLE, 
          market_cap: DOUBLE, 
          total_volume: DOUBLE, 
          high_24h: DOUBLE, 
          low_24h: DOUBLE, 
          price_change_percentage_24h: DOUBLE, 
          last_updated: STRING
        >>'
      )
    ) AS coin
  FROM workspace.crypto_db.bronze_crypto_raw
)
SELECT
  coin.id AS coin_id,
  UPPER(coin.symbol) AS symbol,
  coin.name AS coin_name,
  CAST(coin.current_price AS DECIMAL(18,4)) AS current_price_usd,
  CAST(coin.market_cap AS DECIMAL(20,2)) AS market_cap_usd,
  CAST(coin.total_volume AS DECIMAL(20,2)) AS total_volume_usd,
  CAST(coin.high_24h AS DECIMAL(18,4)) AS high_24h_usd,
  CAST(coin.low_24h AS DECIMAL(18,4)) AS low_24h_usd,
  CAST(coin.price_change_percentage_24h AS DECIMAL(10,2)) AS price_change_pct_24h,
  TO_TIMESTAMP(coin.last_updated) AS last_updated_at,
  ingestion_timestamp
FROM parsed_data;

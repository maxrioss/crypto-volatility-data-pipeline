import requests
import json
from datetime import datetime
from pyspark.sql.types import StructType, StructField, StringType, TimestampType

# 1. Endpoint de CoinGecko (Top 20 por Market Cap)
URL = "https://api.coingecko.com/api/v3/coins/markets"
PARAMS = {
    "vs_currency": "usd",
    "order": "market_cap_desc",
    "per_page": 20,
    "page": 1,
    "sparkline": "false"
}

# 2. Ingesta de datos
response = requests.get(URL, params=PARAMS)
data = response.json()

# 3. Preparar registro con marca de tiempo
ingestion_time = datetime.now()
raw_record = [
    {
        "ingestion_timestamp": ingestion_time,
        "raw_json": json.dumps(data)
    }
]

# 4. Crear DataFrame PySpark
schema = StructType([
    StructField("ingestion_timestamp", TimestampType(), True),
    StructField("raw_json", StringType(), True)
])

df_bronze = spark.createDataFrame(raw_record, schema=schema)

# 5. Guardar en la capa Bronze
df_bronze.write.format("delta") \
    .mode("append") \
    .saveAsTable("workspace.crypto_db.bronze_crypto_raw")

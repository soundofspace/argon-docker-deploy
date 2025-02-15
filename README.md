## Bitcoin state image

```
# Build image
# Change BITCOIN_DATA_FOLDER to point to bitcoin data folder (eg /data/bitcoin)
docker compose build bitcoin-data
docker compose run bitcoin-data
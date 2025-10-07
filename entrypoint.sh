#!/bin/sh

# Baca RUN_ID dari file yang ada di dalam container
RUN_ID=$(cat /app/run_id.txt)

# Jalankan perintah mlflow serve dengan RUN_ID yang sudah dibaca
exec conda run -n mlflow-env mlflow models serve -m /app/mlruns/0/$RUN_ID/artifacts/model -h 0.0.0.0 -p 8080 --no-conda
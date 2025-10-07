#!/bin/sh
set -e

# Baris ini mengaktifkan perintah 'conda' di dalam skrip
. /opt/conda/etc/profile.d/conda.sh

# Aktifkan environment yang sudah kita buat
conda activate mlflow-env

# Baca RUN_ID dari file
RUN_ID=$(cat /app/run_id.txt)

# Sekarang jalankan mlflow serve secara langsung
echo "Starting MLflow server for run_id: $RUN_ID"
exec mlflow models serve -m /app/mlruns/0/$RUN_ID/artifacts/model -h 0.0.0.0 -p 8080 --no-conda
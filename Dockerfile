# Mulai dari base image Python
FROM python:3.11-slim

# Set direktori kerja di dalam container
WORKDIR /app

# Salin file dependensi dan instal
COPY ./MLProject/conda.yaml .
RUN pip install conda && conda env create -f conda.yaml -n mlflow-env

# Salin folder proyek MLProject
COPY ./MLProject /app

# --- PERUBAHAN DI SINI ---
# Ambil RUN_ID sebagai build argument dan simpan sebagai environment variable
ARG RUN_ID
ENV MLFLOW_RUN_ID=$RUN_ID
# --- SELESAI PERUBAHAN ---

# Perintah untuk menjalankan server prediksi MLflow saat container dijalankan
# Sekarang menggunakan environment variable
CMD exec conda run -n mlflow-env mlflow models serve -m /app/mlruns/0/$MLFLOW_RUN_ID/artifacts/model -h 0.0.0.0 -p 8080
# --- PERUBAHAN DI SINI: Mulai dari image yang sudah ada Conda ---
FROM continuumio/miniconda3

# Set direktori kerja di dalam container
WORKDIR /app

# Salin file dependensi
COPY ./MLProject/conda.yaml .

# --- PERUBAHAN DI SINI: Buat environment Conda dari file yaml ---
RUN conda env create -f conda.yaml

# Salin seluruh folder proyek MLProject
COPY ./MLProject /app

# Ambil RUN_ID sebagai build argument dan simpan sebagai environment variable
ARG RUN_ID
ENV MLFLOW_RUN_ID=$RUN_ID

# Perintah untuk menjalankan server prediksi MLflow saat container dijalankan
# Sekarang kita menggunakan 'conda run'
CMD exec conda run -n mlflow-env mlflow models serve -m /app/mlruns/0/$MLFLOW_RUN_ID/artifacts/model -h 0.0.0.0 -p 8080
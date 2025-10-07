# Mulai dari base image Python
FROM python:3.11-slim

# Set direktori kerja di dalam container
WORKDIR /app

# Salin file dependensi
COPY ./MLProject/conda.yaml .

# Instal dependensi dari file conda.yaml menggunakan pip
# Ini lebih cepat daripada membuat ulang lingkungan conda
RUN pip install mlflow==2.9.2 scikit-learn==1.3.2 pandas==2.1.1

# Salin folder proyek MLProject
COPY ./MLProject /app

# Perintah untuk menjalankan server prediksi MLflow saat container dijalankan
# Kita akan gunakan RUN_ID yang didapat dari workflow
ARG RUN_ID
CMD mlflow models serve -m /app/mlruns/0/$RUN_ID/artifacts/model -h 0.0.0.0 -p 8080
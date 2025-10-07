# Mulai dari base image Python
FROM python:3.11-slim

# Set direktori kerja di dalam container
WORKDIR /app

# Salin file dependensi
COPY ./MLProject/conda.yaml .

# Instal dependensi menggunakan Conda (lebih andal untuk ML)
RUN pip install conda && conda env create -f conda.yaml -n mlflow-env

# Salin model yang sudah dilatih (dari hasil run MLflow)
# Kita akan menyalin seluruh folder mlruns
COPY ./MLProject/mlruns /app/mlruns

# Perintah untuk menjalankan server prediksi MLflow saat container dijalankan
# Ganti <RUN_ID> dengan ID run yang sebenarnya nanti di workflow
ARG RUN_ID
CMD exec conda run -n mlflow-env mlflow models serve -m /app/mlruns/0/$RUN_ID/artifacts/model -h 0.0.0.0 -p 8080
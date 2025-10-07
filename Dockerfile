# Mulai dari base image Conda
FROM continuumio/miniconda3

# Set direktori kerja di dalam container
WORKDIR /app

# Salin file dependensi dan buat environment
COPY ./MLProject/conda.yaml .
RUN conda env create -f conda.yaml

# Salin seluruh isi folder proyek MLProject
COPY ./MLProject /app

# --- PERUBAHAN DI SINI ---
# Salin entrypoint script dan buat agar bisa dieksekusi
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Jalankan entrypoint script saat container dimulai
ENTRYPOINT ["./entrypoint.sh"]
# --- SELESAI PERUBAHAN ---
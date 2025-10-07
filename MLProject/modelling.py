import pandas as pd
import mlflow
import mlflow.sklearn
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

# 1. Muat data yang sudah diproses
# Path ini relatif, yang akan bekerja dengan benar saat dijalankan via 'mlflow run'
processed_data_path = "./namadataset_preprocessing/heart_disease_processed.csv"
df = pd.read_csv(processed_data_path)

# Pisahkan fitur (X) dan target (y)
X = df.drop("num", axis=1)
y = df["num"]

# Bagi data menjadi set pelatihan dan pengujian
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Memulai sebuah "Run" atau sesi eksperimen MLflow
with mlflow.start_run():
    
    # Latih model
    model = LogisticRegression(max_iter=1000)
    model.fit(X_train, y_train)

    # Prediksi & Evaluasi
    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    
    print(f"Accuracy: {accuracy}")

    # Catat parameter dan metrik
    mlflow.log_param("model_type", "LogisticRegression")
    mlflow.log_metric("accuracy", accuracy)
    
    # Catat model (artefak)
    mlflow.sklearn.log_model(model, "model")
    print("Model, parameter, dan metrik berhasil dicatat di folder mlruns.")

print("Skrip selesai.")
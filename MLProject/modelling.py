import pandas as pd
import mlflow
import mlflow.sklearn
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

# 1. Muat data
df = pd.read_csv("./namadataset_preprocessing/heart_disease_processed.csv")

# Pisahkan fitur dan target
X = df.drop("num", axis=1)
y = df["num"]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

with mlflow.start_run() as run:
    run_id = run.info.run_id
    # Simpan run_id di dalam folder MLProject
    with open("run_id.txt", "w") as f:
        f.write(run_id)

    # Latih model
    model = LogisticRegression(max_iter=1000)
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    
    # Logging
    mlflow.log_param("model_type", "LogisticRegression")
    mlflow.log_metric("accuracy", accuracy)
    mlflow.sklearn.log_model(model, "model")

    print(f"Accuracy: {accuracy}")
    print("Model, parameter, dan metrik berhasil dicatat.")

print("Skrip selesai.")
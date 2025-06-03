FROM python:3.11.-slim

WORKDIR /app

# Instala dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código
COPY . .

CMD ["python", "processing_files.py"]

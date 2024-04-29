FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y curl git

# Instala Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="${PATH}:/root/.local/bin"

WORKDIR /app

# Copia primero los archivos de configuración de Poetry para optimizar la cache de Docker
COPY pyproject.toml poetry.lock* /app/

# Instala las dependencias utilizando Poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-dev

# Copia el resto del código de la aplicación
COPY . /app

EXPOSE 5000

CMD ["python", "app.py"]

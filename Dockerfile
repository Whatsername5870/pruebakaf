FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


RUN pip install git+https://github.com/dpkp/kafka-python.git


# Actualiza los paquetes y instala curl y git
RUN apt-get update \
    && apt-get install -y curl git

# Instalar Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Asegúrate de que git está instalado correctamente
RUN git --version

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

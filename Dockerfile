# Usa una imagen base de Python.
FROM python:3.9-slim

# Establece variables de entorno para evitar la creación de archivos .pyc
ENV PYTHONDONTWRITEBYTECODE 1
# Establece una variable de entorno para que la salida de Python sea directa en lugar de almacenarse en buffer
ENV PYTHONUNBUFFERED 1

# Actualiza la lista de paquetes e instala las dependencias necesarias.
RUN apt-get update \
    # Instala curl para descargar Poetry y git para las dependencias que requieren git.
    && apt-get install -y curl git \
    # Limpia los archivos temporales del gestor de paquetes para reducir el tamaño del contenedor.
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instala Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Añade el directorio local bin a la variable PATH para asegurar que los binarios de Poetry sean accesibles
ENV PATH="${PATH}:/root/.local/bin"

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de configuración de Poetry en el contenedor
COPY pyproject.toml poetry.lock* /app/

# Configura Poetry para no crear un entorno virtual e instala las dependencias sin dependencias de desarrollo
RUN poetry config virtualenvs.create false \
    && poetry install --no-dev

# Comprueba que Git está correctamente instalado y accesible
RUN git --version

# Copia el resto de tu aplicación al contenedor
COPY . /app

# Expone el puerto 5000 para acceder a la aplicación
EXPOSE 5000

# Comando para ejecutar la aplicación Python
CMD ["python", "app.py"]

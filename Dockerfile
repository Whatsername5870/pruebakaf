
FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1

ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get install -y curl \
    && curl -sSL https://install.python-poetry.org | python3 -


ENV PATH="${PATH}:/root/.local/bin"

WORKDIR /app

COPY pyproject.toml poetry.lock* /app/
COPY mongo_manager.py /app/  

RUN poetry config virtualenvs.create false
RUN poetry install --no-dev

COPY . /app
EXPOSE 5000

CMD ["python", "app.py"]
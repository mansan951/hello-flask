FROM python:3.12-slim AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

FROM base AS test
RUN pip install --no-cache-dir pytest && pytest -q

FROM base AS final
EXPOSE 5000
CMD ["python", "app.py"]

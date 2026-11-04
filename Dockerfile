# Base Stage
FROM python:3.9-slim AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Test Stage (Used during 'docker build --target test')
FROM base AS test
RUN pytest  # or python test_app.py

# Production Stage (Final build image)
FROM base AS final
EXPOSE 5000
CMD ["python", "app.py"]

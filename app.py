FROM python:3.9-slim AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Stage 2: Test execution target used by Jenkins
FROM base AS test
RUN pytest

# Stage 3: Production runtime target
FROM base AS final
EXPOSE 5000
CMD ["python", "app.py"]

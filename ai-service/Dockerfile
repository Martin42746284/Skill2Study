FROM python:3.12-alpine

WORKDIR /app

# Installer les dépendances système + build tools pour numpy
RUN apk add --no-cache \
    gcc \
    g++ \
    musl-dev \
    postgresql-client \
    python3-dev \
    build-base

# Upgrade pip et installer build tools
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Copier requirements
COPY ai-service/requirements.txt .

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code
COPY ai-service/ ./

# Créer les répertoires
RUN mkdir -p models logs

EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=20s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Démarrer l'application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "4", "--timeout", "120", "app:app"]

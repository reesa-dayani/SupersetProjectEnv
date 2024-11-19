# Use an official Python runtime as the base image
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libssl-dev \
    libffi-dev \
    default-libmysqlclient-dev \
    curl \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /app

# Copy local files to the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install pillow  # Add Pillow installation for image handling

# Copy application code to the container
COPY . /app

# Expose Superset's port (Update to your preferred port)
EXPOSE 8086

# Set environment variables
ENV FLASK_APP=superset
ENV SUPERSET_CONFIG_PATH=/app/superset_config.py

# Initialize and start Superset
CMD ["sh", "-c", "superset db upgrade && \
                  superset fab create-admin \
                  --username ${SUPERSET_ADMIN_USERNAME} \
                  --firstname Admin \
                  --lastname User \
                  --email ${SUPERSET_ADMIN_EMAIL} \
                  --password ${SUPERSET_ADMIN_PASSWORD} && \
                  superset init && \
                  superset run -h 0.0.0.0 -p 8086"]

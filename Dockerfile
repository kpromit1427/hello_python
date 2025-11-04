FROM python:3.12-bullseye

# Install system dependencies required for venv and pip
RUN apt-get update && apt-get install -y \
    python3-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Optional: set working directory
WORKDIR /app

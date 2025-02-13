# Use an official Python image as a base
FROM python:3.11

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libffi-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python -m venv /app/venv

# Upgrade pip and install dependencies
RUN /app/venv/bin/pip install --upgrade pip && /app/venv/bin/pip install -r requirements.txt

# Expose Django's default port
EXPOSE 8000

# Run the application
CMD ["/app/venv/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]

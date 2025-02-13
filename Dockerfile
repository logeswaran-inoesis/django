# Use the official Python image
FROM python:3.11

# Set the working directory inside the container
WORKDIR /app

# Copy the application files to the container
COPY . .

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev gcc && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python -m venv /app/venv

# Install dependencies using the virtual environment's Python
RUN /app/venv/bin/pip install --upgrade pip && /app/venv/bin/pip install -r requirements.txt

# Expose Django's default port
EXPOSE 8000

# Start the application using Gunicorn
CMD ["/app/venv/bin/gunicorn", "--bind", "0.0.0.0:8000", "my_project.wsgi:application"]

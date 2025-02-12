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

# Create and activate a virtual environment
RUN python -m venv venv

# Install dependencies
RUN /bin/bash -c "source venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt"

# Expose Django's default port
EXPOSE 8000

# Start the application using Gunicorn
CMD ["/bin/bash", "-c", "source venv/bin/activate && gunicorn --bind 0.0.0.0:8000 my_project.wsgi:application"]

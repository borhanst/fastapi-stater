# Use the official Python image as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install uv
RUN pip install uv

# Set the working directory in the container
WORKDIR /app

# Copy the pyproject.toml and uv.lock files into the container at /app
COPY pyproject.toml uv.lock ./

# Install project dependencies using uv
RUN uv pip install --system --no-cache --locked -r pyproject.toml

# Copy the rest of the application code into the container at /app
COPY . .

# Expose the port the app runs on
EXPOSE 8090

# Define the command to run the application
CMD ["uvicorn", "config.server:app", "--host", "0.0.0.0", "--port", "8090"]

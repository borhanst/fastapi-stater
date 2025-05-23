# Stage 1: Builder
FROM python:3.11-slim-bullseye AS builder

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install uv to /usr/local/bin/
# Running sh as root, so uv gets installed to /root/.cargo/bin/uv initially
RUN curl -LsSf https://astral.sh/uv/install.sh | sh &&     mv /root/.cargo/bin/uv /usr/local/bin/uv

# Set working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml uv.lock ./

# Create a virtual environment and install dependencies
# This installs dependencies into /opt/venv
RUN uv venv /opt/venv &&     /opt/venv/bin/uv pip install --no-cache --locked -r pyproject.toml

# Stage 2: Final image
FROM python:3.11-slim-bullseye AS final

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH="/opt/venv/bin:$PATH"

# Create a non-root user and group
RUN groupadd -r appuser &&     useradd -r -g appuser -d /app -s /sbin/nologin appuser

# Set working directory
WORKDIR /app

# Copy virtual environment from builder stage
COPY --from=builder --chown=appuser:appuser /opt/venv /opt/venv

# Copy application code
# Ensure files copied here are owned by appuser
COPY --chown=appuser:appuser . .

# Switch to non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 8090

# Define the command to run the application
CMD ["uvicorn", "config.server:app", "--host", "0.0.0.0", "--port", "8090"]

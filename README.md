# fastapi-stater

A FastAPI starter template to quickly bootstrap your Python web projects. This template provides a basic project structure, server setup with Uvicorn, and configuration management.

## Getting Started

This section will guide you through setting up and running the project on your local machine.

### Prerequisites

Make sure you have the following installed:

*   **Python:** Version 3.8 or higher (as recommended for FastAPI and Uvicorn). You can check your Python version by running `python --version`.
*   **pip:** Python package installer. It usually comes with Python. You can check its version by running `pip --version`.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url> 
    cd fastapi-stater 
    ```
    *(Replace `<repository-url>` with the actual URL of this repository.)*

2.  **Create and activate a virtual environment (recommended):**

    You can use Python's built-in `venv` module:
    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

    Alternatively, if you are using `uv`:
    ```bash
    uv venv
    source .venv/bin/activate # On Windows use `.venv\Scripts\activate`
    ```
    *(Note: `uv` creates the virtual environment in a `.venv` directory by default.)*

3.  **Install dependencies:**
    The project uses a `pyproject.toml` file to manage dependencies.

    If you are using `pip` (ensure your virtual environment is activated):
    ```bash
    pip install .
    ```

    Alternatively, if you are using `uv` (ensure your virtual environment is activated, `uv venv` does this automatically if the venv doesn't exist, otherwise activate it first):
    ```bash
    uv pip install .
    ```
    *(These commands assume that your `pyproject.toml` is set up to define the project for installation, including its dependencies.)*

### Running the Development Server

Once the dependencies are installed, you can start the development server:

```bash
python main.py
```

The server will start on `http://0.0.0.0:8090` by default. You can access the application by opening this URL in your web browser.

## Configuration

The application's configuration is managed through Pydantic settings, located in `config/settings.py`.

You can define settings such as:

*   `ENV`: The application environment (e.g., "development", "production").
*   `DEBUG`: Toggles debug mode.

These settings can typically be overridden using environment variables. For example, to run in production mode, you might set:

```bash
export ENV=production
export DEBUG=False
python main.py
```

Refer to the `config/settings.py` file and the Pydantic documentation for more details on how to manage configurations.

## Running in Production

For production deployments, it's recommended to:

*   **Use a production-grade ASGI server:** Such as Gunicorn with Uvicorn workers. Example:
    ```bash
    gunicorn -k uvicorn.workers.UvicornWorker -w 4 -b 0.0.0.0:8000 config.server:app
    ```
    *(Adjust the number of workers (`-w`) and binding address (`-b`) as needed.)*
*   **Disable debug mode:** Ensure `DEBUG` is set to `False` in your configuration (e.g., via environment variables).
*   **Set `ENV` to `production`:** Ensure `ENV` is set to `"production"`. This will also disable the automatic API documentation UIs.
*   **Manage static files:** Configure a robust solution for serving static files if your application requires them.
*   **Configure logging:** Set up comprehensive logging for monitoring and troubleshooting.

Refer to the FastAPI deployment documentation and the documentation of your chosen ASGI server for detailed instructions.

## Project Structure

Here's a brief overview of the key files and directories in this starter template:

*   **`main.py`**: The main entry point to start the application using `typer`. It initializes and runs the Uvicorn server.
*   **`apps/`**: Intended to house different modules or applications of your project. You can structure your domain-specific logic here.
*   **`config/`**: Contains configuration files:
    *   **`server.py`**: Defines the FastAPI application instance, including middleware, routers, and error handlers.
    *   **`settings.py`**: Manages application settings using Pydantic.
    *   **`routers.py`**: Example of how to set up API routers. You would typically expand this or add more router files as your application grows.
*   **`pyproject.toml`**: Standard Python project file defining metadata, dependencies, and build system configuration.
*   **`README.md`**: This file – providing information about the project.

## Available API Endpoints

When running in development mode (`ENV="development"`), the following API documentation interfaces are available:

*   **Swagger UI:** [http://localhost:8090/docs](http://localhost:8090/docs)
*   **ReDoc:** [http://localhost:8090/redoc](http://localhost:8090/redoc)

These interfaces provide a convenient way to explore and test the available API endpoints. In production mode, these are disabled by default for security.
# fastapi-stater

## Running with Docker

This project is configured to run with Docker and Docker Compose.

### Prerequisites

*   [Docker](https://docs.docker.com/get-docker/)
*   [Docker Compose](https://docs.docker.com/compose/install/) (usually included with Docker Desktop)

### Setup and Running

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    cd <your-repository-directory>
    ```

2.  **Build and run the services:**
    Use Docker Compose to build the images and start the containers in detached mode:
    ```bash
    docker-compose up -d --build
    ```

### Services

The `docker-compose.yml` file defines the following services:

*   **`app`**: The main Python application.
    *   Accessible at: `http://localhost:8090`
*   **`postgres`**: PostgreSQL database.
    *   Host: `localhost` (from outside Docker network) or `postgres` (from within Docker network)
    *   Port: `5432`
    *   Credentials (default):
        *   User: `user`
        *   Password: `password`
        *   Database: `mydatabase`
*   **`mysql`**: MySQL database.
    *   Host: `localhost` (from outside Docker network) or `mysql` (from within Docker network)
    *   Port: `3306`
    *   Credentials (default):
        *   Root Password: `supersecret`
        *   User: `user`
        *   Password: `password`
        *   Database: `mydatabase`
*   **`mongo`**: MongoDB database.
    *   Host: `localhost` (from outside Docker network) or `mongo` (from within Docker network)
    *   Port: `27017`
    *   Credentials (default):
        *   Root User: `root`
        *   Root Password: `secret`
*   **`pgadmin`**: pgAdmin 4 for managing the PostgreSQL database.
    *   Accessible at: `http://localhost:5050`
    *   Credentials (default):
        *   Email: `admin@example.com`
        *   Password: `admin`
        You will need to configure a new server connection within pgAdmin to connect to the `postgres` service:
        *   Host name/address: `postgres` (this is the service name from `docker-compose.yml`)
        *   Port: `5432`
        *   Maintenance database: `mydatabase`
        *   Username: `user`
        *   Password: `password`

### Stopping the services

To stop all running services:
```bash
docker-compose down
```

To stop and remove volumes (deletes all data):
```bash
docker-compose down -v
```
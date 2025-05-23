import os

import typer
import uvicorn

# from core.config import config



def main():
    uvicorn.run(
        app="config.server:app",
        host="0.0.0.0",
        port=8090,
        reload=True,
        workers=1,
        
    )


if __name__ == "__main__":
    typer.run(main)

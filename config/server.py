from typing import List

from fastapi import FastAPI, Request, HTTPException
from fastapi.middleware import Middleware
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from config.routers import router
from config.settings import  settings as config

from fastapi.middleware.trustedhost import TrustedHostMiddleware


def init_routers(app_: FastAPI) -> None:
    app_.include_router(router)


def on_auth_error(request: Request, exc: Exception):
    status_code, error_code, message = 401, None, str(exc)
    if isinstance(exc, HTTPException):
        status_code = int(exc.code)
        error_code = exc.error_code
        message = exc.message

    return JSONResponse(
        status_code=status_code,
        content={"error_code": error_code, "message": message},
    )

origins = [
    "http://localhost:3000",
    "http://10.0.0.188:8003",
    "http://10.0.0.188:3000",
    "http://localhost",
    "http://127.0.0.1:5500"
]

def make_middleware() -> List[Middleware]:
    middleware = [
        Middleware(
            CORSMiddleware,
            allow_origins=origins,
            allow_credentials=True,
            allow_methods=["*"],
            allow_headers=["*"],
        )
    ]
    return middleware




def create_app() -> FastAPI:
    app_ = FastAPI(
        title="FastAPI Stater",
        description="FastAPI Stater Template",
        version="1.0.0",
        middleware=make_middleware(),
        docs_url=None if config.ENV == "production" else "/docs",
        redoc_url=None if config.ENV == "production" else "/redoc",
        swagger_ui_parameters={"defaultModelsExpandDepth": -1},
        # lifespan=lifespan
    )
    # app_.add_middleware(TrustedHostMiddleware, allowed_hosts=["localhot:3000", "10.0.0.188:8003", "10.0.0.188:3000", "127.0.0.1:5500"])
    # app_.mount("/static", StaticFiles(directory="static"), name="static")
    init_routers(app_=app_)
    return app_


app = create_app()

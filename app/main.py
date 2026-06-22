from fastapi import FastAPI

from app.routers import greet_router, hello_router


def create_app() -> FastAPI:
    app = FastAPI(title="Design First With Codex")
    app.include_router(hello_router)
    app.include_router(greet_router)
    return app


app = create_app()

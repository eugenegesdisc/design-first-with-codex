from fastapi import FastAPI

from app.routers import hello_router


def create_app() -> FastAPI:
    app = FastAPI(title="Design First With Codex")
    app.include_router(hello_router)
    return app


app = create_app()


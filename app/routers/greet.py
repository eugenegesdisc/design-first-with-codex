from typing import Annotated

from fastapi import APIRouter, HTTPException, Path

router = APIRouter()


@router.get("/greet/{name}")
def greet(name: Annotated[str, Path(max_length=50)]) -> dict[str, str]:
    if not name.strip():
        raise HTTPException(status_code=422, detail="Name must not be empty.")

    return {"greeting": f"Hello, {name}!"}

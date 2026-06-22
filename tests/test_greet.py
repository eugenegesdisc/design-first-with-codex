import httpx
import pytest

from app.main import app


@pytest.mark.anyio
@pytest.mark.parametrize(
    ("path", "expected_status", "expected_body"),
    [
        ("/greet/Ada", 200, {"greeting": "Hello, Ada!"}),
        ("/greet/John%20Doe", 200, {"greeting": "Hello, John Doe!"}),
        ("/greet/%20%20", 422, {"detail": "Name must not be empty."}),
    ],
)
async def test_greet_endpoint_handles_valid_and_invalid_names(
    path: str, expected_status: int, expected_body: dict[str, str]
) -> None:
    transport = httpx.ASGITransport(app=app)

    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
        response = await client.get(path)

    assert response.status_code == expected_status
    assert response.json() == expected_body


@pytest.mark.anyio
async def test_greet_endpoint_rejects_names_longer_than_fifty_characters() -> None:
    transport = httpx.ASGITransport(app=app)
    long_name = "a" * 51

    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
        response = await client.get(f"/greet/{long_name}")

    assert response.status_code == 422
    assert response.json()["detail"][0]["type"] == "string_too_long"

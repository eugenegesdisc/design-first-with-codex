import httpx
import pytest

from app.main import app


@pytest.mark.anyio
async def test_hello_world_route_returns_expected_payload() -> None:
    transport = httpx.ASGITransport(app=app)

    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:
        response = await client.get("/hello")

    assert response.status_code == 200
    assert response.json() == {"message": "Hello, world!"}

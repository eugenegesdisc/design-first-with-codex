# Design First With Codex

## FastAPI Hello World

This project includes a minimal FastAPI app with a hello-world endpoint.

Run the app:

```bash
mamba activate design-first-codex
python -m uvicorn app.main:app --reload
```

Open `http://127.0.0.1:8000/hello` to receive:

```json
{"message":"Hello, world!"}
```

Run the tests:

```bash
mamba activate design-first-codex
python -m pytest
```

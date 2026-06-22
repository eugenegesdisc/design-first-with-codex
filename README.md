# Design First With Codex

## FastAPI Hello World

This project includes a minimal FastAPI app with hello-world and personalized greeting endpoints.

Run the app:

```bash
mamba activate design-first-codex
python -m uvicorn app.main:app --reload
```

Open `http://127.0.0.1:8000/hello` to receive:

```json
{"message":"Hello, world!"}
```

Open `http://127.0.0.1:8000/greet/Ada` to receive:

```json
{"greeting":"Hello, Ada!"}
```

For names with spaces, URL-encode the path segment. Example:

`http://127.0.0.1:8000/greet/John%20Doe`

Response:

```json
{"greeting":"Hello, John Doe!"}
```

Invalid names such as blank whitespace or names longer than 50 characters return `422`.

Run the tests:

```bash
mamba activate design-first-codex
python -m pytest
```

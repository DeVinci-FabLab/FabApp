from fastapi import FastAPI
from uvicorn import run

from router.connection import connection, registration
from router.test import test
# from src import connection

app = FastAPI()
app.include_router(connection.router)
app.include_router(registration.router)
app.include_router(test.router)


@app.get("/", status_code=200)
async def root() -> dict:
    return {"message": "Well connected to the API"}


if __name__ == "__main__":
    run("main:app", host="0.0.0.0", port=8080, reload=True)

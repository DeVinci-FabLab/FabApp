import sys
from fastapi.testclient import TestClient

sys.path.append("./src")
from src.main import app


client = TestClient(app)


def test_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Well connected to the API"}


def test_mail_creation_incorrect_username():
    # incorrect username
    response = client.post("/users/register",
                           json={"username": "test_user@email.com",
                                 "email": "test@kodelab.fr",
                                 "password": "password"})
    assert response.status_code == 409
    assert response.json() == {
            "code": 409,
            "message": "Username must not contain @"}


def test_mail_creation_short_password():
    # too_short password
    response = client.post("/users/register",
                           json={"username": "test_user",
                                 "email": "test@kodelab.fr",
                                 "password": "short"})
    assert response.status_code == 409

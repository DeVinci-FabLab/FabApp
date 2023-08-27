from pydantic import BaseModel


# PYDANTIC
class UserBase(BaseModel):
    username: str

    def __repr__(self):
        return f"<UserBase(username={self.username})>"

    def __str__(self):
        return f"<UserBase(username={self.username})>"


class UserCreation(UserBase):
    email: str
    password: str

    def __repr__(self):
        return f"<User(username={self.username}, \
                email={self.email}, password={self.password})>"

    def __str__(self):
        return f"<User(username={self.username}, \
                email={self.email}, password={self.password})>"

from .users import UserCreation
from .email_utils import is_email


def format_user(user: UserCreation) -> dict:
    if is_email(user.email):
        if not is_email(user.username):
            if len(user.password) >= 8:
                return {"code": 0}
            else:
                return {"code": 409,
                        "message": "Password must be at least 8 characters"}
        else:
            return {"code": 409,
                    "message": "Username must not contain @"}
    else:
        return {"code": 409,
                "message": "Email must be a valid email"}

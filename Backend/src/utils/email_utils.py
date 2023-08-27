from dotenv import load_dotenv
import os
from pydantic import EmailStr, BaseModel
from typing import List, Union, Optional

# import smtplib
import re
import smtplib
from fastapi_mail import ConnectionConfig, MessageSchema, MessageType

load_dotenv()
regex = r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b"


server = smtplib.SMTP(os.getenv("MAIL_SERVER", ""), 587)
server.sendmail


conf = ConnectionConfig(
    MAIL_USERNAME=os.getenv("EMAIL", default=""),
    MAIL_PASSWORD=os.getenv("MAIL_PASSWORD", default=""),
    MAIL_FROM=os.getenv("EMAIL", default=""),
    MAIL_PORT=int(os.getenv("MAIL_PORT", default="") or 0),
    MAIL_SERVER=os.getenv("MAIL_SERVER", default=""),
    MAIL_STARTTLS=False,
    MAIL_SSL_TLS=True,
)


class EmailSchema(BaseModel):
    email: List[EmailStr]


def MessageSchemaDefinition(recipients: List[EmailStr], subject: str, body:  Optional[Union[str, list]], subtype: MessageType):
    return MessageSchema(
        recipients=recipients,
        subject=subject,
        body=body,
        subtype=subtype
    )


def is_email(email: str) -> bool:
    if re.fullmatch(regex, email):
        return True
    else:
        return False


def send_email():
    pass

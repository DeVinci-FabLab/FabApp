from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Mapped
from sqlalchemy.orm import mapped_column
from sqlalchemy import DateTime
from sqlalchemy.sql import func
import datetime
# improt from files
from .db import Base


class User(Base):
    __tablename__ = "users"
    id: Mapped[int] = mapped_column(primary_key=True)
    username: Mapped[str] = mapped_column(unique=True)
    email: Mapped[str] = mapped_column(unique=True)
    password: Mapped[str] = mapped_column()


class TempUser(Base):
    __tablename__ = "temp_users"
    id: Mapped[int] = mapped_column(primary_key=True)
    username: Mapped[str] = mapped_column(unique=True)
    email: Mapped[str] = mapped_column(unique=True)
    password: Mapped[str] = mapped_column()
    number: Mapped[str] = mapped_column(unique=True)
    exp: Mapped[int]= mapped_column()

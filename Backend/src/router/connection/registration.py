# fastapi
from fastapi import APIRouter, Depends
# sqlalchemy
from sqlalchemy.exc import IntegrityError
from sqlalchemy import select, or_, update, delete
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import cast, Date, Result
from fastapi.responses import JSONResponse
from fastapi_mail import FastMail, MessageType
from utils.email_utils import conf, MessageSchemaDefinition
# internal imports
from utils.db import get_db
from utils.models import User, TempUser
from utils.users import UserCreation
from utils.format import format_user
# scrypting
from argon2 import PasswordHasher
import jwt
# utils
import os
from datetime import datetime, timedelta, timezone
from dotenv import load_dotenv
from random import randint
# typing
from typing import Tuple

ph = PasswordHasher(hash_len=64,
                    parallelism=8,
                    memory_cost=4096,
                    time_cost=192)

router = APIRouter(prefix="/users",
                   tags=["users"],
                   responses={200: {"description": "Welcome on users route"}},
                   )
load_dotenv()


@router.post("/register")
async def index(user: UserCreation,
                db: AsyncSession = Depends(get_db)) -> JSONResponse:
    results = await db.execute(
            select(User.id)
            .filter(or_(User.username == user.username,
                        User.email == user.email)))
    password = str(results.scalar())
    if password != "None":
        return JSONResponse(status_code=409,
                            content={"code": 409,
                                     "message": "User already exists"})
    format = format_user(user)
    if format["code"] == 0:
        # Hash the password
        hash = ph.hash(user.password)
        # Generate a random number and send it to the user
        number: str = f"{randint(0, 999999):06}"
        number_hash = ph.hash(number)
        try:
            html = f"<p>Please enter this number: {number}\
                    in the application</p>"
            message = MessageSchemaDefinition([user.email],
                                              "Authentification number",
                                              html,
                                              MessageType.html)
            fm = FastMail(conf)
            await fm.send_message(message)
        except Exception as e:
            return JSONResponse(status_code=500,
                                content={"code": 500, "message": e.args[0]})
        # Send user data to the database
        try:
            db_user = TempUser(
                    username=user.username,
                    email=user.email,
                    password=hash,
                    number=number_hash,
                    exp=cast(datetime.now()+timedelta(hours=2), Date)
                    )
            db.add(db_user)
            await db.commit()
            await db.refresh(db_user)
            exp = datetime.now(timezone.utc)+timedelta(hours=24)
            encoded = jwt.encode({"username": str(user.username),
                                  "exp": exp},
                                 os.getenv("JWT_SECRET"),
                                 algorithm="HS256")
            return JSONResponse(
                    status_code=202,
                    content={"code": 0,
                             "message": f"{encoded}"})
        except IntegrityError as e:
            if e.code == "gkpj":
                return JSONResponse(
                        status_code=409,
                        content={"code": 409, "message": e.args[0]})
            else:
                return JSONResponse(
                        status_code=409,
                        content={"code": 409, "message": e.args[0]})
    else:
        return JSONResponse(status_code=409,
                            content=format)


# ou envoyer token ou alors envoyer username
@router.post("/confirm")
async def confirm_user(number: str,
                       token: str,
                       db: AsyncSession = Depends(get_db)) -> JSONResponse:
    # Check if the token is valid and get username
    try:
        jwt_token = jwt.decode(
                token,
                str(os.getenv("JWT_SECRET")),
                algorithms=["HS256"])
        user = jwt_token.get("username")
    except jwt.exceptions.DecodeError as e:
        return JSONResponse(status_code=401,
                            content={"code": 401,
                                     "message": e.args[0]})
    # Check if the number is valid
    try:
        results: Result[Tuple[TempUser]] = await db.execute(
                select(TempUser)
                .filter(TempUser.username == user)
                )
        user: TempUser | None = results.scalar()
        if user is None:
            return JSONResponse(status_code=404,
                                content={"code": 404,
                                         "message": "User not found"})
        if ph.verify(user.number, number):
            db_user = User(
                    username=user.username,
                    email=user.email,
                    password=user.password,
                    )
            db.add(db_user)
            await db.execute(delete(TempUser)
                             .where(TempUser.username == user.username))
            await db.commit()
            await db.refresh(db_user)
            return JSONResponse(status_code=202,
                                content={"code": 0,
                                         "message": "User created"})
        else:
            return JSONResponse(status_code=402,
                                content={"code": 402,
                                         "message": "Invalid number"})
    except Exception as e:
        return JSONResponse(status_code=401,
                            content={"code": 401,
                                     "message": e.args[0]})


@router.get("/new_code")
async def new_code(token: str, db: AsyncSession = Depends(get_db)):
    try:
        jwt_token = jwt.decode(
                token,
                str(os.getenv("JWT_SECRET")),
                algorithms=["HS256"])
        username = jwt_token.get("username")
    except jwt.exceptions.DecodeError:
        return JSONResponse(status_code=401,
                            content={"code": 401,
                                     "message": "User deleted"})
    results: Result[Tuple[str]] = await db.execute(
            select(TempUser.email)
            .filter(TempUser.username == username)
            )
    user: str | None = results.scalar()
    if user is None:
        return JSONResponse(status_code=404,
                            content={"code": 404,
                                     "message": "User not found"})
    number: str = f"{randint(0, 999999):06}"
    number_hash = ph.hash(number)
    try:
        html = f"<p>Please enter this number: {number}\
                in the application</p>"
        message = MessageSchemaDefinition([user],
                                          "Authentification number",
                                          html,
                                          MessageType.html)
        fm = FastMail(conf)
        await fm.send_message(message)
    except Exception as e:
        return JSONResponse(status_code=500,
                            content={"code": 500, "message": e.args[0]})
    try:
        await db.execute(
                update(TempUser)
                .where(TempUser.username == username)
                .values(number=number_hash,
                        exp=cast(datetime.now()+timedelta(hours=2), Date))
                )
        await db.commit()

        await db.commit()
        # await db.refresh(user)
        return JSONResponse(status_code=202,
                            content={"code": 0,
                                     "message": "New code sent"})
    except Exception as e:
        return JSONResponse(status_code=401,
                            content={"code": 401,
                                     "message": e.args[0]})

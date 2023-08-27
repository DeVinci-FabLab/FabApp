from fastapi import APIRouter, Depends
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from fastapi.responses import JSONResponse
# crypting
import argon2
from argon2 import PasswordHasher
import jwt
# database
from utils.db import get_db
from utils.models import User
from sqlalchemy import select, or_
from sqlalchemy.ext.asyncio import AsyncSession
# utils
import os
from dotenv import load_dotenv
from typing import Annotated
from datetime import datetime, timedelta, timezone


router = APIRouter(prefix="/users",
                   tags=["users"],
                   responses={200: {"description": "Welcome on users route"}},
                   )
security = HTTPBasic()
load_dotenv()


@router.post("/login")
async def login(
        credentials: Annotated[HTTPBasicCredentials, Depends(security)],
        db: AsyncSession = Depends(get_db)):
    try:
        results = await db.execute(
                select(User.password)
                .filter(or_(User.username == credentials.username,
                            User.email == credentials.username)))
        password = str(results.scalar())
    except Exception as e:
        return JSONResponse(status_code=409,
                            content={"code": 409,
                                     "message": e.args[0]})
    ph = PasswordHasher()
    try:
        if ph.verify(password, credentials.password):
            try:
                exp = datetime.now(timezone.utc)+timedelta(hours=24)
                encoded = jwt.encode({"username": str(credentials.username),
                                      "exp": exp, },
                                     os.getenv("JWT_SECRET"),
                                     algorithm="HS256")
                return JSONResponse(status_code=202,
                                    content={"code": 0,
                                             "message": f"{encoded}"})
            except jwt.exceptions.InvalidKeyError as e:
                return JSONResponse(status_code=500,
                                    content={"code": 500,
                                             "message": e.args[0]})
    except argon2.exceptions.VerifyMismatchError as e:
        return JSONResponse(status_code=401,
                            content={"code": 401, "message": e.args[0]})

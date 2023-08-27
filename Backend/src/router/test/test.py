from fastapi import APIRouter, Depends
# sqlalchemy
import sqlalchemy
from sqlalchemy.ext.asyncio import AsyncSession
# utils db
from utils.db import get_db
from utils.models import User, TempUser
# utils
import jwt
import os
from datetime import datetime
from dotenv import load_dotenv


router = APIRouter(prefix="/test",
                   tags=["test"],
                   responses={200: {"description": "Welcome on users route"}},
                   )
load_dotenv()


@router.get("/test_token")
async def test_token(token: str):
    try:
        decode = jwt.decode(token,
                            os.getenv("JWT_SECRET"),
                            algorithms=["HS256"])
        if decode.get("exp") > datetime.now().timestamp():
            return {"code": 0,
                    "message": "Token is valid"}
    except jwt.exceptions.DecodeError as e:
        return {"code": 401,
                "message": e.args[0]}
    except jwt.exceptions.ExpiredSignatureError as e:
        return {"code": 401,
                "message": e.args[0]}


@router.get("/reset")
async def reset(db: AsyncSession = Depends(get_db)):
    await db.execute(sqlalchemy.delete(User).where(User.id > 0))
    await db.commit()
    await db.execute(sqlalchemy.delete(TempUser).where(TempUser.id > 0))
    await db.commit()
    return {"message": "Database reset"}

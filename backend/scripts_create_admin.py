import getpass
import os
import sys

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.models.user import User
from app.core.security import hash_password

load_dotenv(".env")

database_url = os.getenv("DATABASE_URL")

if not database_url:
    raise SystemExit("ERROR: DATABASE_URL is not configured")

engine = create_engine(database_url)
SessionLocal = sessionmaker(bind=engine)

username = input("Username: ").strip()
password = getpass.getpass("Password: ")
confirm = getpass.getpass("Confirm password: ")

if len(username) < 3 or len(username) > 100:
    raise SystemExit("ERROR: Username must be 3-100 characters")

if len(password) < 8 or len(password) > 128:
    raise SystemExit("ERROR: Password must be 8-128 characters")

if password != confirm:
    raise SystemExit("ERROR: Passwords do not match")

db = SessionLocal()

try:
    existing = db.query(User).filter(User.username == username).first()

    if existing:
        raise SystemExit("ERROR: Username already exists")

    user = User(
        username=username,
        password_hash=hash_password(password),
        role="admin",
        is_active=1
    )

    db.add(user)
    db.commit()
    db.refresh(user)

    print()
    print("===== USER CREATED =====")
    print("User ID :", user.id)
    print("Username:", user.username)
    print("Role    :", user.role)
    print("Active  :", bool(user.is_active))
    print("Password: securely hashed")

except Exception:
    db.rollback()
    raise
finally:
    db.close()

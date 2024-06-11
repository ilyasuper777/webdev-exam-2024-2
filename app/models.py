import os
from typing import Optional, Union, List
from datetime import datetime
import sqlalchemy as sa
from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin
from flask import url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import String, ForeignKey, DateTime, Text, Integer, MetaData
from users_policy import UsersPolicy


class Base(DeclarativeBase):
  metadata = MetaData(naming_convention={
        "ix": 'ix_%(column_0_label)s',
        "uq": "uq_%(table_name)s_%(column_0_name)s",
        "ck": "ck_%(table_name)s_%(constraint_name)s",
        "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
        "pk": "pk_%(table_name)s"
    })

db = SQLAlchemy(model_class=Base)

class Genre(Base):
    __tablename__ = 'genres'

    id = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(100))

    def __repr__(self):
        return '<Genre %r>' % self.name

class Book_Genre(Base):
    __tablename__ = 'books_genres'
    id = mapped_column(Integer, primary_key=True)
    book_id: Mapped[int] = mapped_column(ForeignKey("books.id"))
    genre_id: Mapped[int] = mapped_column(ForeignKey("genres.id"))
    
    genre: Mapped["Genre"] = relationship()
    book: Mapped["Book"] = relationship()

    def __repr__(self):
        return '<Book_Genre %r>' % self.id

class Book(Base):
    __tablename__ = 'books'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(100))
    short_desc: Mapped[str] = mapped_column(Text)
    year: Mapped[int] = mapped_column(default=0)
    publisher: Mapped[str] = mapped_column(String(100))
    author: Mapped[str] = mapped_column(String(100))
    volume: Mapped[int] = mapped_column(default=0)
    image_id: Mapped[int] = mapped_column(ForeignKey("images.id"))
    
    bg_image: Mapped["Image"] = relationship()

    def __repr__(self):
        return '<Book %r>' % self.name
    
    rating_sum: Mapped[int] = mapped_column(default=0)
    rating_num: Mapped[int] = mapped_column(default=0)
    @property
    def rating(self):
        if self.rating_num > 0:
            return self.rating_sum / self.rating_num
        return 0
    

class Image(Base):
    __tablename__ = 'images'

    id: Mapped[str] = mapped_column(String(100), primary_key=True)
    file_name: Mapped[str] = mapped_column(String(100))
    mime_type: Mapped[str] = mapped_column(String(100))
    md5_hash: Mapped[str] = mapped_column(String(100), unique=True)
    object_id: Mapped[Optional[int]]
    object_type: Mapped[Optional[str]] = mapped_column(String(100))
    created_at: Mapped[datetime] = mapped_column(default=datetime.now)

    def __repr__(self):
        return '<Image %r>' % self.file_name

    @property
    def storage_filename(self):
        _, ext = os.path.splitext(self.file_name)
        return self.id + ext

    @property
    def url(self):
        return url_for('image', image_id=self.id)

class Review(Base):
    __tablename__ = 'reviews'

    id: Mapped[int] = mapped_column(primary_key=True) # -- идентификатор отзыва, 
    rating: Mapped[int] = mapped_column(nullable=False) # -- оценка, которую пользователь проставил курсу (целое число от 0 до 5), 
    text: Mapped[str] = mapped_column(Text, nullable=False) # -- текст отзыва, 
    created_at: Mapped[datetime] = mapped_column(default=datetime.now) # -- дата и время создания отзыва,  
    book_id: Mapped[int] = mapped_column(ForeignKey("books.id")) # -- идентификатор книги, 
    user_id: Mapped[int] = mapped_column(ForeignKey("users.id")) # -- идентификатор пользователя. 
    
    book: Mapped["Book"] = relationship()
    user: Mapped["User"] = relationship()

    def __repr__(self):
        return '<Review %r>' % self.id

class User(Base, UserMixin):
    __tablename__ = 'users'

    id: Mapped[int] = mapped_column(primary_key=True)
    login: Mapped[str] = mapped_column(String(100), unique=True)
    password_hash: Mapped[str] = mapped_column(String(200))
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    first_name: Mapped[str] = mapped_column(String(100))
    last_name: Mapped[str] = mapped_column(String(100))
    middle_name: Mapped[Optional[str]] = mapped_column(String(100))
    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])

    def __repr__(self):
        return '<User %r>' % self.login
    
    role_id: Mapped[int] = mapped_column(ForeignKey("roles.id")) # -- идентификатор пользователя.
    
    role: Mapped["Role"] = relationship()

    def is_admin(self):
        return self.role.name == "администратор"
    
    def is_moderator(self):
        return self.role.name == "модератор" 

    def can(self, action, record=None):
        policy = UsersPolicy(record)
        method = getattr(policy, action, None)
        if method == None:
            return False
        else: 
            return method()


class Role(Base):
    __tablename__ = 'roles'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(100))
    desc: Mapped[str] = mapped_column(Text)

    def __repr__(self):
        return '<Role %r>' % self.name
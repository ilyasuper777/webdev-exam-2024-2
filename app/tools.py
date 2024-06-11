import hashlib
import uuid
import os
from werkzeug.utils import secure_filename
from flask import current_app
from models import db, Book, Image, Book_Genre

class BooksFilter:
    def __init__(self, name, genre_ids, years, author, volume_start, volume_finish):
        self.name = name
        self.genre_ids = genre_ids
        self.years = years
        self.author = author
        self.volume_start = volume_start
        self.volume_finish = volume_finish
        self.query = db.select(Book)

    def perform(self):
        self.__filter_by_name()
        self.__filter_by_genre_ids()
        self.__filter_by_years()
        self.__filter_by_author()
        self.__filter_by_volume_start()
        self.__filter_by_volume_finish()
        return self.query.order_by(Book.year.desc())

    def __filter_by_name(self):
        if self.name:
            self.query = self.query.filter(
                Book.name.ilike('%' + self.name + '%'))
            
    # Используется таблица Book_Genre
    def __filter_by_genre_ids(self):
        if self.genre_ids:
            query2 = db.select(Book_Genre.book_id).filter(Book_Genre.genre_id.in_(self.genre_ids))
            self.query = self.query.filter(
            Book.id.in_(query2))
           
    def __filter_by_years(self):
        if self.years:
            self.query = self.query.filter(
                Book.year.in_(self.years))

    def __filter_by_author(self):
        if self.author:
            self.query = self.query.filter(
                Book.author.ilike('%' + self.author + '%'))

    def __filter_by_volume_start(self):
        if self.volume_start:
            self.query = self.query.filter(
                Book.volume >= self.volume_start)

    def __filter_by_volume_finish(self):
        if self.volume_finish:
            self.query = self.query.filter(
                Book.volume <= self.volume_finish)


class ImageSaver:
    def __init__(self, file):
        self.file = file

    def save(self):
        self.img = self.__find_by_md5_hash()
        if self.img is not None:
            return self.img
        file_name = secure_filename(self.file.filename)
        self.img = Image(
            id=str(uuid.uuid4()),
            file_name=file_name,
            mime_type=self.file.mimetype,
            md5_hash=self.md5_hash)
        self.file.save(
            os.path.join(current_app.config['UPLOAD_FOLDER'],
                         self.img.storage_filename))
        db.session.add(self.img)
        db.session.commit()
        return self.img

    def __find_by_md5_hash(self):
        self.md5_hash = hashlib.md5(self.file.read()).hexdigest()
        self.file.seek(0)
        return db.session.execute(db.select(Image).filter(Image.md5_hash == self.md5_hash)).scalar()

from flask import Blueprint, render_template, request, flash, redirect, url_for, current_app, session
from flask_login import login_required, current_user
from sqlalchemy.exc import IntegrityError
from models import db, Book, Genre, User, Review, Book_Genre, Image
from tools import BooksFilter, ImageSaver
from sqlalchemy import desc, func, delete
from math import ceil
import os
from auth import check_rights

bp = Blueprint('books', __name__, url_prefix='/books')

BOOK_PARAMS = [
    'name', 'short_desc', 'year', 'publisher', 'author', 'volume'
]

def params():
    return { p: request.form.get(p) or None for p in BOOK_PARAMS }

def search_params():
    return {
        'name': request.args.get('name'),
        'genre_ids': [x for x in request.args.getlist('genre_ids') if x],
    }

@bp.route('/')
def index():
    book = BooksFilter(**search_params()).perform()
    pagination = db.paginate(book, per_page=current_app.config["PER_PAGE"])
    books = pagination.items
    genres = db.session.execute(db.select(Genre)).scalars()
    return render_template('books/index.html',
                           books=books,
                           genres=genres,
                           pagination=pagination,
                           search_params=search_params())

@bp.route('/new')
@login_required
@check_rights('create_book')
def new():
    book = Book()
    genres = db.session.execute(db.select(Genre)).scalars()
    return render_template('books/new.html',
                           genres=genres,
                           book=book)

@bp.route('/create', methods=['POST'])
@login_required
@check_rights('create_book')
def create():
    f = request.files.get('background_img')
    img = None
    try:
        if f and f.filename:
            img = ImageSaver(f).save()

        image_id = img.id if img else None
        book = Book(**params(), image_id=image_id)
        db.session.add(book)
        db.session.commit()

        # запись в books_genres
        genre_ids=request.form.getlist("genre_id")
        for genre_id in genre_ids:
            record_in_book_genre = Book_Genre(genre_id=genre_id, book_id=book.id)
            db.session.add(record_in_book_genre)
        db.session.commit()

    except IntegrityError as err:
        flash(f'Возникла ошибка при записи данных в БД. Проверьте корректность введённых данных. ({err})', 'danger')
        db.session.rollback()
        genres = db.session.execute(db.select(Genre)).scalars()
        return render_template('books/new.html',
                            genres=genres,
                            book=book)

    flash(f'Книга {book.name} была успешно добавлена!', 'success')

    return redirect(url_for('books.index'))

@bp.route('/<int:book_id>/form_of_edit')
@login_required
@check_rights('edit_book')
def form_of_edit(book_id):
    book = db.get_or_404(Book, book_id)
    genres = db.session.execute(db.select(Genre)).scalars()
    selected_genres = db.session.execute(db.select(Book_Genre.genre_id).filter_by(book_id=book_id))
    selected_genres = [i.genre_id for i in list(selected_genres)]
    return render_template('books/edit.html',
                           genres=genres,
                           book=book,
                           selected_genres=selected_genres)

@bp.route('/<int:book_id>/edit', methods=['POST'])
@login_required
@check_rights('edit_book')
def edit(book_id):
    try:
        book = db.get_or_404(Book, book_id)
        book.name = request.form.get("name")
        book.short_desc = request.form.get("short_desc")
        book.year = request.form.get("year")
        book.publisher = request.form.get("publisher")
        book.author = request.form.get("author")
        book.volume = request.form.get("volume")
        db.session.commit()

        # удаление в books_genres
    
        book_genres =  db.session.query(Book_Genre).filter_by(book_id=book_id).all() 
        for book_genre in book_genres: 
            db.session.delete(book_genre) 
        db.session.commit()

        # запись в books_genres
        genre_ids=request.form.getlist("genre_id")
        for genre_id in genre_ids:
            record_in_book_genre = Book_Genre(genre_id=genre_id, book_id=book.id)
            db.session.add(record_in_book_genre)
        db.session.commit()

    except IntegrityError as err:
        flash(f'Возникла ошибка при записи данных в БД. Проверьте корректность введённых данных. ({err})', 'danger')
        db.session.rollback()
        genres = db.session.execute(db.select(Genre)).scalars()
        return render_template('books/edit.html',
                            genres=genres,
                            book=book)

    flash(f'Книга {book.name} была успешно изменена!', 'success')

    return redirect(url_for('books.show', book_id=book_id))


@bp.route('/<int:book_id>/delete', methods=['GET','POST'])
@login_required
@check_rights('delete_book')
def delete(book_id):
    try:
        book = db.get_or_404(Book, book_id)
        # удаление в books_genres
        book_genres =  db.session.query(Book_Genre).filter_by(book_id=book_id).all() 
        for book_genre in book_genres: 
            db.session.delete(book_genre) 
        db.session.commit()
        
        # удаление в reviews
        reviews = db.session.query(Review).filter_by(book_id=book_id).all()
        for review in reviews: 
            db.session.delete(review) 
        db.session.commit()

        # удаление в books
        image_id = book.image_id
        book = db.get_or_404(Book, book_id)
        db.session.delete(book)
        db.session.commit()

        # удаление в images
        images = db.session.query(Image).filter_by(id=image_id).all()
        if len(images) == 1:
            for image in images:
                db.session.delete(image)
                db.session.commit()
                split_tup = os.path.splitext(image.file_name) # получение расширения
                path_to_img = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'media', 'images', image.id + split_tup[1]) 
                os.remove(path_to_img) 

    except IntegrityError as err:
        flash(f'Возникла ошибка при записи данных в БД. Проверьте корректность введённых данных. ({err})', 'danger')
        db.session.rollback()
        return redirect(url_for('books.show', book_id=book.id))

    flash(f'Книга {book.name} была успешно удалена!', 'success')
    return redirect(url_for('books.index'))

@bp.route('/<int:book_id>', methods=['GET','POST'])
def show(book_id):
    book = db.get_or_404(Book, book_id)
    review_exist = False
    review_cur_user = ""
    if current_user.is_authenticated:
        check = db.session.execute(db.select(Review).filter_by(user_id=current_user.get_id(), book_id=book.id)).scalar() # проверка к БД, что пользователь не оставлял review к курсу
        if request.method == "POST" and check is None:
            grade = int(request.form.get("grade", 0))
            comment = request.form.get("comment", 0)
            book.rating_sum += grade
            book.rating_num += 1
            new_reviews = Review(
                rating = grade,
                text = comment,
                book_id = book_id,
                user_id = current_user.id
            )
            db.session.add(new_reviews)
            db.session.commit()
        if request.method == "POST" and check is not None:
            flash(f'Вы уже оставляли отзыв !!!!!!!!!!!', 'danger')
        review_cur_user = db.session.query(Review).filter(Review.user_id == current_user.id, Review.book_id == book.id).all()
        review_exist = len(review_cur_user) != 0
    #5 последний отзывов о курсе
    reviews = db.session.execute(db.select(Review).filter_by(book_id=book_id).order_by(desc(Review.created_at)).limit(5)).scalars()

    # запрос к БД для genres

    list_of_genres_id = db.session.execute(db.select(Book_Genre).filter_by(book_id=book_id)).scalars()
    sposok_genres_id = [i.genre_id for i in list(list_of_genres_id)]
    list_genres = db.session.execute(db.select(Genre).filter(Genre.id.in_(sposok_genres_id))).scalars()
    genres = [i.name for i in list(list_genres)]

    return render_template('books/show.html',book=book, reviews=reviews, review_exist=review_exist, review_cur_user=review_cur_user, genres=genres)

@bp.route('/<int:book_id>/reviews', methods=['GET','POST'])
@login_required
@check_rights('view_reviews')
def show_reviews(book_id):
    book = db.get_or_404(Book, book_id)
    check = None
    check = db.session.execute(db.select(Review).filter_by(user_id=current_user.get_id())).scalar() # проверка к БД, что пользователь не оставлял review к курсу
    if request.method == "POST" and check is None:
        grade = int(request.form.get("grade", 0))
        comment = request.form.get("comment", 0)
        book.rating_sum += grade
        book.rating_num += 1
        new_reviews = Review(
            rating = grade,
            text = comment,
            book_id = book.id,
            user_id = current_user.id
        )
        db.session.add(new_reviews)
        db.session.commit()
    if request.method == "POST" and check is not None:
        flash(f'Вы уже оставляли отзыв !!!!!!!!!!!', 'danger')
    per_page = current_app.config["PER_PAGE"]
    active_page = max(int(request.args.get('page', 1)), 1)
    count_notes = db.session.query(func.count(Review.id)).filter(Review.book_id == book_id).scalar()
    start_page = max(active_page - 1, 1)
    end_page = min(active_page + 1, ceil(count_notes / per_page))
    review_cur_user = db.session.query(Review).filter(Review.user_id == current_user.id, Review.book_id == book.id).all()
    review_exist = len(review_cur_user) != 0
    category = request.args.get('category_of_sorting', None)
    if category is None:
        category = session.get("category", None)
    if category == "positive" :
        reviews = db.session.execute(db.select(Review).filter_by(book_id=book_id).order_by(desc(Review.rating)).limit(per_page).offset((active_page-1)*per_page)).scalars()
        session["category"] = "positive"
    elif category == "negative" :
        reviews = db.session.execute(db.select(Review).filter_by(book_id=book_id).order_by(Review.rating).limit(per_page).offset((active_page-1)*per_page)).scalars()
        session["category"] = "negative"
    else: 
        reviews = db.session.execute(db.select(Review).filter_by(book_id=book_id).order_by(desc(Review.created_at)).limit(per_page).offset((active_page-1)*per_page)).scalars()
        session["category"] = "new_date"
    return render_template('books/reviews.html',book_id=book_id,review_exist=review_exist,reviews=reviews, per_page=per_page,count_notes=count_notes ,start_page=start_page, end_page=end_page, active_page=active_page, review_cur_user=review_cur_user)




from flask import Flask, render_template, send_from_directory
from flask_migrate import Migrate
from sqlalchemy.exc import SQLAlchemyError
from models import db, Genre, Image
from auth import bp as auth_bp, init_login_manager
from books import bp as books_bp

app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')

db.init_app(app)
migrate = Migrate(app, db)

init_login_manager(app)

@app.errorhandler(SQLAlchemyError)
def handle_sqlalchemy_error(err):
    error_msg = ('Возникла ошибка при подключении к базе данных. '
                 'Повторите попытку позже.')
    return f'{error_msg} (Подробнее: {err})', 500

app.register_blueprint(auth_bp)
app.register_blueprint(books_bp)

@app.route('/')
def index():
    genres = db.session.execute(db.select(Genre)).scalars()
    return render_template(
        'index.html',
        genres=genres,
    )

@app.route('/images/<image_id>')
def image(image_id):
    img = db.get_or_404(Image, image_id)
    return send_from_directory(app.config['UPLOAD_FOLDER'],
                               img.storage_filename)

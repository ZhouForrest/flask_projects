import os

import redis as redis
from flask import Flask
from flask_session import Session

from apps.house_views import house
from apps.model import db
from apps.user_views import user
from apps.views import lvh
from utils.basic import BASE_DIR


def create_app():
    templates_dir = os.path.join(BASE_DIR, 'templates')
    static_dir = os.path.join(BASE_DIR, 'static')

    app = Flask(__name__, template_folder=templates_dir, static_folder=static_dir)

    app.register_blueprint(blueprint=lvh, url_prefix='/app')
    app.register_blueprint(blueprint=user, url_prefix='/user')
    app.register_blueprint(blueprint=house, url_prefix='/house')

    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:123456@localhost:3306/lvh'

    app.config['SECRET_KEY'] = 'secret_key'
    app.config['SESSION_TYPE'] = 'redis'
    app.config['SESSION_REDIS'] = redis.Redis(host='localhost', port=6379)

    Session(app=app)
    db.init_app(app=app)

    return app
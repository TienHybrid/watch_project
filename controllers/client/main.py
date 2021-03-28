from flask import Blueprint, render_template
from models import Category
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
mod = Blueprint(name='main', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


@mod.route('/')
def main():
    category = db.session.query(Category).all()
    return render_template('client.html', category=category)

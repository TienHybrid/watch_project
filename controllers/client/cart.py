from flask import Blueprint, render_template
from models import Category
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
mod = Blueprint(name='cart', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


@mod.route('/cart', methods=['GET'])
def cart():
    category = db.session.query(Category).all()
    return render_template('cart.html', category=category)


@mod.route('/checkout', methods=['GET'])
def checkout():
    category = db.session.query(Category).all()
    return render_template('checkout.html', category=category)
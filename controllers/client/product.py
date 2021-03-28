from flask import Blueprint, render_template
from models import Category
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
mod = Blueprint(name='product', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


@mod.route('/product', methods=['GET'])
def product():
    category = db.session.query(Category).all()
    return render_template('product.html', category=category)


@mod.route('/product/<id_product>')
def product_detail(id_product):
    category = db.session.query(Category).all()
    return render_template('product-detail.html', category=category)

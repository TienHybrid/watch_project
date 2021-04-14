import sqlalchemy
from flask import Blueprint, render_template, request
from models import Category, Product
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_
from common.constant import ROWS_PER_PAGE
from config import FILTER_PRICE
import json
from sqlalchemy.sql.expression import cast

db = SQLAlchemy()
mod = Blueprint(name='product', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


@mod.route('/product', methods=['GET'])
def product():
    category = db.session.query(Category).filter(Category.is_deleted.is_(False))
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search')
    id_category = request.args.get('id_category', None)
    id_price = request.args.get('id_price', None)
    list_product = db.session.query(Product).filter(Product.is_deleted.is_(False))
    if search:
        list_product = list_product.filter(or_(Product.name.like('%' + search + '%')))
    if id_category:
        list_product = list_product.filter(Product.category_id == id_category)
    if id_price:
        start = None
        end = None
        for price in FILTER_PRICE:
            if price['id'] == int(id_price):
                start = price['start']
                end = price['end']

        if start:
            list_product = list_product.filter(Product.price > start)
        if end:
            list_product = list_product.filter(Product.price < end)

    list_product = list_product.order_by(Product.updated_at.desc()).paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('product.html', categories=category, products=list_product, prices= FILTER_PRICE)


@mod.route('/product/<id_product>', methods=['GET', 'POST'])
def product_detail(id_product):
    category = db.session.query(Category).filter(Category.is_deleted.is_(False))
    if request.method == 'POST':
        data = request.form
        return json.dumps({'message': 'Successfully', 'id_product': id_product})
    else:
        current_product = db.session.query(Product).filter(Product.id == int(id_product),
                                                           Product.is_deleted.is_(False)).first()
        return render_template('product_info.html',
                               current_product=current_product,
                               categories=category)

import sqlalchemy
from flask import Blueprint, render_template, request, session, current_app
from models import Category, Product, Stockinproduct, Place, Stock
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_
from common.constant import ROWS_PER_PAGE
from config import FILTER_PRICE
import json

db = SQLAlchemy()
mod = Blueprint(name='product', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


@mod.route('/product', methods=['GET'])
def product():
    place_id = session['place_id']
    category = db.session.query(Category).filter(Category.is_deleted.is_(False))
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search')
    id_category = request.args.get('id_category', None)
    id_price = request.args.get('id_price', None)
    filters = []
    list_product = db.session.query(
        Product.id.label('id'),
        Product.name.label('name'),
        Product.image_url.label('image_url'),
        Product.price.label('price')
    ) \
        .join(Stockinproduct, Stockinproduct.product_id == Product.id) \
        .filter(Product.is_deleted.is_(False), Stockinproduct.is_deleted.is_(False)) \
        .join(Stock, Stock.id == Stockinproduct.stock_id) \
        .filter(Stock.is_deleted.is_(False)) \
        .join(Place, Place.id == Stock.place_id) \
        .filter(Place.is_deleted.is_(False), Place.id == place_id)
    if search:
        filters.append({'id': "search", 'value': 'Tìm Kiếm: ' + search})
        list_product = list_product.filter(or_(Product.name.like('%' + search + '%')))
    if id_category:
        category_item = db.session.query(Category).filter(Category.id == int(id_category)).first()
        filters.append({'id': "id_category", 'value': category_item.name})
        list_product = list_product.filter(Product.category_id == id_category)
    if id_price:
        for price in FILTER_PRICE:
            if price['id'] == int(id_price):
                price_item = price
        filters.append({'id': "id_price", 'value': price_item['name']})
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
    return render_template('product.html', categories=category, products=list_product, prices=FILTER_PRICE,
                           filters=filters)


@mod.route('/product/<id_product>', methods=['GET', 'POST'])
def product_detail(id_product):
    category = db.session.query(Category).filter(Category.is_deleted.is_(False))
    place_id = session['place_id']
    if request.method == 'POST':
        data = request.form
        return json.dumps({'message': 'Successfully', 'id_product': id_product})
    else:
        current_product = db.session.query(
            Product.id.label('id'),
            Product.name.label('name'),
            Product.image_url.label('image_url'),
            Product.price.label('price'),
            Product.description.label('description'),
            Stockinproduct.quantity.label('quantity'),
            Category.name.label('category_name'),
            Place.name.label('place_name')
        )\
            .filter(Product.id == int(id_product), Product.is_deleted.is_(False)) \
            .join(Stockinproduct, Stockinproduct.product_id == Product.id) \
            .filter(Product.is_deleted.is_(False), Stockinproduct.is_deleted.is_(False)) \
            .join(Stock, Stock.id == Stockinproduct.stock_id) \
            .filter(Stock.is_deleted.is_(False)) \
            .join(Category, Category.id == Product.category_id)\
            .filter(Category.is_deleted.is_(False))\
            .join(Place, Place.id == Stock.place_id) \
            .filter(Place.is_deleted.is_(False), Place.id == place_id).first()
        if current_product:
            return render_template('product_info.html',
                                   current_product=current_product,
                                   categories=category)
        else:
            return render_template('notfound.html'), 404


@mod.errorhandler(404)
def not_found_error(error):
    return render_template('notfound.html'), 404
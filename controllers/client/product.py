import sqlalchemy
from flask import Blueprint, render_template, request, session, current_app
from models import Category, Product, Stockinproduct, Place, Stock, Brand, Commentproduct, User
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_, desc
from common.constant import ROWS_PER_PAGE
from config import FILTER_PRICE
import json
from libs.user_permission import user_required

db = SQLAlchemy()
mod = Blueprint(name='product', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


def get_comments_product(stock_id, product_id, user_id=None):
    list_comments_product = db.session.query(
        Commentproduct,
        User.fullname.label('fullname'),
        User.avatar_url.label('avatar_url'),
    ).join(User, User.id == Commentproduct.user_id).filter(
        Commentproduct.is_deleted.is_(False),
        Commentproduct.product_id == product_id,
        User.is_deleted.is_(False),
        Commentproduct.stock_id == stock_id
    )
    if user_id:
        list_comments_product = list_comments_product.filter(
            Commentproduct.user_id == user_id,
        )
    list_comments_product = list_comments_product.order_by(
        desc(Commentproduct.updated_at)
    ).all()
    return list_comments_product


def get_relate_product(category_id, product_id, limit=None):
    place_id = session['place_id']
    if place_id:
        list_product = db.session.query(
            Product.id.label('id'),
            Product.name.label('name'),
            Product.old_price.label('old_price'),
            Product.category_id.label('category_id'),
            Product.image_url.label('image_url'),
            Product.price.label('price'),
            Stockinproduct.stock_id.label('stock_id'),
            Product.down_price.label('down_price')
        ) \
            .join(Stockinproduct, Stockinproduct.product_id == Product.id) \
            .filter(
            Product.is_deleted.is_(False),
            Product.category_id == category_id,
            Product.id != product_id,
            Stockinproduct.is_deleted.is_(False)
        ) \
            .join(Stock, Stock.id == Stockinproduct.stock_id) \
            .filter(Stock.is_deleted.is_(False)) \
            .join(Place, Place.id == Stock.place_id) \
            .filter(Place.is_deleted.is_(False), Place.id == place_id)
        if limit:
            list_product = list_product.limit(limit)
        list_product = list_product.all()
        return list_product


def get_product_by_desc_created_at(limit=None):
    place_id = session['place_id']
    if place_id:
        list_product = db.session.query(
            Product.id.label('id'),
            Product.name.label('name'),
            Product.old_price.label('old_price'),
            Product.category_id.label('category_id'),
            Product.image_url.label('image_url'),
            Product.price.label('price'),
            Stockinproduct.stock_id.label('stock_id'),
            Product.down_price.label('down_price')
        ) \
            .join(Stockinproduct, Stockinproduct.product_id == Product.id) \
            .filter(Product.is_deleted.is_(False), Stockinproduct.is_deleted.is_(False)) \
            .join(Stock, Stock.id == Stockinproduct.stock_id) \
            .filter(Stock.is_deleted.is_(False)) \
            .join(Place, Place.id == Stock.place_id) \
            .filter(Place.is_deleted.is_(False), Place.id == place_id) \
            .order_by(desc(Product.created_at))
        if limit:
            list_product = list_product.limit(limit)
        list_product = list_product.all()
        return list_product


@mod.route('/product', methods=['GET'])
def product():
    place_id = session['place_id']
    category = db.session.query(Category).filter(Category.is_deleted.is_(False))
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search')
    id_category = request.args.get('id_category', None)
    id_brand = request.args.get('id_brand', None)
    id_price = request.args.get('id_price', None)
    filters = []
    list_product = db.session.query(
        Product.id.label('id'),
        Product.name.label('name'),
        Product.old_price.label('old_price'),
        Product.image_url.label('image_url'),
        Product.price.label('price'),
        Stockinproduct.stock_id.label('stock_id'),
        Product.down_price.label('down_price')
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
    if id_brand:
        brand_item = db.session.query(Brand).filter(Brand.id == int(id_brand)).first()
        filters.append({'id': "id_brand", 'value': brand_item.name})
        list_product = list_product.filter(Product.category_id == id_brand)
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
    newest_list_product = get_product_by_desc_created_at(5)
    return render_template('product.html', categories=category, products=list_product,
                           newest_products=newest_list_product, prices=FILTER_PRICE,
                           filters=filters)


@mod.route('/product/<id_product>', methods=['GET', 'POST'])
def product_detail(id_product):
    category = db.session.query(Category).filter(Category.is_deleted.is_(False))
    place_id = session['place_id']
    if request.method == 'POST':
        return json.dumps({'message': 'Successfully', 'id_product': id_product})
    else:
        current_product = db.session.query(
            Product.id.label('id'),
            Product.name.label('name'),
            Product.old_price.label('old_price'),
            Product.image_url.label('image_url'),
            Product.price.label('price'),
            Product.description.label('description'),
            Stockinproduct.stock_id.label('stock_id'),
            Stockinproduct.quantity.label('quantity'),
            Stock.id.label('stock_id'),
            Stock.name.label('stock_name'),
            Category.name.label('category_name'),
            Category.id.label('category_id'),
            Place.name.label('place_name')
        ) \
            .filter(Product.id == int(id_product), Product.is_deleted.is_(False)) \
            .join(Stockinproduct, Stockinproduct.product_id == Product.id) \
            .filter(Product.is_deleted.is_(False), Stockinproduct.is_deleted.is_(False)) \
            .join(Stock, Stock.id == Stockinproduct.stock_id) \
            .filter(Stock.is_deleted.is_(False)) \
            .join(Category, Category.id == Product.category_id) \
            .filter(Category.is_deleted.is_(False)) \
            .join(Place, Place.id == Stock.place_id) \
            .filter(Place.is_deleted.is_(False), Place.id == place_id).first()
        if current_product:
            list_relate_product = get_relate_product(current_product.category_id,
                                                     current_product.id,
                                                     limit=5)
            list_comments = get_comments_product(product_id=current_product.id, stock_id=current_product.stock_id)
            return render_template('product_info.html',
                                   current_product=current_product,
                                   relate_products=list_relate_product,
                                   product_comments=list_comments,
                                   categories=category)
        else:
            return render_template('notfound.html'), 404


@mod.route('/post_comment', methods=['GET', 'POST'])
@user_required
def post_comment():
    place_id = session['place_id']
    product_id = request.form.get('product_id')
    stock_id = request.form.get('stock_id')
    comment = request.form.get('content')
    user_id = session['user_id']
    if product_id and stock_id and comment and user_id:
        check_exist_product = db.session.query(Product).join(
            Stockinproduct, Stockinproduct.stock_id == stock_id
        ).join(
            Place, Place.id == place_id
        ).filter(
            Stockinproduct.is_deleted.is_(False),
            Product.is_deleted.is_(False),
            Product.id == product_id
        ).first()
        if check_exist_product:
            new_comment = Commentproduct(
                stock_id=stock_id,
                user_id=user_id,
                product_id=product_id,
                content=comment
            )
            db.session.add(new_comment)
            db.session.commit()
            return 'Done'
    return 404


@mod.route('/delete_comment/<id_comment>', methods=['GET', 'POST'])
@user_required
def delete_comment(id_comment):
    if id_comment:
        check_exist_comment = db.session.query(Commentproduct).filter(
            Commentproduct.is_deleted.is_(False),
            Commentproduct.id == id_comment
        ).first()
        if check_exist_comment:
            check_exist_comment.is_deleted = True
            db.session.commit()
            return 'Xóa Thành Công'
    return 404

@mod.errorhandler(404)
def not_found_error(error):
    return render_template('notfound.html'), 404

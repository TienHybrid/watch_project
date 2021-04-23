import json

from flask import Blueprint, render_template, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import or_, func

from common.constant import ROWS_PER_PAGE
from libs.user_permission import admin_required
from models import Stock, Place, Stockinproduct, Product

mod = Blueprint(name='stock_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def handle_create_or_update_stock(form, id_stock):
    """
    Get detail
    :param form:
    :param id_stock:
    :return:
    """
    name = form['name']
    place_id = form['place_id']

    if id_stock == 'add':
        stock = Stock(
            name=name,
            place_id=place_id
        )
        db.session.add(stock)
    else:
        stock = db.session.query(Stock).filter_by(id=int(id_stock)).first()
        stock.name = name
        stock.place_id = place_id
        db.session.merge(stock)
    db.session.commit()
    return stock


def handle_create_or_update_product_stock(form, id_stock, mode):
    """
    Get detail
    :param form:
    :param id_stock:
    :param mode
    :return:
    """
    product_id = form['product_id']
    quantity = form['quantity']
    stock_product_item = db.session.query(Stockinproduct).filter(
        Stockinproduct.stock_id == int(id_stock),
        Stockinproduct.product_id == product_id,
        Stockinproduct.is_deleted.is_(False)
    ).first()
    if stock_product_item:
        if mode == 'merge':
            stock_product_item.quantity = stock_product_item.quantity + int(quantity)
        elif mode == 'change':
            stock_product_item.quantity = int(quantity)
        db.session.merge(stock_product_item)
    else:
        stock_product_item = Stockinproduct(
            stock_id=id_stock,
            product_id=int(product_id),
            quantity=quantity
        )
        db.session.add(stock_product_item)
    db.session.commit()
    return stock_product_item


@mod.route('/stock_management')
@admin_required
def stock_management():
    page = request.args.get('page', 1, type=int)
    search = request.args.get('search', None)
    list_stock = db.session.query(
        Stock.id,
        Stock.name.label('name'),
        Place.name.label('place_name'),
    ) \
        .join(Place, Place.id == Stock.place_id) \
        .filter(
        Stock.is_deleted.is_(False),
        Place.is_deleted.is_(False)
    ).order_by(Stock.place_id)
    if search:
        list_stock = list_stock.filter(or_(Stock.name.like('%' + search + '%')))

    list_stock = list_stock.paginate(page=page, per_page=ROWS_PER_PAGE)
    return render_template('stock_management.html', stocks=list_stock)


@mod.route('/stock_management/stock_product/<id_stock>', methods=['GET', 'POST'])
@admin_required
def stock_product(id_stock):
    if request.method == 'POST':
        mode = request.args.get('mode', None)
        data = request.form
        stock_item = handle_create_or_update_product_stock(form=data, id_stock=id_stock, mode=mode)
        return json.dumps({'message': 'Successfully', 'id_stock': stock_item.id})
    else:
        list_place = db.session.query(Place).filter(Place.is_deleted == False).all()
        list_product = db.session.query(Product).filter(Product.is_deleted.is_(False)).all()
        if id_stock:
            current_stock_product = db.session.query(
                Stockinproduct.id.label('id'),
                Stockinproduct.quantity.label('quantity'),
                Product.id.label('product_id'),
                Product.name.label('name'),
                Product.price.label('price'),
                Product.image_url.label('image_url'),
            ).join(
                Product, Product.id == Stockinproduct.product_id
            ).filter(
                Product.is_deleted.is_(False),
                Stockinproduct.is_deleted.is_(False),
                Stockinproduct.stock_id == id_stock,
            ).all()

            return render_template('stock_product.html', title='Danh Sách Stock Product',
                                   stock_product=current_stock_product,
                                   id_stock=id_stock, places=list_place, products=list_product)


@mod.route('/stock_management/<id_stock>', methods=['GET', 'POST'])
@admin_required
def stock_detail(id_stock):
    if request.method == 'POST':

        data = request.form
        stock = handle_create_or_update_stock(form=data, id_stock=id_stock)
        return json.dumps({'message': 'Successfully', 'id_stock': stock.id})
    else:
        list_place = db.session.query(Place).filter(Place.is_deleted == False).all()
        if id_stock == 'add':
            return render_template('stock_detail.html', title='Thêm Mới stock', id_stock='add',
                                   stock={}, places=list_place)
        else:
            current_stock = db.session.query(Stock).filter(Stock.id == int(id_stock),
                                                           Stock.is_deleted.is_(False)).first()
            return render_template('stock_detail.html', title='Chỉnh Sửa stock', stock=current_stock,
                                   id_stock=id_stock, places=list_place)


@mod.route('/stock_management/stock_product/delete/<id_stock_product>', methods=['POST'])
@admin_required
def delete_stock_product_detail(id_stock_product):
    current_stock_product = db.session.query(Stockinproduct).\
        filter(Stockinproduct.id == int(id_stock_product),
               Stockinproduct.is_deleted.is_(False)).first()
    if current_stock_product:
        current_stock_product.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'


@mod.route('/stock_management/delete/<id_stock>', methods=['POST'])
@admin_required
def delete_stock_detail(id_stock):
    current_stock = db.session.query(Stock).filter(Stock.id == int(id_stock),
                                                   Stock.is_deleted.is_(False)).first()
    if current_stock:
        current_stock.is_deleted = True
        # update multi product in stock
        query = db.session.query(Stockinproduct).filter(Stockinproduct.stock_id == id_stock).all()
        for row in query:
            row.is_deleted = True
        db.session.commit()
    return 'Delete question successfully'

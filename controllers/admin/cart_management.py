from flask import Blueprint, render_template, request, current_app
from libs.user_permission import admin_required
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.dialects.postgresql import array
from models import User, Place, Cart, Cartproduct, Stockinproduct, Product
import json
from sqlalchemy import or_, func
from service.cart import get_all_cart_by_cart_id
mod = Blueprint(name='cart_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')

db = SQLAlchemy()


def check_exist_product_in_stock(product_id, product_stock_id):
    check_exist_product = db.session.query(
        Product
    ).join(Stockinproduct, Stockinproduct.product_id == Product.id) \
        .filter(
        Stockinproduct.product_id == product_id,
        Stockinproduct.stock_id == product_stock_id,
        Stockinproduct.is_deleted.is_(False),
        Stockinproduct.quantity > 0
    ).first()
    if check_exist_product:
        return check_exist_product
    else :
        return False


def update_stock_quantity(product_id,stock_id, quantity):
    compare_quantity = 0 if quantity < 0 else quantity
    stock_product = db.session.query(Stockinproduct).filter(
        Stockinproduct.is_deleted.is_(False),
        Stockinproduct.product_id == product_id,
        Stockinproduct.stock_id == stock_id,
        Stockinproduct.quantity > compare_quantity
    ).first()
    if not stock_product:
        return 'Không Thể Đặt Thêm'
    else:
        stock_product.quantity = stock_product.quantity + quantity
        db.session.merge(stock_product)
        db.session.commit()
        return 'Update Stock Thành Công'


def handle_create_or_update_cart(form, id_cart):
    """
    Get detail
    :param form:
    :param id_cart:
    :return:
    """
    name = form['name']
    short_name = form['short_name']
    if id_cart == 'add':
        cart = Cart(
            name=name,
            short_name=short_name
        )
        db.session.add(Cart)
    else:
        cart = db.session.query(Cart).filter_by(id=int(id_cart)).first()
        cart.name = name
        cart.short_name = short_name
        db.session.merge(cart)
    db.session.commit()
    return cart


@mod.route('/cart_management')
@admin_required
def cart_management():
    user_cart = db.session.query(
        User.id.label('id'),
        User.avatar_url.label('avatar_url'),
        User.username.label('username'),
        User.fullname.label('fullname'),
        Cart.id.label('cart_id')
    ).join(Cart, Cart.user_id == User.id, full=True).filter(
        User.is_deleted.is_(False),
    ).all()
    list_cart = []
    for user in user_cart:
        list_cart.append({
            'id':user[0],
            'avatar_url': user[1],
            'username': user[2],
            'fullname': user[3],
            'carts': get_all_cart_by_cart_id(user[4]) if user[4] else None
        })
    return render_template('cart_management.html', carts=list_cart)


@mod.route('/delete_cart/<id_cart>', methods=['GET','POST'])
@admin_required
def delete_cart(id_cart):
    current_cart = db.session.query(Cartproduct).filter(Cartproduct.id == int(id_cart),
                                                 Cartproduct.is_deleted.is_(False)).first()
    if current_cart:
        current_cart.is_deleted = True
        db.session.commit()
    update_stock_quantity(product_id=current_cart.product_id, stock_id=current_cart.stock_id, quantity=current_cart.quantity)
    return 'Thành Công'


@mod.route('/update_cart', methods=['GET', 'POST'])
@admin_required
def update_cart():
    if request.method == 'POST':
        carts = json.loads(request.form.get('carts', []))
        for cart in carts:
            product_id = cart['product_id']
            stock_id = cart['stock_id']
            cart_product_id = cart['cart_product_id']
            quantity = cart['quantity']
            check_exist_cart = check_exist_product_in_stock(product_id=product_id, product_stock_id=stock_id)
            if check_exist_cart:
                cart_product = db.session.query(Cartproduct).filter(
                    Cartproduct.is_deleted.is_(False),
                    Cartproduct.id == cart_product_id
                ).first()
                total_quantity = 0
                if cart_product:
                    total_quantity = cart_product.quantity - quantity
                    cart_product.quantity = quantity
                    db.session.merge(cart_product)
                db.session.commit()
                # update stock
                update_stock_quantity(product_id=product_id, stock_id=stock_id, quantity=total_quantity)
    return 'Done'

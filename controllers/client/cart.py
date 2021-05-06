from flask import Blueprint, render_template, g, request, current_app, redirect, url_for, flash, session
from models import Category, Voucher, Product, Cart, Cartproduct, Stockinproduct
from flask_sqlalchemy import SQLAlchemy
from libs.user_permission import user_required
from libs.sql_action import safe_commit
import json
db = SQLAlchemy()
mod = Blueprint(name='cart', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')

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

@mod.route('/cart', methods=['GET'])
def cart():
    list_cart = g.carts
    return render_template('cart.html', carts=list_cart)

@mod.route('/delete_cart/<id_cart>', methods=['GET','POST'])
@user_required
def delete_cart(id_cart):
    current_cart = db.session.query(Cartproduct).filter(Cartproduct.id == int(id_cart),
                                                 Cartproduct.is_deleted.is_(False)).first()
    if current_cart:
        current_cart.is_deleted = True
        db.session.commit()
    update_stock_quantity(product_id=current_cart.product_id, stock_id=current_cart.stock_id, quantity=current_cart.quantity)
    return 'Thành Công'

@mod.route('/update_cart', methods=['GET', 'POST'])
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

@mod.route('/add_cart', methods=['GET', 'POST'])
@user_required
def add_cart():
    product_id = int(request.form.get('product_id', None))
    product_stock_id = int(request.form.get('stock_id', None))
    quantity = int(request.form.get('quantity', 1))

    if request.method == 'POST':
        user_id = session.get('user_id')
        check_exist_product = db.session.query(
            Product
        ).join(Stockinproduct, Stockinproduct.product_id == Product.id) \
            .filter(
            Stockinproduct.product_id == product_id,
            Stockinproduct.stock_id == product_stock_id,
            Stockinproduct.is_deleted.is_(False),
            Stockinproduct.quantity > 0
        ).first()

        if not check_exist_product:
            flash(f'Không tồn tại sản phẩm')
            return redirect(url_for('product.product'))

        cart_user = db.session.query(Cart).filter(Cart.is_deleted.is_(False), Cart.user_id == user_id).first()
        if not cart_user:
            flash(f'Giỏ Hàng Không tồn tại')
            return redirect(url_for('product.product'))
        if cart_user:
            check_exist_cart_product = db.session.query(Cartproduct).filter(
                Cartproduct.cart_id == cart_user.id,
                Cartproduct.stock_id == product_stock_id,
                Cartproduct.product_id == product_id,
                Cartproduct.is_deleted.is_(False)
            ).first()
            if not check_exist_cart_product:
                cart_add = Cartproduct(
                    stock_id=product_stock_id,
                    cart_id=cart_user.id,
                    product_id=product_id,
                    quantity=quantity,
                )
                db.session.add(cart_add)
            else:
                check_exist_cart_product.quantity = check_exist_cart_product.quantity + quantity
                db.session.merge(check_exist_cart_product)
            db.session.commit()
    return redirect(url_for('product.product'))


@mod.route('/add_cart_product', methods=['GET', 'POST'])
@user_required
def add_cart_product():
    product_id = int(request.form.get('product_id', None))
    product_stock_id = int(request.form.get('stock_id', None))
    quantity = int(request.form.get('quantity', 1))

    if request.method == 'POST':
        user_id = session.get('user_id')
        check_exist_product = db.session.query(
            Product
        ).join(Stockinproduct, Stockinproduct.product_id == Product.id) \
            .filter(
            Stockinproduct.product_id == product_id,
            Stockinproduct.stock_id == product_stock_id,
            Stockinproduct.is_deleted.is_(False),
            Stockinproduct.quantity > 0
        ).first()

        if not check_exist_product:
            flash(f'Không tồn tại sản phẩm')
            return redirect(url_for('product.product_detail', id_product = product_id))

        cart_user = db.session.query(Cart).filter(Cart.is_deleted.is_(False), Cart.user_id == user_id).first()
        if not cart_user:
            flash(f'Giỏ Hàng Không tồn tại')
            return redirect(url_for('product.product_detail', id_product = product_id))
        if cart_user:
            check_exist_cart_product = db.session.query(Cartproduct).filter(
                Cartproduct.cart_id == cart_user.id,
                Cartproduct.stock_id == product_stock_id,
                Cartproduct.product_id == product_id
            ).first()
            if not check_exist_cart_product:
                cart_add = Cartproduct(
                    stock_id=product_stock_id,
                    cart_id=cart_user.id,
                    product_id=product_id,
                    quantity=quantity,
                )
                db.session.add(cart_add)
            else:
                check_exist_cart_product.quantity = check_exist_cart_product.quantity + quantity
                db.session.merge(check_exist_cart_product)
            db.session.commit()
    return redirect(url_for('product.product_detail', id_product = product_id))


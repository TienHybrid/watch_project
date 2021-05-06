import json

from flask import Blueprint, render_template, g, request, session, current_app
from flask_sqlalchemy import SQLAlchemy

from libs.constant import ORDER_TYPE, SHIPPING_METHOD
from libs.user_permission import user_required
from models import Cartproduct, User, Transaction, Transactionproduct, Stockinproduct
from service.order import get_all_transaction_product_by_transaction_id

db = SQLAlchemy()
mod = Blueprint(name='order', import_name="__name__", url_prefix='/', static_folder='static/client/assets',
                template_folder='templates/client')


def update_stock_quantity(product_id, stock_id, quantity):
    stock_product = db.session.query(Stockinproduct).filter(
        Stockinproduct.is_deleted.is_(False),
        Stockinproduct.product_id == product_id,
        Stockinproduct.stock_id == stock_id,
    ).first()
    if stock_product:
        stock_product.quantity = stock_product.quantity + quantity
        db.session.merge(stock_product)
        db.session.commit()
        return 'Update Stock Thành Công'


def bulk_update_transaction_product_to_transaction(transaction_id, cart_ids):
    carts = db.session.query(Cartproduct).filter(
        Cartproduct.id.in_(cart_ids),
        Cartproduct.is_deleted.is_(False)
    ).all()
    for cart in carts:
        transaction_product = Transactionproduct(
            stock_id=cart.stock_id,
            transaction_id=transaction_id,
            product_id=cart.product_id,
            quantity=cart.quantity
        )
        db.session.add(transaction_product)
        db.session.query(Cartproduct).filter(
            Cartproduct.id == cart.id
        ).update({
            Cartproduct.is_deleted: True
        })
        db.session.commit()
    return True


@mod.route('/checkout', methods=['GET'])
@user_required
def checkout():
    carts = g.carts
    user_id = session.get('user_id')
    if user_id:
        current_user = db.session.query(User).filter(User.id == user_id).first()
    return render_template('checkout.html', carts=carts, current_user=current_user)


@mod.route('/place_order', methods=['GET', 'POST'])
@user_required
def place_order():
    if request.method == 'POST':
        user_id = session.get('user_id')
        data = json.loads(request.form['data']) if request.form.get('data', None) else None
        cart_ids = json.loads(data['cart_ids']) if data['cart_ids'] else None
        if user_id and data:
            transaction = Transaction(
                user_id=user_id,
                user_name=data['user_name'],
                email=data['email'],
                phone_number=data['phone_number'],
                address=data['address'],
                content=data['content'],
                status=ORDER_TYPE.ORDER,
                shipping_method=SHIPPING_METHOD.COD,
                voucher_id=data['voucher_id'],
                discount=data['discount'],
                shipping_fee=data['shipping_fee'],
                subtotal=data['subtotal'],
                total=data['total'],
            )
            db.session.add(transaction)
            db.session.commit()
            if cart_ids and transaction.id:
                bulk_update_transaction_product_to_transaction(transaction.id, cart_ids)

    return 'Đặt Hàng Thành Công'


@mod.route('/order', methods=['GET'])
@user_required
def order():
    user_id = session.get('user_id')
    list_order_product = []
    if user_id:
        orders = db.session.query(Transaction).filter(
            Transaction.is_deleted.is_(False),
            Transaction.user_id == user_id
        ).all()
        for order_item in orders:
            list_order_product.append({
                'Transaction': order_item,
                'order_products': get_all_transaction_product_by_transaction_id(order_item.id)
            })

    return render_template('order.html', orders=list_order_product)


@mod.route('/cancel_order/<id_transaction>', methods=['POST'])
@user_required
def cancel_order(id_transaction):
    current_transaction = db.session.query(Transaction).filter(Transaction.id == int(id_transaction),
                                                               Transaction.is_deleted.is_(False)).first()
    if current_transaction:
        transaction_products = db.session.query(Transactionproduct).filter(
            Transactionproduct.transaction_id == id_transaction
        ).all()
        if transaction_products:
            for transaction_product in transaction_products:
                update_stock_quantity(product_id=transaction_product.product_id,
                                      stock_id=transaction_product.stock_id,
                                      quantity=transaction_product.quantity)
            current_transaction.status = ORDER_TYPE.FAILED
            db.session.commit()
    return 'Delete question successfully'

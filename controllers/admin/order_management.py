from flask import Blueprint, render_template, current_app, request
from flask_sqlalchemy import SQLAlchemy

from libs.user_permission import admin_required
from models import Transaction, Transactionproduct, Stockinproduct, Guaranteeinfo
from service.order import get_all_transaction_product_by_transaction_id
from libs.constant import ORDER_TYPE
from config import ORDER_STATUS
db = SQLAlchemy()
mod = Blueprint(name='order_management', import_name="__name__", url_prefix='/admin', static_folder='static/admin/assets',
                template_folder='templates/admin')

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


@mod.route('/order_management', methods=['GET', 'POST'])
@admin_required
def order_management():
    orders = db.session.query(Transaction).filter(
        Transaction.is_deleted.is_(False)
    ).all()
    list_order_product = []
    for order_item in orders:
        list_order_product.append({
            'Transaction': order_item,
            'order_products': get_all_transaction_product_by_transaction_id(order_item.id)
        })
    return render_template('order_management.html', orders=list_order_product, ORDER_TYPE=ORDER_TYPE, list_status=ORDER_STATUS)


@mod.route('/guarantee_info/<id_transaction_product>', methods=['GET', 'POST'])
@admin_required
def guarantee_info(id_transaction_product):
    list_guarantee_products = db.session.query(Guaranteeinfo, Transactionproduct.id.label('transaction_pro_id')).join(
        Transactionproduct, Transactionproduct.id == Guaranteeinfo.transactionproduct_id
    ).join(
        Transaction, Transaction.id == Transactionproduct.transaction_id
    ).filter(
        Guaranteeinfo.is_deleted.is_(False),
        Guaranteeinfo.transactionproduct_id == id_transaction_product,
        Transaction.status == ORDER_TYPE.COMPLETED
    ).all()
    return render_template('guarantee_info.html', guarantee_products=list_guarantee_products)


@mod.route('/change_status/<id_transaction>/<status>', methods=['GET', 'POST'])
@admin_required
def update_transaction(id_transaction, status):
    current_transaction = db.session.query(Transaction).filter(Transaction.id == int(id_transaction),
                                                               Transaction.is_deleted.is_(False)).first()

    if current_transaction and status:
        if status == ORDER_TYPE.CANCELED:
            # cancel order
            transaction_products = db.session.query(Transactionproduct).filter(
                Transactionproduct.transaction_id == id_transaction
            ).all()
            if transaction_products:
                for transaction_product in transaction_products:
                    update_stock_quantity(product_id=transaction_product.product_id,
                                          stock_id=transaction_product.stock_id,
                                          quantity=transaction_product.quantity)
                current_transaction.status = status
                db.session.commit()
        else:
            current_transaction.status = status
            db.session.commit()
    return 'Thao Tác Thành công'

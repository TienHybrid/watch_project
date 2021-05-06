from flask import Blueprint, render_template, current_app, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import desc
from libs.user_permission import admin_required
from models import Transaction, Transactionproduct, Stockinproduct, Guaranteeinfo, Product
from service.order import get_all_transaction_product_by_transaction_id
from libs.constant import ORDER_TYPE
from config import ORDER_STATUS
from common.constant import ROWS_PER_PAGE
import json
db = SQLAlchemy()
mod = Blueprint(name='guarantee_management', import_name="__name__", url_prefix='/admin',
                static_folder='static/admin/assets',
                template_folder='templates/admin')


def handle_create_or_update_guarantee(form, id_guarantee):
    """
    Get detail
    :param form:
    :param id_guarantee:
    :return:
    """
    transactionproduct_id = form['transactionproduct_id']
    content = form['content']
    if id_guarantee == 'add':
        guarantee = Guaranteeinfo(
            transactionproduct_id=transactionproduct_id,
            content=content,
        )
        db.session.add(guarantee)
    else:
        guarantee = db.session.query(Guaranteeinfo).filter_by(id=int(id_guarantee)).first()
        guarantee.content = content
        db.session.merge(guarantee)
    db.session.commit()
    return guarantee

def get_guarantee_info_by_id(transaction_product_id):
    guarantee_info = db.session.query(Guaranteeinfo).filter(
        Guaranteeinfo.is_deleted.is_(False),
        Guaranteeinfo.transactionproduct_id == transaction_product_id
    ).order_by(desc(Guaranteeinfo.created_at)).all()
    return guarantee_info


@mod.route('/guarantee_management', methods=['GET', 'POST'])
@admin_required
def guarantee_management():
    page = request.args.get('page', 1, type=int)
    guarantee_products = db.session.query(
        Transaction.id.label('transaction_id'),
        Product.id.label('product_id'),
        Product.name.label('product_name'),
        Transaction.user_name.label('user_name'),
        Transaction.address.label('address'),
        Transaction.phone_number.label('phone_number'),
        Transaction.created_at.label('created_at'),
        Transactionproduct.guarantee_time.label('guarantee_time'),
        Transactionproduct.id.label('transaction_product_id'),
        Transactionproduct.quantity.label('quantity'),
        Product.price.label('product')
    ).join(
        Transactionproduct, Transactionproduct.transaction_id == Transaction.id
    ).join(
        Product, Transactionproduct.product_id == Product.id
    ).filter(
        Transaction.is_deleted.is_(False),
        Transaction.status == ORDER_TYPE.COMPLETED,
        Transactionproduct.is_deleted.is_(False)
    ).paginate(page=page, per_page=ROWS_PER_PAGE)
    list_guarantee_product = []
    for guarantee_product in guarantee_products.items:
        list_guarantee_product.append({
            'Guarantee': guarantee_product,
            'guarantee_info': get_guarantee_info_by_id(guarantee_product.transaction_product_id)
        })

    return render_template('guarantee_management.html', guarantee_products=guarantee_products,
                           list_guarantee_product=list_guarantee_product)


@mod.route('/update_guarantee_management/<id_guarantee>', methods=['GET', 'POST'])
@admin_required
def update_guarantee_product(id_guarantee):
    if request.method == 'POST':
        data = request.form
        handle_create_or_update_guarantee(form=data, id_guarantee=id_guarantee)
        return 'Successfully'
    return 'Error'